Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4789231619C
	for <linux-pci@vger.kernel.org>; Thu, 24 Sep 2026 01:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790211864; cv=none; b=WyzrXye/mpljg/eyZwYynDTqBtl8BrPBEOi1fHx6T7Fa6e0mub1p4YT8BoRVx4DsxKSLT6udj8m73dz1zXManKbo62zmUFZiuLkSjKIe0vt+CNhkOFGfbvuCYPgLJZC730bZ4P6EbZmsaWVqPjoE05I6dUuEYELXJDGSV0UG6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790211864; c=relaxed/simple;
	bh=JfjOTmn23C52eZ50zQilW55eYmOVRRAElDsqXwSu/Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fZMwxHSigXu/2avHl1lLWJReFEcgDLZydMB7oC4yUjbMeJrPd0LPcDGPniQz+242lutlbHKfaMxGTm8+YYMzwT/qrc405qFLzHAKT7u1xeZ1qdGdHz17+itR5o0Ef/sr0bYx+2QLo12/AqC4Xgq9zqD7MQFIsNYosv0vaLCq8Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHDH3SwU; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHDH3SwU"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910a0cb7cso113651285a.0
        for <linux-pci@vger.kernel.org>; Wed, 23 Sep 2026 18:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790211862; x=1790816662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=czd/s34OcW98EL8w2Vq/LmrqDyHhrcgOAIgDbU3R4Z0=;
        b=XHDH3SwUGa4Ioe8PNEqE3KfbMp1yTiJ24g5X5MyESGkoVmniIccVKN4BWoyKuRuHMX
         Dat6SqiY3NudxFDfIvzL5efKRcPpjm+HsuKzaCWIPcL4ZagJcf81HpViFtTk84wTLBhw
         +sqPl58fX4bNABjHHmM0+B1j/qNcff4pffJp6Q5t6QMtrkmXi/Wr7KhqmwbDpB8GsbyX
         enRXNTjdfeD2JVyOrWKUIZfzGc4wainScB4/GzAdwZs0y7v1W7Xa132yOIwl+nOQmv2w
         nSEOMjJ3KEM7hSK3/LTgvNM8UbOTiQcBOCIGDeuH8oPgGE44wFyZFhVIK2hLuCbMv8PC
         G1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790211862; x=1790816662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=czd/s34OcW98EL8w2Vq/LmrqDyHhrcgOAIgDbU3R4Z0=;
        b=D3T47+9Wie+SNt4Mc+b5yCFNpWHPW79XtZLk/e3Fi9pBIEMF5zN4WDgJAdHXgDJLto
         FOfUMBGWNrcXpmkNEXleza0N2GOe862hFHY5RZnoN1Oj2UOPSC3giLymPfrJmohCoptC
         vYDFShH9PS3wRyby4Mvrg4pAzX6wbzG6qJiBDdfBbjbKJDCNkDvFQ1Vk+nLbS1q5am2Y
         skOnqfSAFWhrqNzui8vssmQTINxnTlyTdY6k6ZjMV9FAKQ8AaGpEnGdiP7holrciqv69
         zksQfo3A7bCak4U8XS0tBVGIP4JKauwI6FYJsD4F7pQ6ZFh8elPceIu7Z2Y6eSRBd8M9
         ir0w==
X-Forwarded-Encrypted: i=1; AKwUvBzsbgp9mF0rr1zN/FSnkZxDqrjc1qkqfk5qEP9A9jxy/J4KxyJkMNL5PazwFAIZDffFN3Yox+qqC/w=@vger.kernel.org
X-Gm-Message-State: AFuF++najWrL4If/H36Y731p4Ns7GzQ/j4ImLB2qdJkHweoMSLtEnvZB
	ASD1zIYD1C2MqZbqWHWKaGaRElFk7030pESTRXTHsMkTe+yDtRxZSD0V
X-Gm-Gg: AYBFou2SnVR0xw0mpdbR6N4xe5+EixqMEyPShlf9tsxY+Y553//hV5hH0XStEQJeNXY
	DyXjib2Vox8P2tYWQFFwxZ0oWISnzi5A04uxOFdtINcQ0IWvSvnGa2NFNeBN4TbIO1MyycUWSAU
	D0/fTeQvmbX79LAGHhIV3WMD5MQ8i5c0JS+h1jNRo+6D7FLfL3Wb41+d8vAQimSHhNKj99wQi6/
	jssLB2CjTGFmOkbiq0bNeXgcb4oksdP/JF7/xk+D3+2ThUYofRJ5kEPPb00RHIMJNjsLBNaxdqN
	wtUu4WgW4oGc+MWfnD2FOPFEMoYxT4fr0KmzraW+dMV0u59wcDpX0nL5iCoo9fuokEEUifeXTBr
	o87LKa1b5+etrPXTycZW8cbbV4EL8vl52+DAwK+VpmRYBYWzqCShC603wz20eDu+F/euMHGAVwM
	kBpXRFS13eeF43byfTdvVowElbfZWy9XR/ouW5lpGVjSKbC5j5cjI6Th2cNm6meJfzl5N/EF1ze
	EmzV3NQxDJrmJM75JxB6g==
X-Received: by 2002:a05:620a:4413:b0:939:9f51:29a0 with SMTP id af79cd13be357-93c363d6c97mr68153185a.50.1790211862043;
        Wed, 23 Sep 2026 18:04:22 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c2485883asm349018185a.20.2026.09.23.18.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 18:04:21 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>
Subject: [PATCH v2] PCI: rcar: Release temporary device tree node reference
Date: Wed, 23 Sep 2026 21:04:11 -0400
Message-ID: <20260924010418.726980-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_matching_node() returns a referenced node even when it is used
only as a boolean test. Drop the reference right after the match check.

Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Changes in v2:
- Use an explicit of_node_put() instead of __free(device_node) (Marek Vasut)
- Switch to my oss.patchbox address

v1: https://lore.kernel.org/all/20260801233841.469826-1-dbgh9129@gmail.com/

 drivers/pci/controller/pcie-rcar-host.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
index cd9171eebc289..1f5e33c802b5b 100644
--- a/drivers/pci/controller/pcie-rcar-host.c
+++ b/drivers/pci/controller/pcie-rcar-host.c
@@ -1122,7 +1122,11 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
 
 static int __init rcar_pcie_init(void)
 {
-	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
+	if (np) {
+		of_node_put(np);
 #ifdef CONFIG_ARM_LPAE
 		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
 				"asynchronous external abort");

base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
-- 
2.43.0

