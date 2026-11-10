Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305408;
	b=Nb9vsOPWbQUBWRp5HJo5LzQbhA8PS5fpaeJRoXEtT9Zdz2oCOtW9oOEj2IcBXkl5mwjn
	 LhVaVbo+KiqrL6ImioISWGjWHG7irKU46aN1PIrOwecvZ0tuPvE04MBkZJeBDaAfF872Y
	 dJki99aqauSmRG4TAmNVCgFea0ucBaQjyruf9T2GePnqQ99Az5UnoLmxGHJA7IcJ2RBB+
	 zJIVDmzZns2rGwfageq2AWwckrW3QkHyIqVkCzk0AeuPfxOpZ//Ln98egL2EJu9t5KU+0
	 ZbM7ap+ZkRumZZH21He6e/ik0t9eO36aAG52DVliUkeIjkCAVahzVTrZXA0HoCeHSYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305408;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3THZAJnDlKPN9gcQz4s+0XJUgVRIYSdn+ifFET53YiY=;
	b=b482cJTsVVU13fofbpV07MX+HpGuOiW/cnHlL1/JHyPpQU4+sESDRnYA/CCRRxU6qJK4
	 +3JBLaitSgsJVmrk4Fh6b5skjdN1qob/B3k7TgTA/FsOH0/GdRGZZRJN4sSzG7HmRey1X
	 cIhA6Tbb0c9NIuZf4ROL3nGPTtIzVyY2cDYct8H0th5pFhg2pxTCq1RUFemvp6TO/bjur
	 me5whmX1p/XWyYG7TnQQ4C4rF021DUvqN9r9QWm9L2h8VexPpjVLm+u3UTfs6enXIuiYu
	 WdDYhcXziMX+tOE3bxgfgeNLBDaVCNP2lvBh78dKGDetz7DuXWuzxIpAsm1jxyli87Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rJBPYru8;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2D7606A32A;
	Tue, 10 Nov 2026 10:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D2D7606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=rJBPYru8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=rJBPYru8+0VHSsLm/aJRqvkUcYkdPjqXQ/v7N8vZ88jt3untvz7WkAPKk5YcVum2dKSPXlQNOb3ia
	 Rwx2c8HefowT0GWAj7Fh7GXCGOlmCGfDje4xbm9JA2/6Vsm3+5HbGHeDJERnSvB4nO914GTxBXQz3u
	 tV/yccPWpPfaoNWI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66af2ed76570-9b116;
	Tue, 10 Nov 2026 18:09:59 +0800 (CST)
X-RM-TRANSID:2ee66af2ed76570-9b116
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af2ed74c04-b1a90;
	Tue, 10 Nov 2026 18:09:59 +0800 (CST)
X-RM-TRANSID:2ee46af2ed74c04-b1a90
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] PCI: keystone: Fix device node leak in ks_pcie_set_mode()
Date: Tue, 10 Nov 2026 18:09:53 +0800
Message-ID: <20261110100955.1046-3-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
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

ks_pcie_set_mode() resolves the "ti,syscon-pcie-mode" phandle with
of_parse_phandle_with_fixed_args() to obtain the mode register
offset, which takes a reference on the syscon device node, but the
reference is never dropped after the offset has been read from
args.args[0], so the syscon node is leaked on every probe.

Drop the reference with of_node_put() once the offset argument has
been consumed.

Fixes: 7dcf07ac8867 ("PCI: keystone: Use phandle argument from "ti,syscon-pcie-id"/"ti,syscon-pcie-mode"")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1027,8 +1027,10 @@
 
 	/* Do not error out to maintain old DT compatibility */
 	ret = of_parse_phandle_with_fixed_args(np, "ti,syscon-pcie-mode", 1, 0, &args);
-	if (!ret)
+	if (!ret) {
 		offset = args.args[0];
+		of_node_put(args.np);
+	}
 
 	mask = KS_PCIE_DEV_TYPE_MASK | KS_PCIE_SYSCLOCKOUTEN;
 	val = KS_PCIE_DEV_TYPE(RC) | KS_PCIE_SYSCLOCKOUTEN;


