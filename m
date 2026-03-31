Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CEC1A724C
	for <linux-pci@vger.kernel.org>; Tue, 31 Mar 2026 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774915418; cv=none; b=mP6C9aSk2O4kCNyT3GxLOjdDdZ31Q3I+h3lFsC8KHZ6m5+KgXGgiOfCQ7FhFVeXT12EFe+iEm5NEaMPEJuucGObJk9gKL5stzyuYBKn6HfFiwyd+1IpN2UqHEUacxOARmqVcMij4NG33MnVYFUCGCKtD99e0gtIutUuoRoX2F5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774915418; c=relaxed/simple;
	bh=tGFV2VhgTREgrfP98G0uJ3HUP/CSGaSbu+qGayezE0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olZ+Ax+2ZX4P6Dm+zB0anbiXdHHzvio27Bl/+j+Gc3/TUFU53+4keZDH79WL0WYmI71xLGx1aeimfEuA/2zevp0KhhAJQPf9MuX/Y+1Fz+9nsdge+mtnqpqLP4stClqwFppFdnyN8DvK95fW3LUX8DY750QMmd3EaUj88jsFqbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SLP4FRdH; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SLP4FRdH"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8cd77786e97so511593585a.3
        for <linux-pci@vger.kernel.org>; Mon, 30 Mar 2026 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1774915416; x=1775520216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W4YBgDlQG7t09O0fcPskt9PfuzfmSkfNvE01lxkkeEk=;
        b=SLP4FRdHz+CzxQ6VGVwelbz2oEWoQ1X35DiIGfJpcj0QPxlYn/KmJAsUuNzt6fcjDS
         oWFof3bAvc5j9KdXtQI9f0VMQa0DvcYaweoG2FV3kW+pV2IW7exO/w0Jq5JoXb7RzBFU
         +adMRpEIOxmBYmoJ6Cd4CIPGogUaGjpgg9R7KlEUEusODFVhLu9PmurFQGEwwH568in0
         /c3nKwBolvQhoYhiQw+G+W9H4e+vTwj4jenX2n+3SNc/Hx90+MZzdERumY/6y3+1RkKq
         xHRskO965ayYetBnW41UBqBIEHmT4XK4G3bUOJVLeZZjQms3kAdDJ6ChpuO093uiFxnf
         Q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774915416; x=1775520216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4YBgDlQG7t09O0fcPskt9PfuzfmSkfNvE01lxkkeEk=;
        b=guQxd31kzh0/Ce35TpofYMwpkZBxlx9Z5ku3tW8XD+lEx3K7StEOjntJvuaCfeuWqN
         6+99tRdx3Xmu3UP1VIRhvn9jdhz1VGsqBVsE/Y1Qb+zPsTysFYGgwm/HLX01HzVAxPRz
         P982WaeN7GkCJ746iWQnk37afscYjEJZTmMtVp/6//AfCAuSyYGZC6Q60WE+PdUjicnA
         CrirSEy9nd8zu03Xl5ZMW5kqBFtZVqxa5QKGFvQD8VOXkLAkq/rZ2s49FWzXh4CYuwdJ
         fY4w1324m1FJTX7+h2g/E/m3Fkq3oDlsdIHJABglTfj1lUIefCPI4wqvkNkrPSrqdwbi
         aS0w==
X-Forwarded-Encrypted: i=1; AJvYcCVBHFXh+FASka91AwZOZMMlxq6uSsqLlAVW/zk1Z6TJSufpier9ERGBNB0CGJOH9VtClpn56x0KCdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLHcMVY3FKP5ul+iTuX4Euh+d5xJeziAcSvioARf6CiseORyaI
	ueZRj6H1drcRRgvntO3Bqf/wt2RGkBx1SsWv9ZtLL1XsJnQwstgP9/ItT/gvVrA3Ot4=
