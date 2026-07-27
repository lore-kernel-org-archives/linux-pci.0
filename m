Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600141C302
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 21:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187128; cv=none; b=sumKQk07oryEScvsT2mQ/lRd4Ipa18/WPiewOsnoLVYCPNh+c6XVbBi/mJerkRhz838BVDlpCMkWJQnitn0rjKFhPOKT5rZXxX9cCz8PTQ6O++Ivv1Zlwxk2UI8r/PzgMMDbpw51IfprDmGASHvcttwEAkip92VMBGUFaFYr1l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187128; c=relaxed/simple;
	bh=u2+nVHt7la9YltrGQzMce5hV2xgh2wYAZUlmBJxwuuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9OtUWAOY/urby6h+DZuuRw08zdCsJYqOjESQBlJgSsbVJTIWoAv8fUVpSQKKJVE/0xvJigtsgBM9oXzA6DT0vwdwVdKeXKjTxcXgtjEHccVT8c9WuIGQ52GmyArbaKY58PjRrZcIk3R3HlaWNXsyjiUxwNNFn5LLfAJXK6P7EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cKTWo/gF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cKTWo/gF"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e584c7a5bso1531502b3a.2
        for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 14:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785187125; x=1785791925; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VTr/js81B4miTEjNI6MC5wSeZgIjJ1qNbYXRJnSwtn0=;
        b=cKTWo/gFYe/HMutElxueFdzZvVXRMwKh4FPy4yJN4/t72rOrmUiqAuQ1WJtKtkLD/Y
         cKJkKpHJc+E8GSBp5HGyr+3hAlvLM2CR707C05zk2tInYD1/66byo2Oo4CxUnzQ5I195
         FHP4w5ctTcTqQBKSfhRjhkG0XeoU0TGn3qyIfw0S2tZt2o+F+UkXBpfDpoF1Jr25Qjx6
         nZAQpMgL8t3HbFylrGRqY45VGix9jEF2bB1pApGWPb1gsli/zA9p8gQpB5+0SMVYvTK+
         oSHEui5f1MmzuW5riNQJIPD2O+29rQtvNaLqGzC49RerHz0+Yf+k4jHxznInNW3lxcoI
         q8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785187125; x=1785791925;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VTr/js81B4miTEjNI6MC5wSeZgIjJ1qNbYXRJnSwtn0=;
        b=jkrrEORiSTHEUngt1+teazGQtJb7asxCTUVbKj8cyd1jfPTmcFwiMzUdT+fLHtKDsp
         2CvUoeb+AheinRVPC7U1Dn2rx5cizpywAV3k+309JFIIF3NltwXq6U2tdHiql6nu8uPK
         IC4gEudtaxlbDQggUueNYliFxkqOM/PyzN476uIIP4kF0hLFtziUrDKoJ7Fo2LAtSw2X
         a9nKskQfM7uquclFb8vSphjhUalf17Qjg2519Votm9XgdAUro7ypLcjge+LhrgBhsw0+
         0X6sKlXbCTPwzFX2Z+4rCPP6r3fj2GU9fc5shY3J8tBquskLqlKdYOGgSs2eEkXGQiN0
         m9YA==
X-Forwarded-Encrypted: i=1; AHgh+RpuV/edkt+l/hubFhFaZQ5AMP0S0GXAHE4TW+KRRd9e1dAWaDAgZt5gcLsUjMvKXdc+faU2NyunJ4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDZH7nJHArgYf9GbmjAbGuHEIfv9pGLQUJ2pLduYF4e8UTS6CM
	nK7pNpf4C1FvuN+tbVWzfGaM+pfIkSqVWI3PfhcRWJ9/7VxlSw6ckJoi70ORxbs=
X-Gm-Gg: AR+sD11M5/Tu7RnSD8+pJTbK7VxxukiCd2w14rngUDdvaeqEXmVb1+7dGwWvUb/y5Pb
	1LxCEPMn7dwrmIeWaj1tbB9j093OfKU/d9sxgvMMCzy+I36+5vNbSw6XQfWvusM+8XmfV9GAxOU
	As5grldCmgPo6jhi+B+jyH54bs7Cvz98E+Lc2T7fRLR0YSjdEGk+2Qb7R0efrl3COv6quwiG63L
	UyLBDgTKyXFE1EeOpT4a1JEzmdfTGzUGyUnmPJ0gkbiYJMx5iEwAxN+6MG6MBCm8t9RwdaLXo0T
	x4dnrXv2CeRgE1wEZ4ILitBWvLDchISOfnD/fNP4XOFMwW4PUrD7EGINXX97S45KJ2DkU/9sFZj
	5yuATZa3SlN4QlvctYjGsPD3QknXkroaifQdYP4+w3R4/nKqAbrAUs8cFqUa8AFbYzRTaRl0JmW
	LWBevXaaqay6ENBTL+UfSyPNTIg0bRRCXjsLDeouHKPWHIUeQ=
