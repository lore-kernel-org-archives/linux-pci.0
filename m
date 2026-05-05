Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3D5EEBB
	for <linux-pci@vger.kernel.org>; Tue,  5 May 2026 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778000506; cv=none; b=JN+GL378unm18HQaqnpiyGJzElPRpbUOz/8+w3jlh7uR8NFqG85cmIT8jdVbaDWqJjkrrZWeT+/3wAYu1z2Vyp/F3bYqYtuQ5vFik2dDoHv36V9P3t2JMcROPXP2CBXEOWGYBCV1wO08GcVaBuYcNkJ9UNUNyeLCtxPIS2QadAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778000506; c=relaxed/simple;
	bh=zwtyq6+qvtNX9cdXbfemb/bQl1AI50jZLJzxr6mCDNA=;
	h=From:To:Cc:Date:Message-ID:MIME-Version:Subject; b=VCzrGham2fvFFRMO1038QOoaeWxUMoD1MeKzYz0OU71SqDqAHpC2ozywKXc/g5UQ1dXCfdVJKx6Pbv6V/8CpxXcpgONJnNtlKzSnGANqOe4R4duiBAKDG+eJ6cgM9qt4Lrw//k1GkLiInQWtwkpKp19rS6kUjrpsIIzqbCIzoek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=QJ1+HtxR; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="QJ1+HtxR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-ID:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=DXBN9KuhQFJPp/bSu0RLNcwsyFND+T9tCfJBNjAdeo8=; b=QJ1+HtxR7nAGaJZdzKEIEgUG6R
	SxyBp3jXWWo6GXJqDhuXzemouogehiqy/Uz4qYEHU7XS0R8zfjON5AototBrcIo+4ItwYit3bmWzc
	riq/DvdwYTbDB2135zqWGoxHqE0E+MkV9UY++4frszfbVCEcuXIEqfTOl29MTUKvyraJ1YM47GpsW
	V/KMEdcLozLSlGrjXkO++xcsPnTz+B/RIV+dRtMDnQF9E65FpcrJ4SyHuyspOP3Dj+IPlgAsP94KF
	I0M0w5Sk4HIg70dxCmMxsg7aQ2gjhzvMc3LFsq/JWR2saLXX7vXwGrCwFD9OO6jHgGCZK/EASdkxv
	1n/DRF9A==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wKIRp-00000000tmm-22jx;
	Tue, 05 May 2026 10:16:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.98.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1wKIRo-00000000HYB-16xN;
	Tue, 05 May 2026 10:16:36 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Kelvin Cao <kelvin.cao@microchip.com>,
	Ben Reed <Ben.Reed@microchip.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Tue,  5 May 2026 10:16:33 -0600
Message-ID: <20260505161633.67454-1-logang@deltatee.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, bhelgaas@google.com, kelvin.cao@microchip.com, Ben.Reed@microchip.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Level: 
Subject: [PATCH] PCI/switchtec: Add Gen6 Device IDs
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)

From: Ben Reed <Ben.Reed@microchip.com>

Add device IDs for the next generation of switchtec products.

No changes to the driver were required with the new version of
the hardware.

[logang: rewrote commit message]
Signed-off-by: Ben Reed <Ben.Reed@microchip.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 16 ++++++++++++++++
 include/linux/switchtec.h      |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 93ebec94b763..41fc4b512708 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1852,6 +1852,22 @@ static const struct pci_device_id switchtec_pci_tbl[] = {
 	SWITCHTEC_PCI_DEVICE(0x5552, SWITCHTEC_GEN5),  /* PAXA 52XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5536, SWITCHTEC_GEN5),  /* PAXA 36XG5 */
 	SWITCHTEC_PCI_DEVICE(0x5528, SWITCHTEC_GEN5),  /* PAXA 28XG5 */
+	SWITCHTEC_PCI_DEVICE(0x6048, SWITCHTEC_GEN6),  /* PFXs 48XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6064, SWITCHTEC_GEN6),  /* PFXs 64XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6044, SWITCHTEC_GEN6),  /* PFXs 144XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6060, SWITCHTEC_GEN6),  /* PFXs 160XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6148, SWITCHTEC_GEN6),  /* PSXs 48XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6164, SWITCHTEC_GEN6),  /* PSXs 64XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6144, SWITCHTEC_GEN6),  /* PSXs 144XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6160, SWITCHTEC_GEN6),  /* PSXs 160XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6248, SWITCHTEC_GEN6),  /* PFX 48XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6264, SWITCHTEC_GEN6),  /* PFX 64XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6244, SWITCHTEC_GEN6),  /* PFX 144XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6260, SWITCHTEC_GEN6),  /* PFX 160XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6348, SWITCHTEC_GEN6),  /* PSX 48XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6364, SWITCHTEC_GEN6),  /* PSX 64XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6344, SWITCHTEC_GEN6),  /* PSX 144XG6 */
+	SWITCHTEC_PCI_DEVICE(0x6360, SWITCHTEC_GEN6),  /* PSX 160XG6 */
 	SWITCHTEC_PCI100X_DEVICE(0x1001, SWITCHTEC_GEN4),  /* PCI1001 16XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1002, SWITCHTEC_GEN4),  /* PCI1002 12XG4 */
 	SWITCHTEC_PCI100X_DEVICE(0x1003, SWITCHTEC_GEN4),  /* PCI1003 16XG4 */
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index cdb58d61c152..724da6c08bf7 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -42,6 +42,7 @@ enum switchtec_gen {
 	SWITCHTEC_GEN3,
 	SWITCHTEC_GEN4,
 	SWITCHTEC_GEN5,
+	SWITCHTEC_GEN6,
 };
 
 struct mrpc_regs {

base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.47.3

