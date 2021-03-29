Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D4C433DB
	for <linux-pci@archiver.kernel.org>; Mon, 29 Mar 2021 09:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2B26195B
	for <linux-pci@archiver.kernel.org>; Mon, 29 Mar 2021 09:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbhC2Jcw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 29 Mar 2021 05:32:52 -0400
Received: from foss.arm.com ([217.140.110.172]:45292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231654AbhC2Jcn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 05:32:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BDF80142F;
        Mon, 29 Mar 2021 02:32:42 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.51.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 65DE83F7D7;
        Mon, 29 Mar 2021 02:32:41 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     gustavo.pimentel@synopsys.com, bhelgaas@google.com,
        Dejin Zheng <zhengdejin5@gmail.com>,
        toan@os.amperecomputing.com, linux-pci@vger.kernel.org,
        robh@kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, dann.frazier@canonical.com
Subject: Re: [PATCH] PCI: xgene: fix a mistake about cfg address
Date:   Mon, 29 Mar 2021 10:32:35 +0100
Message-Id: <161701033575.5341.4105470875260495956.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210328144118.305074-1-zhengdejin5@gmail.com>
References: <20210328144118.305074-1-zhengdejin5@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 28 Mar 2021 22:41:18 +0800, Dejin Zheng wrote:
> It has a wrong modification to the xgene driver by the commit
> e2dcd20b1645a. it use devm_platform_ioremap_resource_byname() to
> simplify codes and remove the res variable, But the following code
> needs to use this res variable, So after this commit, the port->cfg_addr
> will get a wrong address. Now, revert it.

Applied to pci/xgene, thanks!

[1/1] PCI: xgene: Fix cfg resource mapping
      https://git.kernel.org/lpieralisi/pci/c/f243b619b4

Thanks,
Lorenzo
