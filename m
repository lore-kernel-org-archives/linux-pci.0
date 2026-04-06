Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E2031A061;
	Mon,  6 Apr 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473019; cv=none; b=RZkAGBNxUxTvNlczFG4r2g/9Q1Cw9Oaj7l+V+UQZuFwmnS3RDZkPmZHZ0eE2T0bXKi9r6asq2Jq9ZtRf2UBiNBt4yps450UNg2DL83FNl0lQCi/F3M1s362yEL6nz+OJqd3tcDV0S/dS3w5JBqvQMiHK7KTY+wq+k3FMAKmh3cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473019; c=relaxed/simple;
	bh=nan5179p0F4xSgv64zjXRiKBFJ0BJ3H/7k9IVZT0oEI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T2WZEjuH180JG6amSweZWJlXgeZ9RhdlCIW3u1qI/AQJe93zcmbJY/6sroIqKA7IyqK51T+A7RVg1FNbz7vU6bROKLRbQhyZdfYwKrk1uPcstYTrEBc1UO+O8Yur0jvur8v0q95g255Cu0CEcTuDIzzEsPBmN8b5e8m1rY2GzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=SRIsygnB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="SRIsygnB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=7L
	ld9hOXfc3Ls9HFf+pUDgYMDFqZiJUBOpyviglyfjU=; b=SRIsygnBfn5wTzFKBR
	g18pm6kVb0KFZSAKyEdV0BIjjLgqsp9ql3h0xiGaBiSJUhk4S2yap7WC2vAQu7Wb
	bqoQCHYqrf2AHu4blUbRG8UjdmYZHmdxSD/wa4pUAu55zTdrIWzWWEH9FxGyhLAM
	Wrm/YHlVLBZNsHti/gj2QJ3Ao=
Received: from Precision-7960.. (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wC37wJQkdNpmdyZDg--.25057S2;
	Mon, 06 Apr 2026 18:56:16 +0800 (CST)
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
Subject: [PATCH v6 0/3] PCI: Refactor PCIe speed validation and conversion functions
Date: Mon,  6 Apr 2026 18:56:10 +0800
Message-Id: <20260406105613.1228673-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC37wJQkdNpmdyZDg--.25057S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1Uur17WF15Jry5tFW8JFb_yoW8Aw45pa
	yavw4fJrW7G343Ga97W3WjgFy5Wan3JrW0vry3J3s3Zr13ZFn3Jr4IgF4F9ry2yrWI9r42
	vr12vF1kCw1jkaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRj2NZUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxHHa2nTkVHzNwAA3A

This series refactors PCIe speed validation and conversion logic to
shared functions in the public header, eliminating code duplication
and ensuring consistency across drivers.

---
Changes for v6:
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

 drivers/pci/controller/dwc/pcie-designware.c | 18 +++-------------
 drivers/pci/pci.h                            | 22 ++++++++++++++++++++
 drivers/pci/pcie/bwctrl.c                    | 22 --------------------
 3 files changed, 25 insertions(+), 37 deletions(-)


base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44
-- 
2.34.1

