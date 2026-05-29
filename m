Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572C3D16E5
	for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 11:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780053142; cv=none; b=Z8KQz4wOOmqL1ypOcCWmzR3dNZwCj3H+xN2gIFBttM6R7fuIfeOcrg4OEp4BAU4lsk57uNNwQRi2NTQhAYVZisLjxOk56DrJDbCMiF/qGEET3mH8i+RjnAqWQUoZYC/sT/JojCqh59Wg1YIAbs9zgwWGFLXzQhscJSKg5Kaz9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780053142; c=relaxed/simple;
	bh=zLhKJQfxvv+d9aNsqJrU4irOe5OKs7/A2799Tf2JNWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cGayswdHB+5fW8mhT8QkiZYemcaDx22Q3CT76UMFyUSS9iuOhwCRQldSSlteykGuYEhiPmjSqTOc8tjw8AvCOvBv4CvS/HcVoXU04dZu6e194jtEn/o1OZNRaQhHsQbLxnVt0GfSaQz0OHY1H/Nm02yjObFrwdLmUtoNwcvL8Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--praan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wSUoIdbO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--praan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wSUoIdbO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bf004bf8beso25954365ad.3
        for <linux-pci@vger.kernel.org>; Fri, 29 May 2026 04:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780053134; x=1780657934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=wSUoIdbO7fFMo9G4JafqQaEVtqtyTZ31hqyLopqjaby3Tvx6KI/Omn1lNYGAayNejO
         7nSFJCAId5T/6PFskeIZ+pMRfTpbsp5u36kG73eFy3h0eyjo99VCabaw0VMY0nqNbsWY
         o/8dG0OMlZDwZj4r6RfL+wtJQT0aGv5bRePYrYAw6JJDQP9iNTUav0JZ8gZNWYTcObLF
         maMSkXkRNWyRhcsle7XyPEmuwpvEcSPj6zF1Hh1fNg7I0y9Ci3ClAKncz6XJxemVKFFs
         VCPhaBzOCINcOpo0m8JL6I1lw7KddXnT2K4f9Hfm8Dr0/vQaY9HbpeQUu2sX8Y2PXAWB
         yVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780053134; x=1780657934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H1WHbQ1I/exyopX3p7b75ehhnkD9ODb3Bve7jByn9iQ=;
        b=YwbMxm7rb4fqpFBCxZpdzA3u5Izxp/kexskhQ2F2QCTFhYTHYIThbwv4IXH0oiS99J
         1zRApkiok0aqaVhny3wMN/NuOOM8dJBrYH7qTxSk7Z+F+2DtXCkGIl03Y87Uj96HBrmt
         pM7/5jE9EmFg6c+XqqBxLdwrKrhhDtKKj/OcI2I0ZxOiNeYEmaUoKS3OZ8l6cwsjmqSw
         zZhfCiqffB+oANviXgz/c0DnfXvmMUdkCSMvrCuSH0YpzX+HAe/kx2tVdBKTxk2mxbqs
         CCOYQfA8kubES8qtjrplOk5CxrYTBbyfang25DdDBl/dQdpOsYCbGtT/rQsInqY36GS2
         nfxA==
X-Forwarded-Encrypted: i=1; AFNElJ9lLXmi3JN0nUUHZVsuNlKenHCRzSOkjLkKBrAGr8ss2MsZ1JZ2yQqUUsuISmEzQobznya1z1Lpkp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSHiv/4T6Gv3YNQGqsnuxVX9B4jed68PeWslDWJBR3KgsDw29
	3e9P3MyP5KquepmC8YIrhWwSz/v8FNiCFAw46itFK6W2LIR6vuiNNoJESPQYOqg88NjnQ3o8M6l
	6cA==
X-Received: from pln12.prod.google.com ([2002:a17:903:360c:b0:2bd:5ced:c1c0])
 (user=praan job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ced0:b0:2bc:7d1d:b677
 with SMTP id d9443c01a7336-2bf20ce01c6mr32213585ad.36.1780053134160; Fri, 29
 May 2026 04:12:14 -0700 (PDT)
Date: Fri, 29 May 2026 11:12:03 +0000
In-Reply-To: <20260529111208.387412-1-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529111208.387412-1-praan@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529111208.387412-2-praan@google.com>
Subject: [PATCH v6 1/6] PCI/ATS: Ensure pci_ats_supported() is PF-aware for VFs
From: Pranjal Shrivastava <praan@google.com>
To: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Robin Murphy <robin.murphy@arm.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolin Chen <nicolinc@nvidia.com>, David Matlack <dmatlack@google.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Mostafa Saleh <smostafa@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

Update pci_ats_supported() to additionally check the associated PF's
status when called on a VF. This ensures that PF-level quirks and
untrusted status are correctly propagated to VFs, providing a robust
support check that aligns with the kernel's PF-centric ATS configuration
model and is immune to the timing of VF-specific fixups.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Pranjal Shrivastava <praan@google.com>
---
 drivers/pci/ats.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
index 96efa00d9743..679a3c3c1d54 100644
--- a/drivers/pci/ats.c
+++ b/drivers/pci/ats.c
@@ -40,10 +40,13 @@ void pci_ats_init(struct pci_dev *dev)
  */
 bool pci_ats_supported(struct pci_dev *dev)
 {
-	if (!dev->ats_cap)
+	if (!dev->ats_cap || dev->untrusted)
 		return false;
 
-	return (dev->untrusted == 0);
+	if (dev->is_virtfn)
+		return pci_ats_supported(pci_physfn(dev));
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(pci_ats_supported);
 
-- 
2.54.0.823.g6e5bcc1fc9-goog

