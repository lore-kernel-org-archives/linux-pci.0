Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795016135;
	b=KY3OKnAY9ruNGWxWqCEPgKtFFxu9/ENPYkM1YcFkB7I2Hd+mVHgYDbd5nZCzemZn5+ty
	 G2knGzSWEROGBNsY8AtPN5oPju0N2ScqG2BN4uIFP1Dgu+26/QyUF4T9JucjcaaNp7mVl
	 rn8CJ5kSAVejpTW3GBGME/BSfiVRzPB9PdJE3KpDZeH1yH4Om1GyoxWcA60WXlKHDY3Jv
	 4VzMLyJhH3UkQY1t6P55YsRaVVusWPfJPh4NprPN6tkoleXyRryEnSxwnh0ugY+EymE8Z
	 0Ab8G21l1C3nkVs+WqHEB7l7DOP6dAn+pqsW8F9yJZUnsZrc6m0ur+VCBhhVHuF+JOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795016135;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hHbDnBNXsMrfYdPN6XIU4dlwFEIvntxiBuLc1xN7+Vw=;
	b=VRLrk5QXniJASYDV1AV6xC39K6YJxRYgQbqPGDoMvuisatcUjBZRPKzy3hhnNcEuJH87
	 mc33rWxWRdhaKjCKkErwmH/TcNKKBveSW4Y0vNWZvBgKFsss5BuggzgZtQOtdrt72JY2y
	 RKo1F8XQ5IFHmtnmk4jx8hdwYu4+Q9T5NsutCJAv3y2u39OBlOP4m8PCwHrqWonltrjaR
	 sv0rOhDUr8mWdsNSxp9O252PtGyRQZy22cBt4w1KxIFAxgl6L5JcCeWk0qP3vaxPmYSag
	 6kWR1wSBvzKBDmFQSWpxsoVpbcMjx6rEH8QQFQ2Qu1fYKZrv6a0xCP5yoY4HKfmwsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yVsQdrqY;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DC1606A31C
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 15:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65DC1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yVsQdrqY
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91ec2d42231so5846046d6.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 07:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795016134; x=1795620934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHbDnBNXsMrfYdPN6XIU4dlwFEIvntxiBuLc1xN7+Vw=;
        b=yVsQdrqYH0XxAxVWlxbiF/J5ajV38u5gfxDHPmjnyExLC584nFtzAsyWxOYf6uj2YP
         hEqZb7NW3c0FzKUag7210xnrqp9J1gqEe+RnfqX4TSgpIgTvg3IsqscrTel+CLcWExbo
         si5Pi7A3oUUQlU18E4T3Bafax0tRwb+YCFSCwr1nEvQTwXuX6/VKOfvLDzL9uOIB4hDg
         +QtT6358St+kMyaciaG/+oEWAeredZsB4v0cw4wl4bPz6dnrc5vy6/0FDi6RJ9StFUZb
         /47E27O4v1+B/YoefJBTGpKmuoy+RP8+aSXi3D8eyvHf1IjvQfHYfBm4TN5K4rigbQv7
         wNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795016134; x=1795620934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHbDnBNXsMrfYdPN6XIU4dlwFEIvntxiBuLc1xN7+Vw=;
        b=L+oRmldztF812geGaMvkB08whSUQl4rz3l5RGX9acblsxG/ejw1Rg1C30pTeQOHm3R
         AaBuXTP034AKTI75i8UCOe+qJvJd/AGPOudI1a7V//gTCj7UrtysH4g6iCjilgs9G9Bi
         ssZD5mM1+CUMNPX11J7rDLOgSh+I2TylBCcjz7nmJwFqGwAjk2ertaDGeYHqupqaeEFb
         nJQKgdos1px3NdlfwMMusKjulOQF8Jj4jVkTsZTn5kQduo4AXZM8eVA0XvIdrI7alf4m
         dXgO05QHfFiw6hjVeh0Vt4gU9sRqqUgcyo4baK79KkU3Fc10D0SCA5ym5KlNIDdSiQTn
         w08A==
X-Gm-Message-State: APuU4Z+tLTCVrD4UUVkdJ7zrh/TIhazCTTSv829GsiHKU+2uxtzeVlLe
	HRESINGiQ4byT2GLgkmAE4wXxffGbA/bfcz+3QtvQc5zCNi5DUsU+JXdW+XPoJOIQGo=
