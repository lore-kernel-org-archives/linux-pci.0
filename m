Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAFFC47096
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jun 2021 16:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D7B613E4
	for <linux-pci@archiver.kernel.org>; Thu,  3 Jun 2021 16:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhFCQMo (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 3 Jun 2021 12:12:44 -0400
Received: from foss.arm.com ([217.140.110.172]:44940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229506AbhFCQMo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Jun 2021 12:12:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A9B911B3;
        Thu,  3 Jun 2021 09:10:59 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.39.253])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 640DB3F73D;
        Thu,  3 Jun 2021 09:10:57 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Toan Le <toan@os.amperecomputing.com>
Subject: Re: [PATCH] PCI: xgene: Fix a non-compliant kernel-doc
Date:   Thu,  3 Jun 2021 17:10:51 +0100
Message-Id: <162273663769.18372.12682834197569402787.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20210509030237.368540-1-kw@linux.com>
References: <20210509030237.368540-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 9 May 2021 03:02:37 +0000, Krzysztof Wilczyński wrote:
> Correct a non-compliant kernel-doc at the top of the pci-xgene.c file,
> and resolve build time warning related to kernel-doc:
> 
>   drivers/pci/controller/pci-xgene.c:27: warning: expecting prototype for APM X(). Prototype was for PCIECORE_CTLANDSTATUS() instead
> 
> No change to functionality intended.

Applied to pci/xgene, thanks!

[1/1] PCI: xgene: Fix a non-compliant kernel-doc
      https://git.kernel.org/lpieralisi/pci/c/1e586966e9

Thanks,
Lorenzo
