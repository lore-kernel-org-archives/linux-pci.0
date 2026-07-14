Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3842701CB;
	Tue, 14 Jul 2026 21:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064025; cv=none; b=ipkCSQEsKd7uKFC4e+rPXkMoMld0F0p0ZeR3OFy7tmwXZIg6KyNfNHtqjnUuTXPvZXL9AVw7xcBPlq/3bDVgTB5PRflkS1tVR8fVS3iAW1LIH/vOVEBQtIuHwR2GPyZ0hURoePYi5UAwPaYSfD8Qr0gENMqNi5Dxd8D+TBtvaGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064025; c=relaxed/simple;
	bh=CdZnZFphkNp1YYqrIsvGLAO40Yy/hpFwGZB9OySp8wM=;
	h=From:To:Cc:Date:Message-ID:In-Reply-To:References:MIME-Version:
	 Subject; b=E0/33gfvnQNtNU4lf3N6kqZEevUX6z+SKYtDLhRX9Ow3FBxddGkCAQfRjQFrR86nyKuRZi3c6hPdZRMqVMPMQNAtDVbPh4sSED+6aLUw1vnobtoteCQolH0Jg7ttG9VfKrQXLQJ9RoX7bIe4BZ59QK2OmUpyO4aZ3LEk9RAk7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aqO61bWi; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aqO61bWi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Cc:To:From:content-disposition;
	bh=YlRvQkFmo2h5DWERnI0RBhwdJH2WAHvxSJcGNqwuKZs=; b=aqO61bWivtZtpFT5CetA8WPoAA
	My4zXS3E4xx7ID21MlcvQ3y1ClbIWtHbJcKu/PuGEw++SwONLStljKAbt1Zx7tx6yNuoCYtL5fSX/
	HFTfyLpWrnFcUMqZUOTsz/e8yvcphPexwlCLPCeoOV5fAVrNv3p+DcwmtITlhZXI5+EJziT7h4hIm
	trRbAx/FfVkvYc6fACGkWdrzENq3DVfDwKw88cJGdiCV29wzjDJzWMROHHToXrzmpDgxnAwLRh838
	O8JTAyuNuM8xcydioIKFotsZXrS0Sj7F4zmSsyqubWOb+a0McjIEpkbicsUtEvhFsrvtV/Thiz3uI
	+dUyTClQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY3-00000006f2R-14oC;
	Tue, 14 Jul 2026 15:20:16 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wjkY2-00000000xzs-09Mw;
	Tue, 14 Jul 2026 15:20:14 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Frank Li <Frank.li@nxp.com>,
	Kelvin Cao <kelvin.cao@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jul 2026 15:20:09 -0600
Message-ID: <20260714212010.230606-3-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714212010.230606-1-logang@deltatee.com>
References: <20260714212010.230606-1-logang@deltatee.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org, bhelgaas@google.com, Frank.li@nxp.com, kelvin.cao@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH v1 2/3] PCI/switch: switchtec: Add PCI1008 device ID
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

Add the PCI1008 device ID to the core switchtec management
driver's PCI ID table. Without it, the management endpoint on a
PCI1008 switch is not bound by this driver, preventing userspace
tools from configuring or monitoring the switch and leaving NTB
functionality unavailable.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 41fc4b512708..5711aaa5df11 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1874,6 +1874,7 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI100X_DEVICE(0x1004, SWITCHTEC_GEN4),  /* PCI1004 16XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1005, SWITCHTEC_GEN4),  /* PCI1005 16XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1006, SWITCHTEC_GEN4),  /* PCI1006 16XG4 */
+	SWITCHTEC_PCI100X_DEVICE(0x1008, SWITCHTEC_GEN4),  /* PCI1008 16XG4 */
 	{0}
 };
 MODULE_DEVICE_TABLE(pci, switchtec_pci_tbl);
-- 
2.47.3

