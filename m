Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4039B495030
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 08:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398327; cv=none; b=WRZzhaArdPg4z1wsH9Pn8DubBYEp/C4MLlXiNoCNUyYCyBK033NvOLVYZ73gNzRAH3wSbZhtIAyoNsPrsbaLGKeowuLGcA1HQfA1v+RQ1MNaypX9Bcx5UY2uaF3MEJGi+LipOCuvf7LvAAIVwE1IswlYEv5rYbkbAcx3lBUTGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398327; c=relaxed/simple;
	bh=7j1FjvxzuKjZZZjuEe5PbaUUzNqOVbHpCzh8Twzsigk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyYwXUBylYQGWy7HffXh8iG4NmYQEn2e1dEY9i44CXQl+X5ZZT0uj6c+DlS8c5gVfIjn1VqdZQHRG98EsQ5j0QNWlDI9TKoh9VhJ0s4wwGEXegnLHu485FSC5xndvHknadc5qlhv2V25UTcdBgJMZyq8Ia5H2QW0Thv1PZN02AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HsrCpCkf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HsrCpCkf"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e9f6a16afcso18275ad.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 01:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792398325; x=1793003125; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zdvEr7CMGHUXYm14SkrvOmvdQ1yeNQ3r2FisQDvIWDc=;
        b=HsrCpCkf2TTzQJ8/g+xCfnNv3bDC2T9Tx/h7rEvfbHSNwjQrx4vuvxRmRYTMkubLrd
         i9xL57vd+MIIs5q/acz77N0JK9Cm/bkfkuLXSAv9OFpid6J5cLG8bh5RZNveLImOei3B
         2lizDp0EjpI8OazUayo7cPbds0GnDy+44kWc0BjM0YPZszVFeRoZGiNIfRl74fc2W9Te
         7llNZsNeGX2E3PL/Jt5rowhAjKnjkHV6toN/OyZxOu0os3lio+AQNQNwMrq0BYib+G0k
         JwlGxiniQVQwEvkhHfWNporrq4YUxvij829DM1NIsbH7sjV04IJB7LCptFXEjfClL7nm
         cENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398325; x=1793003125;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zdvEr7CMGHUXYm14SkrvOmvdQ1yeNQ3r2FisQDvIWDc=;
        b=jNNwu/QO1iESJZ4Qu6linOQ7oVu60SvfKsiZ2B+ntzKEhN3dIopgAUAazwEHKplDOp
         yHls/I2jQa1Jrk+tsvaxAVwbZzl3xeI4tONZHZXPif6nSXVNNautKutPbFduOT5yEx2F
         qJXFhxMseGgFqoC5TE6rzw/FYD6mI8Ta/rxJZ/ObG+BicxV/vrdp7NRda1wxfRyA4Bga
         Iuc8UN+QUNpFV9wksFOyVoaawgcn+tijSdRsuNjThhXnhLeIWwXtt/RjObdLjHPu0H3O
         fo8mqLR2KJCfffgVgrskhDbanXI2zUF3w2nucWavPdCg8CuCR2GRGw9J32d5AQDD08a+
         Y64A==
X-Forwarded-Encrypted: i=1; AKwUvBxRxzntU5ZNk/JqR4J1pmmp4box3qwQtxJipZvYoWzf8yVowa/d0pF6qoO9q+UnyViZHIUfhyBrYps=@vger.kernel.org
X-Gm-Message-State: AFq9FYJgh79M2NEu8hkFeICovutnNxs8WIKlSLdxUWqmPpmsydw5XEQd
	mtu2uUip1Ae1aV/H8kGHnNTu7h1tv+XaZM+zJr6lrwDsRcFHT0H3wCGWP/VUnTD9ig==
X-Gm-Gg: AYBFou1INu5tnIuUvAx0s8zjaweBQgS653Mr9JeqjCcIX+VQ5ncV8y7ZX3RCbKd3xlF
	S1TltCzTVKW9auu7EjRfTRt2vmMQfMpkJuaFYbWKE9Vh/PcUin8jvFC6cOGrBv1BemnIN5y2GGH
	D0fND0+UEv1fx6l7ArxKmsJuc1TRqWcEanKDMIVHParQP7aCkL7MTdCAwa/5YiMz9gjT0q5Wuxg
	VIOmGVftdXEbwsRsoY3lWJVnVHhT2xfsP/S8oWBX7quPPRaDVKdNRhTMKy6ffs21gmzGMFiihMm
	ynWs8Ep+HhHSInd5AmiMmz+IdK8jxyy+LU0zxpVIppnTu78y/3cWCYlxHD0kVc2sxa354h8zXU9
	9XldyDvU2eBd/ovHfJ46pBHOB5KwrmIlCFBi52HQwaaGjv2iO7EKD+VDEYIGRt/PkGDnF7TmOfP
	a+9X8PfhMkAoMb8SzqfiVK6BjKrI+lL5WIxovr0delEuKA1rNXho2T6owAl1f/WchYJuQ+qw91+
	yX0PL/WKMv08l8qg+uJxKgytVVJ8F+yUBGt9qCOMJ4eVGGO6d1/YuLHRFhLi+agj5trsPczqVdx
	qbaMXklztG+ipQV9RZ0DEIl7LDK3/2D0TsoY0lc=
X-Received: by 2002:a17:902:d506:b0:2e9:492d:f1a0 with SMTP id d9443c01a7336-2e9b332b549mr6191375ad.16.1792398324879;
        Mon, 19 Oct 2026 01:25:24 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94794dd9sm19384883a91.12.2026.10.19.01.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:25:24 -0700 (PDT)
Date: Mon, 19 Oct 2026 08:25:16 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Will Deacon <will@kernel.org>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	Ashish Mhetre <amhetre@nvidia.com>,
	linux-arm-kernel@lists.infradead.org,
	Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, rafael@kernel.org,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev
Subject: Re: [PATCH v11 11/16] iommu/arm-smmu-v3: Add CMDQ_PROD_STOP_FLAG to
 gate CMDQ submissions
Message-ID: <atXT7FtKrA2e1f8Q@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-12-praan@google.com>
 <asZSQRSYBjbUaaH0@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZSQRSYBjbUaaH0@willie-the-truck>

On Wed, Oct 07, 2026 at 03:08:01PM +0100, Will Deacon wrote:
> On Tue, Sep 29, 2026 at 03:45:05AM +0000, Pranjal Shrivastava wrote:
> > Introduce a new bit flag, CMDQ_PROD_STOP_FLAG (bit 30), in the command
> > queue's producer index to safely gate command submissions during device
> > suspension.
> > 
> > The flag embeds the suspend state directly into the existing global state
> > The flag is checked in the cmpxchg loop in arm_smmu_cmdq_issue_cmdlist(),
> > which acts as a Point of Commitment, ensuring that no indices are
> > reserved or committed once the SMMU begins suspending.
> 
> I'm not familiar with the term "Point of Commitment". Is that something
> you came up with? Without a general definition, I think I'd prefer to
> avoid using it, especially as it sounds like something to do with the
> Arm memory system (where we already have architectural terms such as
> "Point of Coherency".
>  

Ack. I'll re-word this to avoid confusion.

Thanks,
Praan
