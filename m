Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B502BDC26
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123222; cv=none; b=YWm143wN+n/ATTuf62MMxrN5j5AhDqkeU9jqdAyR2Exssv9o49Dy3dPf1fCEbYAvpkgkIdY5aEMWRP6esbanV8XgnbCU7EHRLj+JY89QtqPFmzM+zmSSfZ3VrVBNFZ+bwRHE8iHETxbzVKhh/lurlSENNXC4i4yoTkHmXoJgmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123222; c=relaxed/simple;
	bh=CMuNYaGnRzSq6CZHFO9VntX54RIhTsLJI3gd5H3i0ow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tindt3KbtvDi5gg7VmkyvY459PfjCQX8/TrfahAvxCQm84dxpQaXWZSAVr5bSaw1RpHZzf3FsEJeHRabzP2F8C8ZOYRAWCfBRDQVTRCR4+UPqiDYem4VCdmPCODfdwYP2EEWaj3ylfSjh7OJu7QTzrZHqQGIIU/yC3h2+jzuqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fwh9Ay1z; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fwh9Ay1z"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-84a2c90e383so488777b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 06:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784123220; x=1784728020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bxz//7/e5HTtWCDRAkC6j3Yh9BkeNsmi3Lm7ODOArD4=;
        b=Fwh9Ay1z1EWz+JyWpXDhllwKYL+k/tAMBXQMoYax6OCAJCoA5Xi3vVuoakuY6N/aad
         TYDPqSs9Kb1TXW25wZy0OZB8RsEq6NNkB3LWTNHIN88HF9uHcd8hXPvimjUkhFZdm1J3
         leTd7GXWVly5XnKmFBue0oXwB2sDiDnhPBDmhDXs2a/eVyioQ6HdD5MfZ0qtLIiw5LUM
         JrPueFa59QIErj9U3YGPPVv7BVrU9tbUfmZvrDmIworGrmUU/Wln66Y1Xys6Ss90t1on
         zAcFPIq5fO9dMqczwIITfY29DwWhYLoG2YJEeTXxuvI0WTFoi/9ehXMlOu2oF/0Y6DJF
         c2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784123220; x=1784728020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bxz//7/e5HTtWCDRAkC6j3Yh9BkeNsmi3Lm7ODOArD4=;
        b=LUOX/N44MGtAPTVRW91WQd3FUZ/oCRepCBJVQ+xKP9u0SgifeJQUzQq2PCswldb45a
         qkUGoUZWwf1gobY/1uIFN6VIXJ+D+fPBQPI4u564thM+R5dso7ThbrQrEUU9J9qBboqj
         ay8hNr2gjMa4MBt5iMj/439x2ZSoTZTyjoEqsAgP8Mq3s+cilaWIRUXrvl3uN80SD4Pm
         ABXATxcEWaFwrEBYl3mDHbpL8BSzSGBdltqJ+sKd6nX4CQtOvrOkhBis63krlTRdVdCB
         31ISE48SHwRrHsVsoeK3DUMeHf27YKHXlHqBS7/SffQsQZpl5CvEoz0J5TCmNhFym0/V
         AntQ==
X-Forwarded-Encrypted: i=1; AHgh+RqfrYEHZvj5k604goECC819PYcr2tmBERBq7CZthFDeS99PsrlitoNU+yfuXLQhjQC6JnbRHTzD7aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCC/HBvcrbF52eMeNQas+Ci//uQg38o7iNO1xz+oFNOnYprswn
	Xig78OUc2bMBooXuS31HPXBSRDDsa9e/r36YIE4kwTP72LEIPJlJKZqGJ7z5StR9
X-Gm-Gg: AfdE7cls1Ro0RpBPH4oK2t9WuyD6xtgGcrXJcAdy8iPP4q3tYUXjWCOfITle3Jp2mxh
	CNbpjz7ytVNoAUA8NkHMcRODwPC5B3CPMce0gEE1cGCPe84WKHWHSpzsRa2UypxsZ8sTuQ+vW8N
	T0Tk4LKQ/UxfMI3IOP7D/28Fbo1iB+gheYpWVhHIFm21pR5FJGBUuJpZUS84aijDF60M28lnhwo
	OBhdaEMYPyAj/TCDuZB+heyg2h6jANduudmTsqRtG6n/FQz3M6GCd4nBrFK51xiMRFHWSImikEl
	1IfofAqSZIv2CEsSioSfi2ebiy/ntjhYbkznXqZXO8fqcjO4Uh/KRVuDXXTYIqz4ak7DkVR/TYC
	UcdukmB4wHkOSb6vUz44HUTbDVh8Lu206X+KMILNQk7piy3HTchMMUE1uAJ/6JtN3Je8cvou+yE
	YLm+h7AhwvP9WWTWxVDbNr9i8bAoHIsw==
X-Received: by 2002:a05:6a21:458f:b0:3b5:6b5a:4f31 with SMTP id adf61e73a8af0-3c0f0b726cdmr25977715637.27.1784123219895;
        Wed, 15 Jul 2026 06:46:59 -0700 (PDT)
Received: from workstation.. ([182.180.105.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e4fc28dsm1954487eec.2.2026.07.15.06.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 06:46:59 -0700 (PDT)
From: Ali Tariq <alitariq45892@gmail.com>
To: kevin.xie@starfivetech.com
Cc: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	Markus.Elfring@web.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ali Tariq <alitariq45892@gmail.com>
Subject: [PATCH v2] PCI: starfive: Fix resource leaks on error paths in host_init()
Date: Wed, 15 Jul 2026 18:45:32 +0500
Message-Id: <20260715134532.619566-1-alitariq45892@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714113029.326207-1-alitariq45892@gmail.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
optional regulator in sequence, but does not correctly unwind these
resources when a later step fails.

If starfive_pcie_clk_rst_init() fails after the PHY has already been
successfully enabled, the function returns directly without disabling
the PHY, leaking it and leaving it powered.

If regulator_enable() fails for the optional vpcie3v3 regulator, the
failure is only logged; the function falls through and returns
success, leaving the driver believing the regulator is enabled while
continuing to configure PCIe hardware that may be unpowered. This
also leaves the clocks and PHY enabled with nothing to clean them up.

Disable the PHY on the clk/reset failure path, and disable the
clocks/resets and PHY, then return the error, if the regulator fails
to enable.

Build-tested and boot-tested on StarFive VisionFive 2 v1.2A

Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
---
Changes in v2:
- Use a shared error-handling label instead of duplicating cleanup code
---
 drivers/pci/controller/plda/pcie-starfive.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index ba8ef7842e35..fab44054a5de 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -304,12 +304,14 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 
 	ret = starfive_pcie_clk_rst_init(pcie);
 	if (ret)
-		return ret;
+		goto err_disable_phy;
 
 	if (pcie->vpcie3v3) {
 		ret = regulator_enable(pcie->vpcie3v3);
-		if (ret)
+		if (ret) {
 			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
+			goto err_clk_rst;
+		}
 	}
 
 	if (pcie->reset_gpio)
@@ -379,6 +381,13 @@ static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
 		dev_info(dev, "port link down\n");
 
 	return 0;
+
+err_clk_rst:
+	starfive_pcie_clk_rst_deinit(pcie);
+err_disable_phy:
+	starfive_pcie_disable_phy(pcie);
+
+	return ret;
 }
 
 static const struct plda_pcie_host_ops sf_host_ops = {
-- 
2.34.1

