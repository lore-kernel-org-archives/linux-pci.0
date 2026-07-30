Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B258379ED6;
	Thu, 30 Jul 2026 03:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785380669; cv=none; b=ifcYSXqgf/3fnD1mzPiX/rd+o6VhkgQ6HVPh0S3AWsnMSa78biWO/YpNcMqRQ7kYB4XDSLd+lhtMLsbQ6/ZAqjrOBYWaQDLIrEOPwtzwlKiAqeHB2RbYysNrwqcPnXipI6eGc92nSHjowYaJdD8UAGubCQAZJbuiSECo302Xn1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785380669; c=relaxed/simple;
	bh=+BvT3ypHlo5gLQ63sGMFZMMxT1Ti81n5uAM9nXLaLo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=goJlHjWKtW6AScBLgY7eEAKkVOpZh6shJeYz1Sdy1RESTrMtS94FIqa1Fl0TMqZ6ijJXG5qVB2Vb5yLIoagdDhw4bWZA4PI0pINVuWRcPbZ4pebAG5seu+ES1d9opuCjNLtMOJQvy6xEjMlhfCeT68WPmLL0XL/qJe8q1iMjQak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=ZFvkh5VH; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="ZFvkh5VH"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YyTugJmRvmkfeR/RtT5TTPMQpqRyjUnjmliDiwsfazo=;
	b=ZFvkh5VH7yDQvMNHCPWdJ8e7j3BJjWT7DxuHNwb6iV306vNUJrtjXrILNnlxfRIFzL5oIDoNb
	qPIDRT8bESBO5VusWvyrLNJCay9Y5x8WPcGyjTIZBG/j/SdD6NLmUblyC0hUY+orWZYWWgLKMLD
	VH7F/CHgXmNkQZXkKN1sBIk=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4h9YhY1jFvzLlXC;
	Thu, 30 Jul 2026 10:54:53 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id AA87A4055B;
	Thu, 30 Jul 2026 11:04:20 +0800 (CST)
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
Subject: [PATCH v2 0/6] PCI: Fix procfs PCI config access issues
Date: Thu, 30 Jul 2026 11:24:32 +0800
Message-ID: <20260730032438.1643450-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
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

Hi,

As suggested by Bjorn and Krzysztof, this series aligns the procfs PCI
configuration access implementation with its sysfs counterpart and fixes
issues found while reviewing the two paths.

The first four patches fix the offset truncation, inode size update race,
missing driver-exclusive resource warning, and unnecessary runtime PM
operations at the end of sysfs configuration space. The final two
patches align the procfs read and write implementations with their sysfs
counterparts.

Changes from v1:
  - Merge the read and write offset fixes and move them before the
    refactoring to avoid an intermediate signed/unsigned regression.
  - Serialize i_size_write() with the inode lock.
  - Add the driver-exclusive resource warning to procfs writes.
  - Avoid unnecessary runtime PM get/put when sysfs config access starts at EOF.

Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/
Link: https://lore.kernel.org/linux-pci/20260414024544.2975605-1-duziming2@huawei.com/
Link: https://sashiko.dev/#/patchset/20260414024544.2975605-1-duziming2%40huawei.com


Ziming Du (6):
  PCI: Prevent overflow in proc_bus_pci_{read,write}()
  PCI/proc: Serialize config inode size updates
  PCI/proc: Warn on writes to driver-exclusive config regions
  PCI/sysfs: Avoid runtime PM at config-space EOF
  PCI: Align proc_bus_pci_write() with pci_write_config()
  PCI: Align proc_bus_pci_read() with pci_read_config()

 drivers/pci/pci-sysfs.c |   4 +-
 drivers/pci/proc.c      | 124 +++++++++++++++++++++-------------------
 2 files changed, 68 insertions(+), 60 deletions(-)

-- 
2.43.0

