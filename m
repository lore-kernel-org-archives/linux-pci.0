Return-Path: <SRS0=18Ni=NF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3DAC46475
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1673A2083E
	for <linux-pci@archiver.kernel.org>; Thu, 25 Oct 2018 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBGS+OUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1673A2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJYWSP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727236AbeJYWSP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Oct 2018 18:18:15 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 339C920831;
        Thu, 25 Oct 2018 13:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540475125;
        bh=9IRKv4QjckEAESzxZFcqmCetyj/ofEetZojH9TZmEAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SBGS+OUhF8ZhaVSBiuZZfiyWn2KAMhjcskRNeLSBraE5jwozxspdrBnPAr9OBwKE5
         ga6Q7wj6RvPlTQ4/v2taRkYCp4DfG/Uscrkh46OhhH+FoOQCK4JNYUxIm3P4m0ME/C
         /wVGyfBamO/6BFTr36YmQJyLxfzUjaTqKbQf33Es=
Date:   Thu, 25 Oct 2018 08:45:22 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: Re: [PATCH] PCI/Layerscape: fix wrongly invoking of outbound window
 disable accessor
Message-ID: <20181025134522.GE214775@bhelgaas-glaptop.roam.corp.google.com>
References: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025085323.8819-1-Zhiqiang.Hou@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

  $ git log --oneline --follow drivers/pci/controller/dwc/pci-layerscape.c | head
  6e0832fa432e PCI: Collect all native drivers under drivers/pci/controller/
  3f43ccc4ea1b PCI: dwc: Remove old MSI IRQs API
  8cfab3cf63cf PCI: Add SPDX GPL-2.0 to replace GPL v2 boilerplate
  84d897d69938 PCI: layerscape: Change default error response behavior
  a335b122ba27 PCI: layerscape: Add support for ls1012a
  03fc6134c260 PCI: layerscape: Add support for ls1088a
  8f89357094e6 PCI: layerscape: Add support for ls2088a
  c3f909398827 PCI: layerscape: Remove unnecessary class code fixup
  e44abfed6fcb PCI: dwc: Add accessors for write permission of DBI read-only registers
  4a2745d760fa PCI: layerscape: Disable outbound windows configured by bootloader

Make yours match, e.g., "PCI: layerscape: Call dw_pcie_disable_atu()
correctly"

On Thu, Oct 25, 2018 at 08:53:37AM +0000, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> This issue is introduced by commit 4a2745d760fac ("PCI: layerscape: Disable
> outbound windows configured by bootloader").

Conventional commit reference:

  $ git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n" 4a2745d760fac
  4a2745d760fa ("PCI: layerscape: Disable outbound windows configured by bootloader")

Holy cow, this has been broken since v4.14.  If fixing this makes a
difference, you might want to tag it for stable.

> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-layerscape.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 69f3f1a5a782..b2085988dbee 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -88,7 +88,7 @@ static void ls_pcie_disable_outbound_atus(struct ls_pcie *pcie)
>  	int i;
>  
>  	for (i = 0; i < PCIE_IATU_NUM; i++)
> -		dw_pcie_disable_atu(pcie->pci, DW_PCIE_REGION_OUTBOUND, i);
> +		dw_pcie_disable_atu(pcie->pci, i, DW_PCIE_REGION_OUTBOUND);
>  }
>  
>  static int ls1021_pcie_link_up(struct dw_pcie *pci)
> -- 
> 2.17.1
> 