X-Received: by 2002:a05:6a21:7116:b0:3c3:a9e1:a819 with SMTP id adf61e73a8af0-3c6c7b9562amr1345956637.24.1785187125217;
        Mon, 27 Jul 2026 14:18:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.59.84.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314e17a6f5fsm7916699eec.31.2026.07.27.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 14:18:44 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Andre Eikmeyer <dev@deq.rocks>,
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
Subject: [PATCH v5 2/2] thunderbolt: Add device links for Apple T2 NHI
Date: Mon, 27 Jul 2026 17:18:03 -0400
Message-ID: <20260727211807.1223-3-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
References: <20260727211807.1223-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Ice Lake Thunderbolt NHI on T2 Macs (2018–2020). The NHI and its
associated PCIe Root Ports all sit directly on the Root Complex
with no upstream port. Identify the tunneled PCIe Root Ports by
their PCI IDs and create device links back to the NHI so that
PCIe tunnels can be re-established after sleep.

And on other T2 Thunderbolt NHI's, like Titan Ridge, the default method
is used to add device links.

Co-developed-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>

Signed-off-by: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
---
 drivers/thunderbolt/tb.c | 54 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c69c323e6952..9b80e9339728 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/errno.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_data/x86/apple.h>
 
@@ -3305,21 +3306,70 @@ static const struct tb_cm_ops tb_cm_ops = {
 static bool tb_apple_add_links(struct tb_nhi *nhi)
 {
 	struct pci_dev *upstream, *pdev;
-	bool ret;
+	bool ret = false;
 
 	if (!x86_apple_machine)
 		return false;
 
+	/* On T2 Macs with Ice Lake Thunderbolt NHIs,
+	 * identify the tunneled PCIe Root Ports by their PCI IDs
+	 * and create device links so that
+	 * PCIe tunnels can be re-established after sleep.
+	 */
+	if (has_apple_t2_chip && (nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI0 ||
+				nhi->pdev->device == PCI_DEVICE_ID_INTEL_ICL_NHI1)) {
+		unsigned int slot, func;
+		const struct device_link *link;
+
+		for (slot = 0; slot < 32; slot++) {
+			for (func = 0; func < 8; func++) {
+				struct pci_dev *current_pdev __free(pci_dev_put) =
+					pci_get_slot(nhi->pdev->bus, PCI_DEVFN(slot, func));
+				if (!current_pdev)
+					continue;
+
+				if (!pci_is_pcie(current_pdev) || pci_pcie_type(current_pdev) !=
+						PCI_EXP_TYPE_ROOT_PORT)
+					continue;
+
+				switch (current_pdev->device) {
+				case 0x8a1d:
+				case 0x8a1f:
+				case 0x8a21:
+				case 0x8a23:
+					break;
+				default:
+					continue;
+				}
+
+				link = device_link_add(&current_pdev->dev, &nhi->pdev->dev,
+						DL_FLAG_AUTOREMOVE_SUPPLIER |
+						DL_FLAG_PM_RUNTIME);
+				if (link) {
+					dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+						dev_name(&current_pdev->dev));
+					ret = true;
+				} else {
+					dev_warn(&nhi->pdev->dev,
+						"device link creation from %s failed\n",
+						dev_name(&current_pdev->dev));
+				}
+			}
+		}
+		return ret;
+	}
+
 	switch (nhi->pdev->device) {
 	case PCI_DEVICE_ID_INTEL_LIGHT_RIDGE:
 	case PCI_DEVICE_ID_INTEL_CACTUS_RIDGE_4C:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_2C_NHI:
 	case PCI_DEVICE_ID_INTEL_FALCON_RIDGE_4C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_2C_NHI:
+	case PCI_DEVICE_ID_INTEL_TITAN_RIDGE_4C_NHI:
 		break;
 	default:
 		return false;
 	}
-
 	upstream = pci_upstream_bridge(nhi->pdev);
 	while (upstream) {
 		if (!pci_is_pcie(upstream))
-- 
2.43.0

