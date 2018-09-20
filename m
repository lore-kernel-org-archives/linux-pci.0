Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF03BC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D9D21534
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 21:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xdFYNMll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D9D21534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeIUDXX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 23:23:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:40574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbeIUDXX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 23:23:23 -0400
Received: from localhost (unknown [207.160.231.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A4D21523;
        Thu, 20 Sep 2018 21:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537479470;
        bh=tjmydkzPFl9wcS2cB5L/bQSxAYMjz99lFBfJcKuA8pI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xdFYNMllGTR3ykxpcn5JKHHHGIu2YgMunjCZAoDagL+0PgAfONY1qBfc4DLYC6BLF
         gu+ke2ehwQNjxSec8R3MwYdBfY3WTPe7qLYjHAxhO0sTu+yLKPABz6ezUVKbustFsj
         hZKJSJ+mdHHsWtHuc6L/AieYUFNbE7p/xbF+7Z2E=
Date:   Thu, 20 Sep 2018 16:37:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dwc: fix scheduling while atomic issues
Message-ID: <20180920213749.GC224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180829110408.556c3622@xhacker.debian>
 <20180913150543.GA6199@e107981-ln.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180913150543.GA6199@e107981-ln.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 13, 2018 at 04:05:54PM +0100, Lorenzo Pieralisi wrote:
> On Wed, Aug 29, 2018 at 11:04:08AM +0800, Jisheng Zhang wrote:
> > When programming inbound/outbound atu, we call usleep_range() after
> > each checking PCIE_ATU_ENABLE bit. Unfortunately, the atu programming
> > can be called in atomic context:
> > 
> > inbound atu programming could be called through
> > pci_epc_write_header()
> >   =>dw_pcie_ep_write_header()
> >     =>dw_pcie_prog_inbound_atu()
> > 
> > outbound atu programming could be called through
> > pci_bus_read_config_dword()
> >   =>dw_pcie_rd_conf()
> >     =>dw_pcie_prog_outbound_atu()
> > 
> > Fix this issue by calling mdelay() instead.
> > 
> > Fixes: f8aed6ec624f ("PCI: dwc: designware: Add EP mode support")
> > Fixes: d8bbeb39fbf3 ("PCI: designware: Wait for iATU enable")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > ---
> 
> Applied to pci/controller-fixes aiming at one of the upcoming -rc*.

I cherry-picked this into for-linus for v4.19.

> > since v2:
> >  - Add Fixes tag
> >  - Add Gustavo's Ack
> > 
> > since v1:
> >  - use mdelay() instead of udelay() to avoid __bad_udelay()
> > 
> >  drivers/pci/controller/dwc/pcie-designware.c | 8 ++++----
> >  drivers/pci/controller/dwc/pcie-designware.h | 3 +--
> >  2 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index 778c4f76a884..2153956a0b20 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -135,7 +135,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> >  }
> > @@ -178,7 +178,7 @@ void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Outbound iATU is not being enabled\n");
> >  }
> > @@ -236,7 +236,7 @@ static int dw_pcie_prog_inbound_atu_unroll(struct dw_pcie *pci, int index,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> >  
> > @@ -282,7 +282,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
> >  		if (val & PCIE_ATU_ENABLE)
> >  			return 0;
> >  
> > -		usleep_range(LINK_WAIT_IATU_MIN, LINK_WAIT_IATU_MAX);
> > +		mdelay(LINK_WAIT_IATU);
> >  	}
> >  	dev_err(pci->dev, "Inbound iATU is not being enabled\n");
> >  
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> > index 96126fd8403c..9f1a5e399b70 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.h
> > +++ b/drivers/pci/controller/dwc/pcie-designware.h
> > @@ -26,8 +26,7 @@
> >  
> >  /* Parameters for the waiting for iATU enabled routine */
> >  #define LINK_WAIT_MAX_IATU_RETRIES	5
> > -#define LINK_WAIT_IATU_MIN		9000
> > -#define LINK_WAIT_IATU_MAX		10000
> > +#define LINK_WAIT_IATU			9
> >  
> >  /* Synopsys-specific PCIe configuration registers */
> >  #define PCIE_PORT_LINK_CONTROL		0x710
> > -- 
> > 2.18.0
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
