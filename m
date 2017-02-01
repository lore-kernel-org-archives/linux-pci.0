Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170130204106.31891.59164.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20170130203822.31891.22461.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20170130204106.31891.59164.stgit@bhelgaas-glaptop.roam.corp.google.com>
From: Andreas Boll <andreas.boll.dev@gmail.com>
Date: Wed, 1 Feb 2017 16:45:42 +0100
Message-ID: <CACiKqBfECOAsBHNqkkO84sZrjJ1itv5chOz4ZAu2jwQvBEyacg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/radeon: make MacBook Pro d3_delay quirk more generic
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@canonical.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

2017-01-30 21:41 GMT+01:00 Bjorn Helgaas <bhelgaas@google.com>:
> The PCI Power Management Spec, r1.2, sec 5.6.1, requires a 10 millisecond
> delay when powering on a device, i.e., transitioning from state D3hot to
> D0.
>
> Apparently some devices require more time, and d1f9809ed131 ("drm/radeon:
> add quirk for d3 delay during switcheroo poweron for apple macbooks") added
> an additional delay for the Radeon device in a MacBook Pro.  4807c5a8a0c8
> ("drm/radeon: add a PX quirk list") made the affected device more explicit.
>
> Add a generic PCI quirk to increase the d3_delay.  This means we will use
> the additional delay for *all* wakeups from D3, not just those initiated by
> radeon_switcheroo_set_state().
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> CC: Maarten Lankhorst <maarten.lankhorst@canonical.com>
> ---
>  drivers/gpu/drm/radeon/radeon_device.c |   12 ------------
>  drivers/pci/quirks.c                   |   13 +++++++++++++
>  2 files changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 8a1df2a1afbd..8b8fd981cae5 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -113,7 +113,6 @@ static inline bool radeon_is_atpx_hybrid(void) { return false; }
>  #endif
>
>  #define RADEON_PX_QUIRK_DISABLE_PX  (1 << 0)
> -#define RADEON_PX_QUIRK_LONG_WAKEUP (1 << 1)
>
>  struct radeon_px_quirk {
>         u32 chip_vendor;
> @@ -136,9 +135,6 @@ static struct radeon_px_quirk radeon_px_quirk_list[] = {
>          * https://bugzilla.kernel.org/show_bug.cgi?id=51381
>          */
>         { PCI_VENDOR_ID_ATI, 0x6840, 0x1043, 0x2122, RADEON_PX_QUIRK_DISABLE_PX },
> -       /* macbook pro 8.2 */
> -       { PCI_VENDOR_ID_ATI, 0x6741, PCI_VENDOR_ID_APPLE, 0x00e2, RADEON_PX_QUIRK_LONG_WAKEUP },

Do you intentionally removed the following line?
> -       { 0, 0, 0, 0, 0 },

>  };
>
>  bool radeon_is_px(struct drm_device *dev)
> @@ -1241,25 +1237,17 @@ static void radeon_check_arguments(struct radeon_device *rdev)
>  static void radeon_switcheroo_set_state(struct pci_dev *pdev, enum vga_switcheroo_state state)
>  {
>         struct drm_device *dev = pci_get_drvdata(pdev);
> -       struct radeon_device *rdev = dev->dev_private;
>
>         if (radeon_is_px(dev) && state == VGA_SWITCHEROO_OFF)
>                 return;
>
>         if (state == VGA_SWITCHEROO_ON) {
> -               unsigned d3_delay = dev->pdev->d3_delay;
> -
>                 printk(KERN_INFO "radeon: switched on\n");
>                 /* don't suspend or resume card normally */
>                 dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
>
> -               if (d3_delay < 20 && (rdev->px_quirk_flags & RADEON_PX_QUIRK_LONG_WAKEUP))
> -                       dev->pdev->d3_delay = 20;
> -
>                 radeon_resume_kms(dev, true, true);
>
> -               dev->pdev->d3_delay = d3_delay;
> -
>                 dev->switch_power_state = DRM_SWITCH_POWER_ON;
>                 drm_kms_helper_poll_enable(dev);
>         } else {
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 1800befa8b8b..512d7a875d62 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -1683,6 +1683,19 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,     0x2609, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   0x260a, quirk_intel_pcie_pm);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   0x260b, quirk_intel_pcie_pm);
>
> +static void quirk_radeon_pm(struct pci_dev *dev)
> +{
> +       if (dev->subsystem_vendor == PCI_VENDOR_ID_APPLE &&
> +           dev->subsystem_device == 0x00e2) {
> +               if (dev->d3_delay < 20) {
> +                       dev->d3_delay = 20;
> +                       dev_info(&dev->dev, "extending delay after power-on from D3 to %d msec\n",
> +                                dev->d3_delay);
> +               }
> +       }
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, 0x6741, quirk_radeon_pm);
> +
>  #ifdef CONFIG_X86_IO_APIC
>  /*
>   * Boot interrupts on some chipsets cannot be turned off. For these chipsets,
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
