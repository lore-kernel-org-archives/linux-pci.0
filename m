Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E6C331A4C;
	Sun,  5 Jul 2026 09:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783245260; cv=none; b=U7JeQz690BZRzYcO2OjxVEA2/LbSLtvSi5gQr0hWInx84l37Zim5lEzcqFMXYrA+5IdqXY5xmgm5A3AHAQqqUPnnqQwpiP30VpPI48B6vQdpitq8yf6z7/i/pvRwtQ0SmlGg0vELuYzR7HkfotNlFKM/XKKx+fF8DF8b8vf910g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783245260; c=relaxed/simple;
	bh=JT0pI87OYe1GRsupwo9YuQJhpqhXP9NAWtDRLFZWHwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uW4SN20lDmJPYGSFKs7PevfidjjceWiFapTAEHtx5HTjk7NdR/WUmnfs3cMBnLO7eTTTNbd5Hnnc9e60MGDcZ1ELTI/5PMSBN/OJDmZRcH9Ux7EZ0wtQFZhcNTcjnqdm7vaY3BJ5VOLx68HOTpMELeHG8QHzXJGTMRSdmsvH7Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK52OfRq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK52OfRq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5655B1F000E9;
	Sun,  5 Jul 2026 09:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783245259;
	bh=g5uDqeaXR+9EOCsj/jzdB0jVUtw1/KaVPNerJIIi4PM=;
	h=From:To:Cc:Subject:Date;
	b=XK52OfRqK5nX9nTO9l22DYCd+il7L+upXvtS0uYx2S68ENA1XaDffp28VkEJICMqj
	 R278WU4hJBku/i+sU37Wf+3VMcJDtZXGqdVkFDZIc2bT7sbTGZHldiFql+vA2w5mWJ
	 /LIAEGpt3q3wG3boa+NWHcRSIHiIDoesnMrjxglJzfaqsQ4ks8BUz1aOyZcLc3/1v6
	 hUy4A26ClhSv9AUbBX35EzbKx3aaiisXm9V9crhAmyPTMjiGrAZrkKEhcunL7DH7N3
	 pD4E2C0ERfzQTXaaUxzzHPWvaPNpszuF53l5goN9aThg4GxizgivSCPBi+DzVsRD+N
	 aIkeSVZOkKcjg==
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Add Nvidia Vera Rubin device to P2P whitelist
Date: Sun,  5 Jul 2026 12:54:07 +0300
Message-ID: <20260705-p2p-vr-v1-1-3cd45cab3fb4@nvidia.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20260615-p2p-vr-514bd262a839
X-Mailer: b4 0.15-dev-18f8f
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Nvidia Vera Rubin platforms support PCI peer‑to‑peer transactions.
Add them to the P2P whitelist to enable this functionality.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/pci/p2pdma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b2d5266f8653..9334eb314663 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -564,6 +564,11 @@ static const struct pci_p2pdma_whitelist_entry {
 	{PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_QAT_6XXX, 0},
 	/* Google SoCs. */
 	{PCI_VENDOR_ID_GOOGLE,	PCI_ANY_ID, 0},
+	/* Nvidia CPUs */
+	{PCI_VENDOR_ID_NVIDIA, 0x2f95, 0},
+	{PCI_VENDOR_ID_NVIDIA, 0x2f96, 0},
+	{PCI_VENDOR_ID_NVIDIA, 0x2f97, 0},
+	{PCI_VENDOR_ID_NVIDIA, 0x2f98, 0},
 	{}
 };
 

---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260615-p2p-vr-514bd262a839

Best regards,
--  
Leon Romanovsky <leonro@nvidia.com>

