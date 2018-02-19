Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:43543 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeBSJtQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Feb 2018 04:49:16 -0500
MIME-Version: 1.0
In-Reply-To: <f7593132608eb9a83d7268cc5b3ef12b3dd9c52d.1518941073.git.lukas@wunner.de>
References: <cover.1518941072.git.lukas@wunner.de> <f7593132608eb9a83d7268cc5b3ef12b3dd9c52d.1518941073.git.lukas@wunner.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Feb 2018 10:49:15 +0100
Message-ID: <CAJZ5v0jr0dM7VAPUvjEh0HoVgORzvFov3vPvyaO2nynKyJhNjg@mail.gmail.com>
Subject: Re: [PATCH 1/7] PCI: Restore BARs on runtime resume despite being unbound
To: Lukas Wunner <lukas@wunner.de>
Cc: dri-devel <dri-devel@lists.freedesktop.org>,
        Peter Wu <peter@lekensteyn.nl>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dave Airlie <airlied@redhat.com>,
        nouveau@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
        <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Pierre Moreau <pierre.morrow@free.fr>,
        Bastien Nocera <hadess@hadess.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Feb 18, 2018 at 9:38 AM, Lukas Wunner <lukas@wunner.de> wrote:
> PCI devices not bound to a driver are supposed to stay in D0 during
> runtime suspend.  But they may have a parent which is bound and can be
> transitioned to D3cold at runtime.  Once the parent goes to D3cold, the
> unbound child may go to D3cold as well.  When the child comes out of
> D3cold, its BARs are uninitialized and thus inaccessible when a driver
> tries to probe.
>
> One example are recent hybrid graphics laptops which cut power to the
> discrete GPU when the root port above it goes to ACPI power state D3.
> Users may provoke this by unbinding the GPU driver and allowing runtime
> PM on the GPU via sysfs:  The PM core will then treat the GPU as
> "suspended", which in turn allows the root port to runtime suspend,
> causing the power resources listed in its _PR3 object to be powered off.
> The GPU's BARs will be uninitialized when a driver later probes it.
>
> Another example are hybrid graphics laptops where the GPU itself (rather
> than the root port) is capable of runtime suspending to D3cold.  If the
> GPU's integrated HDA controller is not bound and the GPU's driver
> decides to runtime suspend to D3cold, the HDA controller's BARs will be
> uninitialized when a driver later probes it.
>
> Fix by restoring the BARs on runtime resume if the device is not bound.
> This is sufficient to fix the above-mentioned use cases.  Other use
> cases might require a full-blown pci_save_state() / pci_restore_state()
> or execution of fixups.  We can add that once use cases materialize,
> let's not inflate the code unnecessarily.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-driver.c | 8 ++++++--
>  drivers/pci/pci.c        | 2 +-
>  drivers/pci/pci.h        | 1 +
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 3bed6beda051..51b11cbd48f6 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1277,10 +1277,14 @@ static int pci_pm_runtime_resume(struct device *dev)
>
>         /*
>          * If pci_dev->driver is not set (unbound), the device should
> -        * always remain in D0 regardless of the runtime PM status
> +        * always remain in D0 regardless of the runtime PM status.
> +        * But if its parent can go to D3cold, this device may have
> +        * been in D3cold as well and require restoration of its BARs.
>          */
> -       if (!pci_dev->driver)
> +       if (!pci_dev->driver) {
> +               pci_restore_bars(pci_dev);
>                 return 0;
> +       }
>
>         if (!pm || !pm->runtime_resume)
>                 return -ENOSYS;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..f694650235f2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -563,7 +563,7 @@ int pci_wait_for_pending(struct pci_dev *dev, int pos, u16 mask)
>   * Restore the BAR values for a given device, so as to make it
>   * accessible by its driver.
>   */
> -static void pci_restore_bars(struct pci_dev *dev)
> +void pci_restore_bars(struct pci_dev *dev)
>  {
>         int i;
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fcd81911b127..29dc15bbe3bf 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -83,6 +83,7 @@ void pci_allocate_cap_save_buffers(struct pci_dev *dev);
>  void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
> +void pci_restore_bars(struct pci_dev *dev);
>
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> --
> 2.15.1
>
