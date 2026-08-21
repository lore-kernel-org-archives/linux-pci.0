Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5649505D
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320017; cv=none; b=TOWeVPlPBl7PJKCdOMqiQN+MgOs3AkzKjOaiLYrwtaun+mfawaEwlKp8sv/x+1Q//cnZUfOhy+sFkSGMNyoardc6L5ZwsNMDKcvZppzA1/NUQQOm/PfABbgPkp/ixxkc/h3mZvgE4N2icVME3+JqdRXIqrzKydblpbiNAaG57Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320017; c=relaxed/simple;
	bh=4GRZrykve3DYCt54SQMhbFYoS+0wHD0ES1uEWUPPGeY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GejLp5L1JKpFSns9qm3Lnh/D0QL3sfenMSQ3cCV+16y5vS3yvJFf6QaRvDApFVEzr8SsnVhzORUXdw24pVrVQWz4lNEV+FXsf8U8x8wt4hE7+5EDzUZkBNXlWMASTcNfYNfM36TFgQYNLSJ2sam2vScMDnS5rbXhc17ZGQcy4kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4VDARST; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aniketmaurya.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4VDARST"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc86a9ef97so20045985ad.3
        for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 06:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787320012; x=1787924812; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3j6lgpgnueDnnXaUVeKFBE+wmpz2Lu0oRIsQW+ixGBM=;
        b=W4VDARSTbgpiCzIHcnzGtsXoT5+LWDxvzXo+HB+Cdlr9AOdf306QllTULF5tb+LDua
         xltYVYLdtLMg7gko0Cum5iarKdw/4AJUY+j1fgle0I362BreTXWbCGN+q8feqWPnqspD
         HM61VjKFWZIsVi87X5l+v3tkga/ZG/DuNrAGYow+yscdbZIJrlZzNrZpLibCpI8GVoTD
         8HQgktw9/LxTlDFh/VGVI0/mTqnM3PN0CkmJyBaA7Zi+DQxHs+QwokUCMLb1KDNdGEOv
         kSWHYpfV7JxJZgRNVRW1t4pSj6+eEnhYkc4UbmuWdBtiQmkU05TdJ0szKDdzbXlOlvyw
         wccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320012; x=1787924812;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3j6lgpgnueDnnXaUVeKFBE+wmpz2Lu0oRIsQW+ixGBM=;
        b=Vk0IeB0ytAmlVAT2th9OeEeQ87ueNSH2cndy/Cmk2xxyFcgkATTeWuNIE333tkeEVD
         p0dki9blSIoMK5uHMxIrPsnP1SZlvWOFofIVSYMQ/pjWAbgp7QsFvZrvGEtGrWZdalEy
         0ui8qOXYT7ZIq7sm2fdM4cFcMxgwnN4N4423gkwHeaN4wdB+Vo2pLjmwcb/P3S3WwO4u
         qFDfUx7kqf/Zk8NFEYYbbdGsRgaqUxWJVTvQAcRQbjiq4Diwmjbl6M7507SMFdZB6l0z
         prlPQfvTzwv+a5Cjco1t73cA0UIi5jImgHDQHmu4WFk/hM9FOPP8hD5j74dHxLEIzrwy
         TyKw==
X-Gm-Message-State: AFuF++n+2Cubj0aa7BwR1+n7dpKaR3XmbCJ+VoXdgdY2ydk/7JeYwRHS
	7LPztQDBsIKJcKtHalirICLTQR4qabOJgYNB8S852pMKA0GipxELNmwsEd3PRcvwLbeZqaSrl+W
	s+kYQMXtEtSGHLlMSyWcfFcmtIXiImA==
X-Received: from plbbh3.prod.google.com ([2002:a17:902:a983:b0:2d3:a560:c1f7])
 (user=aniketmaurya job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2c0c:b0:2cf:8131:75f4 with SMTP id d9443c01a7336-2d64b036898mr132058755ad.11.1787320012023;
 Fri, 21 Aug 2026 06:46:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 13:45:21 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260821134521.2211943-1-aniketmaurya@google.com>
Subject: [PATCH v2] PCI/ASPM: Clear L1SS capability when L1 latency is unacceptable
From: Aniket <aniketmaurya@google.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Lukas Wunner <lukas@wunner.de>, 
	"=?UTF-8?q?Ilpo=20J=C3=A4rvinen?=" <ilpo.jarvinen@linux.intel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Manu Gautam <manugautam@google.com>, 
	Ajay Agarwal <ajayagarwal@google.com>, Aniket <aniketmaurya@google.com>
Content-Type: text/plain; charset="UTF-8"

pcie_aspm_cap_init() initializes link->aspm_capable from
link->aspm_support, which includes PCIE_LINK_STATE_L1SS (L1.1, L1.2,
etc.) if supported by both ends of the link.

pcie_aspm_check_latency() then evaluates whether the exit latency of
the link exceeds the acceptable L1 latency advertised by downstream
endpoints. If the latency is unacceptable, it clears
PCIE_LINK_STATE_L1 from link->aspm_capable. However, it does not clear
PCIE_LINK_STATE_L1SS.

L1 PM Substates are substates of L1 and require L1 to be supported
and enabled. If L1 is not capable due to unacceptable exit latency,
L1 PM Substates cannot be supported either. Leaving
PCIE_LINK_STATE_L1SS set in link->aspm_capable causes
aspm_ctrl_attrs_are_visible() to expose L1SS sysfs control files (e.g.,
l1_1_aspm, l1_2_aspm) even though the link cannot use L1/L1SS.

Clear PCIE_LINK_STATE_L1SS along with PCIE_LINK_STATE_L1 from
link->aspm_capable when L1 exit latency is unacceptable.

In addition, update pcie_config_aspm_link() to check link->aspm_support
instead of link->aspm_capable before invoking pcie_config_aspm_l1ss().
This ensures that pcie_config_aspm_l1ss() is called to properly clear L1
PM Substates in the hardware configuration registers if the BIOS left
them enabled, even when link->aspm_capable no longer contains
PCIE_LINK_STATE_L1SS.

Signed-off-by: Aniket <aniketmaurya@google.com>
---
 drivers/pci/pcie/aspm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 172783e7f519..b2660892972a 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -666,7 +666,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
 		latency = max_t(u32, latency_up_l1, latency_dw_l1);
 		if ((link->aspm_capable & PCIE_LINK_STATE_L1) &&
 		    (latency + l1_switch_latency > acceptable_l1))
-			link->aspm_capable &= ~PCIE_LINK_STATE_L1;
+			link->aspm_capable &= ~(PCIE_LINK_STATE_L1 |
+						PCIE_LINK_STATE_L1SS);
 		l1_switch_latency += NSEC_PER_USEC;
 
 		link = link->parent;
@@ -1041,7 +1042,7 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 		pcie_config_aspm_dev(child, 0);
 	pcie_config_aspm_dev(parent, 0);
 
-	if (link->aspm_capable & PCIE_LINK_STATE_L1SS)
+	if (link->aspm_support & PCIE_LINK_STATE_L1SS)
 		pcie_config_aspm_l1ss(link, state);
 
 	pcie_config_aspm_dev(parent, upstream);
-- 
2.55.0.766.g2966f0265a-goog

