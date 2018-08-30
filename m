Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:38856 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeH3Lmd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Aug 2018 07:42:33 -0400
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so13831996oix.5
        for <linux-pci@vger.kernel.org>; Thu, 30 Aug 2018 00:41:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180828095722.GA8820@al>
References: <CAD8Lp46Y2eOR7WE28xToUL8s-aYiqPa0nS=1GSD0AxkddXq6+A@mail.gmail.com>
 <20180824154212.GB8601@al> <CAD8Lp45D6=pqsgr_tXS08pE0dbG1XhcwnDB3mGZQ=P3ETxywzw@mail.gmail.com>
 <20180828095722.GA8820@al>
From: Daniel Drake <drake@endlessm.com>
Date: Thu, 30 Aug 2018 15:41:43 +0800
Message-ID: <CAD8Lp44Re2menmZfY3GLExZVMDfQANTvG3hWC1wQwrXpQ6WKCA@mail.gmail.com>
Subject: Re: [Nouveau] Rewriting Intel PCI bridge prefetch base address bits
 solves nvidia graphics issues
To: Peter Wu <peter@lekensteyn.nl>
Cc: linux-pci@vger.kernel.org, nouveau@lists.freedesktop.org,
        Linux PM <linux-pm@vger.kernel.org>,
        Endless Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 28, 2018 at 5:57 PM, Peter Wu <peter@lekensteyn.nl> wrote:
> Just to be sure, after "sleep", do both devices report "suspended" in
> /sys/bus/pci/devices/0000:00:1c.0/power/runtime_status
> /sys/bus/pci/devices/0000:01:00.0/power/runtime_status
>
> and was this reproduced with a recent mainline kernel with no special
> cmdline options? The endlessm kernel on Github seems to have quite some
> patches, one of them explicitly disable runtime PM:
> https://github.com/endlessm/linux/commit/8b128b50cd6725eee2ae9025a1510a221d9b42f2

Yes, I checked for this issue in the past and I'm certain that nouveau
runtime pm works fine.

I also checked again now on X542UQ and the results are the same.
nouveau can do runtime suspend/resume (confirmed by reading
runtime_status) and then render 3D graphics OK. lspci is fine too. It
is just S3 suspend that is affected. This was testing on Linux 4.18
unmodified. I had to set nouveau runpm parameter to 1 for it to use
runtime pm.

Also checked with Karol's patch, the S3 issue is still there. Seems
like 2 different issues.

> Could you share some details:
> - acpidump
> - lspci -nnxxxxvvv
> - BIOS version (from /sys/class/dmi/id/)
> - kernel version (mainline?)

Linux 4.18 mainline
BIOS version: X542UQ.202
acpidump: https://gist.githubusercontent.com/dsd/79352284d4adce14f30d70e94fad89f2/raw/ed9480e924be413fff567da2edd5a2a7a86619d0/gistfile1.txt
pci: https://gist.githubusercontent.com/dsd/79352284d4adce14f30d70e94fad89f2/raw/ed9480e924be413fff567da2edd5a2a7a86619d0/pci

> Only non-bridge devices can be passed to a guest, but perhaps logging
> access to the emulated bridge is already sufficient. The Prefetchable
> Base Upper 32 Bits register is at offset 0x28.
>
> In a trace where the Nvidia device is disabled/enabled via Device
> Manager, I see writes on the enable path:
>
>     2571@1535108904.593107:rp_write_config (ioh3420, @0x28, 0x0, len=0x4)
>
> For Linux, I only see one write at startup, none on runtime resume.
> I did not test system sleep/resume. (disable/enable is arguably a bit
> different from system s/r, you may want to do additional testing here.)

I managed to install Win10 Home under virt-manager with the nvidia
device passed through.
However the nvidia windows driver installer refuses to install, says:
    The NVIDIA graphics driver is not compatible with this version of Windows.
    This graphics driver could not find compatible graphics hardware.

One trick for similar sounding problems is to change hypervisor vendor
ID but no luck here.

I was going to check if I can monitor PCI bridge config space access
even without the nvidia driver installed, but I can't find a way to
make the windows VM suspend and resume - the option is not available
in the VM.

Daniel
