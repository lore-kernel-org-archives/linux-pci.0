Return-Path: <SRS0=ulVR=N2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F271C43441
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 252EE2145D
	for <linux-pci@archiver.kernel.org>; Thu, 15 Nov 2018 23:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oIcLNF+y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252EE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389094AbeKPJ0R (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 04:26:17 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41528 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeKPJ0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 04:26:16 -0500
Received: by mail-oi1-f196.google.com with SMTP id g188-v6so18227216oif.8;
        Thu, 15 Nov 2018 15:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/PmV1hM4vrJlqJyO21xijvwrR0pYLkAAA5QXEtDSQMk=;
        b=oIcLNF+yYQ013z44r1tNgoJwxIhR3FmZvqn62c/4aCbaIc0Z3aUWvLWj93DzAuHTwa
         gq0DrCk+lFgcGJQrDL3/BWwvLwhnJr154/FCj1Z5b5Tb6WlgVgXzczj8Vf/mtWLwXj46
         TnzRY0a6KXM26AYLwqkd4P7QAVAeXBw5d3X+UjdmI+X5ZCUiaQvtE0iKImfVYTdFKRe4
         bF30KDK0uPyPcuFN3JfKCixfspFpAuY8JyFzXGqFLrdFwO5ZxuRMms2f0scLXgwwUQ8P
         gbUX/LYpUaXDZ62W1CY3jIvy4S1sdcsYw8t8g9Qu6cgk/K+CEvx7q1JAD3h4r+Dzivpv
         ls2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/PmV1hM4vrJlqJyO21xijvwrR0pYLkAAA5QXEtDSQMk=;
        b=eVTHbiutl2wM4iCtXcN4IPMP7uFOK5EO6hsBYxcOAF1DJucp+InVl8I1TVntW3xVrn
         b0pK3FyrFofhYbHMlmCie7/U8o3YZ4TtnPM36i/LcwSLbPeNprhxPVGmDCjJrm5xOzeN
         KCo/CeWlLQ7jmMY2O8L16giFKBtHCrhHGv2NrnhdKRMPf93/KuNhtJnuxUJZSm6hhl4j
         uBZfHFB8xpg+TA2k9hdwY49UJ/LS/VZC3VFrHlTDHwUeFL+cM9tAW9LsDw24mmaLDPRb
         5FeX2OKHD7eXZUJNCxvoLpPIpHuXfjwVmJt4lCEUWljFGAw66CkgC1Tn4x+V5qi2fNiB
         wnww==
X-Gm-Message-State: AGRZ1gKH/OFe/iBJdDDM8h2+d5wfkSJNB6Tbzet29pXxUulJybKcBTc5
        8acVU2V+IeWm2smkNGOAfB0=
X-Google-Smtp-Source: AJdET5dEM4LH/60J1XaBaSQP72vzRRSWkD/tk88ONGpgvdu8jH27+iSofBXX7RzMh67AkjhyG65g8g==
X-Received: by 2002:aca:a6c5:: with SMTP id t66mr2568680oij.225.1542323782908;
        Thu, 15 Nov 2018 15:16:22 -0800 (PST)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id o81-v6sm8680267oif.1.2018.11.15.15.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Nov 2018 15:16:22 -0800 (PST)
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
Subject: [PATCH 2/2] PCI/AER: Determine AER ownership based on _OSC instead of HEST
Date:   Thu, 15 Nov 2018 17:16:03 -0600
Message-Id: <20181115231605.24352-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI), however the correct way to determine
AER ownership is the _OSC method.

pci_dev->__aer_firmware_first is used to prevent modification of AER
registers when firmware owns AER. This is synonymous with the AER
ownership negotiated during _OSC. Thus _OSC is the correct way to
use to set this flag, not HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 57 ++----------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ac014151b7a6..dd9594e8ed08 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -240,66 +240,13 @@ static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
 	return false;
 }
 
-struct aer_hest_parse_info {
-	struct pci_dev *pci_dev;
-	int firmware_first;
-};
-
-static int hest_source_is_pcie_aer(struct acpi_hest_header *hest_hdr)
-{
-	if (hest_hdr->type == ACPI_HEST_TYPE_AER_ROOT_PORT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_ENDPOINT ||
-	    hest_hdr->type == ACPI_HEST_TYPE_AER_BRIDGE)
-		return 1;
-	return 0;
-}
-
-static int aer_hest_parse(struct acpi_hest_header *hest_hdr, void *data)
-{
-	struct aer_hest_parse_info *info = data;
-	struct acpi_hest_aer_common *p;
-	int ff;
-
-	if (!hest_source_is_pcie_aer(hest_hdr))
-		return 0;
-
-	p = (struct acpi_hest_aer_common *)(hest_hdr + 1);
-	ff = !!(p->flags & ACPI_HEST_FIRMWARE_FIRST);
-
-	/*
-	 * If no specific device is supplied, determine whether
-	 * FIRMWARE_FIRST is set for *any* PCIe device.
-	 */
-	if (!info->pci_dev) {
-		info->firmware_first |= ff;
-		return 0;
-	}
 
-	/* Otherwise, check the specific device */
-	if (p->flags & ACPI_HEST_GLOBAL) {
-		if (hest_match_type(hest_hdr, info->pci_dev))
-			info->firmware_first = ff;
-	} else
-		if (hest_match_pci(p, info->pci_dev))
-			info->firmware_first = ff;
-
-	return 0;
-}
 
 static void aer_set_firmware_first(struct pci_dev *pci_dev)
 {
-	int rc;
-	struct aer_hest_parse_info info = {
-		.pci_dev	= pci_dev,
-		.firmware_first	= 0,
-	};
+	struct pci_host_bridge *host = pci_find_host_bridge(pci_dev->bus);
 
-	rc = apei_hest_parse(aer_hest_parse, &info);
-
-	if (rc)
-		pci_dev->__aer_firmware_first = 0;
-	else
-		pci_dev->__aer_firmware_first = info.firmware_first;
+	pci_dev->__aer_firmware_first = !host->native_aer;
 	pci_dev->__aer_firmware_first_valid = 1;
 }
 
-- 
2.17.1

