Return-Path: <SRS0=uFxo=EC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF1C56202
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F6D218AC
	for <linux-pci@archiver.kernel.org>; Tue, 27 Oct 2020 16:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603816593;
	bh=1n0/WuGKfDAu+Z2valDtq9+3jAWf9GHdGKpAwhuGzmY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=1pszjowDLlGCuXTiAMAItCjpidK8VBKwwGKbJM4YpXxQJbwLhxEE467/1XX1lSJgH
	 b+OdT2y4r5sM/iH9O+O+4kiJ7gTH3nMYi+yYZ0Sk74CGOPhLO6Q/cgeDKk2F8SblcX
	 eMZzc9O08pITUjiobnu2K2Vy+wi6G5TS5jgb7g1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1810963AbgJ0Qg1 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 27 Oct 2020 12:36:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1810223AbgJ0Qes (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Oct 2020 12:34:48 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 242E7218AC;
        Tue, 27 Oct 2020 16:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603816488;
        bh=1n0/WuGKfDAu+Z2valDtq9+3jAWf9GHdGKpAwhuGzmY=;
        h=Date:From:To:Cc:Subject:From;
        b=C5tSob0EOXUMBmBu35z0bGotQQngRwwA6kg8LosKXhs7wxQ9iy6jOWbXgrCt/Rv02
         qxeTtqtnahkbX3AIGNNGaC21Tk2LLsEJTAd159dfgUd63hH3ecYM4dENZYvLwVjNLr
         KLvy9T0tbKEWt9BtX1OP5yuXrJJI5M25+fSCZ3yg=
Date:   Tue, 27 Oct 2020 11:34:46 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jingoo Han <jingoohan1@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: pci-exynos.c coverity issue #1437287
Message-ID: <20201027163446.GA184135@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Jingoo,

Please take a look at this issue reported by Coverity:

222 static void exynos_pcie_assert_reset(struct exynos_pcie *ep)
223 {
224        struct dw_pcie *pci = ep->pci;
225        struct device *dev = pci->dev;
226
   	1. Condition ep->reset_gpio >= 0, taking true branch.
227        if (ep->reset_gpio >= 0)

CID 1437287 (#1 of 1): Unchecked return value (CHECKED_RETURN) 2.
check_return: Calling devm_gpio_request_one without checking return
value (as is done elsewhere 112 out of 113 times).

228                devm_gpio_request_one(dev, ep->reset_gpio,
229                                GPIOF_OUT_INIT_HIGH, "RESET");


Maybe you can guarantee that it's safe to ignore the return value by
doing a lot of code analysis, but I think it would be better to check
like all the other callers do.
