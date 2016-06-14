Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48837 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750985AbcFNIhc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jun 2016 04:37:32 -0400
Message-ID: <1465893441.29321.7.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: imx6: Add support for MX6SX LDO PCIE domain
 regulator
From: Lucas Stach <l.stach@pengutronix.de>
To: Fabio Estevam <festevam@gmail.com>
Cc: Christoph Fritz <chf.fritz@googlemail.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 14 Jun 2016 10:37:21 +0200
In-Reply-To: <CAOMZO5A2SRPi=-_WJY87GYoY7vQ+e0vyQcNK8FL4fqxuOaHRqg@mail.gmail.com>
References: <1465344472-15703-1-git-send-email-festevam@gmail.com>
	 <1465378523.1870.26.camel@googlemail.com>
	 <CAOMZO5Bix1Bgrsbn2K_1sh7ee=dxRccU1zk2fJei-WU4vvpCgg@mail.gmail.com>
	 <1465814497.2313.7.camel@pengutronix.de>
	 <CAOMZO5A2SRPi=-_WJY87GYoY7vQ+e0vyQcNK8FL4fqxuOaHRqg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Fabio,

Am Dienstag, den 14.06.2016, 00:18 -0300 schrieb Fabio Estevam:
> Hi Lucas,
> 
> On Mon, Jun 13, 2016 at 7:41 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> 
> > It should be handled the same way as the PU domain regulator on mx6q.
> > This means the regulator is a supply of the PCIe PHY power domain and
> > should be en-/disabled through the GPC driver.
> >
> > I already posted a series to rework the GPC driver to allow adding new
> > power domains easily, but it was rejected by Shawn on formal grounds, as
> 
> Could you please point me to this series?
> 
Here you go:

https://patchwork.kernel.org/patch/8599181/
https://patchwork.kernel.org/patch/8599251/
https://patchwork.kernel.org/patch/8599241/

Regards,
Lucas

