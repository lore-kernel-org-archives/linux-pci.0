Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795CBC43441
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B8EE20868
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B8EE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbeK3C6H (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:58:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:3503 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbeK3C5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 21:57:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 07:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="96807006"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2018 07:51:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B7C2A18E; Thu, 29 Nov 2018 17:51:53 +0200 (EET)
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
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] PCI / iommu / thunderbolt: IOMMU based DMA protection
Date:   Thu, 29 Nov 2018 18:51:49 +0300
Message-Id: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent systems with Thunderbolt ports may be utilizing IOMMU to prevent DMA
attacks. This is different from the previous security level based scheme
because the connected device cannot access system memory outside of the
regions allocated for it by the driver.

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
only external devices need to go through full IOMMU mappings. We add a new
flag "untrusted" that is supposed to cover various PCIe devices that may be
used to conduct DMA attacks.

We also make sure PCIe ATS (Address Translation Service) is not enabled for
devices flagged as untrusted because it could be used to bypass IOMMU
completely as explained in the changelog of patch 3/4.

Finally we expose this information to userspace so tools such as bolt can
do more accurate decision whether or not authorize the connected device.

[1] https://software.intel.com/sites/default/files/managed/c5/15/vt-directed-io-spec.pdf

Previous version of the patch series can be found here:

  v2: https://lkml.org/lkml/2018/11/26/638
  v1: https://www.spinics.net/lists/linux-pci/msg77751.html

Changes from v2:
  
  * Rename the flag to "untrusted"
  * Simplify setting the flag for root ports
  * Dropped loop in set_pcie_untrusted()
  * Add comment on top of prp_guids explaining the possible caveat
    resulting when the new GUIDs are treated as equivalent
  * Updated changelogs according to feedback

Changes from v1:

  * Reword Documentation/admin-guide/thunderbolt.rst to make the feature
    time frame/platform oriented as there will be systems shipping
    with Linux installed by default.

  * Rename the flag is_external to is_untrusted so that we could use the
    same flag to cover all kinds of "untrusted" PCI devices, not just
    Thunderbolt connected devices. I still parse the _DSD in PCI/ACPI core
    because that's where we currently handle "HotPlugSupportInD3" as well.
    Also updated comments in patch [1/4].

  * Added tags from Ashok, Joerg and Yehezkel. I'm assuming they still
    apply because I did not change the code with the exception of few
    comments and rename of the flag. Let me know if that's not the case
    anymore.

Lu Baolu (1):
  iommu/vt-d: Force IOMMU on for platform opt in hint

Mika Westerberg (3):
  PCI / ACPI: Identify untrusted PCI devices
  iommu/vt-d: Do not enable ATS for untrusted devices
  thunderbolt: Export IOMMU based DMA protection support to userspace

 .../ABI/testing/sysfs-bus-thunderbolt         |  9 +++
 Documentation/admin-guide/thunderbolt.rst     | 20 +++++++
 drivers/acpi/property.c                       | 11 ++++
 drivers/iommu/dmar.c                          | 25 +++++++++
 drivers/iommu/intel-iommu.c                   | 56 ++++++++++++++++++-
 drivers/pci/pci-acpi.c                        | 19 +++++++
 drivers/pci/probe.c                           | 15 +++++
 drivers/thunderbolt/domain.c                  | 17 ++++++
 include/linux/dmar.h                          |  8 +++
 include/linux/pci.h                           |  8 +++
 10 files changed, 185 insertions(+), 3 deletions(-)

-- 
2.19.2