X-Gm-Gg: ATEYQzw+zJgWzRwHsO7ejuulbXOYI3RuIvcHkFfB4zPt6m5WWvJwaYBzV/qyKzkgiQO
	hByjXKAVqulUacX0g5uulVkQIQ5VO0eXl8FZRj4IIRLh5DrfMTy2F3rZeNFMpEO4DVhSkDEnWIW
	MVd0YpmO7L54MVH+jDWDwG9Rh9RBFyN9cvhlAXjxpb0tqX14YmXPM68d/d5RtqaCfQbTdT2FvlV
	2dxYm5OvR5OhkaLRhUURzVAdd3pqAdoQyQcKgyTcwj1wDV7dA8xitYpY60VkDC/FVEqYPf9XDXK
	J97Cnp9pl2YLGa7LMXAYNxIRiTUOzWol89k8/NaS5tRmPjLFU4kgTuaPdirXEyfbnXuVHajjOmY
	5NmJQKuP/IISEMYSCuHREjtFLW7vhrtu0HWGZD3/zXhtVjVRCW8xUtGWDGMWOKqdIZsVJDTdHAU
	onEbj3jY3RjVqpWURA8SvR/jLAYf/iRVUYkZ7ciPgYwC/CZcy6OoUj0YCxZvh4fbeFNBvH3g==
X-Received: by 2002:a05:620a:4482:b0:8ca:fe5c:ea6d with SMTP id af79cd13be357-8d01c842aa8mr1753223385a.59.1774915415598;
        Mon, 30 Mar 2026 17:03:35 -0700 (PDT)
Received: from ziepe.ca (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net. [159.2.73.22])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d02806a37bsm712637385a.34.2026.03.30.17.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:03:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1w7MZy-00000005rSd-0n0u;
	Mon, 30 Mar 2026 21:03:34 -0300
Date: Mon, 30 Mar 2026 21:03:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>, wintera@linux.ibm.com,
	ts@linux.ibm.com, oberpar@linux.ibm.com, gbayer@linux.ibm.com,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>, mjrosato@linux.ibm.com,
	raspl@linux.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
	gor@linux.ibm.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v8 2/3] vfio/ism: Implement vfio_pci driver for ISM
 devices
Message-ID: <20260331000334.GI246076@ziepe.ca>
References: <20260325-vfio_pci_ism-v8-0-ddc504cde914@linux.ibm.com>
 <20260325-vfio_pci_ism-v8-2-ddc504cde914@linux.ibm.com>
 <4096cb9d402b1aabc9667d450221cb0922e78d90.camel@linux.ibm.com>
 <3d6457b9-715a-4cbb-9c69-d8a7e7473c89@linux.ibm.com>
 <64e3158a441c79c55febead9aac956c31f034fb9.camel@linux.ibm.com>
 <20260330093646.03b0455f@shazbot.org>
 <20260330155651.GD246076@ziepe.ca>
 <20260330120945.023b2295@shazbot.org>
 <20260330181645.GE246076@ziepe.ca>
 <20260330123925.713edac4@shazbot.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330123925.713edac4@shazbot.org>

On Mon, Mar 30, 2026 at 12:39:25PM -0600, Alex Williamson wrote:
> Yes, that would be the ideal balance of enabling larger BARs while
> retaining compatibility for existing devices.  Sounds like we'll
> continue down the variant driver path for this one-off device for
> now.  It remains fairly self contained so long as we don't add more
> regions for vfio-pci-core to manage.
> 
> This could be a good project if someone is looking though, especially
> if it had a build-time config option to set the minimum region size so
> we can exercise it before we hit 1TB BARs.  Thanks,

Well, it took claude an hour to vibe code a draft from a four sentence
prompt.. I see many things that need changing/cleaning in here, but
the patch strategy and general idea looks sound.

I guess another day of effort would probably get things into something
presentable. We are not so far away - maybe the variant driver path is
not necessary?

https://github.com/jgunthorpe/linux/commits/vfio_maple_tree/

Jason
