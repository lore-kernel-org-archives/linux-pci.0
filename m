Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA51437BE75;
	Thu, 30 Jul 2026 03:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380671; cv=none; b=ngCni9Hko529gd7gXxkX8qO6wOSy5HlQ9qrdn4vhZJJGFRmZBFOVyhXKxagtI5Fp9k9mQ3F8BkD4Tx+R1iYAuPWGVEuRF1wqDYZIvUyQnVjpi8EfjrmCt8IrrUFPiy41LU1tCxcGX2y5fLhsjF+7sqnU4pklC1KT2Aa48pLUCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380671; c=relaxed/simple;
	bh=EzQMPK576cqBS8//Bo8kmz07ynpLKYYpwCOKlvOIlto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DgHzsotZVE/KJ6uVYUQ0BRMnl7n3lO8oA3La9tIgDXe4Eg1VD42hQEZWOJenLtLgztJPL4DJgLJZEcsXNE7/Gtr2TyRsS4R10pglypm/ZS6mglDrh7/oDSk5E5W7HVxoKzY9ttHNepsP839br0nREbpqvbs4nXPGdyJLIiVEgss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wbHxF4yM; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wbHxF4yM"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=IbNVWubbb+ekHKwfwv7T9GZLfRiGvKjoj9Avdj30c04=;
	b=wbHxF4yMaKuiNG87R5tHAXTKFf5OOzW2wcS97EeXQoaw4jUX5CWAxQm8ctYXGpGsiDCJoJE4e
	xv8E27xm+1ZVABi/mlyrD/+FhsSON7zAz/1f55jgMOt43NXzmVGoZRgDFdSXg/bL//xwFuGgzdt
	RxmGnTpX+suxjKvsMJtZsv8=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4h9Yhc2LJLz1K96b;
	Thu, 30 Jul 2026 10:54:56 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BCAF4055B;
	Thu, 30 Jul 2026 11:04:22 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 30 Jul 2026 11:04:21 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>, <kwilczynski@kernel.org>
CC: <rientjes@google.com>, <gregkh@suse.de>, <iweiny@kernel.org>,
	<djbw@kernel.org>, <Jonathan.Cameron@huawei.com>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH v2 4/6] PCI/sysfs: Avoid runtime PM at config-space EOF
Date: Thu, 30 Jul 2026 11:24:36 +0800
Message-ID: <20260730032438.1643450-5-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730032438.1643450-1-duziming2@huawei.com>
References: <20260730032438.1643450-1-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemr500012.china.huawei.com (7.202.195.23)

pci_read_config() and pci_write_config() only reject offsets beyond the
end of configuration space. An offset exactly at the end is reduced to a
zero-length transfer after the bounds adjustment, but still takes and
drops a runtime PM reference despite doing no work.

Return immediately for offsets at the end of configuration space.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Suggested-by: Krzysztof Wilczyński <kw@linux.com>
Signed-off-by: Ziming Du <duziming2@huawei.com>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69bd..a4f6559c619c7 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -718,7 +718,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 
-	if (off > size)
+	if (off >= size)
 		return 0;
 	if (off + count > size) {
 		size -= off;
@@ -799,7 +799,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 
-	if (off > dev->cfg_size)
+	if (off >= dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
 		size = dev->cfg_size - off;
-- 
2.43.0

