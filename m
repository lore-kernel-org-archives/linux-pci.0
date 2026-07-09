Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD32944999A
	for <linux-pci@vger.kernel.org>; Thu,  9 Jul 2026 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783623296; cv=none; b=ZjUjfPjq0mwcgOleULtrIlYrdBtL1Ke0Fy/icFIpgYFd0rMml1/7gqrGuBNDpshxJHtH0gc0qlI+v5i+2XpfSpKV9FJ0TxCLMQXftMNg2ADxb09Lsp/gsgD9ARPM3OO0IUBGLaJcw9JqA9mYxHJOM8rTSSRxEsPOZERmOsSxVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783623296; c=relaxed/simple;
	bh=82jIYnEBVnizznYZVjbcNxVtecRVdrYP/jvI4I8Tfmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NIaFFN5hpIGxqVRXF5zax2X+vI4VCQK3fsPpjWUp7XuiPWwC9oAhUnZ02KsFl1eFBqCoQO+AJflBccb0sH4f9TPa8ple5zQdztkp/BWbkiFoBxgBlhqPg/zVPuwuzUdB8LL70Z1/U8puWp9Kn/jUYlDvxMLnT8sxNeuV1DerrF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=R7uzgWq0; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="R7uzgWq0"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ca70925c25so1307765ad.1
        for <linux-pci@vger.kernel.org>; Thu, 09 Jul 2026 11:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1783623294; x=1784228094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8Zy5PB6oCNiDdVLDyMMBSqbi/zOyH2nEGcV3a3Utlo=;
        b=R7uzgWq0sXvvN4P8M6DkCzqzEpOaZsBZqWFd2Flzx+LzZZGjIyPAV7wHX7inMvo3Sh
         AaA20j4aTOoZx9axJal8NsXhCngaUgIMUYYJZQo6+u4UdgcdXfR3BQdUfJKVUkmzY/dn
         UiNBjL5Ixy0e0AicyRqdcBIak4krPM1ZFNnCjPQ58N/4aeY2uSribDXIXprYqjcNlmea
         0TVmMBJY+dEuvECiLuSlnzH+ih40CWB0Rk17ktek/OHNSzplC6R9LS4LPFO3LQUjQm/u
         3rYApmsTc8xE9V9JVFZl+AR34hXHAMDZol+L+MdomQSFYEYpmSxQ8I7xCP+7SoJ6C0KH
         T1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783623294; x=1784228094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8Zy5PB6oCNiDdVLDyMMBSqbi/zOyH2nEGcV3a3Utlo=;
        b=fL0y3Us95L5xAuQqdmz/zBNTOLSDLIZpdjdY6+mxVB2s2JKAhggWV73UhyjyclPbyG
         xJplXKiWXeN+TFlUMJiT7A6jAR/dBVLUn1qs6qVLc6u93BT7reQVvIHhV++5Zr7besGK
         gbNbAZca5iVv0j9zTjL5ALzY8wEDMTEknoOvNQOemxT/kCKK3TpFbFX8485RP6E3x/wQ
         3Y7q2wRyWbQ1SkDjV8vsjI0nlC3FAKlpEDvBW0/usMyf2NmbxXr7J35ld0Z3r484eQfx
         Qk27pYKmNS3t0ywnrwlSr50CxUNBBwxc4TSXU5YfFHYiF+Yevc7BczP8SbpfBxVSOtpJ
         lDTA==
X-Forwarded-Encrypted: i=1; AHgh+RoBLHUJN88PDux22LgUIgneE72nsa6fLE0ByymvaqjuvNqx5vXvBIQpRv1dYeA8nTJH0mD08qm9E2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQu0S/pvBsqaPGUKXZgiY3h1TW4yCnOjTTSMzWYKPsutgUSmA
	1WU07+CrIDZHdhpq4KURFHP0OEXHKDEmWJWVcG3MT0Ec/0XNnqa81rKSi5+wd1UGOw==
X-Gm-Gg: AfdE7ckUlZWCcE2Vi7hWUT2GFA8RjIGxl4b4QLaE62ESZDbnV7ApLcYKmo9N0BaL89t
	uvBhVl7IHOLtQoONpfpRaaEvmFd7vIJDruXX7ZrnFccV7pQeTILYmVM2emfb4t0Bm6LoUjbh96+
	zfVLYlkMmNmSQ2l4EmeWE/kida4Ky+C79ApYm10dIpewBTGxY2dUiuUkdTO1ZWOV06ouY4YE7A5
	fRYyYsWVKf2MdVzh8EhpWtE1aiKpzP4x4+aDZDBB7O/h1dvydv3FUNjh6Ya/nqlKaJrNivbUKvp
	ty5KaGuMh3/G2VJAeJvbYMYrwAc6HXuu+hfDDk/SGyafU9YrVPp27FgQXRcQLUvcrwt2ZHbzNxk
	hehX5YO6zGbgu7ETWpuw5gVpG3L8uCi+ZFymL9h9TzVBHBRQEhBPfgnvtpcEydZaWB3pOLLbOLq
	yfNvIqLtPYaKZYBa54eDWZAl8/XqCWKNuSVgYaeKj5K89I
