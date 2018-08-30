Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from lekensteyn.nl ([178.21.112.251]:39177 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbeH3Nll (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Aug 2018 09:41:41 -0400
Date: Thu, 30 Aug 2018 11:40:16 +0200
From: Peter Wu <peter@lekensteyn.nl>
To: Daniel Drake <drake@endlessm.com>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
Message-ID: <20180830094016.GA18925@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al>
 <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
 <CAD8Lp44Re2menmZfY3GLExZVMDfQANTvG3hWC1wQwrXpQ6WKCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAD8Lp44Re2menmZfY3GLExZVMDfQANTvG3hWC1wQwrXpQ6WKCA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 30, 2018 at 03:41:43PM +0800, Daniel Drake wrote:
> On Tue, Aug 28, 2018 at 5:57 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> > Just to be sure, after "sleep", do both devices report "suspended" in
> > /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status
> > /sys/bus/pci/devices/0000:01:00.0/power/runtime_status
> >
> > and was this reproduced with a recent mainline kernel with no special
> > cmdline options? The endlessm kernel on Github seems to have quite some
> > patches, one of them explicitly disable runtime PM:
> > https://github.com/endlessm/linux/commit/8b128b50cd6725eee2ae9025a1510a221d9b42f2
> 
> Yes, I checked for this issue in the past and I'm certain that nouveau
> runtime pm works fine.
> 
> I also checked again now on X542UQ and the results are the same.
> nouveau can do runtime suspend/resume (confirmed by reading
> runtime_status) and then render 3D graphics OK. lspci is fine too. It
> is just S3 suspend that is affected. This was testing on Linux 4.18
> unmodified. I had to set nouveau runpm parameter to 1 for it to use
> runtime pm.
> 
> Also checked with Karol's patch, the S3 issue is still there. Seems
> like 2 different issues.
> 
> > Could you share some details:
> > - acpidump
> > - lspci -nnxxxxvvv
> > - BIOS version (from /sys/class/dmi/id/)
> > - kernel version (mainline?)
> 
> Linux 4.18 mainline
> BIOS version: X542UQ.202
> acpidump: https://gist.githubusercontent.com/dsd/79352284d4adce14f30d70e94fad89f2/raw/ed9480e924be413fff567da2edd5a2a7a86619d0/gistfile1.txt
> pci: https://gist.githubusercontent.com/dsd/79352284d4adce14f30d70e94fad89f2/raw/ed9480e924be413fff567da2edd5a2a7a86619d0/pci

Thanks, based on the \_SB.PCI0.HGOF implementation, it looks like this
model will not be affected by the runtime suspend issue (it sets the
"Link Disable" register which is known to work for other models).

As the BIOS date is not visible, can you also confirm that this message
is visible in dmesg?

    nouveau: detected PR support, will not use DSM

FWIW, the latest BIOS version is 305, released at 2018/08/07:
https://www.asus.com/Laptops/ASUS-VivoBook-15-X542UQ/HelpDesk_BIOS/

> > Only non-bridge devices can be passed to a guest, but perhaps logging
> > access to the emulated bridge is already sufficient. The Prefetchable
> > Base Upper 32 Bits register is at offset 0x28.
> >
> > In a trace where the Nvidia device is disabled/enabled via Device
> > Manager, I see writes on the enable path:
> >
> >     2571@1535108904.593107:rp_write_config (ioh3420, @0x28, 0x0, len=0x4)
> >
> > For Linux, I only see one write at startup, none on runtime resume.
> > I did not test system sleep/resume. (disable/enable is arguably a bit
> > different from system s/r, you may want to do additional testing here.)
> 
> I managed to install Win10 Home under virt-manager with the nvidia
> device passed through.
> However the nvidia windows driver installer refuses to install, says:
>     The NVIDIA graphics driver is not compatible with this version of Windows.
>     This graphics driver could not find compatible graphics hardware.
> 
> One trick for similar sounding problems is to change hypervisor vendor
> ID but no luck here.

For laptops, it appears that you have to do at least two things:
- Ensure that the Subsystem Vendor/Product ID are set.
- Expose a _ROM ACPI method that provides VBIOS.

Perhaps you also need to provide a "_DSM" method that emulates at least
the "Optimus" interface for GUID a486d8f8-0bda-471b-a72b-6042a6b5bee0.

You probably lost interest here, but if you want to continue anyway this
is what allowed me to install the driver on the XPS 9560:
https://github.com/Lekensteyn/acpi-stuff/blob/master/d3test/fakedev.asl

If you adapt if for your environment, note:
- I have only tested this with the q35 machine type with an additional
  ioh3420 root port. See the XPS956/boot-vm script.
- The \_SB.PCI0.SE0 device should match the root port:
  cat /sys/bus/pci/devices/0000:00:1c.0/firmware_node/path
  (the SE0 name is chosen by QEMU.)
- The "NET" (\_SB.PCI0.SE0.NET) device name is arbitrary chosen by me,
  it currently assumes PCI address 01:00.0:
  Name (_ADR, 0x00000000) // _ADR: Address (dev+fn only, 01:00.0)
- The _DSM method is copied from the XPS 9560 SSDT with external method
  references removed (focus on the code with "OPCI" true, the other two
  with NBCI and SGCI are irrelevant). One obvious difference with your
  SSDT is function 0x10, your OPVK ("Optimus Validation Key Object" is
  different and there is another "OPDR" check afterwards.

> I was going to check if I can monitor PCI bridge config space access
> even without the nvidia driver installed, but I can't find a way to
> make the windows VM suspend and resume - the option is not available
> in the VM.

The system cannot be suspended if the GPU device has no driver.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
