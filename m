Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:33661 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbaHSPpV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Aug 2014 11:45:21 -0400
Received: by mail-ie0-f171.google.com with SMTP id at1so1328078iec.30
        for <linux-pci@vger.kernel.org>; Tue, 19 Aug 2014 08:45:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140816192135.34260115@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home> <20140527234255.GJ11907@google.com>
 <20140602201650.35f0e936@neptune.home> <20140602201926.4d476818@neptune.home>
 <20140625005501.7ff7e982@neptune.home> <20140705171503.GC6247@google.com>
 <CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
 <CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
 <20140810112654.1bf684d6@neptune.home> <CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
 <20140810183411.19370721@neptune.home> <CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
 <20140816192135.34260115@neptune.home>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Tue, 19 Aug 2014 17:45:00 +0200
Message-ID: <CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Aug 16, 2014 at 7:21 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> This series improves on commit 20cde694027e (x86, ia64: Move EFI_FB
> vga_default_device() initialization to pci_vga_fixup()):
> - cleanup remaining but always-true #ifndefs
> - fix boot regression on dual-GPU Macs
>
> Andreas, can you please test this series? It is a modification from
> previous testing patch that should still work fine for you.
> That testing patch would have been failing X startup on old BIOS systems
> booted with vga=normal (or otherwise in VGA text mode).
>
>
> Greg, in case you have scheduled above-mentioned commit for your next
> stable iteration, please hold it back in the queue until this follow-up
> has landed and can be included within the same stable update as alone
> that patch regresses for Macs with dual-GPU and using efifb.
>
> Bruno

Fails again (with and without efifb).

The vga_set_default_device in vga_arbiter_add_pci_device is at fault.
It sets the boot video device to intel. Removing it makes the system
bootable again.
