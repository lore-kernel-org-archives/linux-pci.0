Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51607 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753519Ab2JaO2X (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 31 Oct 2012 10:28:23 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so1470017oag.19
        for <linux-pci@vger.kernel.org>; Wed, 31 Oct 2012 07:28:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CABZ6j6qH5q=txhAv4CntXpT3d4mzTapSdavz-8vsLw4Kism0QQ@mail.gmail.com>
References: <5090F723.3090103@gmail.com>
	<CAErSpo4sO9qrQdJLD6LxkrAKpzG+dbf9Oekv7PLLdXnZ0QQi2w@mail.gmail.com>
	<CABZ6j6qH5q=txhAv4CntXpT3d4mzTapSdavz-8vsLw4Kism0QQ@mail.gmail.com>
Date: Wed, 31 Oct 2012 15:28:22 +0100
Message-ID: <CABZ6j6r_ockwVN3KtGjFEO3VG2pWLsx7QrcA7EdNkheMORGJFg@mail.gmail.com>
Subject: Fwd: Linux and multy domain PCIe.
From: paolo faverio <fpaolo63@gmail.com>
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

resend to list

---------- Forwarded message ----------
From: paolo faverio <fpaolo63@gmail.com>
Date: Wed, Oct 31, 2012 at 3:21 PM
Subject: Re: Linux and multy domain PCIe.
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org


Thanks Bjorn,
I'm going to dig on it.

one silly question
Enabling both the RC, do l have  255  pci bus ids for each PCI segment
group?

thanks
paolo


On Wed, Oct 31, 2012 at 1:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>
> On Wed, Oct 31, 2012 at 4:02 AM, fpaolo63 <fpaolo63@gmail.com> wrote:
> > Hi guru,
> >
> > I'm working on a multi socket intel xeon platform.
> >
> > We have 2 sockets and each socket has a PCIe RootComplex, and we'd to
> > implement hw with 2 separated PCIe tree.
> >
> > Can Linux kernel handle the 2 RC assigning a PCIe domain each one?
> >
> > Do we need special BIOS in order to configure correctly the 2 sockets,
> > QDPI
> > channel, MMIO and MMU?
> >
> > Can some one point me to one example or documents?
>
> Yes, Linux supports multiple PCI domains (also known as PCI segment
> groups).
>
> On x86, the BIOS should provide a ACPI PNP0A08/PNP0A03 device for each
> root complex.  See drivers/acpi/pci_root.c for details.
