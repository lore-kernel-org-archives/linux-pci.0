Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C1C3B8413
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786465288; cv=none; b=SD/74rpun9d/0KDRbsf661Yv9uf1MxBYFSibbuAYhxhapCT6fF/8p4bw9F/SdzAy01CFToVYgClucuy70KDimH3C3NYSReagluPtLmAQf6J47h6iAX70pltCEJU8Sy3FHkcWpthNpLttay3YSNnAKJI+OWubKaDKHeHFonKIyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786465288; c=relaxed/simple;
	bh=IzG7wcSnS0LX7TU2RQ1pHjEUVUk31vZgsIvwWciX868=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDgXcTY5MyqHwKflCyYiAIPIR+W24ZtwMXyA6KAm8Oe7kWienfdqalYxLWZhH3XYkEiFSf8GG2iso7z2jMWA2UTVslB2H7B4u+0QE25fbkU4XHg5rsEsBVMrAwS/H5soUyK3jHO92ui5MsVbo7peWZEMG3KsXvtJZ5xwfSw3kjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=nKtf0pX2; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="nKtf0pX2"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-934974844ffso8083785a.0
        for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786465286; x=1787070086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=nKtf0pX21rLJ0eVwVhCstxfwpROMM6okWF4T39N426WVApG1snKiQYcVNMlTjzWUiK
         dQ4wztoE2MzksS1pFar2VyvsLJswkX7iPZ5AZzuHFwgb2WTjOdx9YRSpIRLX4rxJWrsu
         YPsf+XqLc0BJbFBdf9KhOocgnpGCtf0AkGRaOWh7keCi1hjHSdERTz7hS83x0SHoKW73
         2LqtA4QB+V9kGibXx7zfQEBycSiiT2jKM+yker1PIy2aG65LqoNCaXLiojcXTPR958YS
         YAXcS8DRmDsh6hxL5buDuQtTtV/mklBrh9hfwUZG9wVXk7oVYs4b8piOh/ir9Z87PCJO
         GUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786465286; x=1787070086;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iF1EovNHXjlni8LKG7pfSf4Sk3EXbwMQtSznu/lYQFo=;
        b=KL4Vewx/5SuzyC3dNXsMqPYhGcBLBuDEOLkhjGUkAgRPc8/kcYmL9zgNKnGJZjZ6uY
         yQgPEMqgEtUmhB6FHWwD3Og7IWJIfW7VYajJRX/OXEViEm3xzSgRGiFcaffpA9zd68tU
         EaRyuCXWHifDbk+vzVTGnpp/QO70kyczpnGf1fzotvzD5r+hbmXX1WaWx90JFJKVvfdj
         65n71YQIs/U40UhLFsxEIExE2WvmDDb+0o0dim1WEjSgvLP4ma7Musk0OyvhOSWKI7Qm
         iEHWxNB94SvqFty8SkV26kJjLAJ3m0tUEmSUGuwJau7XHjdngYl5X9SzA13HWJ18SGnG
         LQTw==
X-Forwarded-Encrypted: i=1; AHgh+RrbE5U0A+pH3BvdVp1OVIkClgDHswwhqMzQpstFbzM4pCwZgTNHzC4uW4TDPDHypBkXSFxWxtJABeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyctfV4CCLBhPg/D+mnmWAt/e9+h+k1B+i7JM3ZFGxmu5jGbPh/
	xuKjv5gp6tCkn26/CTHGCoJXyYr3x0hZ2RpLctAmrZFPlapwmqhGjFglgIUnbVpKZlU=
X-Gm-Gg: AR+sD13+tNv4oiluxNK5eQUdVUzzvvkzC1IBHewUyNF3XkuzabRmtDHYqKzp2N3WobE
	I7K9s1pB9bVt3bry2MMtrtcgEhl9qRtdtkwq2+JrKdeX6vfryn+IIFjGo2ddFXlZFjXG/7Hdf0k
	ob2MAjtkIsFYDPss5b0mSgdFHY/CWXtj0cIKMjBNhl52Lw4BI9bqzQnL6whST+i1LDr2hwVmadw
	Nl+YvaLUwptKXLtjJbiiSSRFJOV6g+/yDpFF1qtr3gVXJdFrm+QhX2ahJcv7s68ou8/GwPziN8X
	zXwYsSb8dZx+3B0lZarPWaxlJKZ+rPLjoyTPGaby92oLW16i99OSEa1HZKA09XCGBurGwUn4kHJ
	dQIdI5eyJrtyBQa5TiKomyKekDMhfUJNoVFVX5EobmAbaYIRzRN0Kmd0eHqs++Cs9hz3u/dT6W2
	OEXuvFYuN0RJQ3n9fOBVL46gVmgOwz1JeptrKBSQ==
X-Received: by 2002:a05:622a:4d43:b0:519:89b6:78b4 with SMTP id d75a77b69052e-52d5867e85amr44709981cf.40.1786465285899;
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90a6c39254fsm2441146d6.23.2026.08.11.09.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 09:21:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wtpEC-00000002Y6b-1J1V;
	Tue, 11 Aug 2026 13:21:24 -0300
Date: Tue, 11 Aug 2026 13:21:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org, x86@kernel.org, wei.liu@kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
	longli@microsoft.com, joro@8bytes.org, will@kernel.org,
	robin.murphy@arm.com, bhelgaas@google.com, kwilczynski@kernel.org,
	lpieralisi@kernel.org, mani@kernel.org, robh@kernel.org,
	arnd@arndb.de, mhklinux@outlook.com, jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com, baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com, vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/5] iommu/x86: Share the architectural MSI reserved
 range
Message-ID: <20260811162124.GK544626@ziepe.ca>
References: <20260811155022.108148-1-zhangyu1@linux.microsoft.com>
 <20260811155022.108148-4-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811155022.108148-4-zhangyu1@linux.microsoft.com>

On Tue, Aug 11, 2026 at 11:50:19PM +0800, Yu Zhang wrote:
> @@ -50,8 +50,6 @@
>  #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
>  
>  /* Reserved IOVA ranges */
> -#define MSI_RANGE_START		(0xfee00000)
> -#define MSI_RANGE_END		(0xfeefffff)
>  #define HT_RANGE_START		(0xfd00000000ULL)
>  #define HT_RANGE_END		(0xffffffffffULL)
>  
> @@ -3097,8 +3095,9 @@ static void amd_iommu_get_resv_regions(struct device *dev,
>  		list_add_tail(&region->list, head);
>  	}
>  
> -	region = iommu_alloc_resv_region(MSI_RANGE_START,
> -					 MSI_RANGE_END - MSI_RANGE_START + 1,
> +	region = iommu_alloc_resv_region(X86_IOMMU_MSI_RANGE_START,
> +					 X86_IOMMU_MSI_RANGE_END -
> +					 X86_IOMMU_MSI_RANGE_START + 1,
>  					 0, IOMMU_RESV_MSI, GFP_KERNEL);

Maybe instead of adding constants you should add a
iommu_alloc_resv_x86_msi_region()

That is just an inline doing the above?

Jason
