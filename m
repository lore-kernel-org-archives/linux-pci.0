Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63139C4320A
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 21:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0306113C
	for <linux-pci@archiver.kernel.org>; Thu,  5 Aug 2021 21:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbhHEVMV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Aug 2021 17:12:21 -0400
Received: from foss.arm.com ([217.140.110.172]:52374 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231587AbhHEVMU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Aug 2021 17:12:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BEE31042;
        Thu,  5 Aug 2021 14:12:05 -0700 (PDT)
Received: from u200856.usa.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0BB833F719;
        Thu,  5 Aug 2021 14:12:05 -0700 (PDT)
From:   Jeremy Linton <jeremy.linton@arm.com>
To:     linux-pci@vger.kernel.org
Cc:     lorenzo.pieralisi@arm.com, nsaenz@kernel.org, bhelgaas@google.com,
        rjw@rjwysocki.net, lenb@kernel.org, robh@kernel.org, kw@linux.com,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 0/3] CM4 ACPI PCIe quirk
Date:   Thu,  5 Aug 2021 16:11:57 -0500
Message-Id: <20210805211200.491275-1-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The PFTF CM4 is an ACPI platform that is following the PCIe SMCCC
standard because its PCIe config space isn't ECAM compliant and is
split into two parts. One part for the root port registers and a
moveable window which points at a given device's 4K config space.
Thus it doesn't have a MCFG (and really any MCFG provided would be
nonsense anyway). As linux doesn't support the PCIe SMCCC standard
we key off a linux specific host bridge _DSD to add custom ECAM
ops and cfgres. The cfg op selects between those two regions, as
well as disallowing problematic accesses, particularly if the link
is down because there isn't an attached device.

Jeremy Linton (3):
  PCI: brcmstb: Break register definitions into separate header
  PCI: brcmstb: Add ACPI config space quirk
  PCI/ACPI: Add new quirk detection, enable bcm2711

 drivers/acpi/pci_mcfg.c                    |  14 ++
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-brcmstb-acpi.c |  77 +++++++++
 drivers/pci/controller/pcie-brcmstb.c      | 179 +-------------------
 drivers/pci/controller/pcie-brcmstb.h      | 182 +++++++++++++++++++++
 include/linux/pci-ecam.h                   |   1 +
 6 files changed, 276 insertions(+), 178 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-brcmstb-acpi.c
 create mode 100644 drivers/pci/controller/pcie-brcmstb.h

-- 
2.31.1

