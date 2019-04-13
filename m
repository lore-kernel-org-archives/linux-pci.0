Return-Path: <SRS0=v2Vw=SP=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F158C282CE
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D2BE214D8
	for <linux-pci@archiver.kernel.org>; Sat, 13 Apr 2019 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555170287;
	bh=M0cC4PjgFnIKBfAPn9xubHpEuRhva+tnS31LyAoiiWg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E38NCHYdfst26+X6XFkQC7lQoHK7HfwOiqlHQLUWz6fGjk1fMYSf0IdTOHIkNlcYh
	 JY9MffOiXRykuJfN2mEl05EmFUTbowOt49+hQc5KX+2L7dtE9G4+KbbOz4VJBsSubC
	 CRp/G63u6N/a3qYCvr7lzG7yJsoASfO75Hsmw7Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDMPol (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:44:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727048AbfDMPol (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Apr 2019 11:44:41 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D3F7214D8;
        Sat, 13 Apr 2019 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555170280;
        bh=M0cC4PjgFnIKBfAPn9xubHpEuRhva+tnS31LyAoiiWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kPOMWg0i+shPWMTgNPqGDHL/Brs+hgUiHtfZ3ZPtMXe9aXijlnXiCVUwLzBNQmWWG
         QBjmIcXIsiknukTAV2X1tKH8aECkUzarDSp37olRkiXjdUhKI/Xcnk+5nIyHwKlYyv
         Jl6Q6gd4t+DNH0BHThP3RWVpfQJLfhSJ060qEqIU=
Date:   Sat, 13 Apr 2019 10:44:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-kernel@axis.com,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH v3 20/26] PCI: dwc: Fix dw_pcie_ep_find_capability to
 return correct capability offset
Message-ID: <20190413154437.GG126710@google.com>
References: <20190325093947.32633-1-kishon@ti.com>
 <20190325093947.32633-21-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325093947.32633-21-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 03:09:41PM +0530, Kishon Vijay Abraham I wrote:
> commit beb4641a787df79a ("PCI: dwc: Add MSI-X callbacks handler") while
> adding MSI-X callback handler, introduced dw_pcie_ep_find_capability and
> __dw_pcie_ep_find_next_cap for finding the MSI and MSIX capability.
> 
> However if MSI or MSIX capability is the last capability (i.e there are
> no additional items in the capabilities list and the Next Capability
> Pointer is set to '0'), __dw_pcie_ep_find_next_cap will return '0'
> even though MSI or MSIX capability may be present. This is because of
> incorrect ordering of "next_cap_ptr" check. Fix it here.

Nice fix.  It looks like dw_pcie_ep_find_capability() is currently
only used for MSI and MSI-X, but IIUC, it *could* be used for any
capability, so this commit message seems a little too specific.

It would be slightly less confusing if beb4641a787d ("PCI: dwc: Add
MSI-X callbacks handler") had been split into a commit that added the
general-purpose dw_pcie_ep_find_capability() and a commit that used it
for MSI and MSI-X, but obviously we can't change history.

> Fixes: beb4641a787df79a142 ("PCI: dwc: Add MSI-X callbacks handler")

These commit references are longer than necessary (and different -
19-char SHA1 here and 16 chars above).  I typically use 12 chars via

  gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'


> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index dc6a4bbd3ace..74477ad7467f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -46,16 +46,19 @@ static u8 __dw_pcie_ep_find_next_cap(struct dw_pcie *pci, u8 cap_ptr,
>  	u8 cap_id, next_cap_ptr;
>  	u16 reg;
>  
> +	if (!cap_ptr)
> +		return 0;
> +
>  	reg = dw_pcie_readw_dbi(pci, cap_ptr);
> -	next_cap_ptr = (reg & 0xff00) >> 8;
>  	cap_id = (reg & 0x00ff);
>  
> -	if (!next_cap_ptr || cap_id > PCI_CAP_ID_MAX)
> +	if (cap_id > PCI_CAP_ID_MAX)
>  		return 0;
>  
>  	if (cap_id == cap)
>  		return cap_ptr;
>  
> +	next_cap_ptr = (reg & 0xff00) >> 8;
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> @@ -67,9 +70,6 @@ static u8 dw_pcie_ep_find_capability(struct dw_pcie *pci, u8 cap)
>  	reg = dw_pcie_readw_dbi(pci, PCI_CAPABILITY_LIST);
>  	next_cap_ptr = (reg & 0x00ff);
>  
> -	if (!next_cap_ptr)
> -		return 0;
> -
>  	return __dw_pcie_ep_find_next_cap(pci, next_cap_ptr, cap);
>  }
>  
> -- 
> 2.17.1
> 
