Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF7C07E9C
	for <linux-pci@archiver.kernel.org>; Mon, 12 Jul 2021 16:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BB0061186
	for <linux-pci@archiver.kernel.org>; Mon, 12 Jul 2021 16:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234445AbhGLQzL (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Jul 2021 12:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232710AbhGLQzL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Jul 2021 12:55:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9114B60FF3;
        Mon, 12 Jul 2021 16:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626108742;
        bh=7PA9T4ztHxOhgBCB8sQ5ExrO4Ozk846zDZeaKJ8RHac=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RWyIORS+4H5zY6ZjBkzga+X1zqSL1ArvZninJVErcXMIjFZvLaMjB6ivhxTgqPMW0
         ubGYbLe2Ww++YTj+qIJseRu6fAgPZrGYrk7LxBfKcdhfNglXAMqLQge2mK3ogHr8Rt
         17ScldlFy755U7xlEdfO/w+tdKhFgiVS8zpmNMFA0d1HuoR/Y5DrOgIweUTbkLKysD
         hb6xY6hVnViQsg6if5Y3/XMyWm3EK35yJEN2DW9PHtEvTb+sRfV7vFh3UajtWyRpWm
         emMfS9JAVvqxB9gRFLf8FN3NVLYstmywcDVZNJTiTX4fL9HGoPRNdXfFfth4HhrV30
         RVW15PvWgF3og==
Date:   Mon, 12 Jul 2021 11:52:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh@kernel.org>, linuxarm@huawei.com,
        mauro.chehab@huawei.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 0/9] Add support for Hikey 970 PCIe
Message-ID: <20210712165221.GA1654345@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1625826353.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 09, 2021 at 12:41:36PM +0200, Mauro Carvalho Chehab wrote:
> ...
> Manivannan Sadhasivam (1):
>   arm64: dts: hisilicon: Add support for HiKey 970 PCIe controller
>     hardware

FWIW, this didn't apply cleanly for me to v5.14-rc1.

> Mauro Carvalho Chehab (8):
>   dt-bindings: phy: add bindings for Hikey 960 PCIe PHY
>   dt-bindings: phy: add bindings for Hikey 970 PCIe PHY
>   dt-bindings: PCI: kirin: fix compatible string
>   dt-bindings: PCI: kirin: drop PHY properties
>   phy: hisilicon: add a PHY driver for Kirin 960

>   PCI: kirin: drop the PHY logic from the driver
>   PCI: kirin: use regmap for APB registers

If/when you repost this, please update these subject lines to match the
historical style:

  PCI: kirin: Drop PHY logic from the driver
  PCI: kirin: Use regmap for APB registers

Also, please update subject lines, commit logs, Kconfig menu and help
text, comments, etc throughout to capitalize "HiKey" and "HiSilicon"
as the vendor does.

>   phy: hisilicon: add driver for Kirin 970 PCIe PHY
