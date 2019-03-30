Return-Path: <SRS0=NgI7=SB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450C8C43381
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 16:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14C172146F
	for <linux-pci@archiver.kernel.org>; Sat, 30 Mar 2019 16:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="gHvSRmbT";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="EQqPvFDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfC3QjE (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 30 Mar 2019 12:39:04 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:46840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbfC3QjC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 30 Mar 2019 12:39:02 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8077260A50; Sat, 30 Mar 2019 16:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553963941;
        bh=Co9dNLzvCqN5cyB9tc1+ZDc3Ab1HcLsdrQHHP69FeeM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gHvSRmbToflNSNZOkfQVoDERP/DllCZ474t54q2WyaZ/53P8zwp1yvzAvUfQNUS1T
         MA85Wav2zV28OClNpsqKFtgOcu3DLGNVN9L2vHyGJe34eXVeJh5IuK/QwrlMec8OhP
         s+LHZ4+oxMipeMg+InTOsNvQGOJslIAV3xL1bYNc=
Received: from [10.79.169.97] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2C9FF60736;
        Sat, 30 Mar 2019 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553963940;
        bh=Co9dNLzvCqN5cyB9tc1+ZDc3Ab1HcLsdrQHHP69FeeM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EQqPvFDbc/L3TZIpQgHHFD5TdMdd/N9kveUekqRgtXANF8thDIcF2MUSzkr2jrSWr
         wx77Dd+VucrkEvqlMAqs1yc5WZnepBHc3xYlJo8raI0OMLdybE3OG9f3/RzGSQ91J8
         WtPw6kLCHyKi2QV74gcKBIeJGYtTaOiCyki7V+JY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2C9FF60736
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: Re: [PATCH] PCI: rockchip: fix bitwise operations on status and
 ROCKCHIP_PCIE_EP_CMD_STATUS_IS
To:     Colin King <colin.king@canonical.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>
References: <20190330150910.9389-1-colin.king@canonical.com>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <ae010bdd-b65a-fa4f-e364-bf0432555f6b@codeaurora.org>
Date:   Sat, 30 Mar 2019 22:08:45 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190330150910.9389-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 3/30/2019 8:39 PM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the bitwise operations on the u16 variable 'status' with
> the setting ROCKCHIP_PCIE_EP_CMD_STATUS_IS are incorrect because
> ROCKCHIP_PCIE_EP_CMD_STATUS_IS is 1UL<<19 which is wider than the
> u16 variable.  Fix this by making status a u32.  (Not tested).
>
> Fixes: cf590b078391 ("PCI: rockchip: Add EP driver for Rockchip PCIe controller")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/pci/controller/pcie-rockchip-ep.c | 2 +-


Looks valid to me.

Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Cheers,
-Mukesh


>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index a5d799e2dff2..d743b0a48988 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -350,7 +350,7 @@ static void rockchip_pcie_ep_assert_intx(struct rockchip_pcie_ep *ep, u8 fn,
>   	struct rockchip_pcie *rockchip = &ep->rockchip;
>   	u32 r = ep->max_regions - 1;
>   	u32 offset;
> -	u16 status;
> +	u32 status;
>   	u8 msg_code;
>   
>   	if (unlikely(ep->irq_pci_addr != ROCKCHIP_PCIE_EP_PCI_LEGACY_IRQ_ADDR ||
