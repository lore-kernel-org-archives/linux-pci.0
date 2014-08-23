Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:41822 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752454AbaHWLGb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 23 Aug 2014 07:06:31 -0400
Date: Sat, 23 Aug 2014 13:06:24 +0200
From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
To: Andreas Noever <andreas.noever@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	Matthew Garrett <matthew.garrett@nebula.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] x86, ia64: Move EFI_FB vga_default_device()
 initialization to pci_vga_fixup()
Message-ID: <20140823130624.06ecc057@neptune.home>
In-Reply-To: <CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
References: <20140514224339.7f8be3a9@neptune.home>
	<20140602201926.4d476818@neptune.home>
	<20140625005501.7ff7e982@neptune.home>
	<20140705171503.GC6247@google.com>
	<CAMxnaaXxAZAJAdr5AYYRZC_xKFCuyrfY=qpJu8x+P-S+osm5vw@mail.gmail.com>
	<CAMxnaaXGQe4vg9cY5e2KZBnG4F-z49OriwxEGUE-DCE6MKUryQ@mail.gmail.com>
	<20140810112654.1bf684d6@neptune.home>
	<CAMxnaaUsd+XHppMmPMXdFL13d1-OhLzoH_yjv_9abOx_uP=_Ug@mail.gmail.com>
	<20140810183411.19370721@neptune.home>
	<CAMxnaaVNpiSZmhQsHa_ZHJckgzG+xHyOL6hOT3Ts8GdcGN_A9g@mail.gmail.com>
	<20140816192135.34260115@neptune.home>
	<CAMxnaaWQoX9KMQVCKHTkeqSxGEybz5u1qU6AVBqzW3+mj_nJHQ@mail.gmail.com>
	<20140820075508.74f5b622@pluto>
	<20140820091152.76cd4e1a@pluto>
	<CAMxnaaUodONkqmdPWedN-Q1qheHiJAScFcG_XbX1--ZmiOQZDg@mail.gmail.com>
	<20140821233435.19a9cffa@neptune.home>
	<CAErSpo6D1B+dPLrYoAF4OA1KeWuW8VZW2_RR5jB1GbCRo+6vHg@mail.gmail.com>
	<20140822082324.12cb6e93@pluto>
	<CAMxnaaU9EiMcne-aQjS1sY1Orn6xGbVHEnd057ogcZ77p74Y=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 22 August 2014 Andreas Noever <andreas.noever@gmail.com> wrote:
> > For Andreas's system the discrete nvidia GPU has no I/O enabled
> > according to PCI_COMMAND flags while the integrated intel one does have
> > them (that's why the Intel GPU is chosen).
> >
> > Unfortunately I don't know what makes his system choke at boot time as
> > he did not provide logs for the failing case.
> Attached dmesg for the failing case (obtained via ssh).
>
> Without blacklisting a small horizontal bar of vertical green bars
> appears (no x, no console).

It's good to know that it's just the graphics (console / X) that are not
displaying properly.

> If nouveau is blacklisted then I get a console, but X will not start
> (No devices found).

The console you get is EFIFB (on the nvidia GPU to which display is routed).

Here the reason why X does not start is probably that i915 did not find
its VBIOS tables nor any connected monitor and thus X thinks "no active
output => I don't start".
Though your X would be able to start if it did not find xf86-video-intel
(intel_drv.so) and/or did find/had an explicit reference to xf86-video-fbdev
(fbdev_drv.so).

If under OSX you told your system to start on intel GPU (I think there
is an option in this direction) you system would probably boot fine as the
initial choice by vgaarb would match gmux/switcheroo settings.

> If i915 is blacklisted then I do not get a console. The screen just
> freezes after a few boot messages.

This is more interesting.

Initially you had efifb printing kernel logs until nouveau gets loaded
by udev and replaces efifb. From there on possibly applegmux does not
take over correctly (it may need both i915 and nouveau active to properly
route framebuffer to panel or connector).

Though your X should be telling the same thing as for nouveau blacklisted
as nvidia GPU is not the one having boot_vga set...

If not it may be worth finding out in what state your system exactly is
with regards to graphics.

> What is vga_default_device() used for? Is it supposed to hold the
> device that is controlling the (boot) screen? Why can't we just read
> the configuration from vga_switcheroo/gmux?

For systems not using vga_switcheroo:
  vga_default_device represents the PCI GPU that was used to boot (and
  normally handles legacy VGA I/O).
  It's never changed after boot (except eventually when a GPU gets
  hotplugged)

For systems with vga_switcheroo
  vga_default_device represents the active GPU (the one that would be
  handling legacy VGA I/O if used - and the one controlling the output
  connectors)
  vga_switcheroo is actively changing vga_default_device.


gmux is a driver for vga_switcheroo to perform the low-level platform
operations allowing switching (outputs) from one GPU to the other.


So a guess on my side would be that with both i915 and nouveau loaded
you may be able to get your display working if you can tell X to
switch GPU twice (and thus end up with matching vga_default_device
and device selected by gmux) - though I don't know how one asks for this
switch to happen.

> > If there is no better way to detect the proper legacy VGA device the
> > only remaining option would be to perform the screen_info testing in
> > vga_arb_device_init() enclosed in arch #ifdef...

I will propose a patch in this direction later this weekend.

Bruno
