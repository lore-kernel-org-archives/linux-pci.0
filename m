Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB78C2B9F4
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jun 2021 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A989613C2
	for <linux-pci@archiver.kernel.org>; Tue, 22 Jun 2021 10:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbhFVKVD (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 22 Jun 2021 06:21:03 -0400
Received: from foss.arm.com ([217.140.110.172]:46064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229794AbhFVKU6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Jun 2021 06:20:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D343411D4;
        Tue, 22 Jun 2021 03:18:40 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.45.237])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 805353F694;
        Tue, 22 Jun 2021 03:18:38 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     bhelgaas@google.com, matthias.bgg@gmail.com, robh@kernel.org,
        ryder.lee@mediatek.com, Zou Wei <zou_wei@huawei.com>,
        jianjun.wang@mediatek.com
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH -next] PCI: mediatek-gen3: Add missing MODULE_DEVICE_TABLE
Date:   Tue, 22 Jun 2021 11:18:32 +0100
Message-Id: <162435709386.20190.12221073740280351625.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <1620717091-108691-1-git-send-email-zou_wei@huawei.com>
References: <1620717091-108691-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 11 May 2021 15:11:31 +0800, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.

Applied to pci/mediatek-gen3, thanks!

[1/1] PCI: mediatek-gen3: Add missing MODULE_DEVICE_TABLE
      https://git.kernel.org/lpieralisi/pci/c/3a2e476dc5

Thanks,
Lorenzo
