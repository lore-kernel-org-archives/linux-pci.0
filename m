Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9C6C433FE
	for <linux-pci@archiver.kernel.org>; Thu, 10 Dec 2020 11:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DAE023D5A
	for <linux-pci@archiver.kernel.org>; Thu, 10 Dec 2020 11:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733074AbgLJLw3 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Dec 2020 06:52:29 -0500
Received: from foss.arm.com ([217.140.110.172]:37362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgLJLtv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 06:49:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3348E30E;
        Thu, 10 Dec 2020 03:49:06 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.55.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70E123F718;
        Thu, 10 Dec 2020 03:49:03 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     robh@kernel.org, jonathanh@nvidia.com, treding@nvidia.com,
        Vidya Sagar <vidyas@nvidia.com>, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kthota@nvidia.com,
        sagar.tv@gmail.com, linux-pci@vger.kernel.org,
        mmaddireddy@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Set 32-bit DMA mask for MSI target address allocation
Date:   Thu, 10 Dec 2020 11:48:50 +0000
Message-Id: <160760089281.19740.7575712960512058139.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201117165312.25847-1-vidyas@nvidia.com>
References: <20201117165312.25847-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 17 Nov 2020 22:23:12 +0530, Vidya Sagar wrote:
> Set DMA mask to 32-bit while allocating the MSI target address so that
> the address is usable for both 32-bit and 64-bit MSI capable devices.
> Throw a warning if it fails to set the mask to 32-bit to alert that
> devices that are only 32-bit MSI capable may not work properly.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Set 32-bit DMA mask for MSI target address allocation
      https://git.kernel.org/lpieralisi/pci/c/660c486590

Thanks,
Lorenzo
