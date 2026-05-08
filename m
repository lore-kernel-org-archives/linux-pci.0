Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778682F531F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 03:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778210309; cv=none; b=ECLISMlL6ZlYVGVCzR6dLKrLIwlbl4ST6DVIKKMW1wehVIvnlkixtjL9BCp7PmGIuVslRYO6p1K5EkJ+DrruEAXfvYnx0VoxAa3qNAh75CW/tPB08SJ4tATTKWThE+i4zbcC7Cq8+5AHyie/a0eeUkwDx55UP43L2ximePOzKoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778210309; c=relaxed/simple;
	bh=L++LTy00lMS0Z9lJGdmdFlMR2op6hVxOgn4kFHOj63g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux0sGKxuTDAeuqiO0xC1tfC+KMbNg8+ZCoNxbzfBHkfmSkYDDlj6jKR4CJSkOFmyglXr6bnZwYt2v0bz+4tHQiEP8BjeDgqn7AQF4FWSlKkqxBX71WoRkXperBlHVCW1/l2LE74X6PL1DMuUfJKhdopdWlfRCh0tKEFQhK8eZrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luJNN9US; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luJNN9US"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3660daea6a5so739855a91.1
        for <linux-pci@vger.kernel.org>; Thu, 07 May 2026 20:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778210305; x=1778815105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaECM3afZbtSVstcoN8c/Bxd1jLK8MEltAPqU9LiKz4=;
        b=luJNN9UStWQ9eytibJ2OU3m1xDtPOGuAPbgmn3NRUqFn2RXKSB372N7kP2zS/O6u1C
         tgqLNmqNVEx2lqTs9BpR4OGT+zvIfLsVMXA3BHVMPtyXBy/augp/ozTMwDHKEypEduug
         YH5q7aSwCCMWsne4haDQHyqksFulFOgJwTMzemcbKisWxGdSRr9shmy1NvPbuy0IdWBs
         IksE5SdWBACGQCSMph0m2zskToxWqo8/W/VJ23gsYl4lOr3AYqUDx+nkMoh0rgHKSa6r
         R+VjIpbJxzK1cOREGT4plIlq0prwY7DZFxi96aBpU9smY8SjAsIQqOPlFTWLEmTZBO3z
         K+sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778210305; x=1778815105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DaECM3afZbtSVstcoN8c/Bxd1jLK8MEltAPqU9LiKz4=;
        b=Fa6w5TgY89311qTz+fhxkhXpZHDXrFCvuw+kW7RX3OBx8pXktmr+ebY7ifdyhKd8i/
         yiJ1/b9cmeqkSIBFyzX4jcXpSUgXnkZwfA63jfGhZ9J0KHYGWyoeTFo2TUcn/r/uCO6o
         TMJzN69fZLDNkxlM3cu5yj2cxsskTilP5NbOU0QTWo6hjsJPqrmjw2si3pUG6sEczUtY
         /WWqOAzmlee6WP24ee8egPVw3qbppQSw/TuoOXZnBaaUnW1FiVAKkPXjhtabBlbR+lGE
         fWWLMSxBpVSggexGIq9QNUYi5WAKSdP4vM1nTy4nzicRG/xwqtTC0ccz5OdfQyJAtOR7
         IooQ==
X-Forwarded-Encrypted: i=1; AFNElJ/tusI9oIks7niIswmNJZmlcyBMRKdpVHZJcpkxNB7NQvtU/LJUjF2zIrRiavPyvD/P4aWvKNV2js4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLuCHPJS+6drcSZY2uvDuY0U+d4eJVaw7wiKUiR8uqhR2wqqyi
	H2MWkpo3X/UySTdQfEEGNeeJRqquT9VvMn8je6UGvm+izM3sRMCBewDE