X-Received: by 2002:a05:6a21:38e:b0:3b3:241f:66c4 with SMTP id adf61e73a8af0-3c0bd0028bfmr10439038637.28.1783623294191;
        Thu, 09 Jul 2026 11:54:54 -0700 (PDT)
Received: from yurypm-home-4hjc6.sjc.aristanetworks.com ([74.123.28.16])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm31297642eec.4.2026.07.09.11.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:54:53 -0700 (PDT)
From: Yury Murashka <yurypm@arista.com>
To: bhelgaas@google.com
Cc: corbet@lwn.net,
	skhan@linuxfoundation.org,
	mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Yury Murashka <yurypm@arista.com>
Subject: [PATCH v2 1/2] PCI: Add pci=noaer_recovery kernel boot option
Date: Thu,  9 Jul 2026 18:54:28 +0000
Message-ID: <20260709185429.627968-2-yurypm@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260709185429.627968-1-yurypm@arista.com>
References: <20260709185429.627968-1-yurypm@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AER error recovery is part of the AER error handling subsystem in the
Linux kernel. On large modular systems with a complex PCIe tree, AER
recovery could cause unexpected behavior and side effects. Sometimes it
would be nice to have the option to keep the system in an unmodified
state and be able to handle PCIe errors from userspace.

Add pci=noaer_recovery kernel boot option to disable AER error recovery
when an uncorrectable error is reported. When this option is set, the
error is still logged but no recovery actions are taken. AER error
status bits are preserved so userspace can inspect the error state.

Signed-off-by: Yury Murashka <yurypm@arista.com>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++++
 drivers/pci/pci.c                             |  2 ++
 drivers/pci/pci.h                             |  2 ++
 drivers/pci/pcie/aer.c                        | 30 ++++++++++++-------
 4 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..13c6b53bb9ee 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5053,6 +5053,12 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		noaer_recovery	[PCIE] If the PCIEAER kernel config parameter is
+				enabled, this kernel boot option can be used to
+				disable AER error recovery when an uncorrectable
+				error is reported. AER error status bits are
+				preserved so userspace can inspect the error
+				state.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..a215dd567d5d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6756,6 +6756,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "noaer_recovery")) {
+				pci_no_aer_recovery();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 4469e1a77f3c..c4a42bbc277b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -1283,6 +1283,7 @@ static inline void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge
 
 #ifdef CONFIG_PCIEAER
 void pci_no_aer(void);
+void pci_no_aer_recovery(void);
 void pci_aer_init(struct pci_dev *dev);
 void pci_aer_exit(struct pci_dev *dev);
 extern const struct attribute_group aer_stats_attr_group;
@@ -1294,6 +1295,7 @@ void pci_save_aer_state(struct pci_dev *dev);
 void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
+static inline void pci_no_aer_recovery(void) { }
 static inline void pci_aer_init(struct pci_dev *d) { }
 static inline void pci_aer_exit(struct pci_dev *d) { }
 static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index c4fd9c0b2a54..fb79990ce8ff 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -128,6 +128,7 @@ struct aer_info {
 					PCI_ERR_ROOT_MULTI_UNCOR_RCV)
 
 static bool pcie_aer_disable;
+static bool pcie_aer_recovery_disable;
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
@@ -135,6 +136,11 @@ void pci_no_aer(void)
 	pcie_aer_disable = true;
 }
 
+void pci_no_aer_recovery(void)
+{
+	pcie_aer_recovery_disable = true;
+}
+
 bool pci_aer_available(void)
 {
 	return !pcie_aer_disable && pci_msi_enabled();
@@ -1187,10 +1193,12 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
 				pdrv->err_handler->cor_error_detected(dev);
 			pcie_clear_device_status(dev);
 		}
-	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
-	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+	} else if (!pcie_aer_recovery_disable) {
+		if (info->severity == AER_NONFATAL)
+			pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
+		else if (info->severity == AER_FATAL)
+			pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+	}
 }
 
 static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
@@ -1242,12 +1250,14 @@ static void aer_recover_work_func(struct work_struct *work)
 		ghes_estatus_pool_region_free((unsigned long)entry.regs,
 					    sizeof(struct aer_capability_regs));
 
-		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
-		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+		if (!pcie_aer_recovery_disable) {
+			if (entry.severity == AER_NONFATAL)
+				pcie_do_recovery(pdev, pci_channel_io_normal,
+						 aer_root_reset);
+			else if (entry.severity == AER_FATAL)
+				pcie_do_recovery(pdev, pci_channel_io_frozen,
+						 aer_root_reset);
+		}
 		pci_dev_put(pdev);
 	}
 }
-- 
2.51.0

