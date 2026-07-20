Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B92F12DA
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784582146; cv=none; b=PV5SdepPg591IiaJT+8TCjBpFZsdFDBpyhKY8AvxIK7YJjNyrQor4uY2dpFo3V5GQ00IxB6qVtV8QABjNwOwy9mH8IPG092GoEUj+PF9SpQ+8mwUg8I08cHM+xg1au/MizU9d7iLSjI9ug8thZT++zP/sOgHaCIWcL1ISIutz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784582146; c=relaxed/simple;
	bh=PyQ/Oh0Uc1LGDI6WQvWV8wZzoK+6+DM1Vl65miLt1+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SwQ8kBSba/qiyFJ+QmVW/T0Svr/s0mdF9syq+cnahpDOf1HncopAUBOIuS3SzW8Tn1sTQfCBrkExXRi6RIAjh6oHD2GQ8yB0lZ0Icdq+IS3BI1nNzUPA1B/kRpMnrOQ4Hjpjd9xWsIvHP91l6BLGRGtKkCoIgJUvdxlb4gx3F2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuVOJA61; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuVOJA61"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF24B1F000E9;
	Mon, 20 Jul 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784582145;
	bh=3PE42KSlwAQkiRA1VqursI4MwdS0MMNxHPVdLlaJjLU=;
	h=From:To:Cc:Subject:Date;
	b=MuVOJA617bFZskfrekNrSEN9OiEP7TlU2l99Q9OGp0F2BvmBGExGJlLACJoxYN0pK
	 g+8ZuiKKnik8nyQ1D57bdV0rlW2sdYB2SslRDECd53UllgacqK2utWNrdSsf+8bRXB
	 +rSAfRSbemqw3thkQPz0snHFrW7j22PTrtJMSJAQKoX1muDPWs0XHRF3mCuUvfPCBK
	 YPAzpR2Knl2Gz1xNmFj79w+dZ1R9q4UdAfT0n9I2LawZPJl2zNXfbcGIgeUkWc2MNN
	 fCGr//EOEyVBslkRD/O9GFL7iKoFC0rakjMqTqsG4RjOoc+GZI+AWaIUeKoNE758Lf
	 ZbUPJKdxsna1A==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/sysfs: Add lockdown checks to legacy I/O and memory handlers
Date: Mon, 20 Jul 2026 21:15:41 +0000
Message-ID: <20260720211541.1509744-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the legacy I/O and memory sysfs handlers do not
check security_locked_down(LOCKDOWN_PCI_ACCESS), leaving the
legacy_io and legacy_mem files unprotected when the kernel is
locked down.

Commit eb627e17727e ("PCI: Lock down BAR access when the
kernel is locked down") added the check to pci_write_config(),
pci_mmap_resource(), and pci_write_resource_io() to prevent
userspace from programming DMA-capable hardware that could be
used to modify kernel code, but did not cover the legacy
handlers.

As a result, root can still write arbitrary I/O ports and map
the legacy I/O and memory spaces while the kernel is locked
down, which is the same capability the lockdown is meant to
remove.

Thus, add the same check to pci_write_legacy_io(),
pci_mmap_legacy_mem(), and pci_mmap_legacy_io().

These generic handlers cover both architectures that
define HAVE_PCI_LEGACY (such as Alpha and PowerPC).

Fixes: eb627e17727e ("PCI: Lock down BAR access when the kernel is locked down")
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..c24d9270a7a5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -913,6 +913,11 @@ static ssize_t pci_write_legacy_io(struct file *filp, struct kobject *kobj,
 				   char *buf, loff_t off, size_t count)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	/* Only support 1, 2 or 4 byte accesses */
 	if (count != 1 && count != 2 && count != 4)
@@ -937,6 +942,11 @@ static int pci_mmap_legacy_mem(struct file *filp, struct kobject *kobj,
 			       struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_mem);
 }
@@ -957,6 +967,11 @@ static int pci_mmap_legacy_io(struct file *filp, struct kobject *kobj,
 			      struct vm_area_struct *vma)
 {
 	struct pci_bus *bus = to_pci_bus(kobj_to_dev(kobj));
+	int ret;
+
+	ret = security_locked_down(LOCKDOWN_PCI_ACCESS);
+	if (ret)
+		return ret;
 
 	return pci_mmap_legacy_page_range(bus, vma, pci_mmap_io);
 }
-- 
2.55.0

