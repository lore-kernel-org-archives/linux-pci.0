Received: from outbound.baidu.com (mx14.baidu.com [220.181.3.101])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 75F0A21CA02;
	Tue, 17 Mar 2026 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.3.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708887; cv=none; b=nZ7CPLj0dIsOvmoQQks3FTO7T7r2Wx0KlEq2Gl2q/BXF6mT89UAFxK4Z8o3P6pd5Fj0MNiDJnKtSM1jBjtUZDW61SIRR+XTBf9OFBZ60CsvvBw1FpJdJEb7mwgN798feZf5RWdFswpBtIpHhCzHWTh8t4hjaAVjuWWusrffY66k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708887; c=relaxed/simple;
	bh=lLQ1C4JPE0l+4G5WJtYypCxK8XWkTXYT3bR7xphw0n8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n3fHdrIsVZgrBJiNjaj0qfxenn2EwH2IKLNy8cTbRx8zLj0PU+64HVnDyCfVe1ZA53kHeqDi1Dgos7xBr7kDty3dh5t/UBIR7mEJ2gmUy/ETldZN4PF1xvhm0x8w+nb423NqIct338zbR/J+Xjm4mjV0W2PzVHDH9oyb5ETt6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=R772xDRU; arc=none smtp.client-ip=220.181.3.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="R772xDRU"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <kwilczynski@kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][v2] PCI: sysfs: Suppress FW_BUG warning when NUMA node already matches
Date: Mon, 16 Mar 2026 20:28:03 -0400
Message-ID: <20260317002803.2353-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1773707292;
	bh=q2JODQo8RjYR52ut57qXnSV08daiUfFnUh62OF1+fSU=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=R772xDRUTkmHaNuZSF5oiRCglIMIns6eQVSoNC/3XY0vlvp4rgsiRupSJVuin09KK
	 6ZShN0OHgcQpkq+ar4IhWFFeeD56bBA0d4owub70Ei1xPP59ErZcB6Qjru0yOjyTW8
	 T2mTRHe5wVshWVhBMN+xDgDBtszuzHb4hVQYiAwGs+nUrv01lmJjHyhpMYW828Rhr/
	 rPh4RyJLDjOI8D7GRmxUg8gOfbducfVQ1XGyeCujw5JmCplXsvTfzStTSvtKCd/id3
	 VctWmmr3nPIw5Oe0TMgQqJJHDWQ1cY72HtFJwMyBTbewUMjvgX/7hUNiRT3+CNWDbJ
	 a68ho7CTnCfLQ==

From: Li RongQing <lirongqing@baidu.com>

The numa_node sysfs interface allows users to manually override a PCI
device's NUMA node assignment. Currently, every write triggers a
FW_BUG warning and taints the kernel, even when writing the same value
that is already set.

Check if the requested node is already assigned to the device. If it
matches, return success immediately without tainting the kernel or
printing a warning.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
Diff with v1: invert the check and return if they are same 

 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 16eaaf7..dd7c9e5 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -378,6 +378,9 @@ static ssize_t numa_node_store(struct device *dev,
 	if (node != NUMA_NO_NODE && !node_online(node))
 		return -EINVAL;
 
+	if (node == dev->numa_node)
+		return count;
+
 	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
 	pci_alert(pdev, FW_BUG "Overriding NUMA node to %d.  Contact your vendor for updates.",
 		  node);
-- 
2.9.4

