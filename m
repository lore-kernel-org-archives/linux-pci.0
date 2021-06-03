Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D624C47096
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jun 2021 14:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EF50613E7
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jun 2021 14:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFCOXW (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jun 2021 10:23:22 -0400
Received: from foss.arm.com ([217.140.110.172]:42522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230044AbhFCOXW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 10:23:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43C9611FB;
        Thu,  3 Jun 2021 07:21:37 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42ABE3F73D;
        Thu,  3 Jun 2021 07:21:35 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh@kernel.org, jonathanh@nvidia.com,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        thierry.reding@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, mmaddireddy@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org, kthota@nvidia.com,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH] PCI: tegra: Fix host initialization during resume
Date:   Thu,  3 Jun 2021 15:21:28 +0100
Message-Id: <162273006694.867.7293504887605547863.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210504172157.29712-1-vidyas@nvidia.com>
References: <20210504172157.29712-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 4 May 2021 22:51:57 +0530, Vidya Sagar wrote:
> Commit 275e88b06a27 ("PCI: tegra: Fix host link initialization") broke
> host initialization during resume as it misses out calling the API
> dw_pcie_setup_rc() which is required for host and MSI initialization.

Applied to pci/tegra, thanks!

[1/1] PCI: tegra: Fix host initialization during resume
      https://git.kernel.org/lpieralisi/pci/c/d0180ba464

Thanks,
Lorenzo
