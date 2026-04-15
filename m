Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CB31960B;
	Wed, 15 Apr 2026 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776244224; cv=none; b=gM5p0Xg5P/3tjKUTO2p2b6jd99yw9NG/waxrVbO0GwIVKrgN5vWCJNdjCz0pcl1rfmwnl4H9Thm6OKiE861XciKi1oJjo+ty+CXGl8q35N810qXFZEHRpnCLwNbabwnzqMuV3xbmmYztlzcdIcgrBH6M5wUuI+xWDCJwFMXqLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776244224; c=relaxed/simple;
	bh=I07ruM7QYMUTqaNOCIaIU9q8CrGA0anhQtKowbWrzwQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R19x1hZSfVMqQIDmX3j7mm0eJapZmXAWvG/+H1tHG4elQEyerC8goy71BaFbaCGhXf9KNF5QcL9AZRjTDkqRs9wqKm0zMo3P4SdqGtMEERShFOHqHCUKINwfo/sGRnudAeBUjjBgfPEePdD0iWbdVGibH8+c5Vjpznm09OiBzOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hSqlaPew; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hSqlaPew"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=zPj3QyVfRmFFU7/irDZ8f9m0F5qHZGktTNjnR7dWtPw=;
	b=hSqlaPewN89PG4fFkORy38sft+2JFBSx7skY+TSq0jgGxhycJCs5m9bfFz1RmVVVu8voDGWXB
	nPExs+785Lq7QcqMMbeMs/KF3xXDaGVMyhbxIT88w+H2rv3EECSoBzz6/aOWA8GDMss+OZBriQn
	L49ViWF+HfQ+IoxyEJS/4T8=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fwZvP3hF6z1cyp9;
	Wed, 15 Apr 2026 17:04:01 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id 0AA8340571;
	Wed, 15 Apr 2026 17:10:19 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Apr 2026 17:10:18 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <alex@shazbot.org>, <jgg@ziepe.ca>
CC: <wathsala.vithanage@arm.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 0/4] vfio/pci: Add PCIe TPH support
Date: Wed, 15 Apr 2026 17:09:55 +0800
Message-ID: <20260415090959.53672-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemk500009.china.huawei.com (7.202.194.94)

This series adds support for PCIe TLP Processing Hints (TPH) to
vfio-pci, allowing userspace to manage device steering tags for
improved performance and QoS in virtualized deployments.

The implementation follows a clean incremental structure:
- Patch 1: Introduce UAPI ABI and implement capability query to
  let userspace discover supported TPH modes, ST table presence
  and size.
- Patch 2: Add TPH enable/disable with mode selection.
- Patch 3: Add interface to batch get per-CPU steering tags for
  device-specific mode.
- Patch 4: Add interface to batch program steering tag table
  entries for standard TPH modes.

All user API definitions are finalized in the first patch and
remain stable across the series. The design follows existing
VFIO conventions and relies on kernel pcie-tph infrastructure.

This series addresses the TPH management requirements discussed
in the RFC "Proposal: Add sysfs interface for PCIe TPH Steering
Tag retrieval and configuration".

Instead of introducing a sysfs interface, we choose to implement
TPH management via a VFIO-specific ioctl for these reasons:
1. VFIO is the standard userspace interface for PCI devices.
2. An ioctl approach provides better type safety, batch support
   and stable ABI compared to sysfs for configuration.
3. VFIO properly isolates TPH operations to the assigned device,
   avoiding conflicts with other kernel management paths.

Based on earlier RFC work by Wathsala Vithanage.

Chengwen Feng (4):
  vfio/pci: Add PCIe TPH interface with capability query
  vfio/pci: Add PCIe TPH enable/disable support
  vfio/pci: Add PCIe TPH GET_ST interface
  vfio/pci: Add PCIe TPH SET_ST interface

 drivers/vfio/pci/vfio_pci_core.c | 193 +++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        |  54 +++++++++
 2 files changed, 247 insertions(+)

-- 
2.17.1

