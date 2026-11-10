Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294589;
	b=nZXfUcB/DZyXko0IfB3KVMM6EpD31RMFqc9H8N7yqxg7RIa8uwNpByDo2eyJYfO5cR75
	 vvkdVGb5d872tltOZUPwFyJb5mmkV21ArvxIo7z9JDvSgRbGulFFxXDv/jCm5zLHcoWUk
	 hjYOVb/TGZYmdu+eiOk2ykFZ5lVNyyzlO7H7WL1g6gSPNsZWSyW7XO+MaqdivNnjFmGgo
	 GnLMHLfWNyzZ3vJ6v//Mx2DyiFcognOyq3R9GYWEVyQczsqj0oi2+G+PL6unQiJRtW96a
	 /Eogne+NMya0yescuDKYjxMBXirZDcG2vyJInhRWq7Qi9aa7PpXLTXAojlhft6NfrXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294589;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=rx0/LH5qhAA2LG3lvtKGfFdTSz5VzXRoPpDdNhgNQgM=;
	b=L3A68mnSucmfjmG5MIVZTqLtTD/GEHtiVKV0wgOGEJ11/o2/jlgAJae6R97N9JizZfAu
	 nwi8hPvz4zQkxhQ2W226d/RK/wfQpyN3BgAdNhfXCZWu2+m+iMyuN1OqhiaHX4YtgEJnS
	 /T4YptDL7v0KthZqkCxicY/9NhtvDYvfYWCDiFKBaP2T46O4N1oRMYanuneDeB3a97Kk1
	 vfS152PR/A1Fv58bOxpyZk2ayKMqXrC21VmQ81O7qA6D4epaB+bVlnoR9rljvzF8jMwbB
	 sjizKp8qsmL9Yz739ZaJYANXXod/4OU9zW5SMnx9j08UmfTzNWnzzWYtZZAafbTxGzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=elYXt2+P;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA598606A325;
	Tue, 10 Nov 2026 07:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA598606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=elYXt2+P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=elYXt2+PVZu4mteSl0xDz+UMnjiGWcATpmBNLR1cftuzGMG0NwV/QUP/U1TP3S3OOn6tF/nFw+r8V
	 QiyYTmxlgyV15t9FEMlaYqweoDw5tWk4VklpfyGAIJI7LpzmGn05R96EhM9X8G7LJF5IrCnFCVsfbo
	 EPIK0gGR0G1R4Yhs=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c339260-c97d0;
	Tue, 10 Nov 2026 15:09:46 +0800 (CST)
X-RM-TRANSID:2ee56af2c339260-c97d0
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af2c3377a6-ab661;
	Tue, 10 Nov 2026 15:09:46 +0800 (CST)
X-RM-TRANSID:2ee96af2c3377a6-ab661
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/2] PCI: j721e: Fix OF node reference leak in j721e_pcie_ctrl_init()
Date: Tue, 10 Nov 2026 15:09:42 +0800
Message-ID: <20261110070944.996-2-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

j721e_pcie_ctrl_init() resolves the "ti,syscon-pcie-ctrl" phandle
with of_parse_phandle_with_fixed_args(), which takes a reference on
the resolved device node, but the reference is never dropped.  Since
j721e_pcie_resume_noirq() re-invokes j721e_pcie_ctrl_init() on every
resume, the device node is leaked not only at probe but again on
every suspend/resume cycle.

Drop the reference with of_node_put() once the offset argument has
been consumed.

Fixes: 7aa256234c4c ("PCI: j721e: Get offset within "syscon" from "ti,syscon-pcie-ctrl" phandle arg")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -274,8 +274,10 @@
 	/* Do not error out to maintain old DT compatibility */
 	ret = of_parse_phandle_with_fixed_args(node, "ti,syscon-pcie-ctrl", 1,
 					       0, &args);
-	if (!ret)
+	if (!ret) {
 		offset = args.args[0];
+		of_node_put(args.np);
+	}
 
 	/*
 	 * The PCIe Controller's registers have different "reset-values"


