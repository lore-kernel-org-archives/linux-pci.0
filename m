Return-Path: <SRS0=ivaI=RS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B783C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 19:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD7AC218D3
	for <linux-pci@archiver.kernel.org>; Fri, 15 Mar 2019 19:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYaseHbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbfCOTaI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Mar 2019 15:30:08 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42226 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCOTaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Mar 2019 15:30:08 -0400
Received: by mail-oi1-f195.google.com with SMTP id m4so8252589oim.9;
        Fri, 15 Mar 2019 12:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWz7NM37J1/gsXL9QJ15ZxX6nUcfHviRQIGzCysbLrE=;
        b=vYaseHbW/OaIr7P1XZYORsQSlKEly1q8VhoL+bDDoFeXY4QwwpEn1bYHY7xrj8puh6
         sLfQP2KOnyDSfdXpFyBV53tYM05EgyRqMBkhJUitRv04uyosEwdBl72x0E+IC/RYw1zb
         B4WUsb1avZRm1mpRqrhVuRd6IOkewiGfJYgMPLzSLbPpxXsCUvkwhupOo/TZgE4iP/H6
         b1oX+1AnhL0SDprLkc5BgQTrFsrLHr5cJkoY7P38DBQClGE/6u/0mTYXkxgIDNVekYyu
         bWerI5Ta2cI9PEvFq9sgv91S+AfTS9SvN7WEadJEEEKVcg3AyhGVFTr4iRhcO5cd4m63
         vBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWz7NM37J1/gsXL9QJ15ZxX6nUcfHviRQIGzCysbLrE=;
        b=o4rDflYAFSKN+/rUXpHv36Wz4pdPb7fK0z97Qi13Gq/uiAqWboZloks8Y44lIQbQWE
         Dp2IWnXchm6Cl/0EPYZg39yPl7hMIPdTwyZaWV74GtBIcS1zV3bluA6+Db9n5GJJKILW
         F/Mx3ROBB9fHvmz9MByBzw/919zWe0wpH6Qyfll1Yug3i+giJZEVcE/s6Eo/Ge/vt43O
         98hRKmWVxH4ycgqmJIeqO2fQfyy9uaj8zSuingNC83BZEC5tHGRHJA7OsCBCpkpJeITE
         fKBOTOndfRs75KNscOf+PbOGDoSqKe4xgBh5QpLAt4N/10yHEHHLwI4zsAmDTp5T/ybA
         kGlg==
X-Gm-Message-State: APjAAAWZv3b4ZCOOUf39Dxq05mRJXYA6wIVUPpobhEBhRTHQQrjzHp6g
        39jF5Vs/MdNOfHnxl7C0w2Y=
X-Google-Smtp-Source: APXvYqw904hNUZIO3L09VUQi9EDFPb2Oo+J6gM/nrcXcNoYnikl4IBXD2aD/qoKror08s3C8euZ0VA==
X-Received: by 2002:aca:ba06:: with SMTP id k6mr2701614oif.159.1552678206701;
        Fri, 15 Mar 2019 12:30:06 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id q8sm1088417oih.6.2019.03.15.12.30.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Mar 2019 12:30:06 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/4] PCI/ACPI: Advertise HPX type 3 support via _OSC
Date:   Fri, 15 Mar 2019 14:29:40 -0500
Message-Id: <20190315192947.13807-1-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190307213834.5914-1-mr.nuke.me@gmail.com>
References: <20190307213834.5914-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

_OSC now has a way to inform firmware that OS has the capability to
interpret HPX type 3 tables. Since ACPI 6.3 deprecated _OSC specifics,
these are now part of the PCI Firmware Specification.

The following is the document describing the changes:
ECN:	_HPX and PCIe Completion Timeout related _OSC Enhancements
Date:	September 12, 2018
Affected Document: PCI Firmware Specification, Rev. 3.2

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---

This patch is designed to go on top of the following series
"PCI: ACPI: Implement support for _HPX Type 3 tables"
	https://lkml.org/lkml/2019/3/7/790

Although the patch can technically be applied independently, it
doesn't make sense without the rest of the series.

The HPX3 capability bit, to my understanding, is designed to be
informational. i.e. Setting or not setting it would not affect whether
firmware would export HPX3 tables. It may have implications in FFS
systems, where FW might need to make sure things like the completion
timeout value is set correctly throughout the tree.

My understanding is that firmware will prefer to set these with HPX3,
in lieu of firing up SMM on hotplug and other events. Firmware can use
the HPX3 support bit to know how to proceed.

 drivers/acpi/pci_root.c | 2 ++
 include/linux/acpi.h    | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index 707aafc7c2aa..0bee23893297 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -145,6 +145,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-type3" },
 };
 
 static struct pci_osc_bit_struct pci_osc_control_bit[] = {
@@ -446,6 +447,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 	 * PCI domains, so we indicate this in _OSC support capabilities.
 	 */
 	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
+	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
 	if (pci_ext_cfg_avail())
 		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
 	if (pcie_aspm_support_enabled())
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 87715f20b69a..028c138b9082 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -508,7 +508,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
-#define OSC_PCI_SUPPORT_MASKS			0x0000001f
+#define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
+#define OSC_PCI_SUPPORT_MASKS			0x0000011f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
-- 
2.19.2

