Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0A9391838
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 05:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612748; cv=none; b=jpTRzvCGKhMCNXu8XucALITWUXLm2NVQWkgK76+gccTKoKL/NzMnwDwL+TZ4yKMZcnF2ZfOqnGNgR0Y5MCogcICT73pVyHiRo/wIJ5LQiEYLGF+6ACjHvr9SvLps3O6oQd/ki6A8G/ljkHOXxI6cUiiL6m90T0jyzxRC+jUE3rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612748; c=relaxed/simple;
	bh=DNpHQBMjU1wP0f8jQ4t452JbWb0XX8oIoHdLdwtqCfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JnQp3MPsKN+91WgQ1UxEkJovFnPhHVNd5F2mIPNJk8aSGdaFnyC2YGEYsnrh5EUtF9i8UBscQ+NISkLrExNY+qjMIH9LCZkF0NrIhUJbidM8GYEsTmsc9FsvmHGgmQ+QBieBnu21DTAAZ1y/w28rFvor4n7jidJS8s/k/kRxRZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzcULYBV; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzcULYBV"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cb5a6aa8760so1739845a12.1
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 22:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784612746; x=1785217546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UgojYRWP1WvUNsyVTZf0JAe0a0XGAFDjQiUak8O6rqY=;
        b=pzcULYBVnMcH42hzqIwsULuQFNtipObN+NiIpKsIBH47VbCr+NjIbq1VyfD3kgfITX
         9iZ+vh2egG2QQqzTX4YetuldKVvXBrwrHq7f4pq/61AFFQl32a79Q8T6Z+GgGxN8wjn2
         sbxzSNeGJ+5CIQcQsa2hpxEQh/d/g7Ffnf4FxIdqlPQ9fWAio6izmjG0UuW0EtFf00tt
         8mYD/9k81Y4hP/adpqahHlMp7QnBd0/tNL+EpdzqKHUian1XgxcMEIfT24bIq3kw8Ame
         opVCC38Meewn8qrYWIBNcEjIt7+tjvYOo/TDgF9le0C+ZwWSMrLyJ+lCY7u+HDY258Wa
         tPLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784612746; x=1785217546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UgojYRWP1WvUNsyVTZf0JAe0a0XGAFDjQiUak8O6rqY=;
        b=XwHLxDoNeLlAZS4cY6vkiPoajGhwJILXNAE9gvVG1Bn9TamIBPHEBEf9FDn/AmWSZe
         Gyn5q7kekE+4UScPGUaLfF/wT3Vn/onbXdx0VrU+3jzvCG7xF8jLW0GWbsk5WkHN471l
         1m/I8hb3gi5Cons8J+hRH6zcUY7vcVtmomtWCG48ayTDG5fEZk1ruz1AaUNU/Y9VsmYZ
         Sep/GYqQv63LJ10bvWfNln+lhMCwX6P9rxoD0pHu6B0jBRPvT6XfnqEMTCQ6s38C8T8q
         xKuqlOYKyp1mUalYFJPaHijc+BSFAJ2YyGeoXo6DIT4VpDWfGwqMvxl7wjsGZ6iLV5a7
         6QJA==
X-Forwarded-Encrypted: i=1; AHgh+Rps8ORT2wvfBPYczzL3vpzGO3E2Gc13e25DdzCPOvssuSbZibARKgSW3px6KKOnedf283Xeqi61ncw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhY4+5OM4U5U3IOHZ3Y1JcV1sAsjG7DNK1KGq0JUW+p1VrQkk6
	yzK7o0MY+yI4vqkhrB1ba9HaHjYh0RMC5Agu40ZnXwR1cGgTKoN9mOQ=
X-Gm-Gg: AfdE7cnlcn3NSKB5+j4hB1qqou79K0XgOUkj9p3CNJy7MjUmqpmoFRqsCM2NaiYcENL
	gw8xiJmoq2oEvFBQBkXWm/Six+KWGWcGeW9or+RDnnstPwEGiJ9da3UDqj9D0sAV1hOr2Mc+8ck
	5uCd2g420vCObeXKUJmfI/lObK+CMmrnhY7sbOTzuXOgEoe+0FAQjwDUqPZzCOhBgxA6IMmTe1k
	0xhjWiMCtY4t4cbq8wSwsAy2rGBzQI5Xr2sDBsFyfUA/DpOQrYrnMCkuF5uIOKw/WPJ2KiBPAkH
	j1KTDS9g4jsvOxqHOinFx/BDpY7Oioa0vvOqAcy3JfVXWA2zG4vjMou+OsczVr022uvYervPdd8
	lpWdXCGXbeMrk+0WMiPEMCPiI6244ajGII08vYDjBx5/hrqq2ppTUestz4AFnEQM8PaMUfZmcIw
	H5FhZML0qFeP86AOKxO8zTrLFupWlNco3Vvff8gg==
X-Received: by 2002:a05:6a21:7111:b0:3c3:a41f:ce83 with SMTP id adf61e73a8af0-3c3ada9e0bbmr18607951637.61.1784612745975;
        Mon, 20 Jul 2026 22:45:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb770sm46620876eec.16.2026.07.20.22.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 22:45:44 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <andre@negmaster.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v2 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Tue, 21 Jul 2026 01:45:02 -0400
Message-ID: <20260721054506.11871-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
References: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <andre@negmaster.com>

Thunderbolt NHI on T2 Macs (2018-2020). The NHI and its
associated PCIe root ports all sit directly on the root complex
with no upstream port. Apple's ACPI tables name Thunderbolt root
ports as TRP0, TRP1, etc. Find them and create device links back
to the NHI so that PCIe tunnels can be re-established after sleep.

Co-developed-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>

Signed-off-by: Andre Eikmeyer <andre@negmaster.com>
---
 drivers/thunderbolt/tb.c | 51 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..ca47bfbcefdf 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -6,6 +6,7 @@
  * Copyright (C) 2019, Intel Corporation
  */
 
+#include <linux/acpi.h>
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
@@ -3305,11 +3306,59 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs. the root ports are stored in ACPI as TRP0,
+	 * TRP1, etc. Find them and create device links
+	 * so that PCIe tunnels can be re-established after
+	 * sleep.
+	 */
+	if (has_apple_t2_chip) {
+		struct acpi_device *adev;
+		unsigned int slot, func;
+		const struct device_link *link;
+		const char *bid;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				pdev = pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!pdev)
+					continue;
+
+				if (!pci_is_pcie(pdev) || pci_pcie_type(pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					goto put_pdev;
+
+				adev = ACPI_COMPANION(&pdev->dev);
+				if (!adev)
+					goto put_pdev;
+
+				bid = acpi_device_bid(adev);
+				if (!bid || strncmp(bid, "TRP", 3) != 0)
+					goto put_pdev;
+
+				link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&pdev->dev));
+					ret = true;
+				} else
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&pdev->dev));
+
+put_pdev:
+	pci_dev_put(pdev);
+			}
+		}
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
-- 
2.43.0

