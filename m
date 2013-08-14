Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:56898 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933115Ab3HNWE0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 18:04:26 -0400
Received: by mail-ie0-f169.google.com with SMTP id qd12so60349ieb.0
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 15:04:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
References: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 14 Aug 2013 16:04:06 -0600
Message-ID: <CAErSpo6Gp34O=L1ASPRLLBxwQShn6SN5EfXjDT+G7XAg3qbL-g@mail.gmail.com>
Subject: Re: PCI devices w/ multiple drivers at once? (sb_edac vs i2c-imc)
To: Andy Lutomirski <luto@amacapital.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-edac@vger.kernel.org,
	Mauro Carvalho Chehab <m.chehab@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 3:45 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> I'm working on a driver for the Sandy Bridge iMC SMBUS controller.  It
> (mostly) lives on pci device 15, function 0.  So my driver registers
> as an ordinary PCI driver for that device (8086.3ca8).
>
> The problem is that sb_edac also registers for 8086.3ca8.  This means
> that the drivers conflict.  The sb_edac driver is actually driving
> functionality that's split between eleven (!) different pci devices,
> none of which overlaps the stuff I'm driving.
>
> What's the Right Way (tm) to handle this?  Should I just modify
> sb_edac to pick a different one of the 11 devices to probe?  Is there
> some standard way to handle this in the PCI code?

Nope, there's no standard way to do this.

The single driver that claims a device is presumed to own all the
device's resources, including its config space, BARs, interrupts, etc.
 If two drivers need access to the same device, they need to
coordinate between themselves somehow.

Bjorn
