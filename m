Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269214F70;
	Tue,  7 Apr 2026 13:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775567175; cv=none; b=AOEfAl/yHY4c7F4diWtQjJ7idv2AiRW8yD/XdSqYoMRoJNmGXi7XGyg/uKSPKNNDP6PgNvt15DqmI0Yn2EyLKMRKvAxO88ze+ZvvRR6RGOABQ9xhcmSn0yz8WuDo1NyY+ligZg2Ps9M6xS4kbdVeKqUEW1SnbOx4ckkML/baYyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775567175; c=relaxed/simple;
	bh=btecWxYQt84G/cM1OgAB/Z75003fNjS8po6gLWzUV9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CI62cQvvgottiEAOYQxFEBa6xiDHIbNOO0MPBsYoiu8fmG8ySE8/g0R7TKkBTjic6osrHaaNkFLRCsdvC2fllzSVasOcjKh2HmZMU30zhc76lm/kAps+A48kqSgAPW1oA8Hjp4jJwOqB4eGZkjqDu/AVzSYBmAoPKsj9rmDu0o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cbDIvhhp; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cbDIvhhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eI
	VNG6V/9ObwTM9dTgO3ipaPLAhctz2zqYUK0qrSakE=; b=cbDIvhhphoQeGtscqe
	eCwNBeXYD38ndj2icX7JDeI/KZHd2t+xRPDn6PXRXWLcfjjmqu+OElNgsSJdpziU
	VOZ9B4GAz3xTpr0kO8jBKn9gF9gcSTnM/i/beDdvnDRr7NZdr68Qzyoz+VDelIYV
	sngZIHJLxJDIbZNa8/qxa6DoE=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wC33bQHAdVpBqSeDg--.5276S2;
	Tue, 07 Apr 2026 21:05:12 +0800 (CST)
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
Subject: [PATCH v7 0/3] PCI: Refactor PCIe speed validation and conversion functions
Date: Tue,  7 Apr 2026 21:04:47 +0800
Message-Id: <20260407130450.1489318-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC33bQHAdVpBqSeDg--.5276S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1Uur17WF15Jr1DGr4UJwb_yoW8uw1Dpa
	yYvw4fJr47G3sxGa97W3W2gry5Wan3XrW0vry3G3s3ZF13AFn3JrW0gF4F9F9FyrWS9r42
	vr12vr1kCw1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piRuWXUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6wkStWnVAQmp9gAA3u

This series refactors PCIe speed validation and conversion logic to
shared functions in the public header, eliminating code duplication
and ensuring consistency across drivers.

---
Changes for v7:
- patch 0002 add #include <asm/bug.h> (Ilpo)
- s/u32 link_speed/enum pci_bus_speed link_speed/ (Ilpo)
- The return value of pci_bus_speed2lnkctl2 uses the variable ctrl2_speed
  to avoid the abuse of variable types. (Ilpo)

Changes for v6:
https://patchwork.kernel.org/project/linux-pci/patch/20260406105613.1228673-1-18255117159@163.com/

- missing one line of code:
  link_speed = pcie_get_link_speed(pci->max_link_speed); 

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20260406104708.1218648-1-18255117159@163.com/

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

 drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++-------------
 drivers/pci/pci.h                            | 23 ++++++++++++++++
 drivers/pci/pcie/bwctrl.c                    | 22 ---------------
 3 files changed, 32 insertions(+), 41 deletions(-)


base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44
-- 
2.34.1

