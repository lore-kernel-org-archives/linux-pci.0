Return-Path: <SRS0=9zG9=SF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31AF0C10F0B
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9553206DF
	for <linux-pci@archiver.kernel.org>; Wed,  3 Apr 2019 15:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGznwaBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfDCPuc (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:50:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40199 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbfDCPuc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Apr 2019 11:50:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so8519497pgo.7;
        Wed, 03 Apr 2019 08:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYqHZ4Fm3dmAxMjcJUl+ZlWUUc6Utfh7jXvMuo2nAcs=;
        b=NGznwaBaPJl2ORUYwXvC0DqZGk9GqVZRq0IF7G4vxZIGEn6uNYs26CaAdw+dWykEzp
         luoUa/AZHdNXggqLLSPJSYtGMVyoeX54aurI3kTMxER4g6/goyQTsxnu/UVNhvhr/o/2
         gIaB1EIgvrWKJORif3BKsMJ06XtZ0xR2UVPHP7s6XOcm41sjPIX6V14PcDtvxt+zg4Vp
         40pVbpC8ZVkBHiEmYeamsJ7p9LRQ9c2WuXblfZJIQhaue5RU+b1CCq/t33eAwW3Byybx
         Hx2iSdZJqJlqwTu2hsTrrl3pO5Jf3i+stUUf2OwmGI5Q1ThFJ6q6lMJOXVIZs0tKABM9
         VHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYqHZ4Fm3dmAxMjcJUl+ZlWUUc6Utfh7jXvMuo2nAcs=;
        b=ZcTELRMAAY8nafaoFX6qXU2XEsfyDdhC29nHoFqW5tzTTN6VkN2gvyeREnSoiVdoaV
         1sFtGeQPRRoOrx4YuNUDKXR7T9SOKAVoAA9NLlDord6CgpLHI5y3ANQMw90H3dF2JoP+
         QK1SX+mkHrOAUBLlMOqrJmqOhkG66gR0phSj/xC1BnHdC3AyPO4ZwbuW5uCkNZAISX2h
         VF69TwWy7076T9vAaYDXqKs0XNUrat6KzJe0QWi49DR5cVzM+1JzFpz0v6g34fGnQCrQ
         EQHFeqIgIfBJ6rYA4T3Ob1HpbW7r6JPUzLy0r0vKdwbYVn28MrphPED/S6NQCqdwF1SA
         /W/A==
X-Gm-Message-State: APjAAAWGvW824QA1lTxHS1Z1NW2E0rRXZMQg5FeKEbf6AmfG9xcNBdkp
        hIzT9oMT/dR57sc8c5QoYvs=
X-Google-Smtp-Source: APXvYqx6Ho2lvOwrV0bhbs5N2jFSDDTsLJ+1HWBV+sy+eTr8jDJn5wx8c92y1jvo4fHFgBYM+izGaQ==
X-Received: by 2002:a62:12c9:: with SMTP id 70mr142272pfs.156.1554306630864;
        Wed, 03 Apr 2019 08:50:30 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id b8sm18906922pgq.33.2019.04.03.08.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 08:50:30 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v2 04/12] Documentation: PCI: convert PCI/pci-iov-howto.txt to reST format
Date:   Wed,  3 Apr 2019 23:49:47 +0800
Message-Id: <20190403154955.12096-5-changbin.du@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190403154955.12096-1-changbin.du@gmail.com>
References: <20190403154955.12096-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This converts the plain text documentation to reStructuredText format and
add it to Sphinx TOC tree. No essential content change.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
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

