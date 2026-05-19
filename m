Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C72848AA
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779217529; cv=none; b=h87cv4cbnPZjOaIPnWIG0/T1XN+scKzJUPwJmuMrvPBjPgY1UOrxgl3zWdsriG7fkBsJPk2r7SBNkc1hpfQPdzv8geco8deycqgs55l2Y+iztYe9wh6Ggz1UFMMzRLSMzhkrQqO+PBlgpQTkodV6Rncb0bWTc5Fs7TFawegI4H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779217529; c=relaxed/simple;
	bh=NkbIuZmZbXDTd/Ba2Xv4PdtZcGFu2cbkqQ6Pohtib0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQbCmVDWK8NRSk2Q6Af1QT8tW74u+3uIBbJUcULi9Jn3T3K0dQifv/do4uws4XAYK3qtWQZdXC56wZ92kcLxoOc9Wxj9V/1HkoII1TslFgUVtwpOmzdhrc5MllbCMKlXtTfq9HF7f7kTrTjTkG/wmHrzRk/d8bvGCmrBoNDJ3pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=slW11qAN; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="slW11qAN"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b46da8c48eso2045ad.1
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779217527; x=1779822327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T65OdPrETtNnBJjVw8yp6v3SGiXxDH7+GlMKU2MxhhE=;
        b=slW11qANdE7O0J1VlGXXMW3txxHtS+YE9WZVT8ugkIg17gN9o5DBbJNkLbZkcVLiyU
         F7c8MJQYJNLRcDczJG81ezRXoSCRgf7jRXXFjUpTZLDmKIcY7RckHmmW3SMOp3eaXEVs
         G+nM3CTkXLeOtE0m0PbZ3xbFnY3AQUOCbUtpK5qoKsXC2bN3fQgF6V7h4R4NY/0lVvPN
         +VgTQnTn9dwDcuPs4O8f7M2D1JwG7jgR7RLT1MuwsnLOxeETSlWuizVSpisvlbRd8Pet
         xRUGp5Rk+DgLXdjt5FijhLwC/TN6y6NMatzL7W6Hrwhr1lt37yl7IPp4yEPl8XMMbfuD
         yypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779217527; x=1779822327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T65OdPrETtNnBJjVw8yp6v3SGiXxDH7+GlMKU2MxhhE=;
        b=H3ak+aNJCfqyB97Rfol9VYshmOgGuOIib9qtsu4ArGfGo5MeZP5/DGN8wUdUiXwqgq
         1FDraFi5jDsjim/PVAYktX9sX9VXGTs89kDtyEE6cfeN/46jcdMgM20dq5TVeAwJeoE/
         KOeQtcPiPp29NnTypLPCr8KGAIO9fcBpLgRArRIhp4NOiaVumK0g2bmRoW6uIiJ8kvPc
         O65ZxlaJ2RJyqv8Ga42tMkmGBI8Yzq9iMa3P+gwSqVIOkCiBt1X568MnPNZK/4kIwFVX
         TLRmdQZrnMVf6dfiFEh679uLClxZ4KyV8ie0GJBaC5WygPyn8KswI8qqtvt+HdSpjyX4
         sEOg==
X-Forwarded-Encrypted: i=1; AFNElJ+cuitb2J76uhRiU0e2cVxW2Kmb9n9P25QCK6BeXMFnd0Nv4GjKVBmK2TzcL35lpXrQdrMRpslU2w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygr6db42zR+nr2cnDMQSlPOmr747w7rxUNiXX9n/kybyfXwGIz
	qIIm8dH3wqoaxg+yFyflaJgnuCWi9a6+lojgg7zDX6lVDhpbzVWXvuw6DIy2jj9+xg==
X-Gm-Gg: Acq92OElBfc51J1AOMlweB+eN3ywuZAwWwP5GW9N6H1d/paFgOkCJOgs1HdTczvW4JF
	uLL3jFJATzifMj5P0VdD/sGPHeqJ4SlSYMk4Jj7nTQYFITa1JeyR6SCQftGkm1G2TIxwdbdb5UX
	6Yd4h36Wzb4dbMzEhO7t3taF5RZzWNOxdX0JeZNd6LEJ/qtDQix42fKhiLDuF+Tg9IjUwf/S+tc
	PicFucCH2c+sIi+d4j3NGa3+TaJe5vMpVSeybii0Bd3Ic/4JLJ7eGLjWUXmSF4pB0NkXoNknCR/
	5e5fPRe2xT33Zd+VRVptLSlPdbDVkQRL+Os5cVTj7/X9jF9Agu+T13CTIk2zA8AHfTAzlYz+Dgb
	UnSVSh+o+/qk9uPfbRO4hPiNLO3zXhjMVMSEfKrgQUk1+fkqKUgC8WBdaWHamMkzQUnJoZToNDK
	SyhLcJxNUZXKgSPS88EzjKhRc3D4wTtPfC9I1o7QPdfZvlHA8ePSqYafIYOstKV5C2TMNfvQ==
X-Received: by 2002:a17:903:3904:b0:2b0:b925:da98 with SMTP id d9443c01a7336-2bdb36b2cdbmr7145165ad.19.1779217526359;
        Tue, 19 May 2026 12:05:26 -0700 (PDT)
Received: from google.com (153.46.83.34.bc.googleusercontent.com. [34.83.46.153])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c7809esm24056508b3a.44.2026.05.19.12.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 12:05:25 -0700 (PDT)
Date: Tue, 19 May 2026 19:05:22 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, Daniel Mentz <danielmentz@google.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 2/3] PCI/ATS: Validate STU for VFs in pci_prepare_ats()
Message-ID: <agy0aNB-KJPsP3aa@google.com>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-3-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-3-praan@google.com>

On Tue, May 19, 2026 at 01:53:21PM +0000, Pranjal Shrivastava wrote:
>While every PCI Function that implements ATS has an independent ATS
>Extended Capability structure with a Read/Write Smallest Translation
>Unit (STU) field, the kernel manages SR-IOV ATS by requiring the IOMMU
>driver to configure the STU on the Physical Function (PF) before any
>any Virtual Functions (VFs) are created.
>
>Currently, pci_prepare_ats() bails out early for VFs, assuming that the
>PF has already been correctly prepared. However, this creates a potential
>mismatch if a VF is subsequently prepared with a different page shift.
>
>Update pci_prepare_ats() to validate that the requested page shift (ps)
>matches the STU already configured in the associated PF. This ensures
>early detection of incompatible configurations and maintains the kernel's
>policy of consistent STU sizing across all functions associated with a
>given SMMU.
>
>Signed-off-by: Pranjal Shrivastava <praan@google.com>
>---
> drivers/pci/ats.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
>index a5fa7745bce8..54319854bfd8 100644
>--- a/drivers/pci/ats.c
>+++ b/drivers/pci/ats.c
>@@ -73,8 +73,13 @@ int pci_prepare_ats(struct pci_dev *dev, int ps)
> 	if (ps < PCI_ATS_MIN_STU)
> 		return -EINVAL;
>
>-	if (dev->is_virtfn)
>+	if (dev->is_virtfn) {
>+		struct pci_dev *pdev = pci_physfn(dev);
>+
>+		if (pdev->ats_stu != ps)
>+			return -EINVAL;
> 		return 0;
>+	}
>
> 	dev->ats_stu = ps;
> 	ctrl = PCI_ATS_CTRL_STU(dev->ats_stu - PCI_ATS_MIN_STU);
>-- 
>2.54.0.563.g4f69b47b94-goog
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
