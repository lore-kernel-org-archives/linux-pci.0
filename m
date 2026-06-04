Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2052E2DECCC
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 23:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780616958; cv=none; b=ajWGGqte1l9lVfZlN2El7gRiUJreAt7JZIFxiwmtNsZxEfWkskTVlbvLvuFBVJVTsDOra4yjAKMoiTRJnjbryf+D7ZrDYXnaISHztJraibYSIJT3ulkJ+aJMAo3Q0E+f2HcRrvi0OjCNuWPH3gkJT4SAVZ934wP3gYVeQBxlXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780616958; c=relaxed/simple;
	bh=oJt2fFfQbIMLj8oKYfu7svnYMm4cuFXCaciuIc/eOAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lznE7g33ed39a9+cR3DdzMvPHUHw4W2ABWwiSGxBG3ObsbfvpLudR3qrodlNQZPy+bwcYngLG4QiMehNwXuglbkUJpYr2mVhoMvUBVGTREJpRJfG28wvM+QCJpHJIqjCVn2EBAcGTZ9M8bQZ4UbM6YRcw1tYQLC84eFgdlPYm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHQYVQM8; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHQYVQM8"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7ded779a345so13383537b3.1
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 16:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780616956; x=1781221756; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=sHQYVQM8rcz8KhCQL24gtXa2eymMfA3tX+eHwmyfuefT/a3jbaBE6rK7qs/+9AT7Es
         8/2vdM/nH2WyPuez7CBTVeJ1j/jQDErhdqEzVA0CNNUeJ+eEfdD5krdV7+/ldYmk9b2u
         AtRopFOcphlnfzA7JQmlha7sWpzs62pNvyYqhY0FKzcTbC/CJ8aFtN1BIf/j0+0jtclV
         Qsb8sTMJvo3qjxqmLwQ88VTbylsbpUBvHoPqnM2sRHgE5wAf/JtlxVcJpBEk7dT4nLEa
         oA/Xd4zRKQECiHV0alLAQc1zsEaeZt4kFB7NR9ebw8rJacDHhzXGtSQPFSwzz4CUWjkx
         LX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780616956; x=1781221756;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnTnrGN1rDoPr2XWYDmMjIU6l0/cMGNmMp999cHq+3Y=;
        b=GJbEniLs+ssfdyRICPv1Nld0AWeqY/CqOTKytt6RSFZ/vHO346F2mkS+cX5h14tajs
         wrzHyIgqSmTtYeD/JDHR7PoKlDsYCjn5SkcrcMztabAOxhyHovao4u87uIjFvR43khnX
         1S9mjS4K1mruwEpkTah1IUieItxnucrvBmnA2f6SZGfO6Exdtxs72XE+pueuNrQGGQ1K
         GjYMib3/pnvN4NveRjR79bTHW7UYG15umYsTys1s+hT49H/fdKqiDvrnNeCCn+fBPYEj
         NfrGFGjaKAoZXZxLooO6oRh9i/z/hly7s/LByHXdJoesIYnXhb8qzvD8pmhz1irxAEDm
         ++IA==
X-Forwarded-Encrypted: i=1; AFNElJ/rJLXWm8URm8kKdWBjnaUeitfhYxywt9GVTMwStAYG/osEF9OBl2rOjGAdE7B1tTxtdWBgr9Wkc04=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1L76OwX82ZWKUDNQVonQqwEbo2cXE/8a5spm+qg3+UZAMmtka
	8hjCRZRZppu9CQitORE047E56a7saUYkuyoiYsX34Oxe4TJGnqgOqYkp
X-Gm-Gg: Acq92OF4maOexSlBw4sAU7SwN+d+B+YLKgbKmiW5ojgQb9E0flI9H9bqIbKNyOO3WWs
	+gqI6UKLjt1XFTd+N4Wno3EhzeQf+HSy9ytGKgfsNZyS5nrxytXbN/xRVHpfnTTaIXQncQ01caO
	VvkqgJMJNRj20oStUWB/TJINtBnd1PQ3YQuFO3oPyKvOjWsRaJdR+K3BFGQQuB331s4B2lDImH0
	AZ3ViYZRh4Wyxsnxsq5WTt8ys+X+WrcsqBVwUHhhrHvwvu+P+h+OmN7c1b1yHsiT6O4t3+T5aUO
	hAM1Q57GibLubbPnvtgW0DUDx59u3QZ8hst5LSi8v32IKkBK7zcrrH73yU8btUeVeYEjrijTQwi
	EJEaMGKU4yhvl3rhYMUBsuniD2C3UvVlupssOSvFP4va+OCnKqzAYwnEGQ8BVyLh78w57G46+ph
	bu+OFeyQAS0m/DNr7q7jNsdEgotkHN+g+C5NHDwjAu74AJbxpMq4N7KCAsOey56eQNkTcJRMds6
	8CdVa8xbmu6aMnRDDCzeHhWqzXkmxGz+uroRTdA2ZNM
X-Received: by 2002:a05:690c:c4e6:b0:7ec:5c2c:1d27 with SMTP id 00721157ae682-7ed0afadc30mr12160017b3.15.1780616956146;
        Thu, 04 Jun 2026 16:49:16 -0700 (PDT)
Received: from [192.168.4.45] (76-224-22-216.lightspeed.sntcca.sbcglobal.net. [76.224.22.216])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23492a24sm42082017b3.27.2026.06.04.16.49.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 16:49:15 -0700 (PDT)
Message-ID: <a07763e2-aff3-4468-83c2-d50a9e1605c8@gmail.com>
Date: Thu, 4 Jun 2026 16:49:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Keith Busch <kbusch@kernel.org>, Alexander Duyck <alexanderduyck@fb.com>,
 Jakub Kicinski <kuba@kernel.org>, Dimitri Daskalakis <daskald@meta.com>,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, xen-devel@lists.xenproject.org
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
 <20260604182031.GB2487554@ziepe.ca>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260604182031.GB2487554@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/4/26 11:20 AM, Jason Gunthorpe wrote:
> On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
>> With this patchset core enumarates the SIOV capability and can identify
>> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
>> To support device pass through, devices will need to add a vfio-mdev
>> driver with IOMMUFD support (or something similar).
> 
> There is an enormous amount of missing work to do something useful
> with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
> components in this plan and there are some missing PCI SIG topics too
> IIRC.
> 
> So, I'm not sure how much value there is in merging just the cap
> discovery without a roadmap for the missing parts..
> 
> Also, I'm quite surprised to see this out of the blue, there is an OCP
> workstream that was building out a standard that outlines how all the
> different components have to act to successfully implement it.  What
> is in PCI SIG was just some minor foundational adjustments without any
> context on how to form them into a solution.
> 
> I think it is extremely premature to merge anything related to SIOV to
> the kernel. Join the OCP work stream if you are interested. I think
> the general feeling was there is not sufficient interest in the
> industry to do this and it has gone quiet.
> 
> Jason

Hey Jason, thanks for the feedback. We (at Meta) are definitely
interested in SIOV-like capabilities for device passthrough to containers.

For those scenarios, having PCIe transactions per RID plus IOMMU
isolation is enough, but I can imagine hypervisors/VMs requiring more
platform support.

I hear you on the broader support story being premature. But on the
other hand, this series unblocks experimentation at the driver level
for basic data path validation.
