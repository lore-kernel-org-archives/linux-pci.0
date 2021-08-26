Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD7C432BE
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 12:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21310610C7
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 12:43:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhHZMny (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Aug 2021 08:43:54 -0400
Received: from foss.arm.com ([217.140.110.172]:46102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhHZMnx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 08:43:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 374111042;
        Thu, 26 Aug 2021 05:43:06 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52AE73F766;
        Thu, 26 Aug 2021 05:43:03 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Fix masking and unmasking legacy INTx interrupts
Date:   Thu, 26 Aug 2021 13:42:55 +0100
Message-Id: <162998176149.21706.5126859600262914131.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210820155020.3000-1-pali@kernel.org>
References: <20210820155020.3000-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 20 Aug 2021 17:50:20 +0200, Pali Rohár wrote:
> irq_mask and irq_unmask callbacks need to be properly guarded by raw spin
> locks as masking/unmasking procedure needs atomic read-modify-write
> operation on hardware register.

Applied to pci/aardvark, thanks!

[1/1] PCI: aardvark: Fix masking and unmasking legacy INTx interrupts
      https://git.kernel.org/lpieralisi/pci/c/d212dcee27

Thanks,
Lorenzo
