Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD285393DEB
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 10:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654238; cv=none; b=I4hY4hLY+yzbdG366PQFYYfg/NBPhM/CcE2igpffp0KQNuYP+WNvLgP0P3lfVbyeEDY5rnzpt9mLVHYFcEVbTd4qx0bZ+ytf5RFkIspr+sHlnJeIMK/QTzXscYbKb/f8Y/YFBNFLf3JTWxD498lXL2zI8AWUehlVSHwqjGjFuuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654238; c=relaxed/simple;
	bh=6Zmbfl5t350g/ikDeKV9bfW8BGWB5eR0UjWTzntGkJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO2kvvddvnmGI8SMnU4forLvAp+bVyfsBrRDsEjuDNeh1G/Laq0OlotdY4ypc5LZxyzoCvAKU7D7kWPf3iq+dgMhmkuRRADAOq9zqTOXnV5NHnzlcKRUCTn0DkYmydPxvWrwvbq1+sQE9ktTJczfiQucxtoDCvJcYpHirLodqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gyZeLyFt; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gyZeLyFt"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cede6375caso102105ad.0
        for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 03:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787654236; x=1788259036; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W7fh18dW+kUBCYJPdPDVxmB9qh9dvTUt5azKdgYfYsE=;
        b=gyZeLyFtzVj9XDnQGpa6F8uT5O+jrfDXiWBxe8o3RPPx1/IU6EAJfI6j+QuTd1bzQN
         EBL/q0zSqVHvumQgPBp3gLQlf9EXKGZCFnEvEYuE4GY2KZyQHbQH11n3rln6mnnpaEC+
         i0ImLzNbFn2dLiMWGA9fJcgD1mjhfCRgv/qAD7USp9ShmSN6OMLm6T7UzsO6osi/8dRE
         MJ4ovUHazVZa0DFrmy3sk+RBac9FMCPi3Q84bcgpi3KoiYn/B2nJr2g8gWt6m5MwLrwQ
         cIi8KkJH7ipeXPcpFx66EOWxtjmQaIt+geD6wTd6B6sVN5ZROdyME/XIgppxBvhEj1Rj
         Uv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654236; x=1788259036;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W7fh18dW+kUBCYJPdPDVxmB9qh9dvTUt5azKdgYfYsE=;
        b=PwK9FWuYtr7C5PDkQdoEQjSBXYQgrZ+NXlGIIA8TbLXSJFObwbRClruqA3LWRBuqVV
         B4HYfQIfw/8TgUPdqjI622XElBSVwQDk+yXa+9Eq105LQs/0Yj8sLPQiBi6bfwPCtK8m
         hsJm5Py9SZXfKoxJWIeVGH14kGj16Z7P2SeN0hlaRtf5MKF12UFVJYOceu/Vr/BISRr8
         /D5Je4zddtSQjiSaYPk7mIBUhKczKz+/Y1OFK/0Qe1J8CiQhIi8TqNa1m/DRZVEATQHq
         WssmSxXdY1W+G67RDjTZG0qJIV0sjVKvllZTYbDbpf3bTqfhE6+SWFdyDwpxEa1C680i
         sMhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqvfviuW9l13TVYRx5vkmCHdvBIxwD3TMUqJOWcjPFBkjraI4uRFWRfbGhM7763UKm+FNOxQdLNA6w=@vger.kernel.org
X-Gm-Message-State: AFuF++lKFKhmbJg1ufhREGdFtznPZwG6VGvVgdngK//onSH0SbuvLTIr
	yc6wkSVEk1Ef1Mfpa1qLwzulFKGz73Z48fmkADnmCEZmV8aeZ1pfYgza2ZyyENobrQ==
X-Gm-Gg: AR+sD13eDeyrGAGaLTnUHY4hzrXHG90fLwjr1bH8dGb6bzVJMQ5rOoQIqmVSSM3Sumi
	Fo87jgyG0mxPCgyMw22l11pCIhWgOgkI3E+GK8jc1EN61cXKPiYQLwJOpNG90Dn7Gp0o53mpvSS
	wGasHuzanXR87wPJ8LejpoMXJOuyMI7dORPKtTRt4sVA7sDrkL1yk/R7f+eYI/kIx6ZYl+B0y4O
	6elAx6jJGAaXu9SLa/ypcSJcKy4CzaMLytYGZ4yoB7X0HirZ9f1DVo8Q8dXorWC8AI6xogKXdmy
	Mzhlg8MVoxYOHTqQaWGZ0InwOxNcInY9+dleepe1Snh/zNNKXnaLOY7kUdsev5eYqsIco50JxFw
	I7gRoTsVYQ8XXWDXjJv7sEOwlSAaX2Euk+ngIEhZQDA/gbaerkK/gGh4kkw/6w1FkgGDlqsVPBj
	4xDrl2+eIX32axq+isX9/5b19YLbvpj2CN4OAUhzxSw/Rztxu6QomlawEcnSeCHNcTNaTaoY0sW
	v6pT8iqaf4+y3JsvmCwyzI/nKVjte8HwiRwkA==
X-Received: by 2002:a17:903:acf:b0:2cf:4353:f117 with SMTP id d9443c01a7336-2d6e036d4cbmr5203815ad.0.1787654235552;
        Tue, 25 Aug 2026 03:37:15 -0700 (PDT)
Received: from google.com (164.210.142.34.bc.googleusercontent.com. [34.142.210.164])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d676895799sm26786905ad.38.2026.08.25.03.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:37:15 -0700 (PDT)
Date: Tue, 25 Aug 2026 10:37:09 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ankit Soni <ankit.soni@amd.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Samiullah Khawaja <skhawaja@google.com>
Subject: Re: [PATCH v3 0/5] iommu/amd: Refactors for ATS robustness
Message-ID: <ao1wVQzyCW22iNlQ@google.com>
References: <20260824122347.1588592-1-praan@google.com>
 <8e53fdee-2c3a-47c6-9478-19fbabef18eb@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e53fdee-2c3a-47c6-9478-19fbabef18eb@amd.com>

On Tue, Aug 25, 2026 at 12:36:18PM +0530, Vasant Hegde wrote:
> Pranjal,
> 
> 
> On 8/24/2026 5:53 PM, Pranjal Shrivastava wrote:
> > This series forms the second half of the subsystem-wide ATS robustness
> > updates. The first part (focusing on the core subsystem, Intel, and ARM
> > SMMUv3) has already been merged upstream [1]. This half addresses the
> > AMD IOMMU driver and standardizes the PCI ATS API.
> > 
> > In v2, the series has been significantly restructured based on feedback
> > on v1. 
> 
> Overall this looks good to me. We did run our CI w/ v2 and no regression found.
> 

Ack. v3 Just addressed a few comments. I'll send out a v4 based on the
feedback on this one soon.

Thanks,
Praan
