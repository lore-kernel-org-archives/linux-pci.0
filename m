Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33954 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309AbbEZTKt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 15:10:49 -0400
Received: by wghq2 with SMTP id q2so105849357wgh.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 12:10:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150311223445.6af76f7c@neptune.home>
References: <20150223215155.18444386@neptune.home>
	<20150303172753.GF83894@vmdeb7>
	<20150305232038.1873d380@neptune.home>
	<20150306174254.GB19001@vmdeb7>
	<20150307011546.0050279d@neptune.home>
	<20150309225238.0b9ced4e@neptune.home>
	<CAErSpo61r-_hy1hfUMm2ooXZVLTBhtjd-x5uXbyEg=WcG=itnQ@mail.gmail.com>
	<20150311223445.6af76f7c@neptune.home>
Date: Tue, 26 May 2015 12:10:48 -0700
Message-ID: <CAGr1u3tKVtQno=hUrKemLFYG12dtvPjFVR7oFwDG5cewJGCnJQ@mail.gmail.com>
Subject: Re: [Patch v3] apple-gmux: lock iGP IO to protect from vgaarb changes
From: Michael Marineau <michael.marineau@coreos.com>
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Darren Hart <dvhart@infradead.org>,
	platform-driver-x86@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Petri Hodju <petrihodju@yahoo.com>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

FYI, this actually broke backlight controls on my MBP11,3 because the
assumption the patch makes that gmux is always loaded before graphics
drivers didn't hold true. At least for me dracut included the nouveau
module in the initrd but not gmux, ensuring the ordering was wrong. No
errors were reporting, and gmux still offered the backlight device, it
just became inoperable. I worked around this for my kernel by building
gmux into vmlinuz instead of as a module but that isn't going to in
more general configs because there is an apple backlight driver which
cannot be built at all in that configuration.

Is there a way to make the ordering between nouveau and gmux more
explicit/reliable? Can gmux complain loudly if the ordering is ever
wrong?


On Wed, Mar 11, 2015 at 2:34 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> As GMUX depends on IO for iGP to be enabled and active, lock the IO at
> vgaarb level. This should prevent GPU driver for dGPU to disable IO for
> iGP while it tries to own legacy VGA IO.
>
> This fixes usage of backlight control combined with closed nvidia
> driver on some Apple dual-GPU (intel/nvidia) systems.
>
> On those systems loading nvidia driver disables intel IO decoding,
> disabling the gmux backlight controls as a side effect.
> Prior to commits moving boot_vga from (optional) efifb to less optional
> vgaarb this mis-behavior could be avoided by using right kernel config
> (efifb enabled but vgaarb disabled).
>
> This patch explicitly does not try to trigger vgaarb changes in order
> to avoid confusing already running graphics drivers. If IO has been
> mis-configured by vgaarb gmux will thus fail to probe.
> It is expected to load/probe gmux prior to graphics drivers.
>
> Fixes: ce027dac592c0ada241ce0f95ae65856828ac450 # nvidia interaction
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=86121
> Reported-by: Petri Hodju <petrihodju@yahoo.com>
> Tested-by: Petri Hodju <petrihodju@yahoo.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Matthew Garrett <matthew.garrett@nebula.com>
> Signed-off-by: Bruno Prémont <bonbons@linux-vserver.org>
> ---
> Resending v2 in the hope Darren won't hit quoted-printable.
> Also adding linux-pci on CC by Bjorn's request in bugzilla.
>
> Changes since v2:
> - Renamed gmux_find_pdev to gmux_get_io_pdev
> - Whitespace fix
> - vga_put() on error path
>
> Changes since v1:
> - Dropped repeat of gmux in pr_info/pr_err calls
> - Mention PCI device we tried to lock IO for in case of error
>
>
>  drivers/platform/x86/apple-gmux.c | 48 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 47 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index b9429fb..e743b03 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -22,6 +22,7 @@
>  #include <linux/delay.h>
>  #include <linux/pci.h>
>  #include <linux/vga_switcheroo.h>
> +#include <linux/vgaarb.h>
>  #include <acpi/video.h>
>  #include <asm/io.h>
>
> @@ -31,6 +32,7 @@ struct apple_gmux_data {
>         bool indexed;
>         struct mutex index_lock;
>
> +       struct pci_dev *pdev;
>         struct backlight_device *bdev;
>
>         /* switcheroo data */
> @@ -415,6 +417,23 @@ static int gmux_resume(struct device *dev)
>         return 0;
>  }
>
> +static struct pci_dev *gmux_get_io_pdev(void)
> +{
> +       struct pci_dev *pdev = NULL;
> +
> +       while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev))) {
> +               u16 cmd;
> +
> +               pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +               if (!(cmd & PCI_COMMAND_IO))
> +                       continue;
> +
> +               return pdev;
> +       }
> +
> +       return NULL;
> +}
> +
>  static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  {
>         struct apple_gmux_data *gmux_data;
> @@ -425,6 +444,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>         int ret = -ENXIO;
>         acpi_status status;
>         unsigned long long gpe;
> +       struct pci_dev *pdev = NULL;
>
>         if (apple_gmux_data)
>                 return -EBUSY;
> @@ -475,7 +495,7 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>                         ver_minor = (version >> 16) & 0xff;
>                         ver_release = (version >> 8) & 0xff;
>                 } else {
> -                       pr_info("gmux device not present\n");
> +                       pr_info("gmux device not present or IO disabled\n");
>                         ret = -ENODEV;
>                         goto err_release;
>                 }
> @@ -483,6 +503,23 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>         pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
>                 ver_release, (gmux_data->indexed ? "indexed" : "classic"));
>
> +       /*
> +        * Apple systems with gmux are EFI based and normally don't use
> +        * VGA. In addition changing IO+MEM ownership between IGP and dGPU
> +        * disables IO/MEM used for backlight control on some systems.
> +        * Lock IO+MEM to GPU with active IO to prevent switch.
> +        */
> +       pdev = gmux_get_io_pdev();
> +       if (pdev && vga_tryget(pdev,
> +                              VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM)) {
> +               pr_err("IO+MEM vgaarb-locking for PCI:%s failed\n",
> +                       pci_name(pdev));
> +               ret = -EBUSY;
> +               goto err_release;
> +       } else if (pdev)
> +               pr_info("locked IO for PCI:%s\n", pci_name(pdev));
> +       gmux_data->pdev = pdev;
> +
>         memset(&props, 0, sizeof(props));
>         props.type = BACKLIGHT_PLATFORM;
>         props.max_brightness = gmux_read32(gmux_data, GMUX_PORT_MAX_BRIGHTNESS);
> @@ -574,6 +611,10 @@ err_enable_gpe:
>  err_notify:
>         backlight_device_unregister(bdev);
>  err_release:
> +       if (gmux_data->pdev)
> +               vga_put(gmux_data->pdev,
> +                       VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
> +       pci_dev_put(pdev);
>         release_region(gmux_data->iostart, gmux_data->iolen);
>  err_free:
>         kfree(gmux_data);
> @@ -593,6 +634,11 @@ static void gmux_remove(struct pnp_dev *pnp)
>                                            &gmux_notify_handler);
>         }
>
> +       if (gmux_data->pdev) {
> +               vga_put(gmux_data->pdev,
> +                       VGA_RSRC_NORMAL_IO | VGA_RSRC_NORMAL_MEM);
> +               pci_dev_put(gmux_data->pdev);
> +       }
>         backlight_device_unregister(gmux_data->bdev);
>
>         release_region(gmux_data->iostart, gmux_data->iolen);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
