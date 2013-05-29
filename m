Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:52017 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754614Ab3E2RaO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 13:30:14 -0400
Received: by mail-la0-f53.google.com with SMTP id ea20so8871686lab.40
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2013 10:30:12 -0700 (PDT)
MIME-Version: 1.0
Reply-To: pricardofc@ipfn.ist.utl.pt
Date: Wed, 29 May 2013 18:30:12 +0100
Message-ID: <CAH9N0t-DOC0iOMjtHUTznCzk=C7RpbdBOhYR=mK1zaAmeH-Rqw@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
From: Paulo Fortuna Carvalho <pricardofc@ipfn.ist.utl.pt>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Yinghai and Bjorn,
Issue solved.
You were correct. The module fakephp.ko was not loaded.
Now everything works ok and device driver need not to be changed.
As you said is a normal PCI Device Driver.

Now I want that that when ATCA card is without energy ( 11:00.0 DPIO
module: PLD APPLICATIONS Device 6014 (rev ff) )

the command:
echo 0 > /sys/bus/pci/slots/0000*/power is automatically executed.

At the moment i'm doing it manually and after that my atca card driver
is removed.

And when i give energy to the ATCA card i have to manually perform pci
bus re-enumeration
with command:
echo 1 > /sys/bus/pci/rescan

and the ATCA card driver is automatically inserted. How can
re-enumeration be done automatically?

Paulo.
