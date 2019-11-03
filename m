Return-Path: <SRS0=wiHL=Y3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F92CCA9ED0
	for <linux-pci@archiver.kernel.org>; Sun,  3 Nov 2019 08:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258EE21928
	for <linux-pci@archiver.kernel.org>; Sun,  3 Nov 2019 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572769384;
	bh=fQa6LAKvOllTgETSlnkQSyfyu7NyoN82hGUQbLNq9/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2QT0vp0q3iPxzQjneMH/EWBezVC5d2oUYxf/QAJrDOA1VnFOtEVVanMv8lw6EWrCB
	 dvi0aa7/zG0hjWJlxQnMeppwZENYI3DdBuJVtGVuv+eRlX2iuJ7ZVz+J9XYs+zwGTC
	 1mVLW6aFVPnGFsty5wcr4AabBVbltyb2emb6cCCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfKCIXD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 3 Nov 2019 03:23:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:48982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfKCIXD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 3 Nov 2019 03:23:03 -0500
Received: from localhost (unknown [106.206.31.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D818214D8;
        Sun,  3 Nov 2019 08:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572769382;
        bh=fQa6LAKvOllTgETSlnkQSyfyu7NyoN82hGUQbLNq9/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7nhhYU41sn0I36OpljX0c29ks9Do6JU+cVRLl5EfwOolwVObo/GuG/30XcPPwmt0
         qfDGg9cZeuRkqPoKKNN662eoPLSmw9oZSe62MmxUNmlyF8Qcmr+JHTex2wVaUwgE5F
         dy6PbxwdqRei+bTT3T/bGpaIlWFtte9SvXo3Xk0Y=
Date:   Sun, 3 Nov 2019 13:52:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom: Fix the fixup of PCI_VENDOR_ID_QCOM
Message-ID: <20191103082254.GP2695@vkoul-mobl.Dlink>
References: <20191102002420.4091061-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191102002420.4091061-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 01-11-19, 17:24, Bjorn Andersson wrote:
> There exists non-bridge PCIe devices with PCI_VENDOR_ID_QCOM, so limit
> the fixup to only affect the PCIe 2.0 (0x106) and PCIe 3.0 (0x107)
> bridges.

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
