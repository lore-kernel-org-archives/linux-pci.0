Return-Path: <SRS0=JkSV=SE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F7C4360F
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B812146E
	for <linux-pci@archiver.kernel.org>; Tue,  2 Apr 2019 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfDBNVO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:21:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:51088 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728817AbfDBNVN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Apr 2019 09:21:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1499716A3;
        Tue,  2 Apr 2019 06:21:13 -0700 (PDT)
Received: from ostrya.cambridge.arm.com (ostrya.cambridge.arm.com [10.1.196.129])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 619603F690;
        Tue,  2 Apr 2019 06:21:11 -0700 (PDT)
From:   Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Grant.Likely@arm.com,
        Jeremy.Linton@arm.com, Robin.Murphy@arm.com
Subject: [PATCH v2 0/2] PCI: Describe external-facing ports in device tree
Date:   Tue,  2 Apr 2019 14:15:46 +0100
Message-Id: <20190402131548.41949-1-jean-philippe.brucker@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since v1 [1], I improved the wording of patch 1/2 as suggested by Bjorn.

Add an "external-facing" property to PCI ports in device-tree, to help
identify untrusted devices. The notion of untrusted PCI devices was
added to the v5.0 kernel to describe devices that should have strict
IOMMU protection [2], for example devices that are plugged in a
Thunderbolt port. ACPI systems use the ExternalFacingPort property [3].
Add an equivalent mechanism to device tree.

[1] https://lore.kernel.org/linux-pci/20190318182124.53859-1-jean-philippe.brucker@arm.com/
[2] https://lkml.org/lkml/2018/11/26/631
[3] https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-externally-exposed-pcie-root-ports

Jean-Philippe Brucker (2):
  dt-bindings: Add external-facing PCIe port property
  PCI: OF: Support external-facing property

 Documentation/devicetree/bindings/pci/pci.txt | 50 +++++++++++++++++++
 drivers/pci/of.c                              |  3 ++
 2 files changed, 53 insertions(+)

-- 
2.21.0

