Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92EE36E467
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 20:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798613; cv=none; b=s8HxsXMO7Cbbjl41nJ/TXBHyjwtDRnG6dCi8gP4D5dJxdRLboH+unEvouMocENfNB8ZGOP/hrCAbX/lj09gZkKZCDjHplJp4OdOdPk4zDpWpymHTRvv7Eq78KvUc3+SPDEas1pS5LPpZRv1M+XFbdb7Lm8qQa5NMBX4bX0ypgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798613; c=relaxed/simple;
	bh=tb7tRqjRKsskIV4ptJEZWXYPWkaWUIXs01cFsV/GkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US+gZAcQvGuxnkLNPFNzHumDo5Skehct0tBZNfnpZ6rVH8h6br2rmpXe+WQj+oQSMXANpCcTbwDgysyR85slAIbRCIzWtWXtVU+2BmkcaRKD1S3rbfl5Isr4w6N0ox78vR7GEgPVCMLewvPovUM8B6sW5wYKCau7cx5OXO++ZsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ClU0L5P2; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ClU0L5P2"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so6715ad.1
        for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790798610; x=1791403410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gV7fs5Nei/k8o70WCYEk0VoBwcvkJqHkvDHNbl1vC2Y=;
        b=ClU0L5P2YXhWqY7+ryTjDFdyyKkUWTwHZ3Dc7i7y4Qkc9I/1b/Qy43pDAsPaGReDKU
         xg+5kfDYP1WMGHzGBTSTIYS21Xt4Irj+dMxVFbsm0U9tiUcqHSxrphpge8q85iQnULAu
         VT4TVGW1z7ihPY//HX65nLVdsvJmz7eEZ7Ml4xHM3twxUGyf75o6znuzA7ZLYbbXHlLO
         /IzQ0rkJzMEbRuiRDSemwKYdgtUWXnxz48SYvPhHxWuNIqqFqQGUfsJ6vvTzeoJS2WfT
         11ngj7wIZ+Jmu4FY6L0VFM0SECdYHzhzrkJhpXfqM40R5lgu7JDXviSKQMV78i4gWOcz
         yepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790798610; x=1791403410;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gV7fs5Nei/k8o70WCYEk0VoBwcvkJqHkvDHNbl1vC2Y=;
        b=wOeqBAhy+5XimjqccB7OusXzULKwZNGSKvjHiS6XfpsKOgAZ0lbNCPTCokGP+Sxw6s
         gZtQvrZ8ME7hOoYYzuZrHFln1nEliADgnl01d8TkG1unizpd1dLofl6BTLcti9pLVDO6
         lAXTE5NOP9LHo3xuS5m7SkaM4o+mh2f1C65MOFUl+AO+gmudbrzVVn5RjwTJ7F8W8MII
         FwlNDFKrX3u+zxNth1ZU1RoGnQYoFU6JSBGF+xA5P0rgXeYv/k5mC2ueMfsYD2/zw48S
         TWStIbcoRrTnVyDj7aV0ZdgC24khr2F281SGBPt/jvcqqARe7l5iicdvEc9QRXmig6Bk
         ZKMA==
X-Forwarded-Encrypted: i=1; AKwUvByc7lcO+E0Y1N+mHY4e3911gypH67hnTISPgTL+QoZOwMfC1tPlJmacXUzbq7pz8egoYfpQRss5KhA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIm0hNAD64LgAb1tXizoS4hTr5PQR9T67VujXBkCxNH1wxiVw1G
	KeljLnhWuXnzHcnQ+y+PyDtZG49T2+PqDyIYvsVYyzvmq3Zo+b8qa4mDTvJCnFWGfg==
X-Gm-Gg: AYBFou20222e3WEgCQFrbcSqXpouxezkkAN5t8HJQ8xyYR6ODhWNMl766+S0qls+EN0
	0nY5Cy5n1CosbpNAUWMHeW73nbY9sy7fYBGmxL7VrD6d0UDWt1chXKOF6nhGzlzpLR4IMqmBjIy
	SkL8RXWeOmKKSWLD9Kfor0y7yqGxwV+YyQtQ1a3Xdje+42NXnMTHKQWKH7Q0NWFz5jwq24O0E61
	Gs4rkEW83awRDwrA5Bm9t6cCjL67sHdYtyPiHcKNGBtxpwTmXJliVbDqG4+c01peU132smNmqbL
	CFN0mebaM6xcbOQK37kg2fFsKMqimR/IHwCpEvnVJOuEi3MA0XpU5u8S1j2mAV7pWjhOSxryRE6
	IxAwPo7K2YeFsGiBs/kJExk/qiIdP/c4C8fNiIuMRmidcEbxpm/3ay+CF1gvb9Hff/7w7a/Td8C
	sT5bRKabW6kTkXFpYoKcNUfgjTRa0SmapkX9LMjFr6YIuo4L4je7NS1UGJ9Zy8n7r7JhxFAc/Nx
	nJzPyeEyhnHk+++ofxt7rRcUi6ltKuC4qVC
X-Received: by 2002:a17:903:32d0:b0:2c7:9e6a:1a8d with SMTP id d9443c01a7336-2e305407c5fmr334005ad.12.1790798609384;
        Wed, 30 Sep 2026 13:03:29 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300a90dc9sm1914285ad.18.2026.09.30.13.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 13:03:28 -0700 (PDT)
Date: Wed, 30 Sep 2026 20:03:21 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v11 10/16] iommu/arm-smmu-v3: Factor out
 arm_smmu_handle_gerror()
Message-ID: <ar1rCWg2mJ3aiZS2@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-11-praan@google.com>
 <ar1WQCud+B3nAWX6@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ar1WQCud+B3nAWX6@nvidia.com>

On Wed, Sep 30, 2026 at 11:34:40AM -0700, Nicolin Chen wrote:
> On Tue, Sep 29, 2026 at 03:45:04AM +0000, Pranjal Shrivastava wrote:
> > The GERROR register's state might be lost when the SMMU is powered down
> > during runtime suspend, requiring the suspend sequence to handle any
> > pending errors before the hardware state is lost.
> > 
> > Refactor the gerror handling logic into a helper function. Subsequent
> > patches will invoke it from the runtime suspend callback after disabling
> > the SMMU, ensuring that any late-breaking gerrors are logged and ack'ed
> > before the hardware state is lost.
> 
> CMDQV has a separate IRQ, so I think it likely needs a counterpart.
> 
> I have a similar patch in one of my series:
> https://lore.kernel.org/linux-iommu/16ae24cc2a002802b990afa1a69fe4ceab1e0da2.1790188510.git.nicolinc@nvidia.com/
> 

On a different note, I should look at that series, I think there were
multiple things that were fixed/addreseds in that series. I'll try to
take a look soon.

Thanks,
Praan
