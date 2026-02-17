Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42EFC2D7DF5
	for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771315300; cv=none; b=bpzPeuAjGu72ptjQAg6unOBqLO7QvO6/SsGZDB9c3TGF7oQ3yYwQoK+nTPIpWHdd2323xONAfhRgLjsODtsB9w1Zam8d2hirMSah9TuC5vbVsG1tSYGRspe1rrxqSDRn8+716sWxA8mr++Wz9tzxF9QmRbYRsGQ9BqFY6qP7Q8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771315300; c=relaxed/simple;
	bh=OfTkdLKhii631W7xDnbBCj+J4IweuTOYodhlfj8wGas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=huwkESA+nkIJxfWoBxOBicSO9UMwT8chzLLdjKrKUG3vLWumEcM+LWtoUF/cqimk4rrhU/JJ4pXUFUT0JWnsYPmErE2agYdyrjHxtqaQTrvxkhBjeTVzy9RrlgFeBSY2su17lyKfgCgu4nDsUOe5u3DhOzVP8ku0K48+9UXlnG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQtYpjli; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQtYpjli"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso10529425e9.3
        for <linux-pci@vger.kernel.org>; Tue, 17 Feb 2026 00:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771315298; x=1771920098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ML/eqcDm9JPU41NbeTbVpohdII8TeXgVAo1wc0Rl7k=;
        b=YQtYpjliZ2FgTYusoVcvHd11h/yTjsh5zBNLZ6+bZyIhMq0qtJKBNSKj9In/PfJyOY
         6Yjs2pa/zbnEUH2iKcNkfi575p3ehwSLDcvDSQ2eaXtJ4RfWhCAHREPwmpJ+CEZQltdd
         IZJx4ink41QBwP1V0Bc7NCsSAfn/TocJyCvXN2nWv4ctkM7pdU0e3djApb7dBZ8/QKrJ
         mUfkiuki6esu4T82vmMYLrUFvmJoCngYgv29VhkczqdCHwuNm6odZL8ooTY3Ds8K+0FM
         q4sseoeHP9RweIn7ABmbSYfAczFjFp9GXQtQkaVnzcd/2sEeYV6i0RJfIkSsNfwEE0BR
         fIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771315298; x=1771920098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7ML/eqcDm9JPU41NbeTbVpohdII8TeXgVAo1wc0Rl7k=;
        b=B1J0i9QV620Yc5RbblCL1gwaCk82kd1Uuhh/p8mKVwgkxzOGUX4h6sovfjr+443UvQ
         B9FTXMK21VepU6dpVz7abihQYzWYmAFR3Wd04HKz5Va1ro1aV1t21EyTp0xL3qS9tfW3
         L2RKemEKEQlTs9HHF6x8yxxUXl73fdirSj5wxZRDYbj5qOZZ7PHoEABu9eXtHE6etpJk
         wM4PlKBqVLZ+UkK3byyu4S0DwSTrDx7K9r6YxC+flWQW3tq4pqegYo4pYCWKiu6JV9oh
         EhQ54fw8aQF5wRqwkJ/XZXmlLaSvzsdScJKNCIQCYCtL0nVOBrckeRdz5OaTtZ8PnAGF
         5igQ==
X-Forwarded-Encrypted: i=1; AJvYcCXaZDSfXEpMGESMN6Id0xY3TR/75CYINDu+FxMIdNS8vWN3NvKXZt+af79J+GI3Og5DxMlpr/cBiPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy66f10zoejWBPju4QXAuA9+xqYx81K431vGIHG85BhCeHwK+xo
	Mzj4P76VOdaXwZ2BYlZR5PjBONbujx9Ra/LHAUIRzGcR2m7i0DVEhErn
X-Gm-Gg: AZuq6aJPb3cWkThiMyhrz/aPvgiw5BP13TBPr2+1iuevc7JmgMd1KrbVGrebuNiXAfk
	48DsJ0jJZXF+YSMOqvHE52WYLtoaeaYBYVEkg6cgomkb8D+ZvpzB/vXqiIvw0AD7YjcS42biAIE
	q75Z9EzJoFH7YBYaHQ0YeQieKzAC2b7SgPwAjgBcZeF7p4l+vBbqMl6yyY2cH8qZzLSdxDrtL8A
	792TM1AdaGIgkby2YZGUoQkSXaMHr7vilAKTZIwe5Ifx53hwGqC3LQcK5C7WsiLYGEURoocOci6
	OK9FWGG2UB+lwmJD2OW7sN8a66VdLL/B2lHBNDDEXyXcQ6a+MgPafpJhBororo92QcXNbzkFsIu
	MrO3Ihof8nXq851cY0FuGu05/Jmd6/mkt0+btP/pVvWX3ZO1MftIAYTPc+z/MO3b1Ap5cY/OrNc
	c5StFu2ZFzmmky6vp3OoDEfWH0bI/3xSGUYOmHGMCW8A391TXWNj+fcpxDBTU=
