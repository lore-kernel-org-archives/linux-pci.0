Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795335562;
	b=5iZG745e9f4P2ri/FZLpCjF2evFJLycaJPKRAUL4pORaAe6OQwaCpldfWoOQD94SeD6e
	 esbU9YPto2VpmSStPYgNWPF21IFdflJhyWKCNgDKHhQdplIafcs/NZJCa/kZ6qKUFWcL2
	 u/57cyn7yxlVDPoZySTqZAx1L5rtNwel/zkN+nmW9vO73cCR3bzjpk2hnAHuucB8Ai1Vu
	 1Q3TQHZgrtSKonk5rdHR4Z9Mv4BBDax8RTCaqIGD8oOVEhu2FLHExwPJjSbH35dQ88nDg
	 lXCKXOC4fRyV1GZkf4UVdtPlQUUJ+7YFvdNZDUI2bRDLLuN3RXSkpcpka/zRqyZ1Uug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795335562;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=SZZ+FaVNZ81W5N9A195kfiFuUgvoLvnOZsjSHMvxU8U=;
	b=fW97hojIgyCZw8t5pgiVIPqIEzX1emUDSwCmewTA3UiM+aEM/HzAGozazAIaMGtF9kxC
	 Cjej09RA70wQ7KzdjQxsoRwRqGU0g/oAH+qRBq0wm7XkqlgcDzSGgFcFaXH0/EyTvj/4J
	 p7LiJaHtKo/EC33baqvXevzRRuKmBCGrk3+Q2K1y64xWT8gW0+MJmfS8T/lEctEAr48Op
	 HzApQ/Q1X1Y37motaAq0OMAcJU1fnNXNGz813UeaNMEukXlgdq4O9bkoohXjWzr2gNnY3
	 4H+HUV7fSQmVmsMS79rOjDjGoeG2HIdUxntAGLJHpOYHoymsXcQq+wIIrS63nz//Pbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuObBb11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C624606A32A;
	Sun, 22 Nov 2026 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AuObBb11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AE91F000CA;
	Sun, 22 Nov 2026 08:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795335561;
	bh=SZZ+FaVNZ81W5N9A195kfiFuUgvoLvnOZsjSHMvxU8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AuObBb11SmjvobS9klEq8nSSkb5UNYg6rD8AbEZBcdTNHachQcn5GeDysByNH4JJS
	 K9sSWZGaYbewG8ddLA9UBjTs4AZZ1sYA9d2g8w8ebb45svMEU1fZBurAY10RtfBQD/
	 PPXtWjZ57cRP5bM2o6916uoRN4HSwyz3b9PlGUjQr4y6cZRaU8zJejjL3MdZqdJtLq
	 tluupgXdnz9FwtBqMMXw4qooXJGWUkxsZAeJ2wSH+5CdidkOIqjY/bF5FR2ZvcF7re
	 QxOAAGM1X0eHaivJl+i5Ytw4NqrNhdB3pY0xZVqk/vZYqkZey8pdRW80e4VO5zMSQh
	 GrmYuI5FNxezg==
Date: Sun, 22 Nov 2026 10:19:10 +0200
From: Mike Rapoport <rppt@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Chris Down <chris@chrisdown.name>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v11 00/13] PCI: liveupdate: PCI core support for Live
 Update
Message-ID: <awKlfqlQYhphXCvf@kernel.org>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <DN0FL1752MH5.1FSZE620OJBM0@google.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DN0FL1752MH5.1FSZE620OJBM0@google.com>

On Fri, Nov 20, 2026 at 03:35:58PM -0800, David Matlack wrote:
> On Wed Nov 18, 2026 at 2:36 PM PST, David Matlack wrote:
> > Merge Plan
> > ----------
> >
> > This series is intended to go through liveupdate.git, the tree listed in
> > the new PCI LIVE UPDATE MAINTAINERS entry.
> >
> > v10 and a follow-up patch were applied to the lu-pci-preservation branch
> > of liveupdate.git. This version is meant to replace them, and applies on
> > v7.4-rc1, the base of that branch.
> 
> Patches 08 and 09 have Reviewed-by tags from Alex now. I have a v12
> prepped with some small fixes from Sashiko and a comment cleanup from
> Pranjal.
> 
> Mike do you want me to send a v12 with these changes or send separate
> fixes for you to apply on top?

Three fixups on top will do. Just please send them as [PATCH] fixup! as a
reply to what you are fixing up.
 
-- 
Sincerely yours,
Mike.
