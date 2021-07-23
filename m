Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70433C4338F
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 15:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B00560F02
	for <linux-pci@archiver.kernel.org>; Fri, 23 Jul 2021 15:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhGWOeg (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 23 Jul 2021 10:34:36 -0400
Received: from foss.arm.com ([217.140.110.172]:47246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235438AbhGWOeg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 23 Jul 2021 10:34:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFFC412FC;
        Fri, 23 Jul 2021 08:15:09 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.38.244])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 265CD3F73D;
        Fri, 23 Jul 2021 08:15:07 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: artpec6: Remove surplus break statement after return
Date:   Fri, 23 Jul 2021 16:14:57 +0100
Message-Id: <162705326490.20778.10355073000427027565.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210701204401.1636562-1-kw@linux.com>
References: <20210701204401.1636562-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 1 Jul 2021 20:44:00 +0000, Krzysztof Wilczyński wrote:
> As part of code refactoring completed in the commit a0fd361db8e5 ("PCI:
> dwc: Move "dbi", "dbi2", and "addr_space" resource setup into common
> code") the function artpec6_add_pcie_ep() has been removed and the call
> to the dw_pcie_ep_init() has been moved into artpec6_pcie_probe().
> 
> This change left a break statement behind that is not needed any more as
> as the function artpec6_pcie_probe() return immediately after making
> a call to dw_pcie_ep_init().
> 
> [...]

Applied to pci/dwc, thanks!

[1/2] PCI: artpec6: Remove surplus break statement after return
      https://git.kernel.org/lpieralisi/pci/c/7c665ce919
[2/2] PCI: artpec6: Remove local code block from within switch statement
      https://git.kernel.org/lpieralisi/pci/c/313b1c763c

Thanks,
Lorenzo
