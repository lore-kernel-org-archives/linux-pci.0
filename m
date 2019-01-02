Return-Path: <SRS0=YnKd=PK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8890FC43387
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 570492075B
	for <linux-pci@archiver.kernel.org>; Wed,  2 Jan 2019 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="ewJa0WoK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbfABKRi (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:17:38 -0500
Received: from smtprelay4.synopsys.com ([198.182.47.9]:34402 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727294AbfABKRi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 2 Jan 2019 05:17:38 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id D8F4B24E11ED;
        Wed,  2 Jan 2019 02:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1546424258; bh=dVn8PzrY2tVGmJLGmwNOrof8PMvNIVBdLsSpBWH5zF4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=ewJa0WoKMc7VbHFWH0YHGE7gjktu8QgfYosap5huL7SgI1DP8qXoKYjSvv2OkZdbb
         8TABp3Hyora7lTktjDfgC2wdyQ0wJKT0DbqtD8X8v6L4xr/p+zZGvSKMnlxihKWyBI
         kwO6cnyaHt/LIQcV75bCb4vyG0Sk5RwDMNLW4lVZXusei1L5OE7DIuQmimmiOO4LWj
         +8G/yh4nyKvpszrmLTTOfU1EHkiztyRcj6EqBKKaIgcx4/xfSqgOsCCcB7IPns7pOt
         7/1tjrd8i2kxYq1H/po6N0ouYT7HZy4e4r7o3jgivD0Hi8lZKjptXANazK5d26gUqN
         +WYc0T0H05uZQ==
Received: from us01wehtc1.internal.synopsys.com (us01wehtc1-vip.internal.synopsys.com [10.12.239.236])
        by mailhost.synopsys.com (Postfix) with ESMTP id EDEC83CC2;
        Wed,  2 Jan 2019 02:17:36 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 us01wehtc1.internal.synopsys.com (10.12.239.231) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 02:17:37 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:34 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 2 Jan 2019 11:17:34 +0100
Subject: Re: [PATCH 10/10] PCI: dwc: Do not write to MSI control registers if
 the platform doesn't use it
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181219124207.13479-1-kishon@ti.com>
 <20181219124207.13479-11-kishon@ti.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <96242503-4727-be68-84d2-4d340c7b3f5c@synopsys.com>
Date:   Wed, 2 Jan 2019 10:13:03 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181219124207.13479-11-kishon@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 19/12/2018 12:42, Kishon Vijay Abraham I wrote:
> Platforms which populate msi_host_init, has it's own MSI controller
> logic. Writing to MSI control registers on platforms which doesn't use
> Designware's MSI controller logic might have side effects. To
> be safe, do not write to MSI control registers if the platform uses
> it's own MSI controller logic instead of Designware's MSI controller
> logic.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 24 ++++++++++---------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index dbc94f3be3d5..6644a5683b2b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -647,17 +647,19 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>  
>  	dw_pcie_setup(pci);
>  
> -	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> -
> -	/* Initialize IRQ Status array */
> -	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
> -					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, ~0);
> -		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
> -					(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> -				    4, ~0);
> -		pp->irq_status[ctrl] = 0;
> +	if (!pp->ops->msi_host_init) {
> +		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
> +
> +		/* Initialize IRQ Status array */
> +		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
> +			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK +
> +					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +					    4, ~0);
> +			dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_ENABLE +
> +					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
> +					    4, ~0);
> +			pp->irq_status[ctrl] = 0;
> +		}
>  	}
>  
>  	/* Setup RC BARs */
> 

Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>

Regards,
Gustavo
