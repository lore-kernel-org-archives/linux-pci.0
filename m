Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050F9C432BE
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 13:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEF99610C9
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 13:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242551AbhHZNCQ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Aug 2021 09:02:16 -0400
Received: from foss.arm.com ([217.140.110.172]:46482 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237214AbhHZNCP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 09:02:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1C7C331B;
        Thu, 26 Aug 2021 06:01:28 -0700 (PDT)
Received: from e123427-lin.arm.com (unknown [10.57.41.138])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D43DE3F66F;
        Thu, 26 Aug 2021 06:01:24 -0700 (PDT)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        yuji2.ishikawa@toshiba.co.jp, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        punit1.agrawal@toshiba.co.jp, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/3] Visconti: Add Toshiba Visconti PCIe host controller driver
Date:   Thu, 26 Aug 2021 14:01:19 +0100
Message-Id: <162998285902.30814.11206633831020646086.b4-ty@arm.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210811083830.784065-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 11 Aug 2021 17:38:27 +0900, Nobuhiro Iwamatsu wrote:
> This series is the PCIe driver for Toshiba's ARM SoC, Visconti[0].
> This provides DT binding documentation, device driver, MAINTAINER files.
> 
> Best regards,
>   Nobuhiro
> 
> [0]: https://toshiba.semicon-storage.com/ap-en/semiconductor/product/image-recognition-processors-visconti.html
> 
> [...]

Applied to pci/dwc, thanks!

[1/3] dt-bindings: pci: Add DT binding for Toshiba Visconti PCIe controller
      https://git.kernel.org/lpieralisi/pci/c/a655ce4000
[2/3] PCI: visconti: Add Toshiba Visconti PCIe host controller driver
      https://git.kernel.org/lpieralisi/pci/c/09436f819c
[3/3] MAINTAINERS: Add entries for Toshiba Visconti PCIe controller
      https://git.kernel.org/lpieralisi/pci/c/34af7aace1

Thanks,
Lorenzo
