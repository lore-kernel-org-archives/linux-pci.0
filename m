Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7937F8D7;
	Thu, 30 Jul 2026 03:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380674; cv=none; b=CQAe7qBlX7UvmQbhewirkWyDtjoBo1NiUd8MOU3xepXoTrAR+loomcBRq4Bcz5/bCFFj+qaYry7Ir0mNcZxl2idGtQmbtJu0iUGybkKSdNLfgj/c/NZIfPs/sxboL2sLNAF2qjU05cM24TUIUlza2QzspI9Q+yCJ1QBLkfwCmh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380674; c=relaxed/simple;
	bh=P07iGtJTQboZJgFo+jFMBcEGCIJOY9zGZ30WoQI7/hM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=umYiGGLg/NL5nd9eEKW9a6LZXMYFYeFk1ApyiZfqIY1QYYQLyKgmmBbSZuG2aP8VpqcxJkJkyhek9SGu3VCwvUBbeQsHIw/85LIoqo11aUsPmOsPDTheBJJOnlHVSCEoR+2gyW8Z9Wq1kxwYLgVARhkLg4zJVZRUJFW3838EoG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pbmWR7pj; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pbmWR7pj"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qKd/4+2oBB4prIc7Zj+KD9zVsfzeJp4GB4gLdal/veA=;
	b=pbmWR7pjcdaxduhGvfPsz3GUACfgXy3pv+++ryMQu+9bvEwwE75G7xwQS4bOumGkv6ra2xwu5
	EU17UCSq4ZtvvrYZoJPi3BxD2z3pl8i/Rhe7h6FDuKyzdAsEy08nrTTbK7Lbz2WrrXy+N9J+KXT
	w8TULmhWA1zRmBV+tzT+1Ms=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4h9YhG4cKdzcb3L;
	Thu, 30 Jul 2026 10:54:38 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 8E8322025F;
	Thu, 30 Jul 2026 11:04:21 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 11:04:20 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 2/6] PCI/proc: Serialize config inode size updates
Date: Thu, 30 Jul 2026 11:24:34 +0800
Message-ID: <20260730032438.1643450-3-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730032438.1643450-1-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

proc_bus_pci_write() calls i_size_write() without serializing concurrent
writers. On 32-bit SMP systems, concurrent updates can corrupt
i_size_seqcount and make later i_size_read() calls spin indefinitely.

Protect the inode size update with the inode lock, as required by
i_size_write().

Fixes: ecb3908046ce ("pci: write file size to inode on proc bus file write")
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/proc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index cad749924dd89..ec2338c1e667e 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -181,7 +181,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	pci_config_pm_runtime_put(dev);
 
 	*ppos = pos;
+	inode_lock(ino);
 	i_size_write(ino, dev->cfg_size);
+	inode_unlock(ino);
 	return nbytes;
 }
 
-- 
2.43.0

