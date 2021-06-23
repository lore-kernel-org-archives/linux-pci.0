Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59030C48BC2
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jun 2021 15:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CB316112D
	for <linux-pci@archiver.kernel.org>; Wed, 23 Jun 2021 15:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFWPZp (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 23 Jun 2021 11:25:45 -0400
Received: from foss.arm.com ([217.140.110.172]:36852 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229523AbhFWPZp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Jun 2021 11:25:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1B331B;
        Wed, 23 Jun 2021 08:23:27 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.46.124])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3D1E3F718;
        Wed, 23 Jun 2021 08:23:26 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix shiftTooManyBitsSigned warning for Tegra194
Date:   Wed, 23 Jun 2021 16:23:20 +0100
Message-Id: <162446177943.19852.7323663097557808562.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210618160219.303092-1-jonathanh@nvidia.com>
References: <20210618160219.303092-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 18 Jun 2021 17:02:19 +0100, Jon Hunter wrote:
> The cppcheck tool issues the following warning for the Tegra194 PCIe
> driver ...
> 
>  $ cppcheck --enable=all drivers/pci/controller/dwc/pcie-tegra194.c
>  Checking drivers/pci/controller/dwc/pcie-tegra194.c ...
> 
>  drivers/pci/controller/dwc/pcie-tegra194.c:1829:23: portability:
> 	Shifting signed 32-bit value by 31 bits is
> 	implementation-defined behaviour. See condition at line 1826.
> 	[shiftTooManyBitsSigned]
> 
> [...]

Applied to pci/tegra, thanks!

[1/1] PCI: tegra194: Fix shiftTooManyBitsSigned warning for Tegra194
      https://git.kernel.org/lpieralisi/pci/c/b1eca3a544

Thanks,
Lorenzo
