Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51701 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753420AbcBEPyS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 10:54:18 -0500
Date: Fri, 5 Feb 2016 09:54:12 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minghuan Lian <minghuan.lian@nxp.com>
Cc: Bhupesh Sharma <bhupesh.sharma@nxp.com>,
	"Shi, Yang" <yang.shi@linaro.org>,
	Yang-Leo Li <leoyang.li@nxp.com>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	Mingkai Hu <mingkai.hu@nxp.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>
Subject: Re: [PATCH] PCI: layerscape: add ls2085a compatible
Message-ID: <20160205155412.GB29306@localhost>
References: <1453915925-19198-1-git-send-email-yang.shi@linaro.org>
 <56A906F4.3050809@linaro.org>
 <20160204223711.GE7031@localhost>
 <56B3E386.8010002@linaro.org>
 <VI1PR04MB1230AA5CAEEEE0D4AD8E3DF288D20@VI1PR04MB1230.eurprd04.prod.outlook.com>
 <VI1PR04MB16155E4265922D6659B439C1E8D20@VI1PR04MB1615.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <VI1PR04MB16155E4265922D6659B439C1E8D20@VI1PR04MB1615.eurprd04.prod.outlook.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 06:07:10AM +0000, Minghuan Lian wrote:
> The patch is ok to me.

Thanks, I'll transform that into an ack.

Who's going to post a patch to update MAINTAINERS to fix the
@freescale.com addresses?  If we can get that in for v4.5, it will
save some hassle.

> > -----Original Message-----
> > From: Bhupesh Sharma
> > Sent: Friday, February 05, 2016 1:36 PM
> > To: Shi, Yang <yang.shi@linaro.org>; Bjorn Helgaas <helgaas@kernel.org>;
> > Yang-Leo Li <leoyang.li@nxp.com>; shawn.guo@linaro.org
> > Cc: Mingkai Hu <mingkai.hu@nxp.com>; Minghuan Lian
> > <minghuan.lian@nxp.com>; bhelgaas@google.com; linux-pci@vger.kernel.org;
> > linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linaro-kernel@lists.linaro.org
> > Subject: RE: [PATCH] PCI: layerscape: add ls2085a compatible
> > 
> > > From: Shi, Yang
> > > Sent: Friday, February 05, 2016 5:19 AM
> > >
> > > On 2/4/2016 2:37 PM, Bjorn Helgaas wrote:
> > > > On Wed, Jan 27, 2016 at 10:05:40AM -0800, Shi, Yang wrote:
> > > >> Correct FSL folks email address to nxp.com, sorry for the
> > > inconvenience.
> > > >
> > > > Do we need some MAINTAINERS updates in addition to the ack for this
> > > patch?
> > > > I see a bunch of @freescale.com addresses in MAINTAINERS.
> > >
> > > I guess so if the @freescale.com address is not valid anymore.
> > 
> > All @freescale.com address have shifted to @nxp.com.
> > 
> > Leo, Minghuan - can you kindly review this patch.
> > 
> > Shawn - can you take this through your tree, once Leo and Minghuan have
> > reviewed the code.
> > 
> > Regards,
> > Bhupesh
> > 
> > >
> > > >
> > > >> On 1/27/2016 9:32 AM, Yang Shi wrote:
> > > >>> The layerscape PCI host driver needs recognize ls2085a compatible
> > > >>> when using firmware with ls2085a compatible property, otherwise
> > > >>> the PCI bus won't be detected even though ls2085a compatible is
> > > >>> included
> > > by the dts.
> > > >>>
> > > >>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> > > >>> ---
> > > >>>   drivers/pci/host/pci-layerscape.c | 1 +
> > > >>>   1 file changed, 1 insertion(+)
> > > >>>
> > > >>> diff --git a/drivers/pci/host/pci-layerscape.c
> > > >>> b/drivers/pci/host/pci-layerscape.c
> > > >>> index 3923bed..c40d8b2 100644
> > > >>> --- a/drivers/pci/host/pci-layerscape.c
> > > >>> +++ b/drivers/pci/host/pci-layerscape.c
> > > >>> @@ -203,6 +203,7 @@ static const struct of_device_id
> > > ls_pcie_of_match[] = {
> > > >>>   	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata
> > > },
> > > >>>   	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata
> > > },
> > > >>>   	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata
> > > },
> > > >>> +	{ .compatible = "fsl,ls2085a-pcie", .data = &ls2080_drvdata },
> > > >>>   	{ },
> > > >>>   };
> > > >>>   MODULE_DEVICE_TABLE(of, ls_pcie_of_match);
> > > >>>
> > > >>
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-pci"
> > > in the body of a message to majordomo@vger.kernel.org More majordomo
> > > info at http://vger.kernel.org/majordomo-info.html
