Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A4FC433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E721532
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 15:41:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551E721532
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731946AbeITVZw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 17:25:52 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48156 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727710AbeITVZw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 17:25:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCE0180D;
        Thu, 20 Sep 2018 08:41:48 -0700 (PDT)
Received: from e107981-ln.cambridge.arm.com (e107981-ln.emea.arm.com [10.4.13.117])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9B33F557;
        Thu, 20 Sep 2018 08:41:46 -0700 (PDT)
Date:   Thu, 20 Sep 2018 16:41:37 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devel@linuxdriverproject.org, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Fix return value check in hv_pci_assign_slots()
Message-ID: <20180920154130.GA7693@e107981-ln.cambridge.arm.com>
References: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537425631-28460-1-git-send-email-weiyongjun1@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+DaveM, netdev]

Removed erroneously added disclaimer, apologies.

On Thu, Sep 20, 2018 at 06:40:31AM +0000, Wei Yongjun wrote:
> In case of error, the function pci_create_slot() returns ERR_PTR() and
> never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().
> 
> Fixes: a15f2c08c708 ("PCI: hv: support reporting serial number as slot information")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index ee80e79..9ba4d12 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1484,8 +1484,10 @@ static void hv_pci_assign_slots(struct hv_pcibus_device *hbus)
>  		snprintf(name, SLOT_NAME_SIZE, "%u", hpdev->desc.ser);
>  		hpdev->pci_slot = pci_create_slot(hbus->pci_bus, slot_nr,
>  					  name, NULL);
> -		if (!hpdev->pci_slot)
> +		if (IS_ERR(hpdev->pci_slot)) {
>  			pr_warn("pci_create slot %s failed\n", name);
> +			hpdev->pci_slot = NULL;
> +		}
>  	}
>  }

I am dropping this patch from the PCI queue since the original series
is now queued in net-next.

Lorenzo

