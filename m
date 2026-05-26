Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E932F3C0A;
	Tue, 26 May 2026 02:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779763900; cv=none; b=VUySNk96obqc8f6XFSl0Q9sf9Nj++V+X6MgjtTIV0v5XlrkQC8qXRa1Xqb2F9kWUCuhnKGjZLudXxQqOE7AgW+l1sbO4X6OYpqc6sZ9r2n/nU/OzNBBle/qAnAaIWFx+4+uP74SK1dFBxfnzWnSdsMD2hU9LIVkdHlfaxb0y0Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779763900; c=relaxed/simple;
	bh=CFIXi1NrL9Qyc68roZ6+hKV/M/Pe2aIOPn3afjd1XKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnhO505TbUv7w7lm+kkmCfsOwmuI+EJ803LG6exU2eeDoASAhx+BEduwfla/m+z0PHHXABa73csV8GbAd1atSR5E+gkasC4HNYrNcp/hgK4mlzhMMrEDVEOELURfCDp3WeKrK/1ERR9hUjLexWT/qtua14tdmRP5U57ScZe1rsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=DD9Z0QfB; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="DD9Z0QfB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1779763895; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zDrKew8pcUrEWVoJLu9WXAJUWTw8kdJstFx5TpwqQk4=;
	b=DD9Z0QfBVUDoFfv8LVxc6vBZbykfbM3ROv8bD0S2JBE+v+RzG/pttnyzEx8TA9n3FUEQvt0B1Y0jyv3pBDx5rdqieMRelSaTuGdEFpLVMvTIhH7EUjCzo0VotuIfy8I/lSrJcLge15Y74cQT2pJAuJwfC2b6dqFPlhWpXS5ULaw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X3egDre_1779763894;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X3egDre_1779763894 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 May 2026 10:51:34 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: dave.jiang@intel.com,
	alison.schofield@intel.com,
	djbw@kernel.org,
	icheng@nvidia.com,
	bhelgaas@google.com,
	rafael@kernel.org,
	lenb@kernel.org,
	guoren@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Pei <cp0613@linux.alibaba.com>
Subject: [PATCH 2/2] ACPI: scan: Honor _DEP for ACPI0016 PCI/CXL host bridge
Date: Tue, 26 May 2026 10:51:18 +0800
Message-ID: <20260526025118.38935-3-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526025118.38935-1-cp0613@linux.alibaba.com>
References: <20260526025118.38935-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL root devices (ACPI0017) declare _DEP on their parent ACPI0016
PCI/CXL host bridge so that cxl_acpi probes only after acpi_pci_root
has attached the PCI root and registered it for acpi_pci_find_root().
However, acpi_dev_ready_for_enumeration() only consults dep_unmet
when the supplier's HID is on acpi_honor_dep_ids[]; otherwise the
dependency is silently ignored.

Without honoring the dependency, cxl_acpi can probe before the PCI
root is ready. The resulting CXL topology is broken: decoder targets
read as 0 and no port/endpoint devices appear under
/sys/bus/cxl/devices/.

Add ACPI0016 to acpi_honor_dep_ids[] so the _DEP declared by ACPI0017
is enforced. This relies on the preceding patch ("ACPI: PCI: clear
_DEP dependencies after PCI root bridge attach"), which releases the
dependency once the PCI root is fully enumerated; the two patches
must be applied together.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 530547cda8b2..5f20e7748f36 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -866,6 +866,7 @@ static const char * const acpi_honor_dep_ids[] = {
 	"RSCV0005", /* RISC-V SBI MPXY MBOX */
 	"RSCV0006", /* RISC-V RPMI SYSMSI */
 	"PNP0C0F",  /* PCI Link Device */
+	"ACPI0016", /* CXL/PCIe host bridge: CXL root (ACPI0017) depends on PCI root attach */
 	NULL
 };
 
-- 
2.50.1

