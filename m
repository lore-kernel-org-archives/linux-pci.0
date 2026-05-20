Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9AF3C3458
	for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779294681; cv=none; b=MHu01C99irCFnm0dNiZs7qAWSsHp5U4w5zCHh2kKQN8RYNjrUqmW0CQg/136Gb56WTRlgKEoUsPenG/k0R7OAKiee6441GmbP3I1qypnneo9Yw8jxN/0DHhDvE1OQsgvHBE0wcVstGK5sQV0sIZ/hsFPvWpsEKX+uCOZubaV2TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779294681; c=relaxed/simple;
	bh=ERs3ykJh2yqgI0ypYiTADNj2Y0fUbo21st20i8W7eS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDQ8p5WBzcr0YYOMndsuhW1zosoQpnmeNumOL9MdggvFRSDkLbCBSoHQQfeVgXER7P2J5Hi1s5H8IoPnBPWA7Mc7/zjsHTpr2oZ7k1JVq6vXWbQm6ysvHLFU+WCy9NlLm6Crpi5bGSoR6Mxb3ly5OHLw2mxuOO7jH8AIBuAOWno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=WOHi6zV6; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WOHi6zV6"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-479f7e75a6bso1844486b6e.2
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2026 09:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779294678; x=1779899478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qBBVTBL2F5IGqRG4xFMB1HH7pJSfipEr3J4L0dTDX8A=;
        b=WOHi6zV68UB7EiTXLMw2CLDPpKHH4+cUqVbIGcEavuMkC7zraV15qNI539tOqTuvTn
         e7neIRF6QxZKe1Mm6XC4ZEua4mfPYxnKPb4zGjXDYOArGFVFkIkXdOENRbHtzOwm9p43
         S+sGr01MIkQ3biP6TfzjJse2/AyDaJX+iE9XOpnk2VH3PWtpKuI5+PB4KZ56FQHDx4ZE
         phHZS6KGL6PSoemc061jaofWBDeU2lcg4D/6K2LNYJstiLoxzAcCWcjdt2Va8ZrXPi9c
         R5C0971jrHb9vE1VRDxYbid2/avsL9zKBY6j+2NcDcD4WlFnHBlo0jtkf73SX4QZltvM
         cGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779294678; x=1779899478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBBVTBL2F5IGqRG4xFMB1HH7pJSfipEr3J4L0dTDX8A=;
        b=KT8NmycahmxffyPWyuIebZWfPCVdA9IdO3A+W9BZpCGIHPP91oymvDeGjYJalV4cJ9
         xPQrJjNb/rGxSvY9x3xnA84I+t/rA5xzxSFrGjGFjHnlIWzYG5FuBoqcDTY4WyyNu9IV
         QSXZYFNmEsxZ7iB+GYxDc71ROLzhFdpjrQF7RBV1ka5ZquGI7togvG8R7pSJpJLtm+sS
         SF5T25xNQ/S+t63Aq5v/gBAsT+zG/B3/pQxnhz4LU0GFPMLwCQbid4sx4XI9395iuBUw
         HaHnj0/RLGvTVbBH8ZuaPzyYwo48mhRbosv44k3JWkjW752sZQa0tSpn1gFlGiroQ4Qs
         oHlA==
X-Forwarded-Encrypted: i=1; AFNElJ9WSp4e0+OdSsrQ6AaNlt9oTXwTslgKzmUKqWXo2LcNKkN9WnaiG8SecIO6+g5nY7iF4jzRsg5CmXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRnk7VhBUrV0kJxNk/KFy82ECkld+4v2VNU/rOHaJcU9PdS6aT
	sq20msziido6XDVuRUK2IjKOMPc20FhwkqBjbeHp5GN5YKi3H6pVydLiwW9+ghH6D/A=
X-Gm-Gg: Acq92OHN8S8Q990ve9IUlHsI9hrLjN3PeRbE3Q/CxeIubRduxqEdaFzkQd3l/GTbOTH
	jE7XhZjEElmRBA5QNTTayPlXDf2VeZeXiKSiQvhSpzwomWxsW4T+OsOvrSE5o43U4zLwxm6+ngc
	9TARD5o3ozum3HltqaWQPPSvfPPztgbYBtjjRbq+6iypQXI2KluY6zqn9X3T8ZXx4PUAU3fpo2j
	w4xdabDg6blUuxPmw/3H8IqSTJwgUj9G9nJc/I7EBukFqwnkekuiwoOwFgaf2xJzF+AbL2JuMrc
	42r7FjrYTLnmyYR3yO4m1nzHpRtDPsx2ccK3PclJWfLT2XYjP9i98ksg7MMbQ3T7Sv1Dm5KlfTt
	7zngtn/87HmfCCTbzO1rXSt9kai8AQBrpSl8CjAFsJbVHOYUY0Akr5xK4b4tMGsuMVcPn2bXxFb
	qfpJVY+gwJOsLR696cGY3PdF1bIicz5oVDoa+s8XAlkMuwRqotUST7utIDeSWEX+s2CiIWU7Wtz
	Bzb3g==
X-Received: by 2002:a05:6808:6d86:b0:484:d3bc:f03b with SMTP id 5614622812f47-484d3bd1771mr8767364b6e.43.1779294678487;
        Wed, 20 May 2026 09:31:18 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51645688c13sm195287021cf.1.2026.05.20.09.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 09:31:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wPjpF-0000000HRrF-1siT;
	Wed, 20 May 2026 13:31:17 -0300
Date: Wed, 20 May 2026 13:31:17 -0300
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
Message-ID: <20260520163117.GX7702@ziepe.ca>
References: <20260519135323.1558777-1-praan@google.com>
 <20260519135323.1558777-4-praan@google.com>
 <20260519144430.GI7702@ziepe.ca>
 <agx5-jFkU2skyEos@google.com>
 <20260519145947.GK7702@ziepe.ca>
 <ag3EL10WAIImL9XR@google.com>
 <20260520145142.GU7702@ziepe.ca>
 <ag3gJLtY1jnT17Zv@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag3gJLtY1jnT17Zv@google.com>

On Wed, May 20, 2026 at 04:24:04PM +0000, Pranjal Shrivastava wrote:
> On Wed, May 20, 2026 at 11:51:42AM -0300, Jason Gunthorpe wrote:
> > On Wed, May 20, 2026 at 02:24:47PM +0000, Pranjal Shrivastava wrote:
> > 
> > > However, I'm thinking what's the right thing to do if pci_enable_ats() 
> > > fails in attach_commit():
> > > 
> > > 1. Fail to attach but unmerging the invs_array entry is complicated.
> > 
> > Is it? We should be able to keep the the original invs and not free
> > it, just put the pointer back?
> 
> Reverting the invs pointer itself is straightforward, but IIUC the 
> current implementation of arm_smmu_install_new_domain_invs() is a
> destructive update as it calls kfree_rcu() on the old list immediately
> after the swap.
> 
> Although, I guess we could refactor the RCU lifecycle to defer the 
> kfree_rcu until after pci_enable_ats() succeeds in the commit phase?

Yeah..

Though really pci_enable_ats is not working the way we want, writing
the enable register can't actually fail - it is all the sanity
checking for kernel bugs that is the problem here.

How about call pci_ats_supported() early in attach and fail, then if
pci_enable_ats() fails just WARN_ON and keep going, kernel bug.

Re-organize pci_enable_ats() so it relies on pci_ats_supported() for
all the sanity checks and cannot fail if supported is true.

??

Jason