X-Gm-Gg: AZFdTZcv1Veey292Hlem4/lr85pPsB8AYLypb0+/jsDFk4HfG3h+OrISX0GDTK0/Kfy
	dMjLBixGZejNKubZkqnyMXvqV3XBvKeY5QvN9yXXk9yu09U/c5oARP5sHGOXJW4qq8c2HgDvl7N
	fABvQ8tiC+C7NG0q+VzsOjpq3Oj7BwEPB4Hm3acdD+2jtfdorh9sevDQCHMgOY7Q1UWSROPfbyL
	QDqOyKWpF5sAQ3gCtYq8XqBDF75oURSqhnAcBpmPz4Fx6e85DSNBGMkVcXel3Kf1Ns/hPFwJ48m
	SJImM/oP+WFXYLDYsgR4gZ7j/BAY2uA5RwmYAoKASi7p3R5iF1L7EJkuvQvccGFSQ7mSd983APO
	LcqOpUy6qbSKd1Mu2/dsd4djY3JKmtzBhM86//gTqOv3ND4oEA7YWVTZu5EFXsnk5xe73NBe7US
	yqL+sea30KlOm0gSdiyVodRgOBfnCS6MJQ2PiptF9dgSCyfOJ0SHNSV2NrFDpgVwYsGOGLfwU8H
	m3SIgEg3t7cIoyBTQyTZL/l2X0Avwq6zZGOIbbiNfEaUxOBQTVylIZoQlOglgfpzdWFRXJfyUMK
	TjavPDY9f2fuAmAbsqbEkeSfQ0BMKchBasIz3bg564vEETz9p7NQ5pCv3zky+h9UMdHBKaUh5Bu
	0ChEqOlGxPGSEUUCGDGkWKhwrHr4bgsekkjM50prSIBw0rERK/c5cmgMR/xmWzqNio7gaUC5714
	PsaKGr1El11kgiRhMkmNWHlB41neX8O1vaPdt80iNxADpKo6XIj6cRwdC04rOkE2KnkAVaCJZ0E
	hktwJUfZQLXSi34CEy8YCd0xv5u4vqb3NbOnWk=
X-Received: by 2002:a05:6214:623:b0:921:47e:e053 with SMTP id 6a1803df08f44-92114edca2emr43364966d6.53.1795016134019;
        Wed, 18 Nov 2026 07:35:34 -0800 (PST)
Received: from coder-gsekar-hip-hyg-new-659c88f9fd-hs8wm.coder.svc.cluster.local (ec2-13-205-193-176.ap-south-1.compute.amazonaws.com. [13.205.193.176])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921148c261bsm24707266d6.0.2026.11.18.07.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 07:35:33 -0800 (PST)
From: Gokulkrishna Sekar <gokulkrishnasr@gmail.com>
X-Google-Original-From: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	mika.westerberg@linux.intel.com,
	linux-kernel@vger.kernel.org,
	Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
Subject: [PATCH] PCI: Encode corrected PCIe port type with FIELD_PREP()
Date: Wed, 18 Nov 2026 15:35:05 +0000
Message-ID: <20261118153505.95686-1-Gokulkrishna.Sekar@harman.com>
X-Mailer: git-send-email 2.56.1
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

set_pcie_port_type() validates PCIe port topology and corrects
invalid upstream/downstream port type information in the cached
pcie_flags_reg value.

When performing these corrections, the code clears the
PCI_EXP_FLAGS_TYPE field but writes PCI_EXP_TYPE_UPSTREAM or
PCI_EXP_TYPE_DOWNSTREAM directly into pcie_flags_reg. The
PCI_EXP_TYPE_* values are decoded port type numbers, not values
encoded for the PCI_EXP_FLAGS_TYPE bitfield, so the corrected type
is stored in the wrong bit position.

As a result, the cached port type may not match the corrected
topology and subsequent users of pcie_flags_reg can observe an
incorrect PCIe device type.

Use FIELD_PREP(PCI_EXP_FLAGS_TYPE, ...) when updating the cached
field so the corrected port type is encoded consistently with the
format used in the PCI Express Capabilities Register.

Fixes: ca78410403dd ("PCI: Get rid of dev->has_secondary_link flag")
Signed-off-by: Gokulkrishna Sekar <Gokulkrishna.Sekar@harman.com>
---
 drivers/pci/probe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..7b09a4463097 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1674,7 +1674,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		if (pcie_downstream_port(parent)) {
 			pci_info(pdev, "claims to be downstream port but is acting as upstream port, correcting type\n");
 			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_UPSTREAM;
+			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
+							   PCI_EXP_TYPE_UPSTREAM);
 		}
 	} else if (type == PCI_EXP_TYPE_UPSTREAM) {
 		/*
@@ -1685,7 +1686,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
 		if (pci_pcie_type(parent) == PCI_EXP_TYPE_UPSTREAM) {
 			pci_info(pdev, "claims to be upstream port but is acting as downstream port, correcting type\n");
 			pdev->pcie_flags_reg &= ~PCI_EXP_FLAGS_TYPE;
-			pdev->pcie_flags_reg |= PCI_EXP_TYPE_DOWNSTREAM;
+			pdev->pcie_flags_reg |= FIELD_PREP(PCI_EXP_FLAGS_TYPE,
+							   PCI_EXP_TYPE_DOWNSTREAM);
 		}
 	}
 }
-- 
2.56.1

