Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35976 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643AbbF3SXO (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jun 2015 14:23:14 -0400
Received: by paceq1 with SMTP id eq1so9193431pac.3
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2015 11:23:13 -0700 (PDT)
From: Duc Dang <dhdang@apm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Pawel Moll <pawel.moll@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Will Deacon <will.deacon@arm.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Tanmay Inamdar <tinamdar@apm.com>, patches@apm.com,
	Duc Dang <dhdang@apm.com>
Subject: [PATCH v2 0/2] pci: xgene: Add multiple memory ranges support
Date: Tue, 30 Jun 2015 11:22:26 -0700
Message-Id: <cover.1435688121.git.dhdang@apm.com>
In-Reply-To: <46305464.n5SOjGAhJb@wuerfel>
References: <46305464.n5SOjGAhJb@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This patch set adds 1 large (up to 64GB) memory window for each PCIe
controller nodes in X-Gene device tree and fix PCIe controller driver
to handle multiple memory ranges correctly. These changes are required
to support PCIe devices that has huge BAR.

v2 changes:
	1. Separate device-tree changes and driver changes into different
	patches
	2. Explicitly define new large window as 64-bit prefetchable in dts
	3. Use IORESOURCE_PREFETCH flag to determine which PCIe controller
	register to be used to configure the memory ranges.
 
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 23 ++++++++++++++---------
 drivers/pci/host/pci-xgene.c           | 12 ++++++++++--
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
1.9.1

