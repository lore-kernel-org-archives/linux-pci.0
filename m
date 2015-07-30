Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38549 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbG3Q5v (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jul 2015 12:57:51 -0400
Received: by iggf3 with SMTP id f3so108721igg.1
        for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2015 09:57:50 -0700 (PDT)
Date: Thu, 30 Jul 2015 11:57:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-mmc@vger.kernel.org,
	Naveen Kumar Parna <pnaveenkos@gmail.com>
Subject: Re: Virtex-5 FPGA PCIE single-function device
Message-ID: <20150730165746.GH9640@google.com>
References: <CAHhAz+gJ3FKgLQLEjro8P+Dn+FPHykLur4fmEkAwFdrLPNoQng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAHhAz+gJ3FKgLQLEjro8P+Dn+FPHykLur4fmEkAwFdrLPNoQng@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Naveen]

On Wed, Jul 29, 2015 at 05:31:59PM +0530, Muni Sekhar wrote:
> [ Please keep me in CC as I'm not subscribed to the list]
> 
> Hello,
> 
> We are using the “Virtex-5 FPGA Integrated Endpoint Block for PCI
> Express” in Linux platform. It supports only a single-function(Header
> Type, Bit 7 is zero), but actually it is having different functions in
> different Bar’s.
> 
> It has UART hardware module implemented in the first Base Address
> Register and MMC host controller in other Base Address Register.

This is a really screwed up device.  Naveen asked about a similar
device recently [1], and I answered:

  The PCI infrastructure is designed such that a bus/device/function
  address identifies a single device.  To that device, we can attach a
  single driver, which manages all BARs on that device.  There is no
  provision for attaching one driver to BAR0 and a different driver to
  BAR1.

  To manage the device you describe, you'd have to have a driver that
  claims the entire PCI device, including both BARs.  That driver
  would internally deal with the UART, GPIO, 1-wire prom, and SD host
  controller modules.

> We are planning to develop our own pcie based uart driver for UART
> hardware and planning to use the MMC kernel stack for MMC host
> controller.
> 
> By default MMC kernel stack gets attached to this device. In the pcie
> based uart driver, tried configuring the uart module after getting the
> pci_dev structure with pci_get_device(not used the
> pci_register_driver). After that I could able to communicate with the
> UART registers even though MMC stack is attached to the device.

This might work, but it's an ugly hack.  It's not at all how the PCI
core is designed, and subverting the design like this may cause
problems down the road.

> Now I am puzzled and stuck with how to proceed further on UART
> Interrupt Service Routine for this kind of device. Can I use
> request_irq() for uart isr, do you have any suggestion on this?

You'd either have to write some kind of wrapper driver that claims the
whole device and make its ISR figure out which device is interrupting
and call either the UART or the MMC ISR, or hack up the MMC ISR to do
something similar.

If you have a choice, I suggest switching to a better-designed device.
This one sounds like it's just broken, and I think it's going to be a
headache to deal with it in software.

Bjorn

[1] http://lkml.kernel.org/r/CAG0bkv+Sve7+XWtGk-kkQU=-64CPbpE=5RMbVq-RzWNgg--6ZQ@mail.gmail.com

