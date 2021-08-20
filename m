Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C40DC4338F
	for <linux-pci@archiver.kernel.org>; Fri, 20 Aug 2021 12:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A3326108F
	for <linux-pci@archiver.kernel.org>; Fri, 20 Aug 2021 12:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237885AbhHTMmK (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 20 Aug 2021 08:42:10 -0400
Received: from foss.arm.com ([217.140.110.172]:60632 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233303AbhHTMmJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Aug 2021 08:42:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3EB3311FB;
        Fri, 20 Aug 2021 05:41:31 -0700 (PDT)
Received: from e123427-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27A7E3F66F;
        Fri, 20 Aug 2021 05:41:27 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Remi Pommarel <repk@triplefau.lt>,
        linux-kernel@vger.kernel.org, Xogium <contact@xogium.me>
Subject: Re: [PATCH 0/2] PCI: aardvark: Resource fixes
Date:   Fri, 20 Aug 2021 13:41:21 +0100
Message-Id: <162946326563.4746.9940152798050527363.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210624215546.4015-1-pali@kernel.org>
References: <20210624215546.4015-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 24 Jun 2021 23:55:44 +0200, Pali Rohár wrote:
> This patch series fixes configuring PCIe resources (IO and MEM) in
> aardvark controller driver. It is required to initialize BARs on systems
> with more cards, e.g. NVMe disks and WiFi AX cards.
> 
> Pali Rohár (2):
>   PCI: aardvark: Configure PCIe resources from 'ranges' DT property
>   arm64: dts: marvell: armada-37xx: Extend PCIe MEM space
> 
> [...]

Applied to pci/aardvark, thanks!

[1/1] PCI: aardvark: Configure PCIe resources from 'ranges' DT property
      https://git.kernel.org/lpieralisi/pci/c/64f160e19e

Thanks,
Lorenzo
