Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850C5C433E0
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 12:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5632A20691
	for <linux-pci@archiver.kernel.org>; Fri, 15 Jan 2021 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbhAOMRy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:17:54 -0500
Received: from foss.arm.com ([217.140.110.172]:37978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726105AbhAOMRx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 15 Jan 2021 07:17:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D65A614F6;
        Fri, 15 Jan 2021 04:17:07 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.39.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5AB13F70D;
        Fri, 15 Jan 2021 04:17:05 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        Vidya Sagar <vidyas@nvidia.com>, amurray@thegoodpenguin.co.uk,
        robh@kernel.org, jingoohan1@gmail.com, jonathanh@nvidia.com,
        treding@nvidia.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, kthota@nvidia.com,
        mmaddireddy@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, sagar.tv@gmail.com
Subject: Re: [PATCH V3] PCI: dwc: Add support to configure for ECRC
Date:   Fri, 15 Jan 2021 12:17:00 +0000
Message-Id: <161071299508.16820.14705114114590810176.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201230165723.673-1-vidyas@nvidia.com>
References: <20201230165723.673-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 30 Dec 2020 22:27:23 +0530, Vidya Sagar wrote:
> DesignWare core has a TLP digest (TD) override bit in one of the control
> registers of ATU. This bit also needs to be programmed for proper ECRC
> functionality. This is currently identified as an issue with DesignWare
> IP version 4.90a.

Applied to pci/dwc, thanks!

[1/1] PCI: dwc: Add support to configure for ECRC
      https://git.kernel.org/lpieralisi/pci/c/9b3a84d0f5

Thanks,
Lorenzo
