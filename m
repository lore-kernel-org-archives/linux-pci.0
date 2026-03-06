Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA41318B9B;
	Fri,  6 Mar 2026 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810154; cv=none; b=Odl0lsDrlz/+sLsiULbL2HfhkBjGclhulMU60gNE33qgz5GxUjuX98ybujuwPf4PSwb98eVwUN89h6nMx4tuadtCPVF7gjGMgyfIiL3RRATfjD2h3B4jINqZwdkXmseFt7MjRC3QZ5eDVSx0/GxGIOgtWK8qoAx5LXArDFEeCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810154; c=relaxed/simple;
	bh=itDrRKImjQv/F+3u3/JI98chLKpt7YBQse0TA6heZJc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PM5voNqkysMVAS/YzGO0LTra+AlaY0rhkLGqd6ORI/MxbSSVMaKtoRY1PYh2kqwcH2oZbhLE0cSFPadxEdhfI8XULbYwOFZKgdsTq9upHyMspAhqvL1pfRtDMabbC1u0HtP+j+ZjWrPWU3eqwhDHAtutcxGEMtI0RTqRZvyqoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=glptThSb; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="glptThSb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vc
	b7oDKsea5aklun0/dzR/DzT5hlyRMavq5EXlRNnS8=; b=glptThSb/68Si9JhKh
	53QaLlgJmJ7z6k8eyZE//8yOGqkIsdZs7Uj8dFe9y8ECxKn4CtZV6Sh3lBxPbP3E
	6d/zfNuVDIVnCvEGjA0VvjD5ypopOpCIPRqIrcwsdbRyhuf+MosQFOJJB2tEaYpW
	czJh5ppfXC99YPucDoa5L+pxc=
