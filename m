Return-Path: <SRS0=qbZn=NX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC1C43441
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 11:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 087E8223DD
	for <linux-pci@archiver.kernel.org>; Mon, 12 Nov 2018 11:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IqPtKD+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087E8223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbeKLVIG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 12 Nov 2018 16:08:06 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53729 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728302AbeKLVIG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Nov 2018 16:08:06 -0500
Received: by mail-wm1-f68.google.com with SMTP id f10-v6so8053730wme.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Nov 2018 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=EQB9tZHTykcdTERBnFRL0vdG71N1IvLfnOeuvuLo1LM=;
        b=IqPtKD+aR0Nmkxq4pmR74da6t/BUgMiGI0HLNNiYmCN5x36noDt/1B+QT89mkv+PeX
         U9X/GBAcqfdWL5BJY79dhwwO23D8JaVDsvgxAhDFTTXzfASAEA9g55HkWr/UlgxtZR4O
         mCVmw6W3g6svCZHktVlftVYJplstF92luf5xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EQB9tZHTykcdTERBnFRL0vdG71N1IvLfnOeuvuLo1LM=;
        b=ebmRllhWBz8pHocX5hHdGIaP26kblrcyq8cU09KE2dpvoDR9D+RlnFKnmvCvROCH2+
         Nzsqp/OrOPOy4Jr+p/fzYZgHj4JEbr2AxU/jUGb6glxN7qNWxijY0lIlNXs1w7tI6Y5g
         xM9Uo4EzZtbgsq+H6L/8scf8LSfoKGZ1n8dWlIJxmAXDz6q2vq3P0Y/Nby3Zd5nr95e7
         x6OzZd+QcaPjLH/ZnD3yaHroiWwVMX4QRxI9fQBmoZPdC2LoJZZeOqWgt26ozRNZ1f6U
         3sLiqaEhSa+hRwol06coytbOm+XXgS5XAq4tdWkWDxUXu1YGLS3uDFrkw1HgDXzOHjRM
         IYbA==
X-Gm-Message-State: AGRZ1gLFzR99+MRPZPM6CRppIYkGQMLJawPOCfqG+TkGorJLJIzD+YJX
        jOc6tyMNgn/FfvMd2zCkLBFxkw==
X-Google-Smtp-Source: AJdET5cdfWJKW7JVSh/oRw3ZAqI3rcFP/M5/gZO6a37/oalXw9t3iePYNhYr6GLVsOOmbQHq0HDn0w==
X-Received: by 2002:a1c:9b4e:: with SMTP id d75-v6mr7851600wme.62.1542021317545;
        Mon, 12 Nov 2018 03:15:17 -0800 (PST)
Received: from localhost.localdomain (237.204.154.77.rev.sfr.net. [77.154.204.237])
        by smtp.gmail.com with ESMTPSA id q11-v6sm2923009wrn.45.2018.11.12.03.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 03:15:16 -0800 (PST)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        graeme.gregory@linaro.org, nariman.poushin@linaro.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH] arm64: acpi/pci: WARN() when ignoring _DSM request to preserve PCI resources
Date:   Mon, 12 Nov 2018 12:15:11 +0100
Message-Id: <20181112111511.12091-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
hierarchy at boot. This is a departure from what is customary on ACPI
systems, and may break assumptions in some places (e.g., CCIX), that
the OS will honour the PCI resource allocation as configured by the
firmware.

ACPI already specifies a device specific ACPI method (_DSM) for PCI
root bridge nodes that tells us whether the firmware thinks the
configuration should be ignored or preserved, but unfortunately, we
cannot simply change the behavior of the OS and start honouring
these requests unconditionally, given that firmware implementations
in the field may issue the _DSM request inadvertently and still rely
on the OS to create the resource allocation from scratch.

So as a preliminary step, let's issue a warning about this case,
increasing the likelihood that we can fix this behavior at some
point in the future.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/pci.c  | 15 +++++++++++++++
 include/linux/pci-acpi.h |  7 ++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
index bb85e2f4603f..318ca865c41f 100644
--- a/arch/arm64/kernel/pci.c
+++ b/arch/arm64/kernel/pci.c
@@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	struct acpi_pci_generic_root_info *ri;
 	struct pci_bus *bus, *child;
 	struct acpi_pci_root_ops *root_ops;
+	union acpi_object *obj;
 
 	ri = kzalloc(sizeof(*ri), GFP_KERNEL);
 	if (!ri)
@@ -193,6 +194,20 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 	if (!bus)
 		return NULL;
 
+	/*
+	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
+	 * Configuration', which tells us whether the firmware wants us to
+	 * preserve or ignore the firmware's configuration of the PCI resource
+	 * tree for this root bridge.
+	 */
+	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
+				IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
+	if (obj && obj->type == ACPI_TYPE_INTEGER)
+		WARN_ONCE(obj->integer.value == 0,
+			  "Firmware did not request its PCI resource allocation to be ignored, but ignoring it anyway\n");
+
+	ACPI_FREE(obj);
+
 	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
 
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..62b7fdcc661c 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
 #endif
 
 extern const guid_t pci_acpi_dsm_guid;
-#define DEVICE_LABEL_DSM	0x07
-#define RESET_DELAY_DSM		0x08
-#define FUNCTION_DELAY_DSM	0x09
+#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
+#define DEVICE_LABEL_DSM		0x07
+#define RESET_DELAY_DSM			0x08
+#define FUNCTION_DELAY_DSM		0x09
 
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
-- 
2.17.1

