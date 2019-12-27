Return-Path: <SRS0=rySr=2R=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 912A0C2D0C6
	for <linux-pci@archiver.kernel.org>; Fri, 27 Dec 2019 08:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B6D20838
	for <linux-pci@archiver.kernel.org>; Fri, 27 Dec 2019 08:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mm-sol.com header.i=@mm-sol.com header.b="eqEBgZNc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfL0IyF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 27 Dec 2019 03:54:05 -0500
Received: from ns.mm-sol.com ([37.157.136.199]:33784 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725936AbfL0IyF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Dec 2019 03:54:05 -0500
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Fri, 27 Dec 2019 03:54:03 EST
Received: from [192.168.1.13] (87-126-225-137.ip.btc-net.bg [87.126.225.137])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 9EEDECF49;
        Fri, 27 Dec 2019 10:45:30 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mm-sol.com; s=201706;
        t=1577436330; bh=rK08qd3GPgKbp4fWxeFCqjHeAZbfvqNcNFr3o32Kgi8=;
        h=Subject:To:Cc:From:Date:From;
        b=eqEBgZNcmpMCMkebZFgQZtC2cmzGmwDBO1Ps3izBsOgloWgJx5T4l45/JMyOUKblO
         4oehlJRzVj1vm9H4kyK4Oiq3U1sShARrqfrCAFQ+gQnLU5d5EMEKz4+xDyxyYwi0mO
         sxjQEQ9YZoh/b0QWiFEYP0xxHBhUiDOpM8XAkhklarRE1P3EWSCWYW6zoSqCFObrSN
         DW4FbsJhAiZeYbsZPo7Yk4DZHb3JPr8KJUDVL4T5X3VDZ5Ab3vCF+MgHcee5kUbUt1
         iz+r291RJYZ9PqP8qc1tPjVW/dKoEctEfzItXoXqVWWpg47lM4IlyHIyKz9XKl4ayN
         lBHaUkH+1uuhw==
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
Message-ID: <ffdfbe52-d19e-101d-f240-0eabee4c2c8f@mm-sol.com>
Date:   Fri, 27 Dec 2019 10:45:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191107001642.1127561-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

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

I don't see my tag, so:

Acked-by: Stanimir Varbanov <svarbanov@mm-sol.com>

-- 
regards,
Stan
