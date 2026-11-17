Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914349;
	b=uxPEwuQpeD+TDlMJOeR5IjpldNJHCuJKh/Kc1sfeCqdUAGK5BetsaKJMNL8xRb3d+e3o
	 4RUTBSv5+TiMgVRtjY6IwBc38f3Btquqlb6n0Elo+A/riDuIf3vc5ydZd0GITixgnL1kp
	 Qg9XVZaXIOPifpYpKr1nISZD0fMPYQfJlRQRX3f3fRzy0HXwqzo54mEewPjY3ZCnLhMgd
	 PbHI3FD0Sg57uqcj31Zfhrs8b2r/Ddm6DgN98lAOS/rlrPWu9T7m/K2yWq8VVv3dHZ42s
	 3Fy25W1TQtpqYVLAKiIDSUYnQqobU/t/14k5XGlS/VBeIr6XyoeF5aefuE/5Fhz5r1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914349;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RYSQ5kLa3H9TG5xUvnHteU+yhk15bteC+s8cksoZucI=;
	b=BoBSXCwZGAF47wvjiwC4bXtLcetn+j6bknzoXxN20DbMGK7zDqtsHx4+1q6txKG2k8Wb
	 39OpNkYzOHf/AzYyNeN5PGJZeGIr9FNZR/yiMSyKB8d9aYFzmQleRw6a/gaDojtqYmykH
	 AFdPh+9OvC/vuNU7oDsiyIeIGuloe6OHiMI0BHq5X4SsDCpWHL6JCHkdF7g/5mWoBEG7h
	 WzqL78oebGujVoCV3FGOswRSJDRuoiDMRBluyKThDPj0xHxHhnaLe5AFJTfC+KJ8RfIRw
	 gwBbCOgfC9acrftvmi88eElfEIT4hc4iDSgaiHdC/q5mumNLuAZyDJLTzodtDs/tN9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KIilknYp;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C064B606A31C;
	Tue, 17 Nov 2026 11:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C064B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KIilknYp
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 36FC11BF3;
	Tue, 17 Nov 2026 03:19:05 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7D3B23F763;
	Tue, 17 Nov 2026 03:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914348; bh=VdWsKyGxR5ZeDlLk4op5RqTNUGJF8BnYRHcAvnh4Am4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KIilknYp8+I1cTjeiTHP1GTtDiTp4mHC9hqjewZSm0iB4PaisNIudYj4+XfprI/k1
	 vOv4ttJW2ITxrTrKKdc0PSgVO2K5gGB9AQaUN+UammfdEOhmHjKg/MkXE3yEodqteg
	 9SOdha/CFNR4QZy6gBJZC52RbPRv8FnqlnSduUqY=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Dan Williams <djbw@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 11/19] RAS: Remove unused ras_userspace_consumers()
Date: Tue, 17 Nov 2026 12:10:21 +0100
Message-ID: <20261117111444.4185512-12-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the unused ras_userspace_consumers() and atomic
trace_count as the previous patch made extlog select
CPER console output by severity.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/ras/debugfs.c | 10 ----------
 include/linux/ras.h   |  2 --
 2 files changed, 12 deletions(-)

diff --git a/drivers/ras/debugfs.c b/drivers/ras/debugfs.c
index 42afd3de68b22..838cc689b9989 100644
--- a/drivers/ras/debugfs.c
+++ b/drivers/ras/debugfs.c
@@ -5,20 +5,12 @@
 
 static struct dentry *ras_debugfs_dir;
 
-static atomic_t trace_count = ATOMIC_INIT(0);
-
 struct dentry *ras_get_debugfs_root(void)
 {
 	return ras_debugfs_dir;
 }
 EXPORT_SYMBOL_GPL(ras_get_debugfs_root);
 
-int ras_userspace_consumers(void)
-{
-	return atomic_read(&trace_count);
-}
-EXPORT_SYMBOL_GPL(ras_userspace_consumers);
-
 static int trace_show(struct seq_file *m, void *v)
 {
 	return 0;
@@ -26,13 +18,11 @@ static int trace_show(struct seq_file *m, void *v)
 
 static int trace_open(struct inode *inode, struct file *file)
 {
-	atomic_inc(&trace_count);
 	return single_open(file, trace_show, NULL);
 }
 
 static int trace_release(struct inode *inode, struct file *file)
 {
-	atomic_dec(&trace_count);
 	return single_release(inode, file);
 }
 
diff --git a/include/linux/ras.h b/include/linux/ras.h
index 468941bfe855f..3159f9a0877ed 100644
--- a/include/linux/ras.h
+++ b/include/linux/ras.h
@@ -7,11 +7,9 @@
 #include <linux/cper.h>
 
 #ifdef CONFIG_DEBUG_FS
-int ras_userspace_consumers(void);
 void ras_debugfs_init(void);
 int ras_add_daemon_trace(void);
 #else
-static inline int ras_userspace_consumers(void) { return 0; }
 static inline void ras_debugfs_init(void) { }
 static inline int ras_add_daemon_trace(void) { return 0; }
 #endif
-- 
2.43.0

