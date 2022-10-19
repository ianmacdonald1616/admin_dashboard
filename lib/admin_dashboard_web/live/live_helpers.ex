defmodule AdminDashboardWeb.LiveHelpers do
  use Phoenix.Component
  alias Phoenix.LiveView.JS

  def modal(assigns) do
    ~H"""
    <div id={@id} class="admin-modal phx-modal fade-in" tabindex="-1">
      <div
        id={"#{@id}-container"}
        class="modal-dialog modal-lg fade-in-scale"
        phx-click-away={hide_modal(@id)}
        phx-window-keydown={hide_modal(@id)}
        phx-key="escape"
      >
        <div class="phx-modal-content">
          <.link patch={@return_to} class="hidden" data-modal-return></.link>
          <a href="#" class="close phx-modal-close" phx-click={hide_modal(@id)}>&times;</a>
          <.live_component module={@component} {@opts} />
        </div>
      </div>
    </div>
    """
  end

  defp hide_modal(js \\ %JS{}, id) do
    js
    |> JS.hide(to: "##{id}", time: 100, transition: "fade-out")
    |> JS.hide(to: "##{id}-container", time: 100, transition: "fade-out-scale")
    |> JS.dispatch("click", to: "##{id} [data-modal-return]")
  end

  def live_modal(component, opts) do
    require Phoenix.LiveView.Helpers
    path = Keyword.fetch!(opts, :return_to)
    modal_opts = %{id: :modal, return_to: path, component: component, opts: opts}
    modal(modal_opts)
  end

  def modal_buttons(assigns) do
    ~H"""
    <div class="modal-buttons">
      <button type="button" class="cancel-btn" phx-click={hide_modal(@id)}>Cancel</button>
      <button type="submit" class="create-btn">Create</button>
    </div>
    """
  end
end
