Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AF1C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A41A2133D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJd4WjRr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A41A2133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388977AbeKPJ0O (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:26:14 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34567 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPJ0N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 04:26:13 -0500
Received: by mail-ot1-f65.google.com with SMTP id t5so19700117otk.1;
        Thu, 15 Nov 2018 15:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0/zlQteT7Eb+WVjd5aUv8zmL6TUh4WrZMBcM1VmM60w=;
        b=RJd4WjRrMh+I3fogDnQnkEar5Mze93Z9Lnb32BCllXD4QjvTA0UEeAiidrUwivLnkn
         Zy/jNIr4E7xK4+d5YunPO0SLw5nz1ms8tF1F4vtVwUjUdFpX+mZwzbr69vM6g5Irx9fF
         oEcYj2+jBiQDx1nqXa+N0Ub37260OCLxo/2uV61XakP5nD4ffB4PHW0EaB4uhSNDvDOE
         Nd5qcppdMBDhjG9Fwr+Lhp9IWUadb5LCndSrYruFqZwq+K9cioIutFKELf1ycYZdMGdI
         O3uN65WmZ9rKbWXm41TjcLij/8yTtzOf1h++geWO6jvOru1cSUHB3rWEMogRsXIAl94e
         ck3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0/zlQteT7Eb+WVjd5aUv8zmL6TUh4WrZMBcM1VmM60w=;
        b=OLVSQRCvscSfL1nob0esDXWIZLKAvQZAj0vTvxsskYt5gscHb9hZD79PSK1fdEkL50
         zZfE9I3RAGl1cnfXTEb3ULV5ErFNWLKE8P+bsOKLLzWUXikxeZmXlFWsVvFqJTxo0sAC
         V2Eo9Y2AYKZ+ZAXc3jGdw3z/J6Jy9Y4qN8NEWD6hHLkETiJkTWqFQBnYMByqKnwM+7e+
         VlsoLOUTGtR/Z9YjbrrO/8DxBWUMQMkd8SnwKz18zn10PGrpzM2G4WfP1J2XY04tszyE
         9dV+KERXaahQw3hvx9BbgaJcTJyJBwISnjWNlEFN6FdTR+TKqXHX17VXgFZq/NJCVoW3
         SCsA==
X-Gm-Message-State: AGRZ1gJf9NO8CrVzbnoDFxV7FLsJahQamwCcb8HdSsdnQDAgwPZ10MC0
        QwbBbWE7wGhivGj1V7CNbqMQ4fc3GZM=
X-Google-Smtp-Source: AJdET5cXWr6Qmr40kj0P21sABhxXuWQiugOA6lCkMgOojEvFft0MixSoyluh6J5y5WMoO5U1IIzehQ==
X-Received: by 2002:a9d:41ca:: with SMTP id v10mr5271965oti.101.1542323779488;
        Thu, 15 Nov 2018 15:16:19 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 15:16:19 -0800 (PST)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     helgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] PCI/AER: Do not use APEI/HEST to disable AER services globally
Date:   Thu, 15 Nov 2018 17:16:02 -0600
Message-Id: <20181115231605.24352-2-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI). HEST is tightly coupled to ownership
of AER, however the correct way to determine AER ownership is the _OSC
method.

_OSC is negotiated per root bus. It's possible to have one HEST
descriptor for all root busses where AER is owned by firmware, and
still have root busses that are not firmware-first. In that case we
would incorrectly disable AER services globally.

Instead of using HEST in making the determination, always request AER
control via _OSC, and only disable AER when firmware denies control.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/acpi/pci_root.c  |  9 ++-------
 drivers/pci/pcie/aer.c   | 25 +------------------------
 include/linux/pci-acpi.h |  6 ------
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..32b2053bb0fa 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -491,13 +491,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
 		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
 
-	if (pci_aer_available()) {
-		if (aer_acpi_firmware_first())
-			dev_info(&device->dev,
-				 "PCIe AER handled by firmware\n");
-		else
-			control |= OSC_PCI_EXPRESS_AER_CONTROL;
-	}
+	if (pci_aer_available())
+		control |= OSC_PCI_EXPRESS_AER_CONTROL;
 
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a90a9194ac4a..ac014151b7a6 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -316,29 +316,6 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
 	return dev->__aer_firmware_first;
 }
 
-static bool aer_firmware_first;
-
-/**
- * aer_acpi_firmware_first - Check if APEI should control AER.
- */
-bool aer_acpi_firmware_first(void)
-{
-	static bool parsed = false;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= NULL,	/* Check all PCIe devices */
-		.firmware_first	= 0,
-	};
-
-	if (pcie_ports_native)
-		return false;
-
-	if (!parsed) {
-		apei_hest_parse(aer_hest_parse, &info);
-		aer_firmware_first = info.firmware_first;
-		parsed = true;
-	}
-	return aer_firmware_first;
-}
 #endif
 
 #define	PCI_EXP_AER_FLAGS	(PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE | \
@@ -1453,7 +1430,7 @@ static struct pcie_port_service_driver aerdriver = {
  */
 int __init pcie_aer_init(void)
 {
-	if (!pci_aer_available() || aer_acpi_firmware_first())
+	if (!pci_aer_available())
 		return -ENXIO;
 	return pcie_port_service_register(&aerdriver);
 }
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 8082b612f561..2e9c0b973eba 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -116,10 +116,4 @@ static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
 #endif	/* CONFIG_ACPI */
 
-#ifdef CONFIG_ACPI_APEI
-extern bool aer_acpi_firmware_first(void);
-#else
-static inline bool aer_acpi_firmware_first(void) { return false; }
-#endif
-
 #endif	/* _PCI_ACPI_H_ */
-- 
2.17.1

