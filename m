Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA824DCF9;
	Sun,  8 Mar 2026 14:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772980032; cv=none; b=FCreol1zVMshFwAzsEZUziiVQAkdsokLUnyv0IXkBVKlmivZM1qjP3UuN35d5FHGX0tJpFWU+kz9uTN1dlmifBg8afpyte7oH37nmkkca+XJXBEekcaxZfOKo1WCHtJuChMRv+kpzsoEHkRCuojwsttnsoQkCipL8j+P3KupFDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772980032; c=relaxed/simple;
	bh=hPIoaB//mtUNj0z8RQaMhVXCZ1GF3FqvHWesbTtal2A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KcEI8YvGf7ZkdNcfleZIddn6nxZwtU3/awh6oSonlLBzuxS56ha4ah+ZB8o9Yr1r+pw4GqZjfgNOIh+/PHMVXVvRM0EjqH8AAPBRJxS2NpRlZHGim0qftxEhruf0Vi4uWJ5nkZFoNqTc5D+129DndCPAjLF5LV2YwSdJ5E1lekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fCSS1nGD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fCSS1nGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cn
	dl7JhmknwW5VKKndEtmXsRqcLIzzZ0yqysu4qdYMQ=; b=fCSS1nGDkYRuSmPesg
	ehOE4YFoCTOV0uGgmPgks4quBYVktYsB5zn/+Gqu/bcncBfjirKM3Kz3NIbekDMM
	4YBzB1wsPI2ZKxZhzEtIWvAg0gzIZYqnVM0bX4AIkKrQ167K34TynKm1gx7cua1r
	MY6p1cYcDR/S4d1VhbBHgugm4=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wBXlAEXh61pUWlUOw--.24999S2;
	Sun, 08 Mar 2026 22:26:31 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	helgaas@kernel.org
Cc: robh@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH v7 0/2] PCI: of: Remove max-link-speed generation validation
Date: Sun,  8 Mar 2026 22:26:27 +0800
Message-Id: <20260308142629.75392-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXlAEXh61pUWlUOw--.24999S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary7uw17tryfWw4DJFy5Jwb_yoW8KF17pa
	yYqw4Fqr4xJrW3t39xGa17ZFn0g3Z3XrWjyryfGw17ZFnrJFnrXFyIgF4FvF9rWFZFkr42
	qF12qa17K34jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUb4S5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6xitUWmthxj6bAAA3C

This series removes the hardcoded max-link-speed validation from
of_pci_get_max_link_speed() to avoid updating the kernel for every new
PCIe generation. As pointed out by Bjorn Helgaas, the removal must be
accompanied by proper validation in callers to ensure robustness.
Therefore, this series also adds validation in the DWC controller driver,
which is a primary user of this function.

Patch 1 simplifies of_pci_get_max_link_speed() by returning the raw
property value (including error codes) without imposing an artificial
upper bound. Patch 2 introduces dw_pcie_get_link_speed() in the DWC core
to validate the retrieved speed against the known pcie_link_speed array,
falling back to Gen1 (safe default) if the value is missing or invalid.

---
Changes for v7:
- Add validation in dw_pcie_get_link_speed() (Bjorn)
- Modify it so that two patches constitute one series.

Changes for v6:
https://patchwork.kernel.org/project/linux-pci/patch/20251218132036.308094-1-18255117159@163.com/

- It'd be good to return the actual errno as of_property_read_u32() can return
  -EINVAL, -ENODATA and -EOVERFLOW. (Mani)

Changes for v5:
https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/

- Delete the check for speed. (Mani)

Changes for v4:
https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/

- Add pcie_max_supported_link_speed.(Ilpo)

Changes for v3:
https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/

- Modify the commit message.
- Add Reviewed-by tag.

Changes for v2:
https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
- The following files have been deleted:
  Documentation/devicetree/bindings/pci/pci.txt

  Update to this file again:
  dtschema/schemas/pci/pci-bus-common.yaml
---

Hans Zhang (2):
  PCI: of: Remove max-link-speed generation validation
  PCI: dwc: Validate max-link-speed property

 drivers/pci/controller/dwc/pcie-designware.c | 29 +++++++++++++++++++-
 drivers/pci/of.c                             |  7 +++--
 2 files changed, 32 insertions(+), 4 deletions(-)


base-commit: c23719abc3308df7ed3ad35650ad211fb2d2003d
-- 
2.34.1

