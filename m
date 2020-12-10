Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD0C2BB48
	for <linux-pci@archiver.kernel.org>; Thu, 10 Dec 2020 15:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9884F23770
	for <linux-pci@archiver.kernel.org>; Thu, 10 Dec 2020 15:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390888AbgLJOkh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 10 Dec 2020 09:40:37 -0500
Received: from foss.arm.com ([217.140.110.172]:45726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391313AbgLJOka (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Dec 2020 09:40:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C563E1FB;
        Thu, 10 Dec 2020 06:39:44 -0800 (PST)
Received: from red-moon.arm.com (unknown [10.57.55.73])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C1FD3F718;
        Thu, 10 Dec 2020 06:39:42 -0800 (PST)
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Tom Joseph <tjoseph@cadence.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/4] PCI: J7: J7200/J721E PCIe bindings
Date:   Thu, 10 Dec 2020 14:39:35 +0000
Message-Id: <160761114382.21392.11608975856655590224.b4-ty@arm.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20201210124917.24185-1-kishon@ti.com>
References: <20201210124917.24185-1-kishon@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 10 Dec 2020 18:19:13 +0530, Kishon Vijay Abraham I wrote:
> Patch series adds PCIe binding for J7200 and and fixes
> "ti,syscon-pcie-ctrl" applicable to both J721E and J7200.
> 
> All the four patches here have got Acks from Rob Herring.
> 
> Ack for "dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take
> argument"
> lore.kernel.org/r/CAL_JsqJQju8TUZA-wu=WA-5XH4H9s2ifO8Hf4TnT5epa=Gg1ng@mail.gmail.com
> 
> [...]

Applied to pci/cadence, thanks!

[1/4] dt-bindings: pci: ti,j721e: Fix "ti,syscon-pcie-ctrl" to take argument
      https://git.kernel.org/lpieralisi/pci/c/b6c81be912
[2/4] dt-bindings: PCI: Add host mode dt-bindings for TI's J7200 SoC
      https://git.kernel.org/lpieralisi/pci/c/3f1f870c01
[3/4] dt-bindings: PCI: Add EP mode dt-bindings for TI's J7200 SoC
      https://git.kernel.org/lpieralisi/pci/c/17c5b458a9
[4/4] PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg
      https://git.kernel.org/lpieralisi/pci/c/7aa256234c

Thanks,
Lorenzo
