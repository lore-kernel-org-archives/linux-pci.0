Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3285348C7C
	for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985952; cv=none; b=WKzPeT7+MKjoIhmBUfMdoQdi/LOWm5c9B9eaDpXbvM9F36dz7KNsESbrm31/WYBOwzlJnndSTX35p8BXJge5mnGw4SvkfAzexoQsDhtRdZCdckNq2LDMiPef1Blj25hmTWyxZwBEzCu0JMHAG34fcxZogkh6rHop9anNwkCsEzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985952; c=relaxed/simple;
	bh=JifQjjeGTYkQYQF9OEClDLZwk6+0Cv5AfpxwRFxUgAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RzoiJ0ZsD2ckpMeuuW/HkHLDglLeB76pEuHuvmM8X5KuDULODU5RmYb/cAzytcgKZPmbbA2OzrjN0xTwtVJcVNwdeiW3WDjzxVt1SrU+JXLvXj29bzRvL1teOGLG8icAcL21OFaMCoiSXr9ZyxWCinNYHFeQ/RzQScS5XescHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D+LNozkZ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D+LNozkZ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2b46da8c48eso1695ad.1
        for <linux-pci@vger.kernel.org>; Thu, 28 May 2026 09:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985951; x=1780590751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=D+LNozkZ7z8RclW3sK7QxICZlV1/2u+s7GXoX2Uo8ijedFsi7LX18lMvy73rHrDfrK
         49s0Hnn+q60xtPG+P05y4rFJgrMwi2y8FmfV9TQdnO2BRcCpUC88zFi1Gm1w2FTyYgdk
         14+iVNkEqIWLXyr8EY28jYPFMYJ/Ty1+HwVho4uy1oIynWBQpKwBEREtVFMT7bCojjRC
         9hpMal3u6F9QdG0uKLOXC+3mFk3FslbjqKNyxV6tRZC3gTH8/dGYXKf9NmSz3AtdhQ4F
         Se+T8tNdy6jPrw2VkAwxn4gySTVWa9WtpAceH3ok3gbWqNTtVMYoVSlQhjTn0ftEfSy6
         owRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985951; x=1780590751;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lQXaLb9WZj3JY/dEJGlzcheRpxj78yrhQDEcCPB8cc4=;
        b=HDeC+oxa2SrHvpH3PpgMSBxKatjI/ta3JpIFs3bze+umLiI+P4VHPBmf5v/Tse3+Ji
         VSzkzMIqFFwG0ijkbF6XIfEBq9b8sneV1zi4U7Y+RO/iYtmzj+6GQDMGba+J6lt7+yqh
         nFgKN7EX8xpbI3hOdIEnloPcvt10/vLouiMr9U4QnzPxnVmaLwOVYGOrci7dr+yrkil/
         kOvLNqNL/4j5u5XH8H/fOKEg7Td3LUcPpmTWVV7HUonaTdrZiN6BHv8KEKmS3rX3Tn3m
         QJuGKM2tWE1VhpKPOEsA30+ngbjFQzZzNcmEMeua+MrDmP8T4BcJM64JQN56q3Bq1EkN
         5LhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+LEFoSs7u4mnbWtAg4hPq/rkrQyiUfe4YJXe8nFm3L7loAOrFcHKrzTJ2f8Qslco2Bc3yhqX/gIEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl4rDynf48kyd/bZUOfb7AMqLMTzZNn/t937m/jyboEzEpDucr
	OIZHhgPei17G07X21X2todlHiStPzTIqJNAzK/d30LhdcPwMw+emg9ME8AczFPsiJA==
X-Gm-Gg: Acq92OHecGIxg3ISVRTZJ9OB3TVmYA3v13gTZX0MOohOrqnHGxI19de/exRuittoToK
	6r8uxLXTX/yvNtEAAzB7u7KU1nnCNJeq32w64Jc4A7odPrd95mZsgIZ7KoUP2xC7jXP+UC1vcKh
	Isf3cV17LEmkaQB94GLIKOTC5DDLl4zV9BVNQ+BUpvBpPSpAh48AAW42rbpARYiP12p+S6fxDVz
	wZCEs7G5ByR6qPYONDoChvr6TxH+b32E3U77lBnG+bPyPqcqMtQgVdt/Zil6Zum/Lq+GAAVCjYt
	0xS3R7jtBiS7X2FLd/gFg7uhVv+Ilcurm8ks60pOO8tpd6V0GBanNmCgrbbdKEf353gv76e2hV1
	z8cOgZenJ9OEjsXaqOdK8QaMdSlpHRqgSeIRkNTu8zumSyYDhCaXe7AjskyfDvhHov5HmsUV2KC
	DbDPmPjSfO0mWqOhL0+ESPt3Yjy2xnDAQP2t6C2I2ooIOvnLkwD8DBJVyDFGaFUxgPbnMekPcU4
	rF+ekc=
X-Received: by 2002:a17:902:d50f:b0:2bc:dc0b:ab29 with SMTP id d9443c01a7336-2bf0bb6f798mr1542415ad.0.1779985950617;
        Thu, 28 May 2026 09:32:30 -0700 (PDT)
Received: from google.com (44.234.124.34.bc.googleusercontent.com. [34.124.234.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36b90c032fasm2002365a91.15.2026.05.28.09.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:32:29 -0700 (PDT)
Date: Thu, 28 May 2026 16:32:23 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org,
	robin.murphy@arm.com, joro@8bytes.org, bhelgaas@google.com,
	baolu.lu@linux.intel.com, kevin.tian@intel.com,
	miko.lenczewski@arm.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, dan.j.williams@intel.com,
	jonathan.cameron@huawei.com, vsethi@nvidia.com,
	linux-cxl@vger.kernel.org, nirmoyd@nvidia.com
Subject: Re: [PATCH v6 3/3] iommu/arm-smmu-v3: Allow ATS to be always on
Message-ID: <ahhuFw3ZJpy48xkH@google.com>
References: <cover.1779392420.git.nicolinc@nvidia.com>
 <18bb6f421b3be891caa8f1fb50f3a4d56b52d5be.1779392420.git.nicolinc@nvidia.com>
 <ahheOF8L0aGMttcI@google.com>
 <20260528152930.GA3195266@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528152930.GA3195266@nvidia.com>

On Thu, May 28, 2026 at 12:29:30PM -0300, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 03:24:40PM +0000, Pranjal Shrivastava wrote:
> 
> > > +	master->ats_always_on = true;
> > > +
> > > +	return arm_smmu_alloc_cd_tables(master);
> > 
> > Nit: I'm not sure if I'm getting this right, are we saying we *need* to
> > allocate CDs for CXL.cache cases in the probe itself because STE.EATS
> > requires Config=Translate with S1DSS in bypass?
> 
> Yeah, basically.
> 
> Effectively the ARM rules for enabling ATS and Bypass together require
> a valid CD table pointer.

Ack. But do we expect transactions before attach_dev? What'd happen if
we don't allocate CDs here? Am I missing the fact that CXL hardware
could be already active and using ATS after the device_probe succeeds?

Thanks,
Praan
