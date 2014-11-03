Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:65221 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbaKCKJl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 05:09:41 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirqus@gmail.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org, Anton Vorontsov <avorontsov@mvista.com>,
	liviu.dudau@arm.com, Krzysztof Halasa <khalasa@piap.pl>
Subject: Re: [RFC PATCH 1/2] arm: cns3xxx: pci: remove artificial dependency on pci_sys_data domain
Date: Mon, 03 Nov 2014 11:09:10 +0100
Message-ID: <1836395.qmSSqUtRH7@wuerfel>
In-Reply-To: <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com> <1414669490-1217-2-git-send-email-lorenzo.pieralisi@arm.com> <CAHXqBFKrVhjKGRmvWep_KsNt2WDM42g5qqpoEUTnuYSZexyt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday 01 November 2014 13:32:08 Michał Mirosław wrote:
> > @@ -335,7 +328,8 @@ void __init cns3xxx_pcie_init_late(void)
> >                 cns3xxx_pwr_soft_rst(0x1 << PM_SOFT_RST_REG_OFFST_PCIE(i));
> >                 cns3xxx_pcie_check_link(&cns3xxx_pcie[i]);
> >                 cns3xxx_pcie_hw_init(&cns3xxx_pcie[i]);
> > -               pci_common_init(&cns3xxx_pcie[i].hw_pci);
> > +               private_data = &cns3xxx_pcie[i];
> > +               pci_common_init(&hw_pci);
> >         }
> 
> This looks weird. hw_pci.private_data is a pointer to a (temporary)
> pointer to private data?
> 

hw_pci is a local data structure that is only used to pass arguments
to pci_common_init. hw_pci->private_data is a pointer to an array of
pointers to the private data in each host bridge that is created in
the new domain during the call to pci_common_init. Like most other
callers, cns3xxx creates only one host bridge per domain, so it's
an array that contains only one entry.

	Arnd
