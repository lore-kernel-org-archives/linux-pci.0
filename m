Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336E374187;
	Sat, 10 Oct 2026 08:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622083; cv=none; b=oa6xqxHG0etq+R95a5W445uasYTeXj/v+UkfPHgJDyOCcXWOyULW6C8Og4OKHSSgOepwZdRJpyRIIyQ/OmuKaBc4oAPVlZ6eODcxv/4n+58RrAUgNkp8EqFdTda0uAjdi4dv+2BUQJLC9ErVbf721n0cnDGVVD4/oYcrfyXUD7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622083; c=relaxed/simple;
	bh=ls/4e4TTxmpeeTi/kMhBzjBeeG2J8NUVdjBhBVpVSn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAWP+eom7Qq0AoNKNUSeuuU5ym4unfT0rC93TVMCWVztSumorxmfuC8DPfU2VBRSpe5PSOOl8Ttu2I4Sby1wX/NclulJ3eRVHYW9+SfCpuzdjt39Fn8LN57FHoNtVeOdBANQunoQHki/+97Ubm/1nXX/uux8chVil2P3t3n/ACQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+QntHaB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+QntHaB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D321F000FF;
	Sat, 10 Oct 2026 08:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791622082;
	bh=9aAKNdFlAWIBUhCteIbdgam8eQs/tWYWWSOa0TvAgNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a+QntHaBhv0z8VDbqJJkqrAwEbrFgBRg9/Xdm5ENmSUmHKoLcSJ8FMMZ1gUr4vKt2
	 kGmnMkcNDCeDjoev+XtP9mnEW/W3AbTtLQlms8kGI99KHAiN8gB4Ms0D0wlymWzpY3
	 A9bZ3rVrc8o9I5DkUPZn69Dq+TWk/7MmKxXr0QQB+04WP/nEaGg0ZWk5RR+xz+Bss8
	 7j/ghcFbgoFQw9puG4IAQz8wyGEuft4Vd85CchZXZtPtCYMZJC3Cw2LlLaQBeKgVQW
	 LkWEQNOgeGNWM1wyUpEfoQkQoV3dm7cHU5Fl9S+m6qv4N2Kw4TOV+2TKCNPET8VLZ9
	 VReZAo7MXRnpw==
Date: Sat, 10 Oct 2026 10:47:52 +0200
From: Mike Rapoport <rppt@kernel.org>
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
Subject: Re: [PATCH v9 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <asn7uP123pDkdkSm@kernel.org>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-4-dmatlack@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918200640.887030-4-dmatlack@google.com>

Hi David,

On Fri, Sep 18, 2026 at 08:06:29PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.
> 
> Add pci_liveupdate_setup_device() which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() will run
> and convert the array of pci_dev_ser structs into an xarray so that it
> can be looked up efficiently.

...

> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 3781e2b5f095..8af20f558086 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -273,7 +273,7 @@ config VGA_ARB_MAX_GPUS
>  
>  config PCI_LIVEUPDATE
>  	bool "PCI Live Update Support"
> -	depends on PCI && LIVEUPDATE
> +	depends on PCI && LIVEUPDATE && 64BIT

This could have been there from the first patch, no? :)

>  	help
>  	  Enable PCI core support for preserving PCI devices across Live
>  	  Update. This, in combination with support in a device's driver,

-- 
Sincerely yours,
Mike.
