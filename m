Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:63672 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934589Ab3E2RrQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 29 May 2013 13:47:16 -0400
Received: by mail-ie0-f179.google.com with SMTP id c13so25515648ieb.38
        for <linux-pci@vger.kernel.org>; Wed, 29 May 2013 10:47:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAH9N0t-DOC0iOMjtHUTznCzk=C7RpbdBOhYR=mK1zaAmeH-Rqw@mail.gmail.com>
References: <CAH9N0t-DOC0iOMjtHUTznCzk=C7RpbdBOhYR=mK1zaAmeH-Rqw@mail.gmail.com>
Date: Wed, 29 May 2013 10:47:15 -0700
Message-ID: <CAE9FiQXCf-h84sXqGPKbdd66oNbzWOtfea+PcHFiJPLPBc6oGQ@mail.gmail.com>
Subject: Re: Pcie Linux HotPlug Driver
From: Yinghai Lu <yinghai@kernel.org>
To: Paulo Ricardo Carvalho <pricardofc@ipfn.ist.utl.pt>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, May 29, 2013 at 10:30 AM, Paulo Fortuna Carvalho
<pricardofc@ipfn.ist.utl.pt> wrote:
> Hello Yinghai and Bjorn,
> Issue solved.
> You were correct. The module fakephp.ko was not loaded.

No, you should not use fackephp.ko. As it was removed already
in recent kernel.
It is replaced by pci slot driver.

In your case you should pciehp.ko

Please post boot log with "debug ignore_loglevel"


> Now everything works ok and device driver need not to be changed.
> As you said is a normal PCI Device Driver.
>
> Now I want that that when ATCA card is without energy ( 11:00.0 DPIO
> module: PLD APPLICATIONS Device 6014 (rev ff) )
>
> the command:
> echo 0 > /sys/bus/pci/slots/0000*/power is automatically executed.
>
> At the moment i'm doing it manually and after that my atca card driver
> is removed.
>
> And when i give energy to the ATCA card i have to manually perform pci
> bus re-enumeration
> with command:
> echo 1 > /sys/bus/pci/rescan
>
> and the ATCA card driver is automatically inserted. How can
> re-enumeration be done automatically?

If you can enable pciehp.ko for 04:08.0, then you can use
echo 0 > /sys/bus/pci/slots/48/power
echo 1 > /sys/bus/pci/slots/48/power

that should probe devices and load driver automatically.

Yinghai
