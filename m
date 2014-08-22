Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f51.google.com ([209.85.216.51]:34861 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831AbaHVEjw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Aug 2014 00:39:52 -0400
Received: by mail-qa0-f51.google.com with SMTP id k15so9087141qaq.24
        for <linux-pci@vger.kernel.org>; Thu, 21 Aug 2014 21:39:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140821233435.19a9cffa@neptune.home>
References: <20140514224339.7f8be3a9@neptune.home> <20140527234255.GJ11907@google.com>
 <20140602201650.35f0e936@neptune.home> <20140602201926.4d476818@neptune.home>
 <20140625005501.7ff7e982@neptune.home> <20140705171503.GC6247@google.com>
 <CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
 <CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
 <20140810112654.1bf684d6@neptune.home> <CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
 <20140810183411.19370721@neptune.home> <CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
 <20140816192135.34260115@neptune.home> <CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
 <20140820075508.74f5b622@pluto> <20140820091152.76cd4e1a@pluto>
 <CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com> <20140821233435.19a9cffa@neptune.home>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 21 Aug 2014 23:39:31 -0500
Message-ID: <CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
To: =?UTF-8?Q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>
Cc: Andreas Noever <andreas.noever@gmail.com>,
	DRI mailing list <dri-devel@lists.freedesktop.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Dave Airlie <airlied@linux.ie>,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 21, 2014 at 4:34 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:

> A second step would then be to tune vgaarb's initial selection.
> Bjorn, is it possible to verify which I/O ports are decoded by a PCI
> device at the time of adding it to vgaarb? If so, how? I would like to
> check for legacy VGA I/O range (0x03B0-0x03DF) and only let vgaarb set
> a device as default if that I/O range is decoded by the device.

I don't know of a way.  I'm pretty sure VGA devices are allowed to
respond to those legacy addresses even if there's no BAR for them, but
I haven't found a spec reference for this.  There is the VGA Enable
bit in bridges, of course (PCI Bridge spec, sec 12.1.1.  If the VGA
device is behind a bridge that doesn't have the VGA Enable bit set, it
probably isn't the default device.

Bjorn
