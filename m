Return-Path: <SRS0=lMXa=OB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B47C43441
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A72220684
	for <linux-pci@archiver.kernel.org>; Thu, 22 Nov 2018 17:48:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A72220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732523AbeKWE3S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 22 Nov 2018 23:29:18 -0500
Received: from foss.arm.com ([217.140.101.70]:54916 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732157AbeKWE3S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 22 Nov 2018 23:29:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1472168F;
        Thu, 22 Nov 2018 09:48:53 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E102F3F5A0;
        Thu, 22 Nov 2018 09:48:52 -0800 (PST)
Date:   Thu, 22 Nov 2018 17:48:47 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc:     "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "joao.pinto@synopsys.com" <joao.pinto@synopsys.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: dwc: Remove 3-bit right rotation on MSI-X table
 offset address calculation
Message-ID: <20181122174847.GA19779@e107981-ln.cambridge.arm.com>
References: <a9c24a70e23dbc5a2d0300452588dc6a0b5e218a.1542903868.git.gustavo.pimentel@synopsys.com>
 <20181122170846.GB17826@e107981-ln.cambridge.arm.com>
 <bae11891-4a6e-3b30-196d-c138ef493ff8@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bae11891-4a6e-3b30-196d-c138ef493ff8@synopsys.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 22, 2018 at 05:31:06PM +0000, Gustavo Pimentel wrote:
> Hi Lorenzo,
> 
> On 22/11/2018 17:08, Lorenzo Pieralisi wrote:
> > On Thu, Nov 22, 2018 at 05:24:28PM +0100, Gustavo Pimentel wrote:
> >> Remove 3-bit right rotation on MSI-X table offset address calculation on
> >> dw_pcie_ep_raise_msix_irq().
> >>
> >> By default, the offset address of the MSI-X table is zero, so that even with a
> >> 3-bit right rotation, the computed result would still be zero, so still valid.
> >>
> >> Fixes: beb4641a787d ("PCI: dwc: Add MSI-X callbacks handler")
> >>
> >> Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> >> ---
> >>  drivers/pci/controller/dwc/pcie-designware-ep.c | 5 +++--
> >>  1 file changed, 3 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> index 1e7b022..cdb2005 100644
> >> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> >> @@ -440,7 +440,6 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>  	tbl_offset = dw_pcie_readl_dbi(pci, reg);
> >>  	bir = (tbl_offset & PCI_MSIX_TABLE_BIR);
> >>  	tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> >> -	tbl_offset >>= 3;
> > 
> > This looks wrong.>
> > - If tlb_offset is always 0 there would no point reading it (but I think
> >   that's a completely wrong assumption)
> > - If tlb_offset can be != 0 you are introducing a bug
> 
> That is the bug. I misunderstood the spec and I though that was
> required to perform 3-bit right rotation. Since my setup during the
> developing had the MSI-X table offset set to zero, this bug passed
> undetected. Now that my current setup has a MSI-X table offset
> different from zero I was able to detect this bug.

Correct, now I got it. You should reword the commit log since it is
not really clear that you are fixing a bug and add a Fixes: tag please,
this is not a minor bug and should go to stable kernels.

> >>  	reg = PCI_BASE_ADDRESS_0 + (4 * bir);
> >>  	bar_addr_upper = 0;
> >> @@ -466,8 +465,10 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
> >>  
> >>  	iounmap(msix_tbl);
> >>  
> >> -	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT)
> >> +	if (vec_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT) {
> >> +		dev_err(pci->dev, "MSI-X entry ctrl set\n");
> > 
> > Unrelated change.
> 
> Ups, that's right. It's just a debug message in case of error.
> Do you prefer a patch version 2 with the description including this debug
> message or do you prefer a second patch only with this debug message?

One patch one logical change. So I expect this patch to be split into
two (more so because this is a significant fix).

Thanks,
Lorenzo

> >>  		return -EPERM;
> >> +	}
> >>  
> >>  	ret = dw_pcie_ep_map_addr(epc, func_no, ep->msi_mem_phys, msg_addr,
> >>  				  epc->mem->page_size);
> >> -- 
> >> 2.7.4
> >>
> 
