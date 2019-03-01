Return-Path: <SRS0=yUVM=RE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A43C43381
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 15:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2335A2084D
	for <linux-pci@archiver.kernel.org>; Fri,  1 Mar 2019 15:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbfCAP33 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Mar 2019 10:29:29 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37736 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbfCAP33 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Mar 2019 10:29:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 935BFA78;
        Fri,  1 Mar 2019 07:29:28 -0800 (PST)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.cambridge.arm.com [10.1.197.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4183F575;
        Fri,  1 Mar 2019 07:29:27 -0800 (PST)
Date:   Fri, 1 Mar 2019 15:29:21 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zachary Zhang <zhangzg@marvell.com>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] PCI: aardvark: Make symbol
 'advk_pci_bridge_emul_ops' static
Message-ID: <20190301152921.GA7771@e107981-ln.cambridge.arm.com>
References: <20190301065809.66046-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190301065809.66046-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 01, 2019 at 06:58:09AM +0000, Wei Yongjun wrote:
> Fixes the following sparse warning:
> 
> drivers/pci/controller/pci-aardvark.c:469:28: warning:
>  symbol 'advk_pci_bridge_emul_ops' was not declared. Should it be static?
> 
> Fixes: 8a3ebd8de328 ("PCI: aardvark: Implement emulated root PCI bridge config space")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/pci-aardvark.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to pci/misc for v5.1, thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> index 6eecae447af3..eb58dfdaba1b 100644
> --- a/drivers/pci/controller/pci-aardvark.c
> +++ b/drivers/pci/controller/pci-aardvark.c
> @@ -466,7 +466,7 @@ advk_pci_bridge_emul_pcie_conf_write(struct pci_bridge_emul *bridge,
>  	}
>  }
>  
> -struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
> +static struct pci_bridge_emul_ops advk_pci_bridge_emul_ops = {
>  	.read_pcie = advk_pci_bridge_emul_pcie_conf_read,
>  	.write_pcie = advk_pci_bridge_emul_pcie_conf_write,
>  };
> 
> 
> 
