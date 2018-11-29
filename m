Return-Path: <SRS0=ChyX=OI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136A3C43610
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0E2213A2
	for <linux-pci@archiver.kernel.org>; Thu, 29 Nov 2018 15:52:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F0E2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbeK3C5t (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 29 Nov 2018 21:57:49 -0500
Received: from mga04.intel.com ([192.55.52.120]:65045 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729044AbeK3C5t (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 29 Nov 2018 21:57:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 07:52:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
   d="scan'208";a="113754391"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 29 Nov 2018 07:51:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 05843325; Thu, 29 Nov 2018 17:51:53 +0200 (EET)
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
Subject: [PATCH v3 4/4] thunderbolt: Export IOMMU based DMA protection support to userspace
Date:   Thu, 29 Nov 2018 18:51:53 +0300
Message-Id: <20181129155153.35840-5-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
References: <20181129155153.35840-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Recent systems with Thunderbolt ports may support IOMMU natively. In
practice this means that Thunderbolt connected devices are placed behind
an IOMMU during the whole time it is connected (including during boot)
making Thunderbolt security levels redundant. This is called Kernel DMA
protection [1] by Microsoft.

Some of these systems still have Thunderbolt security level set to
"user" in order to support OS downgrade (the older version of the OS
might not support IOMMU based DMA protection so connecting a device
still relies on user approval).

Export this information to userspace by introducing a new sysfs
attribute (iommu_dma_protection). Based on it userspace tools can make
more accurate decision whether or not authorize the connected device.

In addition update Thunderbolt documentation regarding IOMMU based DMA
protection.

[1] https://docs.microsoft.com/en-us/windows/security/information-protection/kernel-dma-protection-for-thunderbolt

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Yehezkel Bernat <YehezkelShB@gmail.com>
---
 .../ABI/testing/sysfs-bus-thunderbolt         |  9 +++++++++
 Documentation/admin-guide/thunderbolt.rst     | 20 +++++++++++++++++++
 drivers/thunderbolt/domain.c                  | 17 ++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-thunderbolt b/Documentation/ABI/testing/sysfs-bus-thunderbolt
index 151584a1f950..b21fba14689b 100644
--- a/Documentation/ABI/testing/sysfs-bus-thunderbolt
+++ b/Documentation/ABI/testing/sysfs-bus-thunderbolt
@@ -21,6 +21,15 @@ Description:	Holds a comma separated list of device unique_ids that
 		If a device is authorized automatically during boot its
 		boot attribute is set to 1.
 
+What: /sys/bus/thunderbolt/devices/.../domainX/iommu_dma_protection
+Date:		Mar 2019
+KernelVersion:	4.21
+Contact:	thunderbolt-software@lists.01.org
+Description:	This attribute tells whether the system uses IOMMU
+		for DMA protection. Value of 1 means IOMMU is used 0 means
+		it is not (DMA protection is solely based on Thunderbolt
+		security levels).
+
 What: /sys/bus/thunderbolt/devices/.../domainX/security
 Date:		Sep 2017
 KernelVersion:	4.13
diff --git a/Documentation/admin-guide/thunderbolt.rst b/Documentation/admin-guide/thunderbolt.rst
index 35fccba6a9a6..898ad78f3cc7 100644
--- a/Documentation/admin-guide/thunderbolt.rst
+++ b/Documentation/admin-guide/thunderbolt.rst
@@ -133,6 +133,26 @@ If the user still wants to connect the device they can either approve
 the device without a key or write a new key and write 1 to the
 ``authorized`` file to get the new key stored on the device NVM.
 
+DMA protection utilizing IOMMU
+------------------------------
+Recent systems from 2018 and forward with Thunderbolt ports may natively
+support IOMMU. This means that Thunderbolt security is handled by an IOMMU
+so connected devices cannot access memory regions outside of what is
+allocated for them by drivers. When Linux is running on such system it
+automatically enables IOMMU if not enabled by the user already. These
+systems can be identified by reading ``1`` from
+``/sys/bus/thunderbolt/devices/domainX/iommu_dma_protection`` attribute.
+
+The driver does not do anything special in this case but because DMA
+protection is handled by the IOMMU, security levels (if set) are
+redundant. For this reason some systems ship with security level set to
+``none``. Other systems have security level set to ``user`` in order to
+support downgrade to older OS, so users who want to automatically
+authorize devices when IOMMU DMA protection is enabled can use the
+following ``udev`` rule::
+
+  ACTION=="add", SUBSYSTEM=="thunderbolt", ATTRS{iommu_dma_protection}=="1", ATTR{authorized}=="0", ATTR{authorized}="1"
+
 Upgrading NVM on Thunderbolt device or host
 -------------------------------------------
 Since most of the functionality is handled in firmware running on a
diff --git a/drivers/thunderbolt/domain.c b/drivers/thunderbolt/domain.c
index 93e562f18d40..7416bdbd8576 100644
--- a/drivers/thunderbolt/domain.c
+++ b/drivers/thunderbolt/domain.c
@@ -7,7 +7,9 @@
  */
 
 #include <linux/device.h>
+#include <linux/dmar.h>
 #include <linux/idr.h>
+#include <linux/iommu.h>
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
@@ -236,6 +238,20 @@ static ssize_t boot_acl_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(boot_acl);
 
+static ssize_t iommu_dma_protection_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	/*
+	 * Kernel DMA protection is a feature where Thunderbolt security is
+	 * handled natively using IOMMU. It is enabled when IOMMU is
+	 * enabled and ACPI DMAR table has DMAR_PLATFORM_OPT_IN set.
+	 */
+	return sprintf(buf, "%d\n",
+		       iommu_present(&pci_bus_type) && dmar_platform_optin());
+}
+static DEVICE_ATTR_RO(iommu_dma_protection);
+
 static ssize_t security_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -251,6 +267,7 @@ static DEVICE_ATTR_RO(security);
 
 static struct attribute *domain_attrs[] = {
 	&dev_attr_boot_acl.attr,
+	&dev_attr_iommu_dma_protection.attr,
 	&dev_attr_security.attr,
 	NULL,
 };
-- 
2.19.2

