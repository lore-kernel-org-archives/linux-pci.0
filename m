Return-Path: <SRS0=u7li=ZF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B7CC43331
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 12:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59C6922459
	for <linux-pci@archiver.kernel.org>; Wed, 13 Nov 2019 12:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="qCd+8R77"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbfKMMrx (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 13 Nov 2019 07:47:53 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:45304 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbfKMMrx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 07:47:53 -0500
Received: from [192.168.27.209] (unknown [37.157.136.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 1E1A1CF23;
        Wed, 13 Nov 2019 14:47:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1573649270; bh=V9P+kuRuVLcbVw6LCSQAo0MaJg66SRNAL9F0hA89RRg=;
        h=Subject:To:Cc:From:Date:From;
        b=qCd+8R770gN4/MIN7qXaGcwwcjl8AsBKzUnfmS0InYQiMBMp7AaAJ9RT2VMdRnjUK
         HSZXy3H8+GQXbcSS8h72hy4a/CiWYxmN7wT/KkP3ougv4u4v5FLI2pXi719wX9Cdeq
         p8JOHbFsuVeHMucVpM46CvXPsU2UOXwb+9zG9XQFFJ9kEy4GPAvGrfj0TU+7SHOWFg
         q+GVgSFInY4uq0bGIBy1lyf34I2EcqL86uJ/Pv2y0hv+n+bGs6IUCTKRyJWChEVSYb
         Ht3y4E1pn75iEfeXYKY2Ll/9Yi1C2oLh2zAzPrT3faXHoxPnB4QZNXRmrNYAl1V5Xy
         eU6MuDQHdHCfg==
Subject: Re: [PATCH v3 2/2] PCI: qcom: Add support for SDM845 PCIe controller
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
References: <20191107001642.1127561-1-bjorn.andersson@linaro.org>
 <20191107001642.1127561-3-bjorn.andersson@linaro.org>
From:   Stanimir Varbanov <svarbanov@mm-sol.com>
Message-ID: <d2aa3189-fdf5-23d9-c6d7-9ab577fa98bd@mm-sol.com>
Date:   Wed, 13 Nov 2019 14:47:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/7/19 2:16 AM, Bjorn Andersson wrote:
> The SDM845 has one Gen2 and one Gen3 controller, add support for these.
> 
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - Don't assert the reset in the failure path
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 150 +++++++++++++++++++++++++
>  1 file changed, 150 insertions(+)

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
