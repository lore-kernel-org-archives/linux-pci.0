Return-Path: <SRS0=/keI=R5=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB263C43381
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39A920823
	for <linux-pci@archiver.kernel.org>; Tue, 26 Mar 2019 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6pmjlt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732147AbfCZRX6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:23:58 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46518 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732114AbfCZRX5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Mar 2019 13:23:57 -0400
Received: by mail-oi1-f193.google.com with SMTP id x188so10553820oia.13;
        Tue, 26 Mar 2019 10:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fiq9HXSF/eDUChK1D39FGIx6tNtbvfiGbda9koLVfWA=;
        b=A6pmjlt81e9rK+llVGSzdBcghOO4EtlGbsJ0l3lWyEpLSAHf/bLKnBU3R3qcdCvHp/
         j2dMyT9ZaHULEC4q3vEvEBigr6tQX3tJH75XM2BHA84lBuuNyF1wHxXw+IzrtRlonufN
         v7dmX6g17fHEUmhU4YBZQX0Chq2l7XAeskeHep+yheFxuJnBniBDJVh/0k/0GQP3KmUG
         RkzwMJpCcLnfIxjgjbqkMm/1druHpS/cGvq7mJtHjglKCy2gQ5ucpIJnhmj9vaOgNP8W
         boLFY8AlKhpelTBMRdE3O8FBDxFqQsZPEN9VYyRhClTEmw+cg+/0HnNcOqxqyoQRGi12
         0gLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fiq9HXSF/eDUChK1D39FGIx6tNtbvfiGbda9koLVfWA=;
        b=agN6SntpWFUVfJjNCnlJ9fRDfmfr58VJVPNKaRUMkW8fZ1i0uDs6/OddNSU18mR+mY
         MZ8gGa6OuX932EKxQ//4u+Q9hy35EIGtV4+/Q2tBXJOSjn4wQG+q2tOeg+HZSVLI/r29
         6lvv611ncj+ArKuEAo9PriUYS8Prq/60Aq4Hc+wpwd219pyFbRLvDIW6G3eoBQpD/sIi
         28Ixpt5JGNl+t2wIN2whNxIk9hI5tGs2SEALKIeN29HUwCd5xgR7PaGTxVPaLTe5lQQP
         Ti2OrcVAxpQSnxGmcrbM0g0xTU16kFmVdEJ88hj/59sx6/HrG9OCpzpWCEBbA5UVT6GV
         jMeQ==
X-Gm-Message-State: APjAAAXtoN0iwge3aMLZYuaJmpzq2De2D0LNau6h3UO420Bns5YTbGLw
        cO4HR3/2oH0H1pmRybLv1Lk=
X-Google-Smtp-Source: APXvYqzjkiKtK6IggnWjo8r6fNzDaCeM87ogKjs1yliYkxyFn6OQUL5+X/HGcw0UbAXcsZN3NeswYQ==
X-Received: by 2002:aca:4103:: with SMTP id o3mr16554560oia.71.1553621036988;
        Tue, 26 Mar 2019 10:23:56 -0700 (PDT)
Received: from nuclearis2-1.lan (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id z12sm3047459otp.2.2019.03.26.10.23.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 10:23:56 -0700 (PDT)
From:   Alexandru Gagniuc <mr.nuke.me@gmail.com>
To:     bhelgaas@google.com
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, scott.faasse@hpe.com, leo.duran@amd.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 2/2] PCI/AER: Determine AER ownership based on _OSC instead of HEST
Date:   Tue, 26 Mar 2019 12:23:42 -0500
Message-Id: <20190326172343.28946-3-mr.nuke.me@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190326172343.28946-1-mr.nuke.me@gmail.com>
References: <20190326172343.28946-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HEST is used to describe the meaning of errors received as part of ACPI
Platform Error Interfaces (APEI), however the correct way to determine
AER ownership is the _OSC method.

The ACPI spec allows _OSC and HEST to say things that might not make
sense on a specific hardware implementation.
For example _OSC can say "OS has control" on the root bus, while HEST
says "This PCIe device is firmware-first". This is fine when the
platform can differentiate error sources at the root complex. On x86
platforms, AER errors can be routed to either to an MSI vector
(native AER), or to SMM (firmware-first). As this is done at the root
complex level, the example above would not make sense.

Notice that in neither case is it correct to go to HEST to determine
AER ownership. This is the conclusion of a six-months discussion in
the ACPI Software Working Group.

pci_dev->__aer_firmware_first is used to prevent modification of AER
registers when firmware owns AER. This is synonymous with the AER
ownership negotiated during _OSC. Thus _OSC is the correct way to
use to set this flag, not HEST.

Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
---
 drivers/pci/pcie/aer.c | 57 ++----------------------------------------
 1 file changed, 2 insertions(+), 55 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index d029979e61f6..08cee30b3ef3 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -237,66 +237,13 @@ static inline bool hest_match_type(struct acpi_hest_header *hest_hdr,
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
2.19.2

