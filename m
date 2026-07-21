Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB04430305
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 06:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615693; cv=none; b=XhzvrpskjT7jkOMZ3qa7BH7uXl/OZi85C174MX/auVMa8o7zMIG2ohqWAi624KrllNwhxPZIhGh7WaSeiyrsl87C8vQULLZQl8xMmS4OkQcj84nmSWz1Fz9pGQdlFZ+uTtvlKtoAEmy1/bahv8tV+xwGk9ZCLephzrhzzA87iBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615693; c=relaxed/simple;
	bh=s8XvH2OvdBsp7yjHd0Wbx0kldfTM1MtLmx4xWW/Tb+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZAqo4U02bncdTdMPj6I/qrQSJatupvxnJKKbQZ1Exn5V1KpWNt90/O+rB+FQG5qUs6K3yOgMP0y5dle62zQZ7xPxF4xJG4L8+eM5YzPrVb67l5GVtoRKeEgLiJQA2aJsADscsjK3zNvKfJlIv8QxkzLWO0D5+P7DBtA44Anq4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2mXv6bR; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2mXv6bR"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c9e30214d8fso7768486a12.3
        for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 23:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784615691; x=1785220491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mOwtl82qHyXYWFtXlT6nPpOxkBi8L7STB5ydQzlpO6c=;
        b=L2mXv6bRLFkCqA1afDLqG6juI2t4+/xXmGUHZELFANYgtJa1GiEAWdO+vH5yRlZ5GT
         tSpSmY2tvadIv+3/REpgXc3m5GaML5pyfQ2Tr1QOn/q+ufH4W73+aKlds5x3dXqcrah8
         /M9jQ806DU9ZOP8IGoBFnDf0bZQdvNp79T1/QaNfWnSpm6+g/2r8gHbg16GH8dLo1ML2
         Qj+0y3yas7qEsD2XkBkQkpFEs+5B5E+4oWh9CtSInaVn7AIQqxVzFoxmIJbaai2Dcf0E
         HJkokg4Z7XrvjrZScQ7wQwv/oha23JJ5y3v3uqV/zGNFcnuGnq5to5Ero3OhK0Tqm3tr
         OMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615691; x=1785220491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mOwtl82qHyXYWFtXlT6nPpOxkBi8L7STB5ydQzlpO6c=;
        b=dtbAi+9x5ieSoDtQ75WAJ67BnKapUJTfVVqjsqGknpdvloRVJDOI459/H5wmR7R+qs
         vfX/EMVpppEFIHTG6l7gZ86VtiTQ+4JjuKWvK63DYKoiZLnAl9f0J3ZKr3dqsUWfhTQ2
         I4SBDNcMocx6Xk5xUuR/go3ljQGN8VFnrEwtaeZEp9NWN0LzeAWM38GLXtN5XM4cAnLs
         lmIImvXg4YQ3eqmpwAWygndFyDmB5q30BpFpepOaT/Nl1VwN09vztxYPf6RcPFjiAv83
         7wVepUhUUTtW+RUs8prVA7yfRGdUbENI33IT/wK0VHq48siyqlKccaGiURx5rJ+rT9Pd
         7KBw==
X-Forwarded-Encrypted: i=1; AHgh+RrLfOaClp9GBI+1dOJqbWBVwTM01Sfa48a7nzp1rRsy38cMktqp7uOPQd9mXQiPLVsoRkvDWKX5e8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrfJLfBZWd1RYYUaB51/jlptXdngof5wyfetsErWcl+kH6OIx9
	i9OtNyb8iOS31YC2WORuMv/CRSTSV9xhZMTYgB8a+o6yLoC1afCqUxQ=
X-Gm-Gg: AfdE7cmz5Wj5OAqii2fUgZvDlN18pTDAve9sTpfAtXvFSoHh9j9JCD6SJbuOE1cNdxQ
	jhBboH0clk/yNV6l9H6GXOVr15gVDCW2EGK3eNQle+GjSscrwN8IkVIJaIkhgrL92pa6azMOSgI
	iTCvUwznUEdc+c3EJrJ0Rdk/yvzICtlzk7OzWY4xNuwkwZCyb7Cov7yCnOg6NDZcbsA5Bk8IiS3
	4DvHcsbHaN9/zwgNnHN2NuCk684far8cxUUWdHTkfydnMqtqFGkSakU2xSda4KZjDBVLNv+iKkH
	dYIElR0xpZD/sAZV0o9AwUl2v/0rP5MUN7vqpAlJJ3J3cpnMnye9yJsWxvhoM+GwLQuzyP+0run
	5QJxaqB2SP7EHwjJSMzwHVdLpvQW2eqc61x9lqp3THPVWij6fkzBeKukbaiOdEw42LQWbnDZhPe
	AM6svTPgLr/p59M5RbyNQ6ydH/Kit10BYjx+Vxmg==
X-Received: by 2002:a05:6a20:9c8c:b0:3bf:6c08:fb8e with SMTP id adf61e73a8af0-3c3ad9d5b8fmr19136988637.48.1784615690794;
        Mon, 20 Jul 2026 23:34:50 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm73608386eec.21.2026.07.20.23.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:34:50 -0700 (PDT)
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
Subject: [PATCH v3 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Tue, 21 Jul 2026 02:34:07 -0400
Message-ID: <20260721063412.11588-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
References: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
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
index c69c323e6952..0cdffcf577cd 100644
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
+	if (has_apple_t2_chip && IS_ENABLED(CONFIG_ACPI)) {
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
+				if (strncmp(bid, "TRP", 3) != 0)
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

