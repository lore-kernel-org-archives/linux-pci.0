Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9880839281F
	for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780247191; cv=none; b=YI4VymrRnHYPoyV8RuJhKacwA0FEb1G7+w2AOO4P5BRHv/YewcLDm2hbDN4hWp9OIxyIXiSUZC7Hsp/9L5GTPEpRKsoZ7ikS+GgYPTWEc6W9jmgSqXkiWoi1dZkdjIX663oV66hQO3nbMOfVF73tWyp+fcxwC2tIq+lpHaNMRJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780247191; c=relaxed/simple;
	bh=YjiDVVzZWacAL/M5Ubr5olPaoNX77xqsVgKjn5ZivrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZPo7N157xTYssurzVHxWboTUkZpVLuHmueFEHPdscAfwGFvACquyL9FpeA9qMx2dnPycuEK//LylEBZt4+ghwvqJ9cy1uSw3GpoA1GsI29tLn9oC8hfQyntZxAJ/SptxqI3ZfEp767E5BYTAOTTD9RN/dLOdsujFEO+c80xjw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ym3S6tHQ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ym3S6tHQ"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so425ad.0
        for <linux-pci@vger.kernel.org>; Sun, 31 May 2026 10:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780247189; x=1780851989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BmuO3W1I2r8igx3GUMilp2TWl+RQ7oW1rVuzlsosPns=;
        b=Ym3S6tHQwvZqH0peQAmekER+z0u9eVK+3xQXx6RXGtSblOPonEvPHWn1z7JGjsYxsm
         zKq0h9CwdrtO97jp2d9q9VoyvDYnUqES+b0W1aJxUOmEhSDfJZs3yBn5wVyKoPwM/y9S
         HINa5tQl4OWcI2cYXYWISVCGCzYFhLigBhbZqbLG053lis1/Tp/LxhZ+P0z/gaJdPTSB
         6Ixnn8jLWhqv8W0C6WNO616QgdEAPQhlZ6wHvGyCIoy39pWD6oR7imlvBrB1mw2rEYb8
         ijTCmE1n0hFKLbXZkA5exhgMcZfnUxgA3fuZ67j8h11wChVSdhcpFKnOXyyWLWvxzTs2
         Ue7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780247189; x=1780851989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BmuO3W1I2r8igx3GUMilp2TWl+RQ7oW1rVuzlsosPns=;
        b=Mp3NQF6ORH14M0zIpOkat2YWHKmC5ij5YM0sDQy05oDUZBOJrSbI3JySzMMoDansFM
         JQVRWXxDN2WPul1in+w0zBNUTOzchQ6M0NZbIF84ZQ5pSOhhLsd5VtB9aBxv/S47TmhT
         10HhANXXJrR/o7DFaZV/A0qarUQZ7PkHv4px+/Z4kkJ6SdfsYq1E7hk9eXF9iiKrgHsR
         xg+0Hm8MibZqp97WyOmzJzDzihSBnSYW7nD/AcpY47FoNj7shmRjvMVvkdceGQYqtHeR
         thKqHH/DqepECqu8lwDWbNgtlWLkM9kc503JKwKuNeJNgFkyCyDH3BLz7kGQF4BUjEoY
         8HDA==
X-Forwarded-Encrypted: i=1; AFNElJ/JaVh0eG/LG0Q2E6N/UGGVuAL1LpU+QV1AIlSgF7J6b7Ergkw3wHxGivI2IyrXF9fj2GQxKD5MtEA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+7rynA03F4pSXCemUY24SqBpFptoEEk3zOfWpgcXItAUyYp8M
	cEmOZrRZjQLHlJSi086T4eMLi71EIZLyfmmKYF7pLfCo9BKYgeccqH2fZVHYZPuOAQ==
X-Gm-Gg: Acq92OH53kC5QnIhJwUrxJIUVxFl3SqaMtoysmRRnMp2MIJ/nZrav/7x03XIRmQht4K
	ks1BtdkiEmydnZ/aQyfXf/4CDmNJfgRriLFH8uLirH/2SjDg6/VRyOiS0bt7EAtf47JjfaC1W3F
	bI53Hshs+McatCwooZm/9H7CXIxxkUPI8n6rpL1YwZd3kcu/0fniDTXYHCxXc+ldpTO6veTNoev
	E+qVdvY/AmO6AV9CRywWpwNQnlfsNXeYuJyrfrKJT6QuWKkg1pKajPytTVO18/UmSGg1wP3fYF4
	xlmCP5lNTMVLlN6oawFfVtIaYKnRgYgsLyZwxdSiB5qSiOuqx8ZSXLSOjToYB6gGTd6AZA+yZ1w
	2nxJHanwa39ndnvHllcjD/bSjUxURtbasF8oxRPwF+gyTxI40oGudHtDtVc+UBou+eoEHSG8UPr
	Fyk8CMnsqfHgfelsVsB5RwQQOcB2pDdppsEm5Jh8iQSMxfmSSLU9fq5CQ0ocV4CHX6AzeLqmE=
X-Received: by 2002:a17:902:d4c5:b0:2bd:6dad:7cca with SMTP id d9443c01a7336-2bf975b1f95mr4195355ad.22.1780247187838;
        Sun, 31 May 2026 10:06:27 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c2da36sm97965615ad.69.2026.05.31.10.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 10:06:27 -0700 (PDT)
Date: Sun, 31 May 2026 17:06:20 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, David Matlack <dmatlack@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Daniel Mentz <danielmentz@google.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH v6 3/6] PCI/ATS: Mandate checking pci_ats_supported()
 before pci_prepare_ats()
Message-ID: <ahxqjLg3yRzWhgqE@google.com>
References: <20260529111208.387412-1-praan@google.com>
 <20260529111208.387412-4-praan@google.com>
 <ahoLccjQvmoE90sx@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahoLccjQvmoE90sx@Asurada-Nvidia>

On Fri, May 29, 2026 at 02:56:01PM -0700, Nicolin Chen wrote:
> On Fri, May 29, 2026 at 11:12:05AM +0000, Pranjal Shrivastava wrote:
> > Currently, pci_prepare_ats() internally calls pci_ats_supported() and
> > returns -EINVAL if the device does not support ATS. While this provides
> > a silent safety check, it conflates support detection with configuration.
> > 
> > Update pci_prepare_ats() to wrap the internal pci_ats_supported check in
> > a WARN_ON(). This mandates all callers to call pci_prepare_ats() only if
> > the function supports ATS.
> > 
> > Update the function documentation to mention that callers must verify
> > ATS support (via pci_ats_supported()) before calling pci_prepare_ats().
> > 
> > Suggested-by: Baolu Lu <baolu.lu@linux.intel.com>
> > Signed-off-by: Pranjal Shrivastava <praan@google.com>
> 
> Sashiko pointed out a bisect issue. So, you might want to reorder
> a bit. The patch itself looks good to me.
> 

Ack. I'll re-order for bisectibility.

> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Thanks!
Praan
