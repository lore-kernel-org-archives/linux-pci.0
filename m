Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA580134CCF
	for <linux-pci@vger.kernel.org>; Wed, 17 Jun 2026 03:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781668429; cv=none; b=VfdMM/iivKjSeg2VkzVA63SszuF6amwVKjqtRHCsJVwh6B8rOQdGmoQjW0jgHieIXpH28ay1P4eDImZHv+jEdmKBcki/ZlYajDrfBuSa0mIev7Flc+DJhbl5J7ze/c98cwPrkALkQy3QcdILyVPQyUzlziqVPlidYhXB0ZjzEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781668429; c=relaxed/simple;
	bh=M+sJwbZjGprqJ5P6dzrfQG1U9gug3I7000Ogu/10Zeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Geguc3qmEUd9hTVP2rtMLtskQvlVfmzQQCGz52mjPb/EPVOVA+zBNI7WMnShoqV0mppBeXAYmzB7vl6tSJ2vSYiGp3QL3ixXxL5FXUvdExzBqkRi/tFx0ifzeRLTHMIJPHQ1WPmtRMbI9DRx6GpB/FwreouLvgbeuHE5rqAL4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-37c6cd1ac98so817026a91.0
        for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 20:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781668428; x=1782273228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F12h5agOgtTKhK7bZXDhJCivRbCg78HbH6b0jQZn4DI=;
        b=rg9TzrOdByoY/dwDQwQGxtW9RHancHEbkrZ0whMFdmrMk6I2ytkFigmIW/a0Bx6guW
         o4J5UtYcntBweqA3fIJ8kAJosIRxH2XlvxiBgMNAcFvH17rXmbAd6gKs4a5A5SRcw958
         fTv2+zEaRh3q5vZwk6ikIOdZ1ByNYyHhYkRN6XdY2ngm42pg64trcYsTMtC8FWoF6buQ
         hbHfqni1+8ZRGYDI7eqG+nTF18GICcnwzCYMpM5vM7MEVprX6MpkzSZfGjH3MfzY2Rh5
         IgXG3dhe66sM8ba9kZgd6hvRrkOXBwKrmPYywjdfJiHDh0dyIq54s7Tg3meZ6nMQjKp4
         R2ag==
X-Forwarded-Encrypted: i=1; AFNElJ8/1Qyl3QdmrHpjzuIxOcc5mRhDhgxe68E7IQ0H5rfdMsbogTtIi+sW8xDM9HkVQauFf+vUV4GHkqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJHuCICzNysiaoCkAmtlut6NfKHZsOkmetSa+fVrLAgO3O/fvP
	qC6YFiSeOtbCzhPKohP3D+KoX18hpkXrzb3GbBL+dxU1gL09vOCCEdIv
X-Gm-Gg: AfdE7cnW3pfD9v8lCaQmll5pWHykUb7VH35c0vxgiz4f7l+1wu3uNkLDkxlIgawK/dB
	lZYmbQDJdWXjXEhBoKUOC0cuf4PWEJYD/+JSNH1MyZX7Vl38bRgzPlmlTmE2DIrE/rcw92ZZSCY
	TGCj1yVc9mHqAiSzSsoWncnpRm0cUYDxEJWYps4Ytpjn7PZkHxyL0S2g1hhLoEyHSkVoiV8h+XW
	23RJMuqu+0zNcTaByIs5wWLjt7vsaNzl4DQy8MeOII+Kdp3Ey/LaHAXDk2GNGh+nlz42yUNP+So
	mMZWUgJWo7NJAnPi/jLB98kM6ldnxG0XUQKNeL9H09fqwlnq9t9xMLA/pSSPn4Rq7SvPrCOwCoQ
	0yRos6WZg0D0/vKHRG230Ua25/q5fuH9I4aZj2JSsqvmUXVP13Nq8vqbo/BSf85jtnt1KoMDFgV
	fA/sRrlG7+ZseDEaw4kohpVt+g/aCtFFDNXOUVGBMGU3oTEjlibuR1X10TjEG8B9L3U0lg8WZCy
	NSt5pkF0QmB5ERJy8QGnxrOc+FwiKUVV8JjuTtX1tgfYBAVIjZaUX9dljD+Bcm4ls4lcKP2Kzjb
	kWjagRjBE/yhXZiL72qw
X-Received: by 2002:a17:90b:3d44:b0:36d:b12f:613c with SMTP id 98e67ed59e1d1-37c9ddbd514mr1772249a91.10.1781668427949;
        Tue, 16 Jun 2026 20:53:47 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ae78csm4435118a91.4.2026.06.16.20.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:53:47 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:53:46 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: fengchengwen <fengchengwen@huawei.com>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	helgaas@kernel.org, wathsala.vithanage@arm.com, wei.huang2@amd.com, 
	zhipingz@meta.com, wangzhou1@hisilicon.com, wangyushan12@huawei.com, 
	liuyonglong@huawei.com, kvm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v17 08/12] PCI/TPH: Add sysfs binary file to export CPU
 to steering-tag mapping
Message-ID: <20260617035003.GA1415869@rocinante>
References: <20260616104621.41915-1-fengchengwen@huawei.com>
 <20260616104621.41915-9-fengchengwen@huawei.com>
 <20260616144224.GB3577091@ziepe.ca>
 <20260616105754.784be22d@shazbot.org>
 <20260616172728.GC3577091@ziepe.ca>
 <c913116a-35b4-4934-b78b-8fa0a08a00ae@huawei.com>
 <a81c3479-1749-4b9b-b913-cfb20c621690@app.fastmail.com>
 <e2db72ab-6d51-4d19-8dba-0612207008a3@huawei.com>
 <c3d7ce59-bf5e-40fc-8f0c-6232c58c7495@app.fastmail.com>
 <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1ae7910-6028-4dae-a462-e7464a35028f@huawei.com>

Hello,

[...]
> If the community still prefers option 1 after this discussion, I will fully
> rework the binattr implementation and send out v18 following all your review
> feedback.

Perhaps configfs or debugfs would be a viable alternative, if this is
something that does not have to exposed all the time?

Just thinking out loud...

Thank you!

	Krzysztof