X-Gm-Gg: Acq92OEORyersIv8I0+eQduAtnjXnw/Hf5b/CkAOzU2CA8wO93oo1o8aso9d0ZxG0Qo
	pbfgiaRtIfEKd3KhTkwHh4+uzNER9BLOn81r92QBuDU6eoBkr1O8/a5djd1y4oc/Wmoi8BFVlw1
	qSg1bYBUDk4OXlZeGZ3NsFUNFkLZpfBwOvbRJnPEm4M18lymWtDk06/0EGYVbRTTHEVntF5BC3m
	j60dnlCGbAqn6U64lQhWpL1mb6tGer85xom3JMmyBpwmQYWn56SjCQ12xBNaqqE3lHz64oKjg1v
	a8BGfiLoWFbFbb7YWrvWFkg2eoUQCMJhp2C7lsxr5rMND8xr4aZixhttk1RdocAbtnVcR3Vw2So
	j3GqItyLH4mmtMbXw7swmkTs7c8HfdIKD3LA8sYUiLwDeK3bmjy4HVlWwJOmyydJbcttcE3KBg2
	ZWLBAM8H7qTMn9EpR58xFdutqTxLNHDi5SFn4lfRJp
X-Received: by 2002:a17:903:3bcc:b0:2ba:4e84:976 with SMTP id d9443c01a7336-2ba78f45b67mr104924825ad.13.1778210304563;
        Thu, 07 May 2026 20:18:24 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1eafa62sm3220685ad.74.2026.05.07.20.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 20:18:24 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: alistair@alistair23.me,
	linux-kernel@vger.kernel.org,
	lukas@wunner.de,
	Jonathan.Cameron@huawei.com,
	bhelgaas@google.com,
	rust-for-linux@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-cxl@vger.kernel.org,
	djbw@kernel.org,
	linux-pci@vger.kernel.org
Cc: alex.gaynor@gmail.com,
	wilfred.mallawa@wdc.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	boqun.feng@gmail.com,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	ojeda@kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 08/18] PCI/TSM: Support connecting to PCIe CMA devices
Date: Fri,  8 May 2026 13:17:00 +1000
Message-ID: <20260508031710.514574-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260508031710.514574-1-alistair.francis@wdc.com>
References: <20260508031710.514574-1-alistair.francis@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

In the next patch we are going to add a PCIe CMA TSM driver, as such we
need to ensure that is_pci_tsm_pf0() will allow us to connect to CMA
capable devices. These devices don't necessarily has DEVCAP_TEE or IDE
support.

As such for Root Complex Integrated Endpoint (PCI_EXP_TYPE_RC_END) we
also check for the CMA DOE feature.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/linux/pci-tsm.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/pci-tsm.h b/include/linux/pci-tsm.h
index a6435aba03f9..5059954e4853 100644
--- a/include/linux/pci-tsm.h
+++ b/include/linux/pci-tsm.h
@@ -3,6 +3,7 @@
 #define __PCI_TSM_H
 #include <linux/mutex.h>
 #include <linux/pci.h>
+#include <linux/pci-doe.h>
 #include <linux/sockptr.h>
 
 struct pci_tsm;
@@ -129,6 +130,8 @@ struct pci_tsm_pf0 {
 /* physical function0 and capable of 'connect' */
 static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 {
+	struct pci_doe_mb *doe;
+
 	if (!pdev)
 		return false;
 
@@ -146,9 +149,15 @@ static inline bool is_pci_tsm_pf0(struct pci_dev *pdev)
 	 * switch.
 	 */
 	switch (pci_pcie_type(pdev)) {
+	case PCI_EXP_TYPE_RC_END:
+		doe = pci_find_doe_mailbox(pdev, PCI_VENDOR_ID_PCI_SIG,
+					   PCI_DOE_FEATURE_CMA);
+
+		if (doe)
+			break;
+		fallthrough;
 	case PCI_EXP_TYPE_ENDPOINT:
 	case PCI_EXP_TYPE_UPSTREAM:
-	case PCI_EXP_TYPE_RC_END:
 		if (pdev->ide_cap || (pdev->devcap & PCI_EXP_DEVCAP_TEE))
 			break;
 		fallthrough;
-- 
2.52.0

