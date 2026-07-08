Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D7403E85
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500322; cv=none; b=JzSgv+slvbNpEo5dQAB9a1b8NeM9aH/NBCtymvIIW4m2uxf8NSFJwhEcurqiaDP3Re1PX1sD6WBzG8KnsIaFmkNk1IzrIIir7DWBG1BrX63QxXHQVriWneRyuJn7g7REalpzOa26zLVdSsCmPf+ZetqtlCMmodyGwo7A4w4A/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500322; c=relaxed/simple;
	bh=2w5to60u5/U6uPBI/jN/szCIjDNAxdnIcM4804no7uA=;
	h=Message-Id:Content-Type:Cc:From:Date:Mime-Version:References:To:
	 In-Reply-To:Subject; b=LLqWy2PTwMT8i0IY25M+wyorwsexYolJEe4W5kuLycPX6XZTX3WDO9pEnOAC/RNvEcfwgEUUMuMKuvlnoNZRJzAWGpfCNW83zxjtmi3ejZ8WsykddGvzus/SO7fRyprJwLg+19cRYotSXL+ijBAMSXsu/vD0N6QQhL28Uq5mWu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=VwdJxzi/; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="VwdJxzi/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783500315; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=7o8TBtJip9ZbjPmZ+w6tJTy7FiTYdegsFo6xEm6cakE=;
 b=VwdJxzi/VBSr3X3yf4+S75Pd377nNTLJL/XB83208si7q2LxtRMdEjF+EX31fifpEfR8G7
 TKQPeQbByANhTVtJCXZXDPgyf8F6LDVGpEV5FCqEjjuv4c0sJYUOp9RDwhSWuLGRFUlWO3
 RuqF+x9R0oTWiz/KhyxseU+dc8KjKp7eQgVxL1RwQ37NzOfnWbc/0+80ExZOQP8+bKadG3
 OHk0iCWd8prOpsKMuHfa3qG1rVIbQxaKFp70g9VxRYrjJTKcVmPM0KpOozMS6XRYKs/bqv
 llDE2Ar/LIml672Req8yV8uzyNnE+CYKzrhARsK0akn+ZKXBrhaLaIKF66QXpQ==
X-Lms-Return-Path: <lba+26a4e0e1a+3b96d1+vger.kernel.org+yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
Message-Id: <20260708084507.98242-2-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=UTF-8
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Wed,  8 Jul 2026 16:45:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.112]) by smtp.feishu.cn with ESMTPS; Wed, 08 Jul 2026 16:45:12 +0800
References: <20260708084507.98242-1-yang.yicong@picoheart.com>
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20260708084507.98242-1-yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Subject: [PATCH v3 1/4] perf/dwc_pcie: Add support for Picoheart vendor devices

Add PCI_VENDOR_ID_PICOHEART in pci_ids.h. Update the DWC PCIe
vendor table with Picoheart PCIe Vendor ID to enable the PCIe
PMU support.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
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
index 8ff778e7aec0..d3cd701a58e3 100644
--- a/include/linux/pcie-dwc.h
+++ b/include/linux/pcie-dwc.h
@@ -26,6 +26,8 @@ static const struct dwc_pcie_vsec_id dwc_pcie_rasdes_vsec_ids[] = {
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_AMPERE,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
+	{ .vendor_id = PCI_VENDOR_ID_PICOHEART,
+	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_QCOM,
 	  .vsec_id = 0x02, .vsec_rev = 0x4 },
 	{ .vendor_id = PCI_VENDOR_ID_ROCKCHIP,
-- 
2.50.1 (Apple Git-155)
