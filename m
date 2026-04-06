Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E829AB1A;
	Mon,  6 Apr 2026 10:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775472470; cv=none; b=Q2mmfHtMjKDOwtpbu5I2TgKU6tl/GURXmGmJL4H8OsAtXIcwig7/A8OOX2NmGIGKZaRVHZUZgpgqJVaePWdITIWfKSrMkDRUfMoCmVNgy5il41DLjVhL+wSqRuxbGjU/MW9Eg3Ae/hGiSBzB7mibLx3Bcn1xkRt0WBnzQObl3sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775472470; c=relaxed/simple;
	bh=2WXdmx/OHTFowaytlAyg72Xu077NyS5AHa38VtIFAT8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C2rpD4uhqMxyn0E7AAFd5Qq4iAgE0ufwJ9usgr0WjFRWNm/VfJVB34z2Z8nNFPzfu3eq/iVgqzHbaCPDtH0hyvPOP0jKCd+oQckeTFZ5V1YrG/sCt3YGPqk2I2nS0mOxbdaR5xOD4aynC+OdQ9u79JVC86n0hg2o7TmUIydx/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jKpvglRk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jKpvglRk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=a0
	E+3XY/DLuQReYHxz9Ank/+UXX8GYsG22VdNmAC4no=; b=jKpvglRkmonrAdrRNt
	H8FzDYg4m9OAd7Nc0yE3O/XpWm2ySQY/i4O15aSHtSTUFlGQ7nphldbNJd+KzFOE
	XQ4H/j0Qjl4tmpgxmye0Hv1tV0a1toD8e6Y76MJ1nMTbxzyRrjgs95IQsFBOECB4
	4bEHplXM0NkVwJPXPKzaR+HSo=
Received: from Precision-7960.. (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgDXX3Qwj9NpKHYUAA--.1246S2;
	Mon, 06 Apr 2026 18:47:16 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	kwilczynski@kernel.org,
	mani@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v5 0/3] PCI: Refactor PCIe speed validation and conversion functions
Date: Mon,  6 Apr 2026 18:47:05 +0800
Message-Id: <20260406104708.1218648-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgDXX3Qwj9NpKHYUAA--.1246S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1Uur17WF15Jw4xZw4xWFg_yoW8Wr13pa
	9xWayfArW7G343Ga93X3WjgFy5Wan3Jr40qry3J3s3Zr13ZFn7JrW8KF109r9rtrWIqr42
	vF1jvFyDC3WjkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piM7K3UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xVA42nTjzUNYgAA3y

This series refactors PCIe speed validation and conversion logic to
shared functions in the public header, eliminating code duplication
and ensuring consistency across drivers.

---
Changes for v5:
- Rebase to v7.0-rc1. (pci/next tree)

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20251102143206.111347-1-18255117159@163.com/

- Maintain O(1) array-based lookup for speed conversion (addressing
  performance concerns from v3 feedback)
- Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
- Update dwc driver to use the shared functions
- Rebase to v6.18-rc3.

This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
on the v3 submission, ensuring no runtime performance regression while
achieving code reuse.

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/

- Rebase to v6.17-rc1.
- Gentle ping.

Changes for v2:
- s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
- The patch commit message were modified.
---

Hans Zhang (3):
  PCI: Add public pcie_valid_speed() for shared validation
  PCI: Move pci_bus_speed2lnkctl2() to public header
  PCI: dwc: Use common speed conversion function

 drivers/pci/controller/dwc/pcie-designware.c | 17 ++-------------
 drivers/pci/pci.h                            | 22 ++++++++++++++++++++
 drivers/pci/pcie/bwctrl.c                    | 22 --------------------
 3 files changed, 24 insertions(+), 37 deletions(-)


base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44
-- 
2.34.1

