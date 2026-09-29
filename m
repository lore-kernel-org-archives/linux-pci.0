Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719FE3F9263
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 03:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790653536; cv=none; b=fD2i7+VmKFeQ0YJna35flX0vfNgNBAUHAn+ZUzmJxmVeQUzRsClb/s43KNxkIHm/wMVu7zI47SQMS9i2+ImEl3RRS+FflPzqbOwm3iVG8QJsEsoDmPrAfYLKTaeUpDgcycKaiHE9dLZhhkA9k2/sxrPdzUtkWglVppys0FBmLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790653536; c=relaxed/simple;
	bh=t6s4Oe+o2p1ts8W0BX63x7TlPfAs6I5sA3X1EA+4bIY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lbcTel/ZKEQcS1SrTqi0tW+3tqvk4V5MFgZMUEgkTqGWoaexHN/w2ZHnjEym6xxLuFroR1Go+XHB6pMGAB5lfGUJ1tu4uQ+7PntETZgb0VAElAl1agpdrCoOf1GFGEgq4x265OLRaYa7QJOJSF3AhoDcV3eY29/hr1E7CzAauvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q9PKogkv; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q9PKogkv"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-880babf652aso511952b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 28 Sep 2026 20:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790653534; x=1791258334; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNojz/m5/pZo5fqQWuhdwjNU5hLUXAkkyG3PUmd5nDE=;
        b=q9PKogkv6YDgLQIyhJ2XD4moH50hdabhUOPoy47SxRomxKDEP3/Ay8iBcqXMN90vQr
         9OfQrr4QEjagrkQtUceDMFrlvYjLeXmg8mz4Zp35tdp6Ucj9BASOEaZQlsfoag4fqHhG
         t29HgZjZ4u+hzmCxeg3/BXP6t/uXFlOIEoaGKGxGwdzYSgGZgZWG1fsop4TzPWqjAsg4
         woOnbf1g7DohYaSE9on7VWetqFAmoPJzQ3kG6bHBLv/wQ/dJ77Vz1ZnCFrnjYWPTSeHR
         7bJWsrQJaT2koKaF4JCJtouRED6b7yyEaG4juDHcnujiIkVqd+7nXW+eF5sAVRNA1nQV
         ZbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790653534; x=1791258334;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNojz/m5/pZo5fqQWuhdwjNU5hLUXAkkyG3PUmd5nDE=;
        b=kxBtPUiZyiDXhmqlCJdrTf1nvmY86CTzFWbHulfMF4pPCzy61VkAnJe4vkCjZiv9fh
         ZmI9L9eKh84VJVvPl8mmzJzDzEJFnR56mzofSbUfKoGmh3STaeOQL5t73LPLRDBXr8/+
         ZU+y3AdjkNgrzoQvnfLeah7o3blZ6fY1/0zzZi9fw1JnspbYVDUn/5Fd0Z3v1JhAlgFJ
         Cr58ixH1Mww7jaNcuCMxtixOQTh/d+esIgGJaGcMyRLL/47HDqXrlNxy4MYE4ctrYN54
         4YANhM0bBgVL4kYLMGqzJyTGBeAEpUTBjxpHugOk+6saspHYRGCeeg62zKwke5WR6qpt
         ApGw==
X-Forwarded-Encrypted: i=1; AKwUvBzaByXW6sC3o2T4Vqc+2LefMTdcG/R95VfoUJBe7r5PYxqJr2XdIqwoKtL+4cfmhdfUee8l1lrulLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nTrLIYv6PCJtGCPMP+0vNoS5xxt/gMCnmrGjOvz6kTjca5GOPr
	S0au2GwejcK+7GddZTeCUhUfNRRtuhrqIYuvzYwFqXU7HuC43zzI2kw8CHUCccugf/eIlw9YpLE
	jfw==
X-Received: from pflr18.prod.google.com ([2002:aa7:9892:0:b0:878:112:ded2])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1703:b0:878:3705:5724
 with SMTP id d2e1a72fcca58-8856314d6ffmr806898b3a.48.1790653532960; Mon, 28
 Sep 2026 20:45:32 -0700 (PDT)
Date: Tue, 29 Sep 2026 03:45:00 +0000
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260929034510.2023173-1-praan@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929034510.2023173-7-praan@google.com>
Subject: [PATCH v11 06/16] iommu/tegra241-cmdqv: Restore PROD and CONS after resume
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Ashish Mhetre <amhetre@nvidia.com>, linux-arm-kernel@lists.infradead.org, 
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org, 
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	Pranjal Shrivastava <praan@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ashish Mhetre <amhetre@nvidia.com>

PROD and CONS indices for vcmdqs are getting set to 0 after resume.
Because of this the vcmdq is not consuming commands after resume.
Fix this by restoring PROD and CONS indices after resume from
saved pointers.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index a394bf0f487f..c7989fcd2c62 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -567,6 +567,16 @@ static int tegra241_vcmdq_hw_init(struct tegra241_vcmdq *vcmdq)
 	/* Configure and enable VCMDQ */
 	writeq_relaxed(vcmdq->cmdq.q.q_base, REG_VCMDQ_PAGE1(vcmdq, BASE));
 
+	/*
+	 * HW Registers reset to 0 when power-cycled. Restore them from their
+	 * SW copies to prevent executing stale/ghost commands after resume.
+	 * Note on RPM: Power-cycles can never happen when VCMDQs are assigned
+	 * to the Guests since the relevant frameworks (IOMMUFD / VFIO) hold
+	 * active PM references preventing suspend while VMs are active.
+	 */
+	writel_relaxed(vcmdq->cmdq.q.llq.prod, REG_VCMDQ_PAGE0(vcmdq, PROD));
+	writel_relaxed(vcmdq->cmdq.q.llq.cons, REG_VCMDQ_PAGE0(vcmdq, CONS));
+
 	ret = vcmdq_write_config(vcmdq, VCMDQ_EN);
 	if (ret) {
 		dev_err(vcmdq->cmdqv->dev,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

