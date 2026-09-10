Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4312C3A1E8C;
	Thu, 10 Sep 2026 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084289; cv=none; b=nUxAVAlbUkVLwDc1wahroLwGyeErOCvp3Z8hLx98nzk1VQNw7bHdo0UhYRFDDhMnPgFvLOJFuVdmXMc7Jkm5Nz7CYEpFSfe3XAlWKzjBNDoRbmIbdKF5EZ4cgXaH9vr8H9Lt1dCqvpIOFlXQXL2zBbavEfzCD4y9nD0ELGYVkRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084289; c=relaxed/simple;
	bh=l5ZrRK7gSFsX0OGvJSNjVsVYmkSH3KyNuVwJEgGY4QA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KhwHHcZEE8wqMeh3bhtU10Agz3TFdidkAk+Rh34LWM7lCPorqD6ibpg+69VDXcFmHXdI0XdPzIDY3u/VHL2bKhLPHI1Dz5PKU91eTwVICwPrzZFTv9eKpzzHiWS6FwCFzUfR33CUJitnNWRM5KD38qfBqS8mDBVpucq9SJHbelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVJaDbr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVJaDbr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AF91F000FF;
	Thu, 10 Sep 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084288;
	bh=EchVdgHD/jaEOcGNwu9K1D/RE/PHTaZPan+sGsBz7Hg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=eVJaDbr7TDZmKSMVzTSzTnbr6LHPdVB4T8TxUGUgkzVL2dnOJj+wLioEQMQFNT3ah
	 EDa8rpCFBgV+rnysoPzaOpgFMxYYbo6Pqs9IDGAnRjH1SCRWeQAno8HW7ro0Srunsp
	 TwjzW2QzUsiPSGwBN81N923kRd+vNzY/mtS3h5Mgqmm0nw5zmAtkqRGBLWuvO0dk/y
	 T7sC6NnhLKcVOV0B9w3Q2t3F20Bkgj7A8yWD4vKMGvehrAyuHIexfk0nS8hyD53iNM
	 M3Au8yPby2Gvs2mOCaOtk75szaMwkTrZFJK3RlCxg0htPYfabgJWieRiyt71eR9ILS
	 HiP7AziEsSSfg==
Date: Thu, 10 Sep 2026 18:51:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: kexec@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vipin Sharma <vipinsh@google.com>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v8 06/12] PCI: liveupdate: Auto-preserve upstream bridges
 across Live Update
Message-ID: <20260910235126.GA367952@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-7-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:10:00PM +0000, David Matlack wrote:
> When a PCI device is preserved across a Live Update, all of its upstream
> bridges up to the root port must also be preserved. This enables the PCI
> core and any drivers bound to the bridges to manage bridges correctly
> across a Live Update.
> 
> Notably, this will be used in subsequent commits to ensure that
> preserved devices can continue performing memory transactions without a
> disruption or change in routing.
> 
> To preserve bridges, the PCI core tracks the number of downstream
> devices preserved under each bridge using a reference count in struct
> pci_dev_ser. This allows a bridge to remain preserved until all its
> downstream preserved devices are unpreserved or finish their
> participation in the Live Update.

This seems to hint that we're going to allow bridge reconfiguration in
some cases, e.g., for hot-adds.  The simplest case is "leave config of
all bridges the same", and I thought that was what the previous patch
commit log said.

What's the benefit added by this patch?
