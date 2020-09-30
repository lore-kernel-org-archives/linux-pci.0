Return-Path: <SRS0=vfl7=DH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015CEC4363D
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 22:44:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B37512074A
	for <linux-pci@archiver.kernel.org>; Wed, 30 Sep 2020 22:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1601505854;
	bh=ynqIN4QGTHMSH/o+EfxA3I1GuDHZviQrFCi/cWn2cX8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=z8AVnElBAi0sEss8lZhWeLv/6YqR0lxVk62sCVyoHzYRDc5yGceDo0LQXCvTvOZUc
	 BkwCLjgYArGmxwraT2ZkaU6yBjyZn8tLo+MikIozlRs3SqZrqySYAkEFCZlSWDvMxO
	 dToExDkTxt5b/8LADjedjtMj6W+ichFsnXJrivwY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgI3WoO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Sep 2020 18:44:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:47964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729980AbgI3WoO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 18:44:14 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E2202071E;
        Wed, 30 Sep 2020 22:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601505853;
        bh=ynqIN4QGTHMSH/o+EfxA3I1GuDHZviQrFCi/cWn2cX8=;
        h=Date:From:To:Cc:Subject:From;
        b=hJn2jxESch3KiVPq1jM35BchEJk22g/fZmn86fbokVN3Sc/WxMYUQ2lsIbGmMB8Me
         +hCMV4Dta6KMXc0AjwwJYtiZJYH523TCgFTCh+tN/g5MFXuYrFb+cV4KYk4kIVcaMa
         stDg7IhPusZqU4LHiiS+0GvPaRKt+7EAAFNAMf9g=
Date:   Wed, 30 Sep 2020 17:44:11 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pratyush Anand <pratyush.anand@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org
Subject: pcie-spear13xx.c sparse warnings
Message-ID: <20200930224411.GA2643351@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

FYI, sparse complains quite about about pcie-spear13xx.c:

  $ make C=2 drivers/pci/controller/dwc/pcie-spear13xx.o
    CHECK   drivers/pci/controller/dwc/pcie-spear13xx.c
  drivers/pci/controller/dwc/pcie-spear13xx.c:73:54: warning: incorrect type in initializer (different address spaces)
  drivers/pci/controller/dwc/pcie-spear13xx.c:73:54:    expected struct pcie_app_reg *app_reg
  drivers/pci/controller/dwc/pcie-spear13xx.c:73:54:    got void [noderef] __iomem *app_base
  drivers/pci/controller/dwc/pcie-spear13xx.c:100:26: warning: incorrect type in argument 2 (different address spaces)
  drivers/pci/controller/dwc/pcie-spear13xx.c:100:26:    expected void volatile [noderef] __iomem *addr
  drivers/pci/controller/dwc/pcie-spear13xx.c:100:26:    got unsigned int *
  ...

Any ideas about how to fix these?  I haven't looked into them at all.

I'm building on x86 with CONFIG_COMPILE_TEST=y and CONFIG_OF not set,
so probably not the typical config for this driver.

Bjorn
