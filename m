Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 22 Mar 2017 11:35:00 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH v2] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
Message-ID: <20170322113500.GA3940@red-moon>
References: <1490123810-12383-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322102939.GB3519@red-moon>
 <35F65528-FC1F-4813-A0C6-641CF864212A@linaro.org>
MIME-Version: 1.0
In-Reply-To: <35F65528-FC1F-4813-A0C6-641CF864212A@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-efi@vger.kernel.org, matt@codeblueprint.co.uk,
 linux-pci@vger.kernel.org, heyi.guo@linaro.org, pjones@redhat.com,
 hanjun.guo@linaro.org, bhelgaas@google.com, yinghai@kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+Yinghai]

On Wed, Mar 22, 2017 at 11:08:48AM +0000, Ard Biesheuvel wrote:
> 
> > On 22 Mar 2017, at 10:29, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> wrote:
> > 
> >> On Tue, Mar 21, 2017 at 07:16:50PM +0000, Ard Biesheuvel wrote:
> >> On UEFI systems, the PCI subsystem is enumerated by the firmware,
> >> and if a graphical framebuffer is exposed by a PCI device, its base
> >> address and size are exposed to the OS via the Graphics Output
> >> Protocol (GOP).
> >> 
> >> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
> >> scratch at boot. This may result in the GOP framebuffer address to
> >> become stale, if the BAR covering the framebuffer is modified. This
> >> will cause the framebuffer to become unresponsive, and may in some
> >> cases result in unpredictable behavior if the range is reassigned to
> >> another device.
> >> 
> >> So add a quirk to the EFI fb driver to find the BAR associated with
> >> the GOP base address, and set the IORESOURCE_PCI_FIXED attribute so
> >> that the PCI core will leave it alone.
> >> 
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >> As it turns out, setting the IORESOURCE_PCI_FIXED flag is not sufficient
> >> to make the PCI core leave the BARs alone, so instead, the BAR resource
> >> is claimed in the quirk handler.
> >> 
> >> As suggested by Lorenzo, a check is added that the device has memory
> >> decoding enabled, and if it doesn't, no attempt is made to use the
> >> EFI framebuffer.
> >> 
> >> drivers/video/fbdev/efifb.c | 58 +++++++++++++++++++-
> >> 1 file changed, 57 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> >> index 8c4dc1e1f94f..eeeaf78c4a5b 100644
> >> --- a/drivers/video/fbdev/efifb.c
> >> +++ b/drivers/video/fbdev/efifb.c
> >> @@ -10,6 +10,7 @@
> >> #include <linux/efi.h>
> >> #include <linux/errno.h>
> >> #include <linux/fb.h>
> >> +#include <linux/pci.h>
> >> #include <linux/platform_device.h>
> >> #include <linux/screen_info.h>
> >> #include <video/vga.h>
> >> @@ -143,6 +144,9 @@ static struct attribute *efifb_attrs[] = {
> >> };
> >> ATTRIBUTE_GROUPS(efifb);
> >> 
> >> +static bool pci_bar_found;    /* did we find a BAR matching the efifb base? */
> >> +static bool pci_bar_disabled;    /* was it disabled? */
> >> +
> >> static int efifb_probe(struct platform_device *dev)
> >> {
> >>    struct fb_info *info;
> >> @@ -152,7 +156,7 @@ static int efifb_probe(struct platform_device *dev)
> >>    unsigned int size_total;
> >>    char *option = NULL;
> >> 
> >> -    if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >> +    if (screen_info.orig_video_isVGA != VIDEO_TYPE_EFI || pci_bar_disabled)
> >>        return -ENODEV;
> >> 
> >>    if (fb_get_options("efifb", &option))
> >> @@ -360,3 +364,55 @@ static struct platform_driver efifb_driver = {
> >> };
> >> 
> >> builtin_platform_driver(efifb_driver);
> >> +
> >> +static void claim_efifb_bar(struct pci_dev *dev, int idx)
> >> +{
> >> +    u16 word;
> >> +
> >> +    pci_bar_found = true;
> >> +
> >> +    if (pci_claim_resource(dev, idx)) {
> > 
> > I would not do that. If claiming the resource succeeds, it will become
> > immutable (ie it becomes part of the resource tree), if it is your FB
> > fine if it isn't this will mess things up since a) you won't be able to
> > claim the PCI resources for the real FB and b) you won't be able to
> > reallocate the PCI resources for the device we *think* is the FB but it
> > actually isn't (unless we force a realloc).
> > 
> > So, I would carry out the check below first, if the device is enabled
> > we should flag its resource IORESOURCE_PCI_FIXED otherwise just do
> > nothing and let PCI core (through arch specific realloc policy) handle
> > it.
> > 
> 
> Well, it turned out that this does not actually work: the BAR is not
> reassigned, but the same range ends up being given to another device
> in some cases.

Ok, that's because the PCI core just prevent assigning that resource
but it does not request it (ie insert it in the resource tree) which
is what you do when claiming it.

I wonder how IORESOURCE_PCI_FIXED works on eg x86, I think it is time
to have a proper look into resources allocation code because there
are bits and pieces that are quite obscure to me.

I think I would reverse the order in which you carry out the BAR
reservation anyway (first check if the device is enabled second request
the resource ie claim it).

Lorenzo

> 
> 
> > Side note: I *think* it should be fine to claim a resource twice
> > (ie in x86 the FB would have been claimed already by core x86 code),
> > just thought it is worth checking.
> > 
> > Lorenzo
> > 
> >> +        pci_bar_disabled = true;
> >> +        dev_err(&dev->dev, "BAR %d: failed to claim efifb BAR\n", idx);
> >> +        return;
> >> +    }
> >> +
> >> +    pci_read_config_word(dev, PCI_COMMAND, &word);
> >> +    if (!(word & PCI_COMMAND_MEMORY)) {
> >> +        pci_bar_disabled = true;
> >> +        dev_err(&dev->dev,
> >> +            "BAR %d: efifb BAR has memory decoding disabled!\n", idx);
> >> +        return;
> >> +    }
> >> +
> >> +    dev_info(&dev->dev, "BAR %d: claimed for efifb\n", idx);
> >> +}
> >> +
> >> +static void efifb_fixup_resources(struct pci_dev *dev)
> >> +{
> >> +    u64 base = screen_info.lfb_base;
> >> +    u64 size = screen_info.lfb_size;
> >> +    int i;
> >> +
> >> +    if (pci_bar_found || screen_info.orig_video_isVGA != VIDEO_TYPE_EFI)
> >> +        return;
> >> +
> >> +    if (screen_info.capabilities & VIDEO_CAPABILITY_64BIT_BASE)
> >> +        base |= (u64)screen_info.ext_lfb_base << 32;
> >> +
> >> +    if (!base)
> >> +        return;
> >> +
> >> +    for (i = 0; i < PCI_STD_RESOURCE_END; i++) {
> >> +        struct resource *res = &dev->resource[i];
> >> +
> >> +        if (!(res->flags & IORESOURCE_MEM))
> >> +            continue;
> >> +
> >> +        if (res->start <= base && res->end >= base + size - 1) {
> >> +            claim_efifb_bar(dev, i);
> >> +            break;
> >> +        }
> >> +    }
> >> +}
> >> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, efifb_fixup_resources);
> >> -- 
> >> 2.7.4
> >> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
