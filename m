Return-Path: <SRS0=Emu/=SZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBCC10F03
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4B6A20643
	for <linux-pci@archiver.kernel.org>; Tue, 23 Apr 2019 16:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijck6Jk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfDWQe7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 23 Apr 2019 12:34:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41606 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728476AbfDWQe6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Apr 2019 12:34:58 -0400
Received: by mail-pl1-f195.google.com with SMTP id d9so1865098pls.8;
        Tue, 23 Apr 2019 09:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbDzPgrG7sGMDqtDgEqDecIChfX7yasg95T4JIMF8ig=;
        b=ijck6Jk5jSTFu2bSdPPJqVJPs/1kM3SnO59t7pHYDikzku4nrYwI5QOuv+i7bZeD4o
         cZdrTPRAEmDk+Q7LJXtlbwSHqUhJEcTpIzf+LF2oS1Wy8urQppC8jVKLqRseAhikBvWg
         P8YQyzWrhkSBQsCQpunArWaQxYs1aXD0kalpZD8S875Eb53ISaNiK7b8hnfGSYHTaJBt
         uFLc20tsMQb4fRiT5J3ElRgI4hPXsxWR8T5cdSsqpdU6zTR2dYdjdI7SVLXrThhy57u0
         bDQASgNo4HvrS3Gs8W01u1xZy9OaTrSkuHlunsi1TGDbpg6LctOoToru/gNgkpxRp1YQ
         BkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbDzPgrG7sGMDqtDgEqDecIChfX7yasg95T4JIMF8ig=;
        b=hfIEv/Lo6JWWN//uj4+Nwf3pVu4qYSdXnMbsPZRgx3xhay3XLKGvmpj6NDxRwDYdOk
         G3o/1s34aYQwdh+vNV+tLlFmVj7X98uBGAp7OsxDE2uIugeE2ItShaS//Ulj7OWHMcqS
         sBz2jeTbfgJXNPrzP7CJZiH7hlg1TNKuCFbpevhumUFllOhdUDzfmhG2DKKHi1KVAsnm
         7+KzIJvzkUxHmbCb7+f3XBNpefP1dtOHTR90hDzyh6bpEIRSOEjiCRI/n6N0QkgcttB3
         3UnYCECQGb7keX0DXqYOL1zcQeCf8PYOlTRn3GO2Ch3U0jLouXFiit728U7OfzDYKNxl
         O8Cg==
X-Gm-Message-State: APjAAAVdiBxLtJDFAM4Dft76V1b/dFD7+EPtCt1W1CzHhJP+tjFtLxSn
        SkeoQpYxAqiV/aJS51NzRm8=
X-Google-Smtp-Source: APXvYqxx15uCdJw5COvBnkhivriUaaQc4+Y+k3PQcEua79hCuteAQL71tHPPK/VosXDCo8QQ2oStuw==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr27706060plr.254.1556037297364;
        Tue, 23 Apr 2019 09:34:57 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id v1sm24364801pff.81.2019.04.23.09.34.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 09:34:55 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        x86@kernel.org, fenghua.yu@intel.com,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-gpio@vger.kernel.org, mchehab+samsung@kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v4 28/63] Documentation: PCI: convert pci-iov-howto.txt to reST
Date:   Wed, 24 Apr 2019 00:28:57 +0800
Message-Id: <20190423162932.21428-29-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190423162932.21428-1-changbin.du@gmail.com>
References: <20190423162932.21428-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/index.rst                   |   1 +
 .../{pci-iov-howto.txt => pci-iov-howto.rst}  | 161 ++++++++++--------
 2 files changed, 94 insertions(+), 68 deletions(-)
 rename Documentation/PCI/{pci-iov-howto.txt => pci-iov-howto.rst} (63%)

diff --git a/Documentation/PCI/index.rst b/Documentation/PCI/index.rst
index 452723318405..e1c19962a7f8 100644
--- a/Documentation/PCI/index.rst
+++ b/Documentation/PCI/index.rst
@@ -10,3 +10,4 @@ Linux PCI Bus Subsystem
 
    pci
    PCIEBUS-HOWTO
+   pci-iov-howto
diff --git a/Documentation/PCI/pci-iov-howto.txt b/Documentation/PCI/pci-iov-howto.rst
similarity index 63%
rename from Documentation/PCI/pci-iov-howto.txt
rename to Documentation/PCI/pci-iov-howto.rst
index d2a84151e99c..b9fd003206f1 100644
--- a/Documentation/PCI/pci-iov-howto.txt
+++ b/Documentation/PCI/pci-iov-howto.rst
@@ -1,14 +1,19 @@
-		PCI Express I/O Virtualization Howto
-		Copyright (C) 2009 Intel Corporation
-		    Yu Zhao <yu.zhao@intel.com>
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
 
-		Update: November 2012
-			-- sysfs-based SRIOV enable-/disable-ment
-		Donald Dutile <ddutile@redhat.com>
+====================================
+PCI Express I/O Virtualization Howto
+====================================
 
-1. Overview
+:Copyright: |copy| 2009 Intel Corporation
+:Authors: - Yu Zhao <yu.zhao@intel.com>
+          - Donald Dutile <ddutile@redhat.com>
 
