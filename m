Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:50022 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750847Ab2GQSZA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jul 2012 14:25:00 -0400
Received: by lbbgm6 with SMTP id gm6so962435lbb.19
        for <linux-pci@vger.kernel.org>; Tue, 17 Jul 2012 11:24:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <FC57104DF444434A9D1D8A7B4EBB29231353B632@HC-EXCHANGE.nt-fsrvr.o2micro.com>
References: <FC57104DF444434A9D1D8A7B4EBB29231353B632@HC-EXCHANGE.nt-fsrvr.o2micro.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 17 Jul 2012 12:24:37 -0600
Message-ID: <CAErSpo5tpn0o3NTZy3VCvhU4H7+vWCSdMVmgaexqY8VY_4h=yw@mail.gmail.com>
Subject: Re: FW: [Bug 43247] O2 micro SD/MMC+1394 controller: 1394 device
 can't work (Register access failure)
To: "Jennifer Li (TP)" <Jennifer.Li@o2micro.com>
Cc: linux-pci@vger.kernel.org, stefanr@s5r6.in-berlin.de,
	bugzilla-daemon@bugzilla.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> 1.)  Is there a kernel parameter which Jennifer could try in order to force serialized PCI driver probing?

I don't understand the question here.  As far as I know, drivers
compiled statically into the kernel are already initialized serially,
via the do_initcalls() -> do_initcall_level(6) path.  The PCI core
enumerates all the devices, then when we call each driver's
module_init() function (serially), the module_init() function will
register the driver, and the driver core will call the driver's
.probe() function for every matching PCI device.

> 2.)  If there is one and if this turns out to cure the issue in testing:
> How can I implement serialization between the O2Micro FireWire .probe() and .resume() on one hand and the O2Micro SDHCI .probe() and .resume() on the other hand?

If serialization is required between two drivers, that sounds like a
driver bug.  What are the two drivers involved?
