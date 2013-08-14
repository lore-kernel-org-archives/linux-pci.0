Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37744 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933270Ab3HNVp5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 14 Aug 2013 17:45:57 -0400
Received: by mail-vc0-f174.google.com with SMTP id gd11so6662vcb.19
        for <linux-pci@vger.kernel.org>; Wed, 14 Aug 2013 14:45:57 -0700 (PDT)
MIME-Version: 1.0
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 14 Aug 2013 14:45:37 -0700
Message-ID: <CALCETrUHJg5qskadGG11fGvCVgbm=Zn0zuWv+CAgrEm9-Qcfdg@mail.gmail.com>
Subject: PCI devices w/ multiple drivers at once? (sb_edac vs i2c-imc)
To: linux-pci@vger.kernel.org, linux-edac@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm working on a driver for the Sandy Bridge iMC SMBUS controller.  It
(mostly) lives on pci device 15, function 0.  So my driver registers
as an ordinary PCI driver for that device (8086.3ca8).

The problem is that sb_edac also registers for 8086.3ca8.  This means
that the drivers conflict.  The sb_edac driver is actually driving
functionality that's split between eleven (!) different pci devices,
none of which overlaps the stuff I'm driving.

What's the Right Way (tm) to handle this?  Should I just modify
sb_edac to pick a different one of the 11 devices to probe?  Is there
some standard way to handle this in the PCI code?

--Andy