X-Received: by 2002:a05:600c:8b4c:b0:480:5678:1fdd with SMTP id 5b1f17b1804b1-4837105240amr220470315e9.12.1771315297189;
        Tue, 17 Feb 2026 00:01:37 -0800 (PST)
Received: from ionutnechita-arz2022.localdomain ([2a02:2f07:6006:8800:54ea:a0a1:e16b:9ca4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48371a21cbesm153558775e9.5.2026.02.17.00.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 00:01:36 -0800 (PST)
From: "Ionut Nechita (Sunlight Linux)" <sunlightlinux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ionut Nechita <sunlightlinux@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [RFC PATCH 2/3] PCI: Add PCIe Gen 7 (128 GT/s) speed detection and reporting
Date: Tue, 17 Feb 2026 10:01:00 +0200
Message-ID: <20260217080102.206581-6-sunlightlinux@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260217080102.206581-2-sunlightlinux@gmail.com>
References: <20260217080102.206581-2-sunlightlinux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ionut Nechita <ionut_n2001@yahoo.com>

Add kernel infrastructure to detect and report PCIe Gen 7 128 GT/s
link speeds:

  - Extend PCIE_LNKCAP_SLS2SPEED, PCIE_LNKCAP2_SLS2SPEED, and
    PCIE_LNKCTL2_TLS2SPEED macros with 128 GT/s mapping
  - Add 128 GT/s to PCIE_SPEED2MBS_ENC bandwidth calculation using
    1:1 Flit mode encoding (no overhead), consistent with Gen 6
  - Add PCIE_SPEED_128_0GT to pcie_dev_speed_mbps() switch
  - Map link speed encoding 7 to PCIE_SPEED_128_0GT in
    pcie_link_speed[] table
  - Add "128.0 GT/s PCIe" display string
  - Add pcie_speed_requires_flit() helper for Gen 6+ speed
    validation with proper range check against PCI_SPEED_UNKNOWN
  - Widen pcie_get_supported_speeds() return type from u8 to u16
  - Add Flit mode diagnostic warning when Gen 6+ speed is active
    but PCI_EXP_LNKSTA2_FLIT is not set

Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
---
 drivers/pci/pci.c   |  7 +++++--
 drivers/pci/pci.h   | 28 ++++++++++++++++++++++------
 drivers/pci/probe.c |  3 ++-
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 13dbb405dc31f..8091f7bf30e6f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5912,10 +5912,10 @@ EXPORT_SYMBOL(pcie_bandwidth_available);
  *
  * Return: Supported Link Speeds Vector (+ reserved 0 at LSB).
  */
-u8 pcie_get_supported_speeds(struct pci_dev *dev)
+u16 pcie_get_supported_speeds(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
-	u8 speeds;
+	u16 speeds;
 
 	/*
 	 * Speeds retain the reserved 0 at LSB before PCIe Supported Link
@@ -6020,6 +6020,9 @@ void __pcie_print_link_status(struct pci_dev *dev, bool verbose)
 
 	if (dev->bus && dev->bus->flit_mode)
 		flit_mode = ", in Flit mode";
+	else if (dev->bus && pcie_speed_requires_flit(dev->bus->cur_bus_speed))
+		pci_warn(dev, "Flit mode not active at %s, expected for Gen 6+\n",
+			 pci_speed_string(dev->bus->cur_bus_speed));
 
 	if (bw_avail >= bw_cap && verbose)
 		pci_info(dev, "%u.%03u Gb/s available PCIe bandwidth (%s x%d link)%s\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 60542b05de0c6..4dd23f0d5de9f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -487,7 +487,8 @@ void pci_bus_put(struct pci_bus *bus);
 ({									\
 	u32 lnkcap_sls = (lnkcap) & PCI_EXP_LNKCAP_SLS;			\
 									\
-	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
+	(lnkcap_sls == PCI_EXP_LNKCAP_SLS_128_0GB ? PCIE_SPEED_128_0GT :	\
+	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_64_0GB ? PCIE_SPEED_64_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_32_0GB ? PCIE_SPEED_32_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_16_0GB ? PCIE_SPEED_16_0GT :	\
 	 lnkcap_sls == PCI_EXP_LNKCAP_SLS_8_0GB ? PCIE_SPEED_8_0GT :	\
@@ -498,7 +499,8 @@ void pci_bus_put(struct pci_bus *bus);
 
 /* PCIe link information from Link Capabilities 2 */
 #define PCIE_LNKCAP2_SLS2SPEED(lnkcap2) \
-	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
+	((lnkcap2) & PCI_EXP_LNKCAP2_SLS_128_0GB ? PCIE_SPEED_128_0GT : \
+	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_64_0GB ? PCIE_SPEED_64_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_32_0GB ? PCIE_SPEED_32_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_16_0GB ? PCIE_SPEED_16_0GT : \
 	 (lnkcap2) & PCI_EXP_LNKCAP2_SLS_8_0GB ? PCIE_SPEED_8_0GT : \
@@ -510,7 +512,8 @@ void pci_bus_put(struct pci_bus *bus);
 ({									\
 	u16 lnkctl2_tls = (lnkctl2) & PCI_EXP_LNKCTL2_TLS;		\
 									\
-	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
+	(lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_128_0GT ? PCIE_SPEED_128_0GT :	\
+	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_64_0GT ? PCIE_SPEED_64_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_32_0GT ? PCIE_SPEED_32_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_16_0GT ? PCIE_SPEED_16_0GT :	\
 	 lnkctl2_tls == PCI_EXP_LNKCTL2_TLS_8_0GT ? PCIE_SPEED_8_0GT :	\
@@ -519,9 +522,14 @@ void pci_bus_put(struct pci_bus *bus);
 	 PCI_SPEED_UNKNOWN);						\
 })
 
-/* PCIe speed to Mb/s reduced by encoding overhead */
+/* PCIe speed to Mb/s reduced by encoding overhead:
+ *   Gen 1-2 (2.5, 5 GT/s):       8b/10b encoding
+ *   Gen 3-5 (8, 16, 32 GT/s):    128b/130b encoding
+ *   Gen 6+  (64, 128 GT/s):      Flit mode, 1:1 (no encoding overhead)
+ */
 #define PCIE_SPEED2MBS_ENC(speed) \
-	((speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
+	((speed) == PCIE_SPEED_128_0GT ? 128000*1/1 : \
+	 (speed) == PCIE_SPEED_64_0GT ? 64000*1/1 : \
 	 (speed) == PCIE_SPEED_32_0GT ? 32000*128/130 : \
 	 (speed) == PCIE_SPEED_16_0GT ? 16000*128/130 : \
 	 (speed) == PCIE_SPEED_8_0GT  ?  8000*128/130 : \
@@ -544,6 +552,8 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 		return 32000;
 	case PCIE_SPEED_64_0GT:
 		return 64000;
+	case PCIE_SPEED_128_0GT:
+		return 128000;
 	default:
 		break;
 	}
@@ -551,7 +561,13 @@ static inline int pcie_dev_speed_mbps(enum pci_bus_speed speed)
 	return -EINVAL;
 }
 
-u8 pcie_get_supported_speeds(struct pci_dev *dev);
+/* PCIe Gen 6+ (>= 64 GT/s) requires Flit mode with 1:1 encoding */
+static inline bool pcie_speed_requires_flit(enum pci_bus_speed speed)
+{
+	return speed >= PCIE_SPEED_64_0GT && speed <= PCIE_SPEED_128_0GT;
+}
+
+u16 pcie_get_supported_speeds(struct pci_dev *dev);
 const char *pci_speed_string(enum pci_bus_speed speed);
 void __pcie_print_link_status(struct pci_dev *dev, bool verbose);
 void pcie_report_downtraining(struct pci_dev *dev);
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9d4eeda5ea946..031c3ec8615d2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -774,7 +774,7 @@ const unsigned char pcie_link_speed[] = {
 	PCIE_SPEED_16_0GT,		/* 4 */
 	PCIE_SPEED_32_0GT,		/* 5 */
 	PCIE_SPEED_64_0GT,		/* 6 */
-	PCI_SPEED_UNKNOWN,		/* 7 */
+	PCIE_SPEED_128_0GT,		/* 7 */
 	PCI_SPEED_UNKNOWN,		/* 8 */
 	PCI_SPEED_UNKNOWN,		/* 9 */
 	PCI_SPEED_UNKNOWN,		/* A */
@@ -816,6 +816,7 @@ const char *pci_speed_string(enum pci_bus_speed speed)
 	    "16.0 GT/s PCIe",		/* 0x17 */
 	    "32.0 GT/s PCIe",		/* 0x18 */
 	    "64.0 GT/s PCIe",		/* 0x19 */
+	    "128.0 GT/s PCIe",		/* 0x1a */
 	};
 
 	if (speed < ARRAY_SIZE(speed_strings))
-- 
2.53.0