-1.1 What is SR-IOV
+Overview
+========
+
+What is SR-IOV
+--------------
 
 Single Root I/O Virtualization (SR-IOV) is a PCI Express Extended
 capability which makes one physical device appear as multiple virtual
@@ -23,9 +28,11 @@ Memory Space, which is used to map its register set. VF device driver
 operates on the register set so it can be functional and appear as a
 real existing PCI device.
 
-2. User Guide
+User Guide
+==========
 
-2.1 How can I enable SR-IOV capability
+How can I enable SR-IOV capability
+----------------------------------
 
 Multiple methods are available for SR-IOV enablement.
 In the first method, the device driver (PF driver) will control the
@@ -43,105 +50,123 @@ checks, e.g., check numvfs == 0 if enabling VFs, ensure
 numvfs <= totalvfs.
 The second method is the recommended method for new/future VF devices.
 
-2.2 How can I use the Virtual Functions
+How can I use the Virtual Functions
+-----------------------------------
 
 The VF is treated as hot-plugged PCI devices in the kernel, so they
 should be able to work in the same way as real PCI devices. The VF
 requires device driver that is same as a normal PCI device's.
 
-3. Developer Guide
+Developer Guide
+===============
 
-3.1 SR-IOV API
+SR-IOV API
+----------
 
 To enable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	int pci_enable_sriov(struct pci_dev *dev, int nr_virtfn);
-	'nr_virtfn' is number of VFs to be enabled.
-(b) For the second method, from sysfs:
+
+'nr_virtfn' is number of VFs to be enabled.
+
+(b) For the second method, from sysfs::
+
 	echo 'nr_virtfn' > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To disable SR-IOV capability:
-(a) For the first method, in the driver:
+
+(a) For the first method, in the driver::
+
 	void pci_disable_sriov(struct pci_dev *dev);
-(b) For the second method, from sysfs:
+
+(b) For the second method, from sysfs::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_numvfs
 
 To enable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. This is the
 default behavior.
+::
+
 	echo 1 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
 To disable auto probing VFs by a compatible driver on the host, run
 command below before enabling SR-IOV capabilities. Updating this
 entry will not affect VFs which are already probed.
+::
+
 	echo  0 > \
         /sys/bus/pci/devices/<DOMAIN:BUS:DEVICE.FUNCTION>/sriov_drivers_autoprobe
 
-3.2 Usage example
+Usage example
+-------------
 
 Following piece of code illustrates the usage of the SR-IOV API.
+::
 
-static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
-{
-	pci_enable_sriov(dev, NR_VIRTFN);
+	static int dev_probe(struct pci_dev *dev, const struct pci_device_id *id)
+	{
+		pci_enable_sriov(dev, NR_VIRTFN);
 
-	...
-
-	return 0;
-}
+		...
 
-static void dev_remove(struct pci_dev *dev)
-{
-	pci_disable_sriov(dev);
+		return 0;
+	}
 
-	...
-}
+	static void dev_remove(struct pci_dev *dev)
+	{
+		pci_disable_sriov(dev);
 
-static int dev_suspend(struct pci_dev *dev, pm_message_t state)
-{
-	...
+		...
+	}
 
-	return 0;
-}
+	static int dev_suspend(struct pci_dev *dev, pm_message_t state)
+	{
+		...
 
-static int dev_resume(struct pci_dev *dev)
-{
-	...
+		return 0;
+	}
 
-	return 0;
-}
+	static int dev_resume(struct pci_dev *dev)
+	{
+		...
 
-static void dev_shutdown(struct pci_dev *dev)
-{
-	...
-}
+		return 0;
+	}
 
-static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
-{
-	if (numvfs > 0) {
-		...
-		pci_enable_sriov(dev, numvfs);
+	static void dev_shutdown(struct pci_dev *dev)
+	{
 		...
-		return numvfs;
 	}
-	if (numvfs == 0) {
-		....
-		pci_disable_sriov(dev);
-		...
-		return 0;
+
+	static int dev_sriov_configure(struct pci_dev *dev, int numvfs)
+	{
+		if (numvfs > 0) {
+			...
+			pci_enable_sriov(dev, numvfs);
+			...
+			return numvfs;
+		}
+		if (numvfs == 0) {
+			....
+			pci_disable_sriov(dev);
+			...
+			return 0;
+		}
 	}
-}
-
-static struct pci_driver dev_driver = {
-	.name =		"SR-IOV Physical Function driver",
-	.id_table =	dev_id_table,
-	.probe =	dev_probe,
-	.remove =	dev_remove,
-	.suspend =	dev_suspend,
-	.resume =	dev_resume,
-	.shutdown =	dev_shutdown,
-	.sriov_configure = dev_sriov_configure,
-};
+
+	static struct pci_driver dev_driver = {
+		.name =		"SR-IOV Physical Function driver",
+		.id_table =	dev_id_table,
+		.probe =	dev_probe,
+		.remove =	dev_remove,
+		.suspend =	dev_suspend,
+		.resume =	dev_resume,
+		.shutdown =	dev_shutdown,
+		.sriov_configure = dev_sriov_configure,
+	};
-- 
2.20.1

