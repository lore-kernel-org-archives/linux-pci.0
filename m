Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40AC3BBFDE
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725259; cv=none; b=CU1mjB0iD9CXOvG8FEYIQV4ZoqquRoGgDrHke7rMbgtp305RcgEsahPofT9+naybCCoj7zb95VXyt6oK/1fbqoJ1ZlOw1AllWTpq3k/xdxg5yLD3P9g1GJ8eDlPKXS7kOc82PLRkgmSWJnCmLc2/prLW4X5vuc4ag4+JFTqOCWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725259; c=relaxed/simple;
	bh=M8ZYStHBPaDlJV4iE/Ttaz+6lqK7NDqa/oXH31Bd4a8=;
	h=Message-Id:In-Reply-To:Content-Type:To:Cc:From:References:Subject:
	 Date:Mime-Version; b=VI5zCYqfDj7lE55mc3tAjYXWzW/w/kZwnnNnmXvq6CqR1HW3kAsDs46VgOTZ/i8cFttEPubiS/rP41QN+NaHFhhTttTmuHuvhxtWdH+JIY1SJ57j85z4RNiB8rhU367Mn4AaJ6dWA7Jpzhucjxaes1x9m0L76jR7WdbQ4uFTlXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=NJyyJPXG; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="NJyyJPXG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782725246; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=4DtN0RAP3EGpuMNCDd5FU8AeKhCOsojX++bMHfZxsxk=;
 b=NJyyJPXGT+iEh6pMh679POndJ5eNw+iMWxJlJuKD1qeszv6o2mmQIoY4v6EkVhUzSNjktm
 pvEiBWSdHi/Wg+gqD0Mej9VCYOPjkiiTtRDfEbfjqGLNCCz1s1xI+j+pFE8/Bo7IBujl1B
 hW81lM4b+p2xbvEtTRZ2Q779ozUiuRTzHS21H3VsJoruQ5hicl8/2HB1HRWjQtRB/RVmVv
 QOIIfpVwl9ihq33cyZi2wMcA+OAkdAbUtgaJs2PLPS5ULr1u4XUwKPqWwj1J0u42iCCoaj
 RBDNwNm4e7XvY9c5VYcS2JnNqt6IYLbvvCMwpENkIuDZHjxTC5LJwZF1n6ZNFA==
Message-Id: <20260629092717.74946-2-yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
In-Reply-To: <20260629092717.74946-1-yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.118]) by smtp.feishu.cn with ESMTPS; Mon, 29 Jun 2026 17:27:23 +0800
Content-Type: text/plain; charset=UTF-8
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
X-Lms-Return-Path: <lba+26a423a7c+3fed8b+vger.kernel.org+yang.yicong@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Subject: [PATCH v2 1/3] perf/dwc_pcie: Add support for Picoheart vendor devices
Date: Mon, 29 Jun 2026 17:27:15 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
vendor table with Picoheart PCIe vendorid to enable the PCIe
PMU support.

Signed-off-by: Yicong Yang <yang.yicong@picoheart.com>
---
 include/linux/pci_ids.h  | 2 ++
 include/linux/pcie-dwc.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 1c9d40e09107..2c17239aacea 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2640,6 +2640,8 @@
 #define PCI_VENDOR_ID_SUNIX		0x1fd4
 #define PCI_DEVICE_ID_SUNIX_1999	0x1999
 
+#define PCI_VENDOR_ID_PICOHEART		0x20fa
+
 #define PCI_VENDOR_ID_HINT             0x3388
 #define PCI_DEVICE_ID_HINT_VXPROII_IDE 0x8013
 
diff --git a/include/linux/pcie-dwc.h b/include/linux/pcie-dwc.h
index 8ff778e7aec0..b0ccb2ad74db 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -32,6 +32,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_SAMSUNG,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_PICOHEART,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{}
 };
 
-- 
2.50.1 (Apple Git-155)
