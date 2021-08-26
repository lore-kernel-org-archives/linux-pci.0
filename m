Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555BBC4320A
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 07:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34E2160ED5
	for <linux-pci@archiver.kernel.org>; Thu, 26 Aug 2021 07:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239528AbhHZHQq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 26 Aug 2021 03:16:46 -0400
Received: from foss.arm.com ([217.140.110.172]:40238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238379AbhHZHQq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 26 Aug 2021 03:16:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 39BC8D6E;
        Thu, 26 Aug 2021 00:15:59 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9B3F3F5A1;
        Thu, 26 Aug 2021 00:15:58 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v3 0/4] CM4 ACPI PCIe quirk
Date:   Thu, 26 Aug 2021 02:15:53 -0500
Message-Id: <20210826071557.29239-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PFTF CM4 is an ACPI platform that is following the Arm PCIe SMC
(DEN0115) standard because its PCIe config space isn't ECAM compliant
since it is split into two parts. One part describes the root port
registers, and another contains a moveable window pointing at a given
device's 4K config space. Thus it doesn't have an MCFG table. As
Linux doesn't support the PCI/SMC, a host bridge specific _DSD is
added and associated with custom ECAM ops and cfgres.  The custom cfg
op selects between those two regions, as well as disallowing
problematic accesses.

V2->V3:
	Rebase to -next to pickup new MAINTAINERS entries that
	       needed updating.
	Enforce _DSD property is exactly the same len as the
		MCFG OEM field it is overriding.
	More commit/comment tweaks.
	
V1->V2:
	Only move register definitions to new .h file, add
	     include guards.
	Change quirk namespace identifier.
	Update Maintainers file.
	A number of whitespace, grammar, etc fixes.

Jeremy Linton (4):
  PCI: brcmstb: Break register definitions into separate header
  PCI: brcmstb: Add ACPI config space quirk
  PCI/ACPI: Add Broadcom bcm2711 MCFG quirk
  MAINTAINERS: Widen brcmstb PCIe file scope

 MAINTAINERS                                |   6 +-
 drivers/acpi/pci_mcfg.c                    |  17 +++
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-brcmstb-acpi.c |  79 +++++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 149 +-------------------
 drivers/pci/controller/pcie-brcmstb.h      | 155 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 7 files changed, 257 insertions(+), 151 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
 create mode 100644 drivers/pci/controller/pcie-brcmstb.h

-- 
2.31.1

