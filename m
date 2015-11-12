Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:9386 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754332AbbKLM2y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2015 07:28:54 -0500
Date: Thu, 12 Nov 2015 20:24:28 +0800
From: Jisheng Zhang <jszhang@marvell.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-arm-kernel@lists.infradead.org>, <wangzhou1@hisilicon.com>,
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hisi: Fix Section mismatch compilation warning for
 probe()
Message-ID: <20151112202428.3c1cefc8@xhacker>
In-Reply-To: <4599031.EERjkvxHAA@wuerfel>
References: <1447329728-1589-1-git-send-email-jszhang@marvell.com>
	<4599031.EERjkvxHAA@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 12 Nov 2015 13:21:02 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Thursday 12 November 2015 20:02:08 Jisheng Zhang wrote:
> > Following compilation warning occurs when compiled with:
> > CONFIG_DEBUG_SECTION_MISMATCH=y
> > 
> >  WARNING: drivers/pci/host/built-in.o(.data+0x308): Section mismatch in
> >  reference from the variable hisi_pcie_driver to the function
> >  .init.text:hisi_pcie_probe()
> > 
> > Fix it by dropping __init from hisi_pcie_probe().  
> 
> The patch description should ideally say what the impact is here, not
> only what the warning says.
> 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > Fixes: 500a1d9a43e0 ("PCI: hisi: Add HiSilicon SoC Hip05 PCIe driver")
> > ---
> >  drivers/pci/host/pcie-hisi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pcie-hisi.c b/drivers/pci/host/pcie-hisi.c
> > index 35457ec..1cc0a21 100644
> > --- a/drivers/pci/host/pcie-hisi.c
> > +++ b/drivers/pci/host/pcie-hisi.c
> > @@ -139,7 +139,7 @@ static int __init hisi_add_pcie_port(struct pcie_port *pp,
> >         return 0;
> >  }
> >  
> > -static int __init hisi_pcie_probe(struct platform_device *pdev)
> > +static int hisi_pcie_probe(struct platform_device *pdev)
> >  {
> >         struct hisi_pcie *hisi_pcie;
> >         struct pcie_port *pp;  
> 
> This seems incomplete, you now get a new warning about hisi_add_pcie_port().

oops, yes. Thanks.

> 
> I did a similar patch yesterday, will follow up with my version.

Your version is completed.

Thanks,
Jisheng
