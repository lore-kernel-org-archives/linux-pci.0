Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05AAC4338F
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 15:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D9B60ED7
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 15:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhGWOjy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Jul 2021 10:39:54 -0400
Received: from foss.arm.com ([217.140.110.172]:47340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235550AbhGWOjd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:39:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D68ED12FC;
        Fri, 23 Jul 2021 08:20:06 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF3253F73D;
        Fri, 23 Jul 2021 08:20:04 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: tegra: Remove unused struct tegra_pcie_bus
Date:   Fri, 23 Jul 2021 16:19:59 +0100
Message-Id: <162705358656.23747.5514271825711966250.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210704235733.2514131-1-kw@linux.com>
References: <20210704235733.2514131-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 4 Jul 2021 23:57:33 +0000, Krzysztof Wilczyński wrote:
> Following the code refactoring completed in the commit 1fd92928bab5
> ("PCI: tegra: Refactor configuration space mapping code") there are no
> more known users of struct tegra_pcie_bus.
> 
> Thus, remove declaration of struct tegra_pcie_bus as it's no longer
> needed and does not have any existing users left.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Remove unused struct tegra_pcie_bus
      https://git.kernel.org/lpieralisi/pci/c/6310a1526a

Thanks,
Lorenzo
