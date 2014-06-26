Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40372 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750960AbaFZJ1F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 26 Jun 2014 05:27:05 -0400
From: Juergen Borleis <jbe@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Subject: Re: [RFC] PCI: pci-imx6: Add delay to workaround kernel hang
Date: Thu, 26 Jun 2014 11:26:09 +0200
Cc: Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawn.guo@freescale.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <r65037@freescale.com>,
	"David =?iso-8859-1?q?M=FCller?= (ELSOFT AG)" <d.mueller@elsoft.ch>,
	Sascha Hauer <kernel@pengutronix.de>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Tim Harvey <tharvey@gateworks.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
References: <1403637507-9424-1-git-send-email-festevam@gmail.com> <201406260932.30524.jbe@pengutronix.de> <201406261117.12542.marex@denx.de>
In-Reply-To: <201406261117.12542.marex@denx.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201406261126.09235.jbe@pengutronix.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek,

On Thursday 26 June 2014 11:17:12 Marek Vasut wrote:
> On Thursday, June 26, 2014 at 09:32:30 AM, Juergen Borleis wrote:
> > On Thursday 26 June 2014 05:43:19 Fabio Estevam wrote:
> > > [...]
> > >
> > > Below is the log with linux-next kernel and earlyprintk enabled:
> >
> > Does it also hang when you disable "earlyprintk"? A few weeks ago we had
> > a similar issue with i.MX6/PCI and "earlyprintk" (at the end it was
> > caused by a clock change for the UART when changing from the early to the
> > regular console).
>
> How can the UART clock have impact on the PCIe please ?

Not to the PCIe hardware, it just hanged the kernel when the PCIe driver came 
up (due to some of its messages it tries to output at this moment).

jbe

-- 
Pengutronix e.K.                              | Juergen Borleis             |
Industrial Linux Solutions                    | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
