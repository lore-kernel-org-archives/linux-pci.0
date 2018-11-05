Return-Path: <SRS0=Hm5h=NQ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F43EC0044C
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017F220854
	for <linux-pci@archiver.kernel.org>; Mon,  5 Nov 2018 12:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="RLlFE4J9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 017F220854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726368AbeKEVmC (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 5 Nov 2018 16:42:02 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:50470 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVmC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Nov 2018 16:42:02 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 2190C10C1102;
        Mon,  5 Nov 2018 04:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1541420552; bh=ksbHQ5PvnQ2/FcPBvY0xK6iBRSXj3tU0N5zuVW9P0Qo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=RLlFE4J9BgmIvctcpqwxpF5zHP6cO8w0PAWB5uXW0bRR42ShLMAVVizYEEbvv8ggZ
         7iFppZh/s3q7VCjLs5Ij9Z5Bi8UP/ffMWp0UhkbGCxt2G34AOweSA7gM6CtgHnJjxM
         zhR6mRq0kgpEA9LvW62jLUto1OPt54t6Hr0KGjqT66sUEDpo5HZisI3EJ+b1ifRqqD
         0a7FDqSjahXtzXErwRhKoskVgPDbdy27nl2UXl1va0igTPBVyKTSEl7zsIZAUJeYow
         t2YaX99SWrP7wg6IX47+7Dklhno5DDQecG+LzK19VVp7JWvZzmn4UuPHyw2KbJGhfq
         l7qt5K3+jG8kw==
Received: from US01WEHTC2.internal.synopsys.com (us01wehtc2-vip.internal.synopsys.com [10.12.239.238])
        by mailhost.synopsys.com (Postfix) with ESMTP id E0FC73FD7;
        Mon,  5 Nov 2018 04:22:31 -0800 (PST)
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 US01WEHTC2.internal.synopsys.com (10.12.239.237) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 04:22:31 -0800
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.92) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:22:29 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 5 Nov 2018 13:22:29 +0100
Subject: Re: [PATCH 1/4] PCI/dwc: fix potential memory leak
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
 <20181025092229.28413-2-Zhiqiang.Hou@nxp.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <b2de1b89-c5d0-f14d-c9e2-3da25ada7f62@synopsys.com>
Date:   Mon, 5 Nov 2018 12:18:37 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181025092229.28413-2-Zhiqiang.Hou@nxp.com>
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
> Free the allocated pci_host_bridge struct when failed to get
> host bridge resources, and free the resource windows before
> free the bridge.
> 
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 29a05759a294..ecacce016489 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -353,7 +353,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
>  					&bridge->windows, &pp->io_base);
>  	if (ret)
> -		return ret;
> +		goto error;
>  
>  	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
>  	if (ret)
> @@ -502,6 +502,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
>  	return 0;
>  
>  error:
> +	pci_free_resource_list(&bridge->windows);
>  	pci_free_host_bridge(bridge);
>  	return ret;
>  }
> 

Thanks for the memory leak fix. :)

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