Received: from zhb.. (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDn93OK76ppQgsKQw--.6882S2;
	Fri, 06 Mar 2026 23:15:22 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: lpieralisi@kernel.org,
	jingoohan1@gmail.com,
	mani@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com
Cc: robh@kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	Cheng Xin <chengqin195275@126.com>
Subject: [v2] PCI: dwc: Add PCIe event counters for groups 5 to 7 in DWC debugfs
Date: Fri,  6 Mar 2026 23:15:25 +0800
Message-Id: <20260306151525.43160-1-18255117159@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn93OK76ppQgsKQw--.6882S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4UXFyfur1ftw45Wr1Utrb_yoWrXFy3p3
	yjyr42gF4ktr13ZrsxX3s8ur1kZFWkJrZ7Kan3uwnxu3W3urn5Ar13tr15Jry8Gryqqr1a
	vF17try8WryYy37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pitCztUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwsjxmmq74tkPwAA3R

Extend the DesignWare PCIe controller's debugfs statistical counter
interface with event definitions from groups 5 through 7 as documented
in the DWC PCIe Databook (version 3.30a, section 3.8.2.3, Tables 3-59,
3-60, 3-61). These counters provide visibility into Layer1 non-error
events (link state transitions,ASPM, L1 substates), Layer2 DLLP
exchanges, and Layer3 TLP transactions.

The counters are exposed under the debugfs statistical counter directory,
allowing users to monitor link behavior and diagnose PCIe protocol issues
more effectively.

Co-developed-by: Cheng Xin <chengqin195275@126.com>
Signed-off-by: Cheng Xin <chengqin195275@126.com>
Signed-off-by: Hans Zhang <18255117159@163.com>
---
Thank you, Cheng Xin, for providing the 3.30a version of the DWC PCIe Data Book.

Changes for v2:
- Sorry, I sent the patch multiple times in a row. The first version of
  the email was incorrect. The email address of Cheng Xin has been corrected.
---
 .../controller/dwc/pcie-designware-debugfs.c  | 52 ++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index 0d1340c9b364..2efddb21b2b2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -131,13 +131,16 @@ static const u32 err_inj_type_mask[] = {
  *				   supported in DWC RAS DES
  * @name: Name of the error counter
  * @group_no: Group number that the event belongs to. The value can range
- *	      from 0 to 4
+ *	      from 0 to 7
  * @event_no: Event number of the particular event. The value ranges are:
  *		Group 0: 0 - 10
  *		Group 1: 5 - 13
  *		Group 2: 0 - 7
  *		Group 3: 0 - 5
  *		Group 4: 0 - 1
+ *		Group 5: 0 - 13
+ *		Group 6: 0 - 6
+ *		Group 7: 0 - 25
  */
 struct dwc_pcie_event_counter {
 	const char *name;
@@ -181,6 +184,53 @@ static const struct dwc_pcie_event_counter event_list[] = {
 	{"completion_timeout", 0x3, 0x5},
 	{"ebuf_skp_add", 0x4, 0x0},
 	{"ebuf_skp_del", 0x4, 0x1},
+	{"l0_to_recovery_entry", 0x5, 0x0},
+	{"l1_to_recovery_entry", 0x5, 0x1},
+	{"tx_l0s_entry", 0x5, 0x2},
+	{"rx_l0s_entry", 0x5, 0x3},
+	{"aspm_l1_reject", 0x5, 0x4},
+	{"l1_entry", 0x5, 0x5},
+	{"l1_cpm", 0x5, 0x6},
+	{"l1.1_entry", 0x5, 0x7},
+	{"l1.2_entry", 0x5, 0x8},
+	{"l1_short_duration", 0x5, 0x9},
+	{"l1.2_abort", 0x5, 0xa},
+	{"l2_entry", 0x5, 0xb},
+	{"speed_change", 0x5, 0xc},
+	{"link_width_change", 0x5, 0xd},
+	{"tx_ack_dllp", 0x6, 0x0},
+	{"tx_update_fc_dllp", 0x6, 0x1},
+	{"rx_ack_dllp", 0x6, 0x2},
+	{"rx_update_fc_dllp", 0x6, 0x3},
+	{"rx_nullified_tlp", 0x6, 0x4},
+	{"tx_nullified_tlp", 0x6, 0x5},
+	{"rx_duplicate_tlp", 0x6, 0x6},
+	{"tx_memory_write", 0x7, 0x0},
+	{"tx_memory_read", 0x7, 0x1},
+	{"tx_configuration_write", 0x7, 0x2},
+	{"tx_configuration_read", 0x7, 0x3},
+	{"tx_io_write", 0x7, 0x4},
+	{"tx_io_read", 0x7, 0x5},
+	{"tx_completion_without_data", 0x7, 0x6},
+	{"tx_completion_w_data", 0x7, 0x7},
+	{"tx_message_tlp_pcie_vc_only", 0x7, 0x8},
+	{"tx_atomic", 0x7, 0x9},
+	{"tx_tlp_with_prefix", 0x7, 0xa},
+	{"rx_memory_write", 0x7, 0xb},
+	{"rx_memory_read", 0x7, 0xc},
+	{"rx_configuration_write", 0x7, 0xd},
+	{"rx_configuration_read", 0x7, 0xe},
+	{"rx_io_write", 0x7, 0xf},
+	{"rx_io_read", 0x7, 0x10},
+	{"rx_completion_without_data", 0x7, 0x11},
+	{"rx_completion_w_data", 0x7, 0x12},
+	{"rx_message_tlp_pcie_vc_only", 0x7, 0x13},
+	{"rx_atomic", 0x7, 0x14},
+	{"rx_tlp_with_prefix", 0x7, 0x15},
+	{"tx_ccix_tlp", 0x7, 0x16},
+	{"rx_ccix_tlp", 0x7, 0x17},
+	{"tx_deferrable_memory_write_tlp", 0x7, 0x18},
+	{"rx_deferrable_memory_write_tlp", 0x7, 0x19},
 };
 
 static ssize_t lane_detect_read(struct file *file, char __user *buf,

base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
-- 
2.34.1

