Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D01C0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4521920854
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MNlWCKsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4521920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbeKEVs4 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:48:56 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:50658 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727337AbeKEVs4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 16:48:56 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id EF8E710C1102;
        Mon,  5 Nov 2018 04:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541420965; bh=NNRpqDEe7aIs09Gq5JxAGtct8MIkOcbAirPVuDJCgA0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=MNlWCKspKZfj+aj56QJqQy2UBVb2YI2z06YjCnvjMAwUpx9K9NoRImpoDasHGLefl
         Dr5Kzb9iUo6mkfW1RDtgYK3lZmZvsGZUIgW5BVk6MXaWZZYbW4gz3JUpBalI/sBIF0
         WCLMQr5JZ7Z3I8sXpkk08wWbXIDf5mdsqpMR4uNiQNjBL8vxhUGdGy1pCg0aw4r15X
         iAsS/57HLe0eruzI6u1GaHEBjkOaahZwxx4DkgduHpaWoWm50BjvxeMEGjAS2HKGZw
         BZyAww6OQ1B/MWqFIv5U9OH+WPcuORvwVdm6JZI0w7j6345C2AUQJW/xTLpb7/Nk04
         1IDtSer5VtEWw==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id D611F371A;
        Mon,  5 Nov 2018 04:29:24 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 04:29:24 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:29:22 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:29:22 +0100
Subject: Re: [PATCH 2/4] PCI/dwc: Fix the 4GiB outbound window size truncated
 to zero issue
To:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>
CC:     Roy Zang <roy.zang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
References: <20181025092229.28413-1-Zhiqiang.Hou@nxp.com>
 <20181025092229.28413-3-Zhiqiang.Hou@nxp.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <681034bb-f73b-1793-ed48-ff49e8b58cf5@synopsys.com>
Date:   Mon, 5 Nov 2018 12:25:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025092229.28413-3-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 25/10/2018 10:22, Z.q. Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> 
> The current type of mem_size is 'u32', so when resource_size()
> return 4G it will be truncated to zero. This patch fix it by
> changing its type to 'u64'.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 4 ++--
>  drivers/pci/controller/dwc/pcie-designware.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 2153956a0b20..7ac5989c23ef 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -106,7 +106,7 @@ static void dw_pcie_writel_ob_unroll(struct dw_pcie *pci, u32 index, u32 reg,
>  
>  static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  					     int type, u64 cpu_addr,
> -					     u64 pci_addr, u32 size)
> +					     u64 pci_addr, u64 size)
>  {
>  	u32 retries, val;
>  
> @@ -141,7 +141,7 @@ static void dw_pcie_prog_outbound_atu_unroll(struct dw_pcie *pci, int index,
>  }
>  
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index, int type,
> -			       u64 cpu_addr, u64 pci_addr, u32 size)
> +			       u64 cpu_addr, u64 pci_addr, u64 size)
>  {
>  	u32 retries, val;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9f1a5e399b70..a438c3879aa9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -153,7 +153,7 @@ struct pcie_port {
>  	u32			io_size;
>  	u64			mem_base;
>  	phys_addr_t		mem_bus_addr;
> -	u32			mem_size;
> +	u64			mem_size;
>  	struct resource		*cfg;
>  	struct resource		*io;
>  	struct resource		*mem;
> @@ -238,7 +238,7 @@ int dw_pcie_link_up(struct dw_pcie *pci);
>  int dw_pcie_wait_for_link(struct dw_pcie *pci);
>  void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
>  			       int type, u64 cpu_addr, u64 pci_addr,
> -			       u32 size);
> +			       u64 size);
>  int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int bar,
>  			     u64 cpu_addr, enum dw_pcie_as_type as_type);
>  void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
> 

Nice catch! :)

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

