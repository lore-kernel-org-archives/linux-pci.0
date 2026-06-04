Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752F1DC9B3
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780597235; cv=none; b=GaSOVFDI5xAjHI5yQCjfY6nJYZGajqhYMmvpvT28d8xVkJdQ4O3jLGynno/aSHPUdlWNucHFypxWar3eoN1B5RdEvdPEMFye2eO9iippack+DULGt0wSF442I3vQwvhUl/9o4oGY8i3nQ7RvEnxnhDVlDvRr9FSGg37114o1iuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780597235; c=relaxed/simple;
	bh=ouL5XvfeSLQ6GEaEsqJR0/FGgzHrau6qGhqQ/UmaVCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hM2mrdLcw9SspWoTZuUPuM72utRbExIo0kSlwHZZVl/AhpyfO84AdYosDAs346FnVEH4IuDlkMA2qB5iIwu5XUKv9e+wOL0JHKcRfyBL8QFeBY+8LbOARkF2A361/LdF+bkLILKlKzhsEHyxtadQFxe0dxPXQ4WiyPrK3/JRtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bZJM9Ddc; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bZJM9Ddc"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-91587626ae1so118827885a.3
        for <linux-pci@vger.kernel.org>; Thu, 04 Jun 2026 11:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1780597233; x=1781202033; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=bZJM9Ddc41JZholXg+7Xw13JitkdVXhfvJNIwp+n21XOpUUmaTsj56rV12lxw1bACa
         bymQmIsGk+gklIpxidxBCI7znUxxwGpMRQbMhTQnhzVUhy4a4DhwG+9fldnC/DIENL2x
         uyHazBvUC8NYMS4CL7jeZldX2326HMV292vG7eDsYZptXRoYUa+0cmvE/Zr4vZPGRTo/
         OO4mmsXFif3eGzAvDgoJoHZ6LUculXktoVTDGLHRvotMoqXWb7e4yXv+3b5vw0dQuq1t
         eUbZCTx69hQK5MlkjNHbS+EdHvo8JeBKWNLiTKQHTUmN+hh5PJQSAremU83+Aky1zY+1
         70QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780597233; x=1781202033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cznawapF5vO4PWrDdsZF/fc6qNY58JTcnmMkw1TddjY=;
        b=dYhdtCkXfOeSYPOQFC0/uVGz/eKWYDZBJKk8Ot+apDcWQ32OUMafMiOWRpWPG+OSRy
         BLi3GkTqdPVBp7FQWlMio9KPuDfYClpHDBT1x6JNoQFJGLN9YllIHY+3RN2PaGtxspg8
         CDZYNZP23leEmbnUsD+emXnVJMLEE1oWnD/S4onijTx98gXEKAe8oZ28kI7+waJ3sphI
         qkX5aT/nEgdYwxxriTO1j8WPA+s8H6aCsULmGTvF/PH3wu/p35fD6a0aw8ZG9vMgdXrQ
         DI4JgErjqOjmnB4xsTcttHAwkd3D5Rznu7iz2ZqTN970l8NiS3g/hyWArbm7x3PKHVFy
         uEsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9r9RWyyHZ1yMPF85StyCaMV3EsR866Lrkos/RnkmbAXf5m5w/3+c0tWeyD6LLoty2P4wiNZKo27sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjf6fz66GmmY1G+pw4gKCPg9QgpPMWidnTMCT+e9+G/OVm2Il8
	EktEvRMrDQGgtqB9jFiy3WhvbolPVYkh3VHbAT16SZ2GBmVlYYIGuw0sWlRKC0K+zoQ=
X-Gm-Gg: Acq92OEhl+E2QOUjSse6hwJOddLkFdz0dBHhAj2Vs/VXyfg3fUz8/k4vEUbpBvmRv8w
	X+pEZ6HH6FK3CuBlSzTEwxM6/d2GB+9qZVLIItrzll9stU2M7YaDfEwfkGObp4OcUzW4g/cQuBt
	Yet44qEiBXhPwVil9A5zYpH51oUP/mCTOEfKwiJgLmrkOGtyFQlzcN+T3gOEMS8k1VfeTtfRb52
	/TLl3IHDi2/5gJhp+aYKHilX8itH13clZN7+skkjZC9jp6FYDd8yJQwFFJLT4tlOdsxsW4+DuIw
	SS4KR7b9vNsVBaUQo2Lutm8HsGmZgQh5rin2tJqXuB+ECJczhqrx9OvRLeCzfTNOgNunr6s/i6S
	/lGUMD8iINAHOo+cgsBnDMBVIwyyuieNDwtZIl5N+ktCOlsbPgt0wkh2APk+p8jAOdjYlyfxR6g
	26MD4NPTwUXX8GEZl0Vx5NL2SNfgYs+n9v1lFz4Sz7iQJZ4H88DlgIXiK6nzsI6sHrNAdN76yDi
	CM/kYtEZm6REuYC
X-Received: by 2002:a05:620a:a414:20b0:914:afc1:c66d with SMTP id af79cd13be357-915a9c75c96mr40356185a.11.1780597232897;
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd051d61sm58430626d6.29.2026.06.04.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 11:20:32 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wVCgB-00000008erz-2jW4;
	Thu, 04 Jun 2026 15:20:31 -0300
Date: Thu, 4 Jun 2026 15:20:31 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Alex Williamson <alex@shazbot.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Keith Busch <kbusch@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [RFC 00/12] PCI: Add support for Scalable I/O Virtualization
Message-ID: <20260604182031.GB2487554@ziepe.ca>
References: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604150153.3619662-1-dimitri.daskalakis1@gmail.com>

On Thu, Jun 04, 2026 at 08:01:41AM -0700, Dimitri Daskalakis wrote:
> With this patchset core enumarates the SIOV capability and can identify
> SIOV PFs. But there is no central mechanism to allocate/manage SIOV VFs.
> To support device pass through, devices will need to add a vfio-mdev
> driver with IOMMUFD support (or something similar).

There is an enormous amount of missing work to do something useful
with the SIOVr2 stuff. IIRC there is even supposed to be BIOS
components in this plan and there are some missing PCI SIG topics too
IIRC.

So, I'm not sure how much value there is in merging just the cap
discovery without a roadmap for the missing parts..

Also, I'm quite surprised to see this out of the blue, there is an OCP
workstream that was building out a standard that outlines how all the
different components have to act to successfully implement it.  What
is in PCI SIG was just some minor foundational adjustments without any
context on how to form them into a solution.

I think it is extremely premature to merge anything related to SIOV to
the kernel. Join the OCP work stream if you are interested. I think
the general feeling was there is not sufficient interest in the
industry to do this and it has gone quiet.

Jason
