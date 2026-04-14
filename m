Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2512A30FF31;
	Tue, 14 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133351; cv=none; b=Y4GseAtqhuwbccT4Cu3fDWR6ws821woaRvj+dTtBYP1xlG5wPNjQY3IhjzLvxZwMUR6hzqgV4i4bVcXZkMCJvLYB5NjQuJl0bfQYWa5IC16HKpvH79y44i7F8Lj3+tOxVqul2VF+9r9kgOoKQJ957Ykjw2z8a9thHpp1RJuqYHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133351; c=relaxed/simple;
	bh=FS1SeOowBA8gVevNxsZJHOuY/+0HP+CQiKPo21lhM/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3xxB4Kh90h9tF7WHvQt3IEidiuMbWuO9pYbkvE3suvdnHchR40lgmklL2P2UyMftU9hr/rv3xv/1JRceakndEj4o4h77VBAX2BwqKMlan0cReNRUJbStL0AmfovqxDSzI0mRK0HpcWp4NJvI33fwt0/vHWjo2roPpRQ9PA+lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6XizOr64; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6XizOr64"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qzl/k/41auKXeIJoyyj8kJiE746ZRuL8fpePAiVIFKA=;
	b=6XizOr64tVdveY4iAm9fCU/G8D5ioZ293uPIDR5NVwmM9mYeYpLmin2rN2ppXYZ/i6CE1B5lQ
	NDU1ddxR5YhsWFwcik9zSAC5JnKmeOVhYzwh8oj0D7yMkjXNvxRPhhlYVylolDL3sZ2jCjQTz7S
	qX0GFx5ihCanyPddXHMQmgE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fvnvD18GQz12LCb;
	Tue, 14 Apr 2026 10:16:08 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id D58AE40572;
	Tue, 14 Apr 2026 10:22:26 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 10:22:26 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH 4/4] PCI: Prevent overflow in proc_bus_pci_read()
Date: Tue, 14 Apr 2026 10:45:44 +0800
Message-ID: <20260414024544.2975605-5-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414024544.2975605-1-duziming2@huawei.com>
References: <20260414024544.2975605-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)

proc_bus_pci_read() assigns the 64-bit loff_t *ppos directly to a 32-bit
integer variable. For large offsets, such as 0x100000000, this
implicit conversion could truncate the value and incorrectly consider the
offset as valid.

Fix this by changing the type of off to loff_t.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Ziming Du <duziming2@huawei.com>
Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index a5db7d23353a..f11f48becf52 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -29,7 +29,7 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 				 size_t nbytes, loff_t *ppos)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
-	unsigned int off = *ppos;
+	loff_t off = *ppos;
 	unsigned int count = nbytes;
 	unsigned int size;
 
-- 
2.43.0

