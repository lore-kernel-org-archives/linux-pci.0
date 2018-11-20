Return-Path: <SRS0=4GJS=N7=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286EDC18DF5
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E080F206B2
	for <linux-pci@archiver.kernel.org>; Tue, 20 Nov 2018 14:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E080F206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbeKUBFa (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:05:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47221 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbeKUBFa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Nov 2018 20:05:30 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gP78A-0008Cy-8d; Tue, 20 Nov 2018 15:35:58 +0100
Message-ID: <1542724556.2508.14.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/3] PCI: dwc: allow to limit registers set length
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Stefan Agner <stefan@agner.ch>, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, tpiepho@impinj.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 20 Nov 2018 15:35:56 +0100
In-Reply-To: <20181120132705.6917-1-stefan@agner.ch>
References: <20181120132705.6917-1-stefan@agner.ch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am Dienstag, den 20.11.2018, 14:27 +0100 schrieb Stefan Agner:
> Add length to the struct dw_pcie and check that the accessors
> dw_pcie_(rd|wr)_own_conf() do not read/write beyond that point.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

FWIW:

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..b422538ee0bb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -29,6 +29,8 @@ static int dw_pcie_rd_own_conf(struct pcie_port *pp, int where, int size,
> >  		return pp->ops->rd_own_conf(pp, where, size, val);
>  
> >  	pci = to_dw_pcie_from_pp(pp);
> > +	if (pci->dbi_length && where + size > pci->dbi_length)
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >  	return dw_pcie_read(pci->dbi_base + where, size, val);
>  }
>  
> @@ -41,6 +43,8 @@ static int dw_pcie_wr_own_conf(struct pcie_port *pp, int where, int size,
> >  		return pp->ops->wr_own_conf(pp, where, size, val);
>  
> >  	pci = to_dw_pcie_from_pp(pp);
> > +	if (pci->dbi_length && where + size > pci->dbi_length)
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> >  	return dw_pcie_write(pci->dbi_base + where, size, val);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9f1a5e399b70..5be5f369abf2 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -215,6 +215,7 @@ struct dw_pcie {
> > >  	struct device		*dev;
> > >  	void __iomem		*dbi_base;
> > >  	void __iomem		*dbi_base2;
> > > +	int			dbi_length;
> > >  	u32			num_viewport;
> > >  	u8			iatu_unroll_enabled;
> > >  	struct pcie_port	pp;
