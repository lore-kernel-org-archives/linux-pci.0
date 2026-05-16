Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503633B6C2;
	Sat, 16 May 2026 15:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778945979; cv=none; b=iT1jXhSoxgAudrsq/ftpMz/POBFN5OJHq0kXMHpv8kSeRSUKz8YtIj7W1u37Pwq8rPCPQbj9+ZIePgd+HdTeDpW4LhhNeBIpqg4+MfT/OvzKfUbqOGX2pmB/xkbw5wFfu28DPKEx21TR6RZ3rn1aJ/I+X9ocxbc7CzfIH/Ycgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778945979; c=relaxed/simple;
	bh=lvEUvbtIjyb3eE+XVZArod+nmwHZzuRJ16wcQU/Xu4o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=foCwjUrBApogQsZLBwzbJJlSzwu3UvwlXmeZ3BRD07NnKFcdNgi812fmO/n8Skm2E4dtT5CEoW+47/vo/GFbwIi0KFTNulbm1bGxY9N7Q0c2H0So6Q2a46ZQoQNf47XtOWJq68gRNW1/gOkG1M+KjF2U1KTs6vrDw+Ej1WBYblQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=d2QmB9eo; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="d2QmB9eo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7j
	5CDU0URFs1JHVW/teG8LXt9sldBcK/VZWwCoLPTn0=; b=d2QmB9eoJfN4H8jgzK
	isoUWshJ0VQrkkZ16xJurPpKgUo4dkF2FHYYtQZ8bmk7Nb1OFZRDgxEUXAxA/l/w
	0Xs5cG9hn3WiU4s55HKy70NeCzeQZ8oO0V9nxvifysixOpAfyAk2Aej8s5OUbJRp
	J5v8mlRRJK6y6iPo11zGDYBOg=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wD3XzoajwhqfCYHBw--.40848S2;
	Sat, 16 May 2026 23:36:58 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	mani@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH 0/3] PCI: Unify TLP type definitions across controller drivers
Date: Sat, 16 May 2026 23:36:54 +0800
Message-Id: <20260516153657.65214-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3XzoajwhqfCYHBw--.40848S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww4kZryUAw1xAF1fZw1fZwb_yoW8Cr18pa
	y3tay3Zr1xta13uFs3Z3W8Zr1Yv3Z3CayUWrsFgw1SqF9IkFyUtry8tr1rXFy3JrW0qwnI
	kr4jgr97GFsrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pirOzxUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxuGKmoIjxuaDQAA3V

This series replaces scattered hardcoded values and private macros for
PCIe TLP type fields with a single set of common definitions in pci.h.

Background:
PCIe Transaction Layer Packets (TLPs) have a Type field (bits 4:0 of
byte 0) that identifies the request type. Different controller drivers
(dwc, cadence, aspeed, mediatek) currently use either magic numbers or
their own macro names for these values, hurting code readability and
maintainability.

Changes:
- Patch 1: Introduce common macros in pci.h and convert aspeed/mediatek.
- Patch 2: Convert dwc driver (includes tegra194-acpi glue).
- Patch 3: Convert cadence driver.

All replacements are compile-time constant substitutions with identical
numeric values, so no runtime behavior change.

---
When I was integrating the DWC driver into the firmware of the GPU, 
discovered that the TLP type field of the iATU was similar to that
in drivers/pci/pci.h. Therefore, I wanted to make the code uniform.
---
Hans Zhang (3):
  PCI: Add common TLP type macros and convert aspeed/mediatek
  PCI: dwc: Replace ATU type macros with common TLP type macros
  PCI: cadence: Use common TLP type macros

 .../cadence/pcie-cadence-hpa-regs.h           | 12 ++++++-----
 .../pci/controller/dwc/pcie-designware-ep.c   |  6 +++---
 .../pci/controller/dwc/pcie-designware-host.c | 20 +++++++++----------
 drivers/pci/controller/dwc/pcie-designware.c  |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h  |  5 -----
 .../pci/controller/dwc/pcie-tegra194-acpi.c   |  4 ++--
 drivers/pci/controller/pcie-aspeed.c          |  8 ++++----
 drivers/pci/controller/pcie-mediatek.c        |  8 ++------
 drivers/pci/pci.h                             |  9 +++++----
 9 files changed, 34 insertions(+), 40 deletions(-)


base-commit: 6916d5703ddf9a38f1f6c2cc793381a24ee914c6
-- 
2.34.1

