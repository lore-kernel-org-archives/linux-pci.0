Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:34555 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbHCPls (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2015 11:41:48 -0400
Received: by wibud3 with SMTP id ud3so141457757wib.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2015 08:41:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
References: <CABLseQ6HhaozD6D0Y-gPpjz1R5Ass_-mumn9jfcWReAVvrdjHQ@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 3 Aug 2015 10:41:27 -0500
Message-ID: <CAErSpo4f_BLrnq7T2foOA2HAySPTDVYn61dfyOfZahyiyzGTdg@mail.gmail.com>
Subject: Re: Failure to HotPlug if devices not present at boot - no memory space
To: Barry Grussling <barry@grussling.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Barry,

On Mon, Aug 3, 2015 at 10:28 AM, Barry Grussling <barry@grussling.com> wrote:
> Hello,
>
> I am having some issues with PCIe hotplug on Linux.  Bottom
> line is if PCIe endpoints are present and enabled on boot,
> things work fine.  I can disable/enable endpoints and rescan
> the PCI chain great and everything is found and loaded.
>
> If PCIe endpoints are not present on boot and instead
> are added later, I get "no space" and "failed to assign"
> when I try to rescan the PCIe bus.
>
> Booting with pci=realloc=on seems to have no effect.
>
> I have verified I have CONFIG_PCI_REALLOC_ENABLE_AUTO=y
> and CONFIG_PCI_IOV=y in my config.
>
> The root complex is an ARM Cortex A9 SoC.  There is
> a PLX PEX 8619 16-lane PCIe switch chip hooked up to
> the root complex of the SoC.

Can you attach complete dmesg logs and "lspci -vv" output for both
cases?  (You can attach them to a kernel.org bugzilla if they're too
big for email.)

> ...
> Note the working system allocates 0xc0000000 to 0xc7dfffff to
> the PCI subsystem but the failing boot only allocates 0xc0000000
> to 0xc59fffff.

The dmesg logs will tell us what space is allocated to the host
bridge.  That is generally done by firmware or the bootloader, and
Linux doesn't change it.  So if firmware only assigns 0xc0000000 to
0xc59fffff to the host bridge, the current Linux kernel will only
assign PCI devices inside that region; it will never expand the
region.

Bjorn
