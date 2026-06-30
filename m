Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214FD477980
	for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851384; cv=none; b=GQQzYY/Ex51POGCyFGJAY13QkwPBjpBqziLVdJJL4AiTW0DmMzSdaILkATz3msRraGWRb6Wcu0hAzSBDyVLEQEPSWPwSyS7jBJ9lpx9IWFkOg66lwTQ4KTuCcr88CXm5gQsz/2M7cQzVOh1UWqnV74Tq0Yg/CnVbumWR3o1LgeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851384; c=relaxed/simple;
	bh=T3hAAuEcnuvOxgSX7BF+epZ+XdQfUSblgvEQCfCRlVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UZRKGFINNSGKZo/Zm0WZoUJg7vzt0Pu6xCulQLhKjhKEZH35YYMW/Yqp7bwOZFEEQtYw4JGAJthX/OXVGNISFCUpprmDZceAg88EydgwyYF1IbS5VyuBBb8jXcNAFwVBMOsANotmNx98VcNEf+MPqBoZu5ESel4TVf8tChSme4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRQeK/n7; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRQeK/n7"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eefd4a8057so32761166d6.0
        for <linux-pci@vger.kernel.org>; Tue, 30 Jun 2026 13:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782851382; x=1783456182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHkAtPDzDj99Aof3Amn7WPi3kL41U0foNenjtplF7UM=;
        b=HRQeK/n7/VLAMsi8Hl7MNCKzK4OFtvquRBgqzZMogyg9Fz0wBEB6lfg69DBfWm/2Ae
         WV8geQfBVl8Lnc8/Oxy7Y++MercluriXRhNoiRb/+FOzxu37zd+jNTL8HqdoyZXEqayb
         PtRQTsPkL+J3Z+297pcyHyBIVF9jrXloywrj3tXMgb1BJdqEVz/mFPulzTNyLSZzJMqB
         7aLgNipQkRe0uCQsyjIwuljQcaABELVFxlLucKeSMUsTRWAj3V04gor/84hASDltB3E3
         hZoCHCDLar66AVVpEpEFygTltbPRtOmGb5zB2HPB78o9VHD+gYq/bSwgclHoa/NlYoQp
         BSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782851382; x=1783456182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHkAtPDzDj99Aof3Amn7WPi3kL41U0foNenjtplF7UM=;
        b=Jw1f/IxQUKQJlBSTa03JqpR0hMTX121eoF5MR1hs3l1z68yXmEZVG9GosIlBj/33N0
         vLT3LJgS7R4/nvIxajoaaQnx7AorwF/vWSsDfsZHGkCKQKAV4XJ00jeBJMBAWU8x0hMb
         WXCpIbO2iCIk+6KYRlEvEpYZ3EVetKUealxI+cSNhPIzhh4TTzrOUHs4tJEbARrpWQ0T
         cCvuXLB2GzmN/n8sYOFpdlmsF1h0L6g13A9jbBju4gmUZFAR4+asGbF6xjWbEfPf0F1Z
         745WlkPD6SZYHq3n2paLajqjfYubQGnnW97OKJReEP5uGfCzEcChPHYFc8K78NMFsBlB
         gOTg==
X-Gm-Message-State: AOJu0Yx+q64PbKEpsEbr/KVhSkrAC+vj56wKlb5zcI6cNjCIqx2Ida6p
	wZmwZK1bbKZQh0kT5wQgFqvCfAWSENwFyR9RRbb90nPJIlgG1yachV3I
X-Gm-Gg: AfdE7clMrlZWGuOWpabfQRdHO0C4vy2fZks0G1Hb95GQSfV2KG5XBW8HC3j5Ahdw0ER
	l7I8qvuvE3zFoGrScDoFUSd+MUJrmbzZdEToMrK4azxnTWRk6aTZhFTg91LNT13ZkeqTZ4uO4ZZ
	6EgoQtqz1pgvhJPr9iDNhNhxqSKC9Q28gpmM2TwuWUVJg7PRnkqMViPw0Z3uJx36OkPw8XnLCUT
	wLklbx5K+URI50jaqooCHVhWRMcLm+uWJhLLJFBpt2eFTnLwv4+nECinyxdjBpkGS4mnbE0c52o
	Qa+S9+eAKA6mYEBH1/rQ0ljzW5cCNJeWbZjgg6c6YtpfWqrn/YOtXxLNVyOKI6+bz/F5p3JfV3F
	DQlJnC74IWrAr5jKQcZJ/a1ACiSKyQuIiDOBdtiOOZ36TEByiSJpiW99alxnw7RlAW/UK8CjV+j
	OPD0jFQ/LC26TQj89xrLWaC2sFMJGe6Q==
X-Received: by 2002:a05:6214:4508:b0:8ce:f1b:74ec with SMTP id 6a1803df08f44-8f1ba49e96emr78192396d6.25.1782851382096;
        Tue, 30 Jun 2026 13:29:42 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a717edc7sm32006346d6.36.2026.06.30.13.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 13:29:41 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Niklas Cassel <cassel@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Qianfeng Rong <rongqianfeng@vivo.com>,
	Koichiro Den <den@valinux.co.jp>,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v1] PCI: keystone: Fix OF node reference leak in init
Date: Tue, 30 Jun 2026 16:29:38 -0400
Message-ID: <20260630202938.1877632-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_find_matching_node() returns a device node with its reference count
incremented. ks_pcie_init() only uses the returned node to decide whether
to register the ARM external abort fault handler, but never drops the
reference.

Store the lookup result in a temporary variable and release it with
of_node_put() once the existence check has been made.

Fixes: bc10d0ad540d ("PCI: keystone: Add support to build as a loadable module")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 278d2dba1db0..f1b27aed488d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1389,13 +1389,17 @@ static int ks_pcie_fault(unsigned long addr, unsigned int fsr,
 
 static int __init ks_pcie_init(void)
 {
+	struct device_node *np;
 	/*
 	 * PCIe access errors that result into OCP errors are caught by ARM as
 	 * "External aborts"
 	 */
-	if (of_find_matching_node(NULL, ks_pcie_of_match))
+	np = of_find_matching_node(NULL, ks_pcie_of_match);
+	if (np) {
+		of_node_put(np);
 		hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 				"Asynchronous external abort");
+	}
 
 	return platform_driver_register(&ks_pcie_driver);
 }
-- 
2.43.0

