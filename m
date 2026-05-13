Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4784134DCE3;
	Wed, 13 May 2026 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778645627; cv=none; b=cXMWmikVaP7nzrf8FgPvfyawCi0/FSckvmfHqzDkjempzU3wCTFeQF1WGHGEKi0vDKIjWV5wHqb4hYIXQjk6NYZ8ZqqS7POekqeLGSqHvr6oGdKQSYac8dfd5wPinIgVEfsonbfUa7sOTevH5CjuL5g+tTKuLCrNcvBleO0/i5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778645627; c=relaxed/simple;
	bh=K3hvB9fLQwEw2xVdBUs65ubLt508ojRUBv+xEHUgaK4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DoEppKI8n391QRJY61FaHwfIeHzT6MEg5xWbVD1Q+dkH44uky25uwR4Cbvzj6lnK3ww+qrVZwGL9PG5oWW1ORIH4zPExEqVVGTnyYbN2GJhYEJyvl7+fV/GuJhtUSbHmi2G7GYcxRhdLm4m+xzF7uRlql2fTnuh23UPBm9y/bMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=TFDWDx64; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="TFDWDx64"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778645626; x=1810181626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ah3cGmdxUquVZwb4HjqZ6FMc2kUwi/RScc7qdhhywBI=;
  b=TFDWDx64lomMjRdY0b9bpulnK83nUvuBhhbGWGd8TGA40KIi+gvzJsqM
   bvNEjW/tQxxtZ7llMgtPFXvVid1XJ/FlGStzi6XPLcrxHuUJ3pXQQVBIv
   JhCaWtEp0UCk+CWm1w+KDzszblwZXGGhcwcPvrKl3Qf8gfbCDv0E5NaAj
   Obym6GvbsxoqqvFI8+v1/JNdl+MqsqAfjJZn70/DBuunouyK10Yj1WlNB
   TcTRxjUhz6hPlVVW0NB9sPbg5Dg/EiRe/+sXuXoO3xovr2fb0DcucX72t
   OOTwxl+dIwUBIZocQcQmh4NGtKfwfRZQnLpyRPri2WjHR2WLJEfc6GJHs
   g==;
X-CSE-ConnectionGUID: 9tEWjWGYTaW8GfGAvUpj/g==
X-CSE-MsgGUID: HZZ3ET5eTISsmPe3GQaOQA==
X-IronPort-AV: E=Sophos;i="6.23,232,1770595200"; 
   d="scan'208";a="19497983"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:13:45 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:27159]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.132:2525] with esmtp (Farcaster)
 id 8cffdc27-fff1-4184-a0a3-dac8f8b0addf; Wed, 13 May 2026 04:13:45 +0000 (UTC)
X-Farcaster-Flow-ID: 8cffdc27-fff1-4184-a0a3-dac8f8b0addf
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 04:13:44 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Wed, 13 May 2026 04:13:44 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: <ravib@amazon.com>, <kwilczynski@kernel.org>,
	<ilpo.jarvinen@linux.intel.com>
CC: <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: [PATCH v2] PCI/sysfs: Check if device disabled in resource mmap handler
Date: Wed, 13 May 2026 04:13:32 +0000
Message-ID: <20260513041332.24105-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260512084315.32564-1-ravib@amazon.com>
References: <20260512084315.32564-1-ravib@amazon.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA003.ant.amazon.com (10.13.139.31) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_mmap_resource() does not check if device is enabled before mapping
a PCI BAR resource into userspace. This allows new mmaps to succeed
even after a device has been marked disabled or soft-unplugged by the
driver to prevent further access.

Add the check to return -ENODEV when the resource is disabled, blocking
new userspace mmaps of BAR resources after device removal.

Tested by marking the PCI BAR resource as disabled and verifying that
a subsequent mmap attempt fails with -ENODEV.

$ sudo python3 -c "
import os, mmap, errno
try:
    fd = os.open('/sys/bus/pci/devices/0001:01:00.0/resource0',os.O_RDONLY)
    mmap.mmap(fd, 4096, access=mmap.ACCESS_READ)
    print('mmap succeeded')
except OSError as e:
    print(f'mmap failed - {e}')
"
mmap failed - [Errno 19] No such device
$

Signed-off-by: Ravi Kumar Bandi <ravib@amazon.com>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..83d580256c4b 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	if (ret)
 		return ret;
 
+	if (pci_dev_is_disconnected(pdev))
+		return -ENODEV;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-- 
2.47.3

