Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166F5C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:06:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD4A122419
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 16:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4A122419
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbeKMCAZ (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 21:00:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:52069 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbeKMCAZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Nov 2018 21:00:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Nov 2018 08:06:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,495,1534834800"; 
   d="scan'208";a="105580985"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 12 Nov 2018 08:06:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 59EFA3EA; Mon, 12 Nov 2018 18:06:28 +0200 (EET)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Christian Kellner <ckellner@redhat.com>,
        Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date:   Mon, 12 Nov 2018 19:06:24 +0300
Message-Id: <20181112160628.86620-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Recent systems shipping with Windows 10 version 1803 or newer may be
utilizing IOMMU to prevent DMA attacks via Thunderbolt ports. This is
different from the previous security level based scheme because the
connected device cannot access system memory outside of the regions
allocated for it by the driver.

When enabled the BIOS makes sure no device can do DMA outside of RMRR
(Reserved Memory Region Record) regions. This means that during OS boot,
before it enables IOMMU, none of the connected devices can bypass DMA
protection for instance by overwriting the data structures used by the
IOMMU. The BIOS communicates support for this to the OS by setting a new
bit in ACPI DMAR table [1].

Because these systems utilize an IOMMU to block possible DMA attacks,
typically (but not always) the Thunderbolt security level is set to "none"
which means that all PCIe devices are immediately usable. This also means
that Linux needs to follow Windows 10 and enable IOMMU automatically when
running on such system otherwise connected devices can read/write system
memory pretty much without any restrictions.

Since there is a way to identify PCIe root ports that are "external facing"
we can put all internal devices to pass through (identity mapping) mode and
only external devices need to go through full IOMMU mappings.

We also make sure PCIe ATS (Address Translation Service) is not enabled for
external devices because it could be used to bypass IOMMU completely as
explained in the changelog of patch 3/4.

Finally we expose this information to userspace so tools such as bolt can
do more accurate decision whether or not authorize the connected device.

[1] https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Lu Baolu (1):
  iommu/vt-d: Force IOMMU on for platform opt in hint

Mika Westerberg (3):
  PCI / ACPI: Identify external PCI devices
  iommu/vt-d: Do not enable ATS for external devices
  thunderbolt: Export IOMMU based DMA protection support to userspace

 .../ABI/testing/sysfs-bus-thunderbolt         |  9 +++
 Documentation/admin-guide/thunderbolt.rst     | 23 ++++++++
 drivers/acpi/property.c                       |  3 +
 drivers/iommu/dmar.c                          | 25 ++++++++
 drivers/iommu/intel-iommu.c                   | 58 ++++++++++++++++++-
 drivers/pci/pci-acpi.c                        | 13 +++++
 drivers/pci/probe.c                           | 23 ++++++++
 drivers/thunderbolt/domain.c                  | 17 ++++++
 include/linux/dmar.h                          |  8 +++
 include/linux/pci.h                           |  1 +
 10 files changed, 177 insertions(+), 3 deletions(-)

-- 
2.19.1

