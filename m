Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05209291C10
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710003; cv=none; b=SCi9UsCCxmtP+2kXDQhWVRC1K3ZS3mMamZlnJJfz9VP1tDavYfXgSo1tbwj1cuLSEwVbUZ/iJZDsklCBgcFkga1/2XqGCJvX8gqUtZhh3yEXbZs3f1AT6y2SUBBArO3feMMdPuy1nW6dmfMi2lvo3PXdJgIHCYQh2f0XvV2uvKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710003; c=relaxed/simple;
	bh=jbPVSAPrjwCZ1QgFLEq2EkAZjF01jNgD4rg/XY2hQcs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L33aFtHt/m460SR3q5A/1K/lJ3vD/Ji1XC1/o7m61SKbIcHu5ihfoJ2mVWcKodWvbHpiBNLU+GMPixG/4KXnftNhHuxiSE6oj8XwyC6COUfKdecGaGyXFsoZDIgvWEkwHRRN/kHJhsCSu5epfNZ2ZgHbBeX0BNoDvXW8RNoziEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jkQzAg0/; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jkQzAg0/"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-88a288811a4so12445156d6.3
        for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 10:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1769710001; x=1770314801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fvou5EnfC6erSqFqmm4M1vH3YCXBRlE30VyZs921xdw=;
        b=jkQzAg0/Fttj1eTXAoI3vJ8NKSPPc9FB8P1M2b/77gt0ivll1HOgfxCollSvMumVht
         t3dDtwDXdiEDmtNBZUK8v50TqSkFsEBPmZSc8GKBIhezu+laQO3reezceCuXi9/KmILO
         dnwrtAdcGqZWYFhSFaRXFxGg9cgFt1PmwCEeBDeeoCft+cQejJR3maz1doZSkmO0oNuy
         jMX9of4ENPl0TVOTWyEpQ53AZP9+cDd+0Dl8fTnSWwFTnThOmCVd0gb53IT80NJ7XHVj
         2n6ytoWWbufieV1HfSogfIDZ/jXjD/gFH5LCJgv9t11RZEG8pw78ylu4X8FuzBqAlRlk
         KsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769710001; x=1770314801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fvou5EnfC6erSqFqmm4M1vH3YCXBRlE30VyZs921xdw=;
        b=qnGfla4UX7SlwcOTc1AbZNfytekPn2cf+j73Q0MiLpPtG/9XA65sYecVRISBtgamw5
         VazFtAsaNJd7WXoM8HOWM71svY2rdNrasiAvdPWEpsMspaxk8B6OUIFZuE+gmgiwXCVK
         9o1zkPrChJXN9PUk0vx6G42t9wtqlyYycOQFycllMQA9vVB3dd9q0+MNcCZdW2qHELAw
         qvPD6o2axc9YqNpbS5meTpi4lcptHBfV04bhLeLq8yoc2iOdwVGL8qIFjKnh7D57i9Ca
         XVv0PO7eZ2MfsMWsk/HtnPzIAG7xdDRHhqdJ4p1I3mkYTbFRvuSmsOiNnM316x/5R1uB
         siMA==
X-Forwarded-Encrypted: i=1; AJvYcCXyJA531ypX5C7HAUDdtW2BV9javyQB70Z/7E1ae1r4ec1MzJgrI4meRqQxGv+Qte9NPxHSY0k4j9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/ULP0x0jjBd0EET6/BLd/VBb2x/t5rMD8H1XcROXA/PEewIm
	MoK6O/0/eMrVk6iEvfcwUzjsmU/SesEuPqq4WS//bov+ACE/YAJQVMCPYK89NJ4geMTq3wJBmwW
	hnXQ4
X-Gm-Gg: AZuq6aKiLHX7wMZYTwPZJHgI0shciCZ9xZUM8GrwGFHKALf01r3p/BT32v3MbZmcTLU
	4Es7GEW+y3keJYlwnIPGMC9PWmPeU8drFTAMtcSJtiBl65H46+MFy2Pl+Sb7xoUf03vhPv4CfQ1
	EkpiXPo9+hef3aVV7OeA4t4yhJj6ExPI/pIE9BXm25/Lhs2DcBn+PEoJ6pYmYNE6yk7ttS7DguH
	ttuRe7Ad8ieSxYxi1R/L9g5aeiECRsJ+Nq36oZ0qNmXfI/5ZdWtmlAVx1SexIQMEJMpLMRN6Zz/
	RiuorUUi418V8pBydWjQYSIj9TjhecETXx05Y5oAMilWB9GWkLURCO+RmoN2G/Pgl9kl315adDJ
	TqLQgvS0Nv9DQ/P28ce3wl0BjJHn+iWbecN604W0IKBY6CBsVW4J6LMPsQz9V9xuZTLaUvSFTSq
	SXHwO/qSdZrhDKWW3P4y/3DrNjvvoOfIHwbvr+aXnLaCRnPsKvW4qlBaeps0DbfpG4aSM=
X-Received: by 2002:a05:6214:f0e:b0:894:2d0c:5de4 with SMTP id 6a1803df08f44-894ea058de0mr3910776d6.34.1769710000756;
        Thu, 29 Jan 2026 10:06:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-894d376e65bsm41852446d6.55.2026.01.29.10.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 10:06:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vlWPf-00000009mLl-22aB;
	Thu, 29 Jan 2026 14:06:39 -0400
Date: Thu, 29 Jan 2026 14:06:39 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
	Robin Murphy <robin.murphy@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Pavankumar Kondeti <quic_pkondeti@quicinc.com>,
	Xingang Wang <wangxingang5@huawei.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH v3 0/4] PCI: Fix ACS enablement for Root Ports in OF
 platforms
Message-ID: <20260129180639.GA2328995@ziepe.ca>
References: <20260102-pci_acs-v3-0-72280b94d288@oss.qualcomm.com>
 <2hua2e6admppbj5ttscqmclngfkvqpccix4n35vc4xc44o2bnr@yzw6hyvmar2c>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2hua2e6admppbj5ttscqmclngfkvqpccix4n35vc4xc44o2bnr@yzw6hyvmar2c>

On Thu, Jan 29, 2026 at 11:12:07PM +0530, Manivannan Sadhasivam wrote:
> > Manivannan Sadhasivam (4):
> >       PCI: Cache ACS capabilities
> >       PCI: Disable ACS SV capability for the broken IDT switches
> >       PCI: Extend the pci_disable_broken_acs_cap() quirk for one more IDT switch

I'm OK with these patches

Jason
