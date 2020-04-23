Return-Path: <SRS0=NHSM=6H=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07C7C54FD0
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 19:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 779C020780
	for <linux-pci@archiver.kernel.org>; Thu, 23 Apr 2020 19:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587668795;
	bh=Q+e7wbh0/bodULTWVv6BlC7Ry61IRTyy+hRF5kcJBLM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aD8R6QnmgsUAKxbFU/gxBPHGVG0AGmBcKdyv23EEBOfCFlDdqo6SPLa0RdjKVg+Kn
	 UU9hbryWQ/CUk/Yn5/Vkys/oKtbQY1TKM7E+NCcAiyNfkkccG2hoCFm/wFP0kpKku1
	 9C6fmG5GoQO7ZTQxmXOe2xszEkoaoKjYBr6QSypE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgDWTGe (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:06:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:43724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgDWTGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Apr 2020 15:06:34 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39F7120728;
        Thu, 23 Apr 2020 19:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587668794;
        bh=Q+e7wbh0/bodULTWVv6BlC7Ry61IRTyy+hRF5kcJBLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fJRF5ZjSSdtEC6P71fezhU9khJAHzxfi91KW72BdmETSEkuKZSr3D+G0oA+fxR8C8
         Shb/KrkK8TAnc2I1q0oR7SIioR4APV425hu0XIwSf1itNd9qj9wkZ9krFTNN+ettlt
         KaBolrUYwU/P2uLnyukrdVseDYpJMF2//+ziZHwE=
Received: by pali.im (Postfix)
        id 40C0E76C; Thu, 23 Apr 2020 21:06:32 +0200 (CEST)
Date:   Thu, 23 Apr 2020 21:06:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Remi Pommarel <repk@triplefau.lt>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Xogium <contact@xogium.me>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 5/9] PCI: aardvark: add FIXME comment for
 PCIE_CORE_CMD_STATUS_REG access
Message-ID: <20200423190632.7pjqqnxci2dsplwv@pali>
References: <20200421111701.17088-6-marek.behun@nic.cz>
 <20200423184413.GA202435@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200423184413.GA202435@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thursday 23 April 2020 13:44:13 Bjorn Helgaas wrote:
> [+cc Rob]
> 
> On Tue, Apr 21, 2020 at 01:16:57PM +0200, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > Register PCIE_CORE_CMD_STATUS_REG is applicable only when the controller
> > is configured for Endpoint mode, which is not the case for the current
> > version of this driver.
> > 
> > Add a FIXME comment, since this needs to be explained, removed or fixed.
> 
> If it's not applicable, why not just remove it?

Problem is hat if I remove this part of code, ath10k cards stops
working. So for some unknown reasons setting this "not applicable"
register is required.

I have in-progress V3 version of this patch series with updated comment
and commit message of this patch (include this observation).

> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  drivers/pci/controller/pci-aardvark.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index e2d18094d8ca..e893d7d8859f 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -429,6 +429,12 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
> >  
> >  	advk_pcie_train_link(pcie);
> >  
> > +	/*
> > +	 * FIXME: Following code which access PCIE_CORE_CMD_STATUS_REG register
> > +	 *        is suspicious. This register is applicable only when the PCI
> > +	 *        controller is configured for Endpoint mode. And not when it
> > +	 *        is configured for Root Complex.
> > +	 */
> >  	reg = advk_readl(pcie, PCIE_CORE_CMD_STATUS_REG);
> >  	reg |= PCIE_CORE_CMD_MEM_ACCESS_EN |
> >  		PCIE_CORE_CMD_IO_ACCESS_EN |
> > -- 
> > 2.24.1
> > 
