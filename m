Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA46031716B
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 03:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296721; cv=none; b=kpCounMb5JVPcPADTgVGk5ehg4uvSYjlU4lTWQTl7qggF5jU5odNfmaKylArGmg7mFfM9P+u3BUEFuVxJeFHpjInZGv5vig7JvJnGuCIB325EQf+h25FZTXvKJ/07Hgp2GJ3QypCosvUXYbCTD6QAftC1LvCNGSCHbSWoI0quiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296721; c=relaxed/simple;
	bh=Es6lp4sOkhbkI7c76EG++xpxe+PBhG4G+JhgQIFQ0Sg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FMkwf7DVEMhykf9q2RbO0/w++i79aUE+Vepu/83SLivgsgsayer6bS/TQe8fNRStFDl8v8Gn+WgoEgCiiqE/kiMXLVcvgaYr0l719VwMwq1BfLHjBttTqE9pwApEgNDvQwVvtbuQ6CwUS0zRzcN3Al8jJuELX6k51HKNHYlJz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XQe9QlD0; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XQe9QlD0"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785296716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=BXR5dw+JmZZTWclJ59fD/wWLiRKTDftTv1SPTY+Jnng=;
	b=XQe9QlD0scGeOKtEfCvCzElzGYsw4ZWYIfzzfLe7vLZoYwV0gA8DPVCRDU5n8ujbTMyTZidx2hDqylkIgk0LQS/LP87mHsjJ31TSHLh3m+0JIglO3zH3RRCpJgL6pDbgE+LmrkSCrXovslj6ZdHRDoy/HQGCLPzV1Yh+bwzdl/M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X80sIi7_1785296714;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X80sIi7_1785296714 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 29 Jul 2026 11:45:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Kees Cook <kees@kernel.org>
Cc: linux-pci@vger.kernel.org,
	xlpang@linux.alibaba.com,
	oliver.yang@linux.alibaba.com
Subject: [PATCH v1 2/2] PCI: Add pci=nobwctrl parameter to disable the PCIe bandwidth controller
Date: Wed, 29 Jul 2026 11:45:05 +0800
Message-ID: <20260729034505.469107-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260729034505.469107-1-kanie@linux.alibaba.com>
References: <20260729034505.469107-1-kanie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PCIe bandwidth controller enables the Link Bandwidth Management
Interrupt Enable (LBMIE) and Link Autonomous Bandwidth Interrupt Enable
(LABIE) bits.  On some (typically old) platforms this has been observed to
cause boot hangs; commit 46a9f70e93ef ("PCI/bwctrl: Disable BW controller
on Intel P45 using a quirk") addresses one such platform with a per-device
quirk.

Per-device quirks only help once the offending device has been identified
and a quirk has shipped, which is awkward for a boot hang since the machine
cannot be booted to report it.  The only existing escape hatch,
pcie_ports=compat, is a blunt instrument that also disables AER, PME,
hotplug and DPC.

Add a pci=nobwctrl boot option to disable just the bandwidth controller
system-wide, giving users an immediate, rebuild-free workaround while a
targeted quirk is worked out.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
 drivers/pci/pci.c                               | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b5493a7f8f22..7621f0b61dc8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5053,6 +5053,12 @@ Kernel parameters
 		noaer		[PCIE] If the PCIEAER kernel config parameter is
 				enabled, this kernel boot option can be used to
 				disable the use of PCIE advanced error reporting.
+		nobwctrl	[PCIE] Disable the PCIe bandwidth controller,
+				which manages Link Bandwidth Management
+				Interrupts. Enabling these interrupts has been
+				observed to cause boot hangs on some (typically
+				old) platforms; use this option to work around
+				such issues.
 		nodomains	[PCI] Disable support for multiple PCI
 				root domains (aka PCI segments, in ACPI-speak).
 		nommconf	[X86] Disable use of MMCONFIG for PCI
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 77b17b13ee61..36c0b3fe4017 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6756,6 +6756,8 @@ static int __init pci_setup(char *str)
 				pcie_ats_disabled = true;
 			} else if (!strcmp(str, "noaer")) {
 				pci_no_aer();
+			} else if (!strcmp(str, "nobwctrl")) {
+				pci_no_bwctrl();
 			} else if (!strcmp(str, "earlydump")) {
 				pci_early_dump = true;
 			} else if (!strncmp(str, "realloc=", 8)) {
-- 
2.43.7

