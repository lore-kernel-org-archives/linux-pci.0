Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751271AbcH2THm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Aug 2016 15:07:42 -0400
Date: Mon, 29 Aug 2016 14:07:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roland Singer <roland.singer@desertbit.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: Kernel Freeze with American Megatrends BIOS
Message-ID: <20160829190737.GA4053@localhost>
References: <004c7dbe-2014-c691-29d1-7a45f3b73dfa@desertbit.com>
 <20160829160210.GA24451@localhost>
 <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1cca943f-eab4-4054-4a13-31370d7ae057@desertbit.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 08:46:17PM +0200, Roland Singer wrote:
> Hi Bjorn,
> 
> I am using the bbswitch kernel module to switch off/on the GPU and
> to obtain the GPU power state.
> Obtaining the GPU state immediately after starting the graphical user
> session freezes the system.
> 
> This code triggers something, which is responsible for the freeze.
> 
> ---
> // Returns 1 if the card is disabled, 0 if enabled
> static int is_card_disabled(void) {
>     u32 cfg_word;
>     // read first config word which contains Vendor and Device ID. If all bits
>     // are enabled, the device is assumed to be off
>     pci_read_config_dword(dis_dev, 0, &cfg_word);
>     // if one of the bits is not enabled (the card is enabled), the inverted
>     // result will be non-zero and hence logical not will make it 0 ("false")
>     return !~cfg_word;
> }
> 
> static int bbswitch_proc_show(struct seq_file *seqfp, void *p) {
>     // show the card state. Example output: 0000:01:00:00 ON
>     dis_dev_get();
>     seq_printf(seqfp, "%s %s\n", dev_name(&dis_dev->dev),
>              is_card_disabled() ? "OFF" : "ON");
>     dis_dev_put();
>     return 0;
> }
> ---
> 
> Either dis_dev_get or pci_read_config_dword is the trigger.

What happens if you remove the call to is_card_disabled()?  Does the
system still freeze if you only do the dis_dev_get()/dis_dev_put()?

> Link to the bbswitch module source code:
> https://github.com/Bumblebee-Project/bbswitch/blob/master/bbswitch.c#L333
> 
> 
> Am 29.08.2016 um 18:02 schrieb Bjorn Helgaas:
> > [+cc linux-acpi, linux-kernel, dri-devel]
> > 
> > Hi Roland,
> > 
> > I have no idea how to debug this problem.  Are you seeing something
> > that suggests it may be a PCI problem?
> > 
> > On Tue, Aug 23, 2016 at 11:23:45AM +0200, Roland Singer wrote:
> >> Hi,
> >>
> >> hope somebody can help me fix this kernel problem which affects the following machines:
> >>
> >> - Clevo P651RA (i7-6700HQ/GTX 965M, part of the P6xxRx family which are also affected)
> >> - MSI GE62 Apache Pro (i7-6700HQ/GTX 960M)
> >> - Gigabyte P35V5 (i7-6700HQ/GTX 970M)
> >> - Razer Blade 14" (2016) (i7-6700HQ/GTX 970M) (BIOS 5.11, 04/07/2016)
> >>
> >>
> >> The kernel freezes if the graphical user session (Xorg & Wayland) is
> >> started with a switched off discrete GPU card (NVIDIA).
> >> If the discrete GPU is switched off after the graphical session start,
> >> then everything works as expected, until the graphical session is restarted.
> >>
> >> This problem seams to be linked to specific BIOS settings. If the computer
> >> is started with the following command line:
> >>
> >> acpi_osi=! acpi_osi="Windows 2009"
> >>
> >> then the kernel freeze does not occur anymore. However this required a special
> >> ACPI DSDT firmware patch for the Razer Blade 2016 laptop:
> >>
> >> https://github.com/m4ng0squ4sh/razer_blade_14_2016_acpi_dsdt
> >>
> >> I strongly recommend to fix this in the kernel and I am ready to help and solve
> >> this problem with some help.
> >>
> >> Here is a link to the GitHub issue with further information:
> >>
> >> https://github.com/Bumblebee-Project/Bumblebee/issues/764#issuecomment-241212595
> >>
> >> Here are some more detailed information:
> >>
> >> https://github.com/Lekensteyn/acpi-stuff/blob/master/Clevo-P651RA/notes.txt
> >>
> >> Hope somebody can help.
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
