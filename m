Return-Path: <SRS0=qE/B=CR=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4AFC433E2
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026F921924
	for <linux-pci@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599595458;
	bh=gjCn8tZYO8EZEJxb6zWUNu7X0UN5/LfWTmKa1w9g2Vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=1OSSax4yNKJKwJ1ghlvwqv2GAZUfN14mCqOjeR/1qC93IO40MuEY4sWl9ljEB0HRM
	 XE9w/UIPRKMPtxFNBVTkv3IRpB1uCPd66G3c12WuISsUG/JY3Ka027T0OxtzRKZ/12
	 erO21Ek97pL8Fgx4cMjtZIpjHM4B+b20PyVkw104=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgIHUEM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:56068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731189AbgIHUEL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 16:04:11 -0400
Received: from localhost (35.sub-72-107-115.myvzw.com [72.107.115.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2EA1E2137B;
        Tue,  8 Sep 2020 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599595449;
        bh=gjCn8tZYO8EZEJxb6zWUNu7X0UN5/LfWTmKa1w9g2Vc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZsYb8GNf7AjNpQRxFz6SmTqBwka+1YvZm+hYRECMKuMbcynUOTDS8nDFcSqBwyfzY
         5ufyoFCYUo/oNuTvQVY2ai6HleZ/LLOLme6ar1ouh9PoSalYQ7mDm6YU9NbxFEcmSh
         gp4XRibiRPjXh1B6k1ZSyYuok22LvRfoGPO0jU+E=
Date:   Tue, 8 Sep 2020 15:04:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        davem@davemloft.net, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sj Huang <sj.huang@mediatek.com>
Subject: Re: [v1,1/3] dt-bindings: Add YAML schemas for Gen3 PCIe controller
Message-ID: <20200908200407.GA628520@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907120852.12090-2-jianjun.wang@mediatek.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 07, 2020 at 08:08:50PM +0800, Jianjun Wang wrote:
> Add YAML schemas documentation for Gen3 PCIe controller on
> MediaTek SoCs.

Please mention "mediatek" in the subject line so "git log --oneline"
is more useful.

The convention (not universally observed) seems to be something like:

  dt-bindings: PCI: <driver-name>: Add YAML schema
