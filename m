Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB573546DC
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779201884; cv=none; b=pfVgiU90V3KFkmqQAMue+RIZ65yo6bb0dOJbrdKDxpvwPoaIXFakFse9FEVstSVGVHA/HEkX3mnROAWCPU+alNwy4BaY/OuBreImWeLtLVi651Hug3krsawhXf8Afp447XS/n+xtJQpmWGZaO5eOgK4Fw8PrP+6DO4feIO+mm0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779201884; c=relaxed/simple;
	bh=ababuGkYXc1kwBB4VAaU12lszAJn+bUQOtY++53c6VM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIOmmP0XAiIOcrtjnacHRfXx/3qeJ9eWXzoQurUK12YO37r07CHIMuJvUd6DNWoT2ZzZFr0cQE9NDOJBHMLMEVhGMaPU7r4hngBQmMlWQ8fVuO6OjjjO+d1UjtRI4znnriDsH1f6ChCv9+XsdvNJ02l1GjCebm2lz65SIW7GZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JkacNqif; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JkacNqif"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b59772d441so47176966d6.0
        for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 07:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779201871; x=1779806671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wk5x+E6XSA8178Vrjl/Xpe+vTMcrSAIJSeHPv64RB8s=;
        b=JkacNqifTmIov0fY0uD0bLtoB5U6la0Wxp3JsYCZ6cXpzs2T6CJSh7fn6CUI/2CY4J
         aQPgMjUX1CfWqhU/MA4WTC1hLTAhzZfeI7cKUJpl/sSaOUYB7kK7AvmfxLuENy14m1vx
         dvnXkKkVhvcna+CmnsfPVlawXkP/OiTwXSdQ7h5v3H6oKtU7rb33AeGj81vNnSTqU3Gn
         gTfZ4sgqZQC3fJy3MVg7QZ1P9A+RLRsL9GC/6pxztuZ0IG1490akYZaNqADgJAL5MvLc
         QHVppi+DWCWL0kqGKXM3OlyIFyHWqBY2G0rgJ2wR/dW9dl1poFUOE5MAqFfR42IE7Hki
         x6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779201871; x=1779806671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wk5x+E6XSA8178Vrjl/Xpe+vTMcrSAIJSeHPv64RB8s=;
        b=ZJNkwV2lQZff4RSMtEreR0EEjJ+nj4iV9Czb6ICEw5YTyRIFaJGd/oEEl1j4HeeZP1
         RV57vsvVyrw25ZaQezpzhU0BChLvKq2vfxhaurjGVCDwh8cC1ymR+j7P6RiTaZ8+bu0Z
         i0VMXBwU4J+nj9p+Ni7Z9sARdU+9CJ/td26IyeXXp/CrI2/ebEhd3RmA295Fbh3Rvjdb
         LzU+T9IaxSuquloqRH6NRUoajI4Fy5wlMmf37nPymsGRuu1Qw3UpH6YbZpGXZS/K+qm5
         ggX3Hyt8/0W50NSbLytHUuocRv3kDzLoEi8nUz2HkZrqizx9aEx2pbCTugTcfRCmgFD0
         z8lA==
X-Forwarded-Encrypted: i=1; AFNElJ+rbcML4JatKsmpQ/JdG2FMNkBjLjiaXf8hqioqnbVnGf0357IqzHsvVfyIYQB1TZxTf8I5miECKvc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt0zELAC+T0Ilw2nuK/8z1CKTZk6aH/7OK86XYZOJJ644yA1Bk
	26gK/5gCgCSysmmsrNmxWIyq9VVIZoZCRteKT1bKpguNB+/2rQSVSSPTKKcaWZp2jxD4A6i3KjW
	+FnY9
X-Gm-Gg: Acq92OHMJwYHo551Ij2n5sghxWMIw4TrBH3vNoLxLbp3i3JEa/ez2rOYSdIdBcEThZl
	jpumj6M2XZaGcYln3ulAxOrjQ/NOQgmTrGIQ/dcoAFxELZBdW5LYrQhUE/RLfln2P9U0gVyj2Op
	oeko8XHhk6BeICC3JWAPg8iQQBo+OQNxv36lq1lKFbny6JTZU3+kkzIgzzrQXwmCaU834Shfdrr
	yTN9jg7e5ms/e/pqbXW8CLXbWGqGNrGBVuFXOcUhRFsfUa32EyTVD0hlRNESvu+3beyg/TpbzxC
	sEh1u+uiYIcf2EorSnAy0RzD9WJv5OOrgjeAR982Y6S8AatwqRKRnKJy34W1nqQfP6eS5NbQOiB
	NM+ogy0JPrZnmAl8MerJiqhQeFAQXDpOAYTz3FIfqdYsIFyh1hWAevxJD8AvGgE9I3NoWDXyKCC
	m6evNIATNuUwD7aQz8OkTHzGKyBjMArgUh6DsaGvs1VojLuqicoLXdFlvcgLhVFsN37MrXs29DC
	5FBmw==
X-Received: by 2002:a05:6214:21ef:b0:8ca:7f:89b2 with SMTP id 6a1803df08f44-8ca0f651b22mr304560826d6.12.1779201871273;
        Tue, 19 May 2026 07:44:31 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca3618fdd7sm92678956d6.27.2026.05.19.07.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:44:30 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPLgM-0000000F8gK-06mQ;
	Tue, 19 May 2026 11:44:30 -0300
Date: Tue, 19 May 2026 11:44:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>
Subject: Re: [PATCH v3 3/3] iommu/arm-smmu-v3: Fix ATS state tracking via
 ats_prepared gate
Message-ID: <20260519144430.GI7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519135323.1558777-4-praan@google.com>

On Tue, May 19, 2026 at 01:53:22PM +0000, Pranjal Shrivastava wrote:
> @@ -4450,7 +4450,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	if (dev_is_pci(dev)) {
>  		unsigned int stu = __ffs(smmu->pgsize_bitmap);
>  
> -		pci_prepare_ats(to_pci_dev(dev), stu);
> +		if (!pci_prepare_ats(to_pci_dev(dev), stu))
> +			master->ats_prepared = true;
>  	}

This should fail not keep going, it is a kernel bug if
pci_prepare_ats() fails.

Jason
