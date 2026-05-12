Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A5B4ADD85;
	Tue, 12 May 2026 08:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778575413; cv=none; b=cNHZcpdJsl+ygGfn9eMRMR2uYBqFaigY851jdvgSXL9TQv5CJkQVSwYKG+rgQa/TnFy6X5ndhax/t8y1FQtIbsne7Qdn0LylvSAuwyDF/ezbZL246BPvpKnkhjd4ABCIp+6DG0NQuX17xiXkdcG2bSt2dFk+tZ+Unp/pBCX3PUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778575413; c=relaxed/simple;
	bh=oI4YbKwga5mAud22gJRAy9x+oiS3jV+SeTUTJdgcZpo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R2lNb8S2sxp3U9UPfP2ugazcYyg01TCOJPl0C/qvwAXQhw5frd5mpkWSA/Y5AJaKLMtXJhSmY/U3XugDzbFGRI6/txdXNoiRaR2u2ALzFhjUZX06EMzIDKlTDa0yaElmhfwrpeoNqIHei5okKWLPvYqUOCqDDiO9gLgacOTz1ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=PD4Ffk/g; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="PD4Ffk/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1778575404; x=1810111404;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dKN+2ZEAVXH7CDPcSWltN5Ct4zDBfKhT15rL40JkLZs=;
  b=PD4Ffk/gREckhIgRmtpchVvRMjV+cPE25j3JUQs/VYb1SyqTuNr2NOlu
   bhiy78e75zO1oF4W9CwBl57jUyfhsyKkGg4I4zeLc9ZKCfMmcXLBPiJZL
   6Sr9vPgrSAUkc0/RpyGprZxRwdmBYGz/5H4ZZwANB4C//bD0CLhF03jSI
   l0MHZg01xB0JgJwykAqLIPkxEs6XDKtyeybIJ9If4p0Cp6y1li4fN84Gm
   UXYTAUmgUyTt/kkiqJ661o6943MW7oOpCAgkDVeFSCw05H3MC4+fSFsLk
   lhyvCRCaxyrpkQZf7/aVKkuO7XWJ1LcJaEOzY+jxz7B7daaePbZ691co6
   Q==;
X-CSE-ConnectionGUID: ELZo8o+fSpeequ03M+1Hzg==
X-CSE-MsgGUID: pr1doGV8S7GeTirC7o6MKw==
X-IronPort-AV: E=Sophos;i="6.23,230,1770595200"; 
   d="scan'208";a="19414108"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 08:43:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com [205.251.233.51:6847]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.8.77:2525] with esmtp (Farcaster)
 id 85fb1caa-6e75-469b-8614-2accbaa9e8c3; Tue, 12 May 2026 08:43:20 +0000 (UTC)
X-Farcaster-Flow-ID: 85fb1caa-6e75-469b-8614-2accbaa9e8c3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 08:43:18 +0000
Received: from dev-dsk-ravib-2a-f2262d1b.us-west-2.amazon.com (10.169.187.85)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Tue, 12 May 2026 08:43:18 +0000
From: Ravi Kumar Bandi <ravib@amazon.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ravib@amazon.com>
Subject: [PATCH] PCI/sysfs: Check IORESOURCE_DISABLED in resource mmap handler
Date: Tue, 12 May 2026 08:43:15 +0000
Message-ID: <20260512084315.32564-1-ravib@amazon.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

pci_mmap_resource() does not check IORESOURCE_DISABLED before mapping
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
index d37860841260..61ae259f8ca8 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1089,6 +1089,9 @@ static int pci_mmap_resource(struct kobject *kobj, const struct bin_attribute *a
 	if (ret)
 		return ret;
 
+	if (res->flags & IORESOURCE_DISABLED)
+		return -ENODEV;
+
 	if (res->flags & IORESOURCE_MEM && iomem_is_exclusive(res->start))
 		return -EINVAL;
 
-- 
2.47.3

