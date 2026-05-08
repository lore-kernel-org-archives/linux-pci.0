Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13D3803DB;
	Fri,  8 May 2026 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247335; cv=none; b=B+9Oqwk3wDmMRJPjIx59EkQ2La9sw3aX80E3YbLZYZycCdsDIvOO/TOwEjEd7pLajkZV1FVHVwhANHhNKymo3JbO8TOvlUzUS6kUkOK5sC7wXc0vuHJwkyNGfZ65wtthg5ymZI8NWG90xHJgVvZ1LaLF9lp+bkyKLE+Y1B0wLfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247335; c=relaxed/simple;
	bh=RGMIVNf/eRIW1H26XcWiWS8pUZCDxFiKW0izvg6Z54I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMkOjRrn7pvNPD1FNzC4IsVQtnscpI7ZL7eyEQbdYsDlNgfHnGMC94Dg1lDabXFbXsURBgMlRaW9P3Oad62GszZlZMFpLZUqfR/ZwZPdEuyOFFseK3INd29CaL5SfI9HIMvlpPQ2IuVhiHKhxn77f8gRXNNQAKmTsfkJlmtLLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Zuy27JTT; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Zuy27JTT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NQ
	rrU4DUp4dwlu87AbZILJUAgxQd+2imnarUPxYCCdo=; b=Zuy27JTT6IQQOWMasD
	cz0kfz8Qe7qFVbDd7HN/oQjDUaqFgFkmw0YQ131jqSih3JtlNZoIAo5k4h17zRhd
	N4fyvlpSzmZD3Tt+s1AvacUcSImavppg9KqemrJQmZXAkO1JyRZ9z293Cxi0Vxgl
	3cOq2/r/xssfSDgV7feBvtAiU=
Received: from Precision-7960.. (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgB39Cx15v1pfGmJDg--.37039S2;
	Fri, 08 May 2026 21:34:46 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	jingoohan1@gmail.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>
Subject: [PATCH] PCI: dwc: Use DEFINE_SHOW_ATTRIBUTE for ltssm_status debugfs
Date: Fri,  8 May 2026 21:34:32 +0800
Message-Id: <20260508133432.1964491-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSgvCgB39Cx15v1pfGmJDg--.37039S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1rJF1fJr1UuFy7CF17Jrb_yoW8Aw45pa
	98Aw40yF4rAr4fWF1Yyan8uryfKFs3JrW7G39F9w1xX3ZrCr1aqF15GFW2yryfGrW8Jr1a
	9a1YyryDGF4FyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JU1rWOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxBawVGn95nbwyAAA3K

Replace the custom open function and file_operations with the
standard DEFINE_SHOW_ATTRIBUTE macro to reduce boilerplate code.

No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/controller/dwc/pcie-designware-debugfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index d0884253be97..87f5ec9c48eb 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -507,11 +507,6 @@ static int ltssm_status_show(struct seq_file *s, void *v)
 	return 0;
 }
 
-static int ltssm_status_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ltssm_status_show, inode->i_private);
-}
-
 #define dwc_debugfs_create(name)			\
 debugfs_create_file(#name, 0644, rasdes_debug, pci,	\
 			&dbg_ ## name ## _fops)
@@ -548,10 +543,7 @@ static const struct file_operations dwc_pcie_counter_value_ops = {
 	.read = counter_value_read,
 };
 
-static const struct file_operations dwc_pcie_ltssm_status_ops = {
-	.open = ltssm_status_open,
-	.read = seq_read,
-};
+DEFINE_SHOW_ATTRIBUTE(ltssm_status);
 
 static void dwc_pcie_rasdes_debugfs_deinit(struct dw_pcie *pci)
 {
@@ -642,7 +634,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 static void dwc_pcie_ltssm_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
 {
 	debugfs_create_file("ltssm_status", 0444, dir, pci,
-			    &dwc_pcie_ltssm_status_ops);
+			    &ltssm_status_fops);
 }
 
 static int dw_pcie_ptm_check_capability(void *drvdata)
-- 
2.34.1

