Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9022446859
	for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 15:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905892; cv=none; b=RNzbDEy7Z+NSTCAXXp9nWXS2m7ShMGH/qeKdWM2Co3cfCAwZUT3b62E0anlq6HhPbz3P8ygobEw3r0B4MOvK4y5BgARjVLyaflfCrC5Btq4WUnR8NjIVZcOxenGV6KbVEqBdawWesofTTicM/vAyj98iVipsS0jyuTTAx7yXCLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905892; c=relaxed/simple;
	bh=6Ky7RUFYVrq7ZdVer0P6fF8pIZq2ZBH2F27HGxmfcHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sLHTe0uVSOdHloYD+3y49Vbk1gRtMG0t9nNsntqYLvCqK3ca5Z2fWZXUh5BY7oDsNpsFrfqP2F6k0brNl2T9FU1/kf7tY7yxQLb8/vncxWoCBi1GF8rEfrPZG3jVEpW+BTApWLi+j4XGLnt8kgBGnxVE1U6yUBpy8j3xlLgIHic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Q0fjSgQL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Q0fjSgQL"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8453427d3f4so570653b3a.3
        for <linux-pci@vger.kernel.org>; Fri, 24 Jul 2026 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784905890; x=1785510690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ke98c75eH/+iYi1A8tNuqQeqLvc55paMqSI5+8TgofE=;
        b=Q0fjSgQLuYB9HRygq+lJjcloueZgc1r+lccuNCFCGIXNqqW+bkwsFW4snPjRZFSm5z
         P5X0eXLFL+BiuVe8Zm7mk2EtnTj3d1cslhzCn0UjFsfXl4D8cDm1gfwk/h6r0eKvSpQX
         RdzvVnXRsX3/+WyuO4xNjNQihdIcbZY+Rg3EJvp+N+Cn0PyGn8koiobD0ocxHqLsYyvV
         gK+B7/d/J5K2UgIXoazUBuRzQuXZxD38juKWCG8YdoLvfaR2bNPQk+LFBFw2z6eYVRhs
         kDXKQAQ+c4xQXziesLY1voqvh2qS+QM/bP3C9GMHVmB8io7/pIPQ2TuZpgfW4cB2gtAr
         tsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905890; x=1785510690;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ke98c75eH/+iYi1A8tNuqQeqLvc55paMqSI5+8TgofE=;
        b=DJMyTcq7uAcxcbTsYfenrIqtu5aHYKA3o45ZhO2iQ9WvgNCiS6mUFboca+qVTrfR9Y
         /OFdRCu1VsnUrWaTHesFp1W/roIVNQBnpJ+JpNPyIw2AyGRoCPG861PqgqISbGmkh3jj
         Oy1m5IK1YTgxmLH171Q5CQKhTbmViPkkcJRknwjU05DGG6InV2oRc9uZxN6C5PrZ65Zc
         AKGjVQ0HZjo4VrCCnjSR4MWtbbto+dorjjjb/hzhdeHqOv2xB6NH/r7Wd2qX6kFj6K0l
         xHoRewttvpsMXbHmsyUDs7hoVu8x7L5x1APH7yYpjJL6hssd0eMNhCa1L6gZpEvPUp1A
         NGdg==
X-Forwarded-Encrypted: i=1; AHgh+RqiDYj0ux+dCM4uEuaeQTSdr1UdE1KeSvlsowdkm3H5BcjHD2qdlFAezaxTpaWrR9XanQ+RKkFQi4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKcnknEmb7O81PnHOFmdHyIR5LJHRqzXb6LeIPorRklCTCMegN
	zy52cKdIXRyoytAzTjgQt4kgQWghFl93krjixrTaN9wNuP1hHMdCx/tE1iZR4u1wQkg=
X-Gm-Gg: AR+sD11uJNqvfKJG7ciaI1WuFIq191Z10XtbO3vwQuQyLQQ2B/fTALB5E+/iqOY80JI
	JJK++SG5niM+OTd2JWPodVb2tI+dRKweORoTEVyK70/ZBNvqIwfnWs+STt5vPeqDMoBWswx6WmY
	Non/5Sn8hP8aV93pCVz63JkGPF7rrFYScHVuLW13c+3Htz5yLJ2mALIBlOXHG0KW6OcIIX1XQHg
	FwFPtbgMTPgAdz8sAaXRTAkbpD4E9o4de73nRH1l8gcEUhH8H9imhOiMTWZ8cpho9I7hw5kRQK0
	7mxMXQkvOka4Odx3INeaYP+kbfIxwZKB2nvygC1v2yn4MYNFzec+E8x53HnwQT7p/exAXicmijX
	QHrw7uANe47EdNUu6gpFPqAbJaIwKH3+HlCMgUURPprBRYpOMLnuz
X-Received: by 2002:a05:6a21:7317:b0:3c4:2036:3032 with SMTP id adf61e73a8af0-3c44b06afccmr8103843637.34.1784905889794;
        Fri, 24 Jul 2026 08:11:29 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5a67f3sm572419eec.29.2026.07.24.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 08:11:28 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wnHYe-000000002lY-0zFZ;
	Fri, 24 Jul 2026 12:11:28 -0300
Date: Fri, 24 Jul 2026 12:11:28 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
	joro@8bytes.org, linux-pci@vger.kernel.org, will@kernel.org,
	robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
	bhelgaas@google.com, alexander.deucher@amd.com,
	Amandeep Kaur Longia <AmandeepKaur.Longia@amd.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 2/2] iommu/amd: Force identity mode for selected GPUs only
Message-ID: <amOAoNmkgDc3kuBi@ziepe.ca>
References: <70e6d40b-3e13-4efd-b1e7-62195ff66e91@amd.com>
 <20260723210246.GA856455@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723210246.GA856455@bhelgaas>

On Thu, Jul 23, 2026 at 04:02:46PM -0500, Bjorn Helgaas wrote:
> I don't think the Root Port is always passed into the guest.  From
> 1ae8c4ce1570 ("PCI: Enable AtomicOps only if Root Port supports
> them"):

If this device has broken support for iommu translation entirely then
vfio is unsuably broken too. The right answer is to refuse to attach a
paging domain to such a device, I think this patch series should be
enhanced to include this.

Like a qurik that says translation is broken and then def domain is
changed and paging attach will fail

Jason
