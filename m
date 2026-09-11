Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5C310645
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 23:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789169751; cv=none; b=Eq8n5fpRGmUA/FRHrmUSWZEOPQAjD5B8r2GWHQh2GJ4PSBQZXpUPPdIbYHOYx9rIvIanyM5mYZrfPDDrXdEGASgin+onANSNkZ8Svn+DDV04XIQ2e1CfhyB37KCcNuXOmwak0wPlX8mLcLCIPS14vCSVtmXCEoU2K8HG4TfJwUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789169751; c=relaxed/simple;
	bh=gm8FLDFOd5PNU/XMYySl5EipqTgCJEpfIrzqK402/WE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KttwmeQ2AMac1trUZl6OCYldSp2eTbAaNnDRfPrEjuaBSMQ8poFrqaMaLnxb4q5deArHmzJ95ExW0CJvDGUrSd/egR3c9eujmOi2s3mVfaXvNNcNr7EP9S5NHf/rXs+tzlvEmLn3QUxfYWkzTZ3LVmBMB8HnsJD/WZt+xenV7VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=agyq7Aao; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="agyq7Aao"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-852c481415fso1755381b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789169750; x=1789774550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b2fm0ws0RI4s9RoRTTFvcpWCb6oGc74Nxq3EnwLBIAc=;
        b=c4xIxM1MwraBoz6rB7SM+rZJycxBrEBih7YIvekEtAttCXjGsJEVx1D+NNMqoe+50n
         LD7PD3wQYsJd8KBmK8Q5SmsbN9omH3yW7zGcda2GjWf54xapLQgNjD0fkge6VlZnmPs4
         gHz21COeEtuz2QMcXxWyO9+Md04d3ceAYAp7BBM/TGUis6CLK3CMZoQLslun5KmtuUmt
         YEPA1iGviJQeIHY10N7w905QBYs+EaZR8EuuUXxPBe3j+y10zvHRxRl2fVg8so/tMkxv
         G+AHkLW3gcNOTRtImWCk1ZC2cx+XpVRT7H/VUh5CC/ViYL7795sF9cHQJZh3EZdfNClt
         eryw==
X-Gm-Message-State: AFuF++nPw/cN7/7WFae9J5gugVfQwhfQGViphtBKUR1rkFgEY6yi1TMY
	qs5pg/OAn3ZUtVV/oIWV9NBQm70ueCRs0xwVKjQ0O+IKYfRIEMN5L30icDvCNThweIMqgN1gCcE
	Z4N3ScNVJh0/MWvU3Kcw6CLDJc+Izd6ktCxr1dYIgqmHIheCaJVVqPVf3KdkWjQ/6v71qJQOmD4
	1q8++MUvzbYlu4iOR9gfM8rUEjXZ22h0Vf4dSWSDAW/TuRQQMh8z19Rx9VpAuKBplJsv60CMoVI
	OZicGKpUl8yCzzv
X-Gm-Gg: AYBFou3Le0YE8yHyc7PF9EQ5p24wDv0qfsDojsXBIFtF9OI38mpmjeUab1eYmNqWqXW
	1n+Qk7YYVTRHDmgMOdgosLZDIjwN9sIoTM76pAVpuZn7D85fZfybH7krsxFRoc3DzxhbAABr/9c
	FIPaxLqmYLFPysfEXueoSyvPuMn2DC3Ow+qLUIAVBhuAYZ9oehbKkOQAyDGQ0J07mixWpur1hdO
	5zQtRtjSrItTIWdIYZC0f3T++5iPJLSiMeX/Br1keReTF3w4s+Z+ezbJ4ldiMBNTbxmXWK2GrSy
	htpPR1H4NrMwYh5mS2dGomLoMB+QPycMBnJrjDFvczj3wezccd9OVABvWwRrnLGJTbY1dOxEBAI
	dEr7gTCFTiUge9EveNBvHdDbmx3xmsL9FdtXGzKKSwDVK0onQslymvwH8Oc6f+yeEeRayOkOEF6
	2e9uHDUJGekYouDFkjp46SNmZPrwVnQbi+8bEm
X-Received: by 2002:a05:6300:220c:b0:3d0:57c3:65f4 with SMTP id adf61e73a8af0-3db0e0ad192mr807594637.5.1789169749668;
        Fri, 11 Sep 2026 16:35:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc4c65f754esm1303381a12.10.2026.09.11.16.35.49
        for <linux-pci@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Sep 2026 16:35:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-90e87478402so32242256d6.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 16:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1789169748; x=1789774548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b2fm0ws0RI4s9RoRTTFvcpWCb6oGc74Nxq3EnwLBIAc=;
        b=agyq7AaoAhnxpaxQe5nJqFpQRS/b4NutoFP+BL7ljaM9Fbm2gvkxGafMrARpQorFt5
         JEZv0NhnNw5ohiu2xz39LO4nxm+lHg3+zEEEMDmg/kKZBm5uA6jRTLwnDszPhcbPGxj9
         sFqobIOK58AELPbOzAaBqtCJlbbfCRaJt0HLA=
X-Received: by 2002:a05:620a:2982:b0:939:d5f4:ab5d with SMTP id af79cd13be357-93a038b94d6mr83405185a.33.1789169748386;
        Fri, 11 Sep 2026 16:35:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2982:b0:939:d5f4:ab5d with SMTP id af79cd13be357-93a038b94d6mr83401085a.33.1789169747922;
        Fri, 11 Sep 2026 16:35:47 -0700 (PDT)
Received: from stband-bld-1.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f45ab71sm31717326d6.12.2026.09.11.16.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 16:35:47 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 01/13] PCI: brcmstb: Remove redundant const specifier for struct fields
Date: Fri, 11 Sep 2026 19:35:26 -0400
Message-Id: <20260911233541.1650895-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260911233541.1650895-1-james.quinlan@broadcom.com>
References: <20260911233541.1650895-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

All of the variables using this particular structure are declared as const.
There is no reason to declare its individual fields as being const.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 8a0c353d2abf..89aaa19d508a 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -288,9 +288,9 @@ struct inbound_win {
 
 struct pcie_cfg_data {
 	const int *offsets;
-	const enum pcie_soc_base soc_base;
-	const bool has_phy;
-	const u32 quirks;
+	enum pcie_soc_base soc_base;
+	bool has_phy;
+	u32 quirks;
 	u8 num_inbound_wins;
 	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
 	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
-- 
2.34.1

