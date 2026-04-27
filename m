Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFEB3A63E0;
	Mon, 27 Apr 2026 21:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323931; cv=none; b=I5BAwPDf7SLFQn+QQAGGS7H/H4JlDgn4plIg5HhmakchXZ1XZlddmIqUT8TWcuXR/yzsVhtXhNFQerWjIn8gm9OJz+M2PMo0fUPBjgTopBROsB658zkSOK3OV52kwzWYqGK5YLqT4YpcmsTZwpdgmLpVYnU9AOmJO60uhAUd5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323931; c=relaxed/simple;
	bh=BKvU8n8CmmLGOo/iWjExHY4UTAHtpbclc/VETFqsn3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mB9tPAc/vWAZxdoUQFXUv5M2PdPJjHpwM/1py9qxtL1vmJ1Dm5BZ0lLKTWQexOw5f5looyCpKG+XvUo+O1fgokA4B5N9bZL6PBT8EQb3xZXpyKcmfRZ8iBQw7BemBjXY4T0et1kOXpZNV6shPREA2eBzh/alb5MCM+k0j9CnnbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2Yasvoi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2Yasvoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222BEC2BCB5;
	Mon, 27 Apr 2026 21:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323931;
	bh=BKvU8n8CmmLGOo/iWjExHY4UTAHtpbclc/VETFqsn3Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f2Yasvoienx7V+cC4PCEeVthUNsSP6+lU5/iKedPkKipBTK3W9hQlKQOizBDpjzWt
	 tmNepResRGa9Robr+yPwMgrRAe7aQXzQ2jhIQgRJwvJEOo5f7UtB42dPaDXfDIIcUX
	 afIekttok4tFW/iR+rCngQveUvcIZiUoA3WIpOc8oBp48Bn3VRBy58KHuIkjYwkEFc
	 ftQaqsh5nTtMk8ievxIuK556Wzq+jWivXo+c6aFEfpXiH+ww+Ds4y1wq8ksZKb1Iiu
	 FW8X5Rtq0CoA/Jo+Rum76rkryfic5YtzKPIShtN7H0Nv1vappKhtvXjZXcsJO2PIOL
	 MZ+Bgj4uYDiiQ==
Date: Mon, 27 Apr 2026 16:05:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: iommu@lists.linux.dev, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>,
	Alex Williamson <alex@shazbot.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Leon Romanovsky <leonro@nvidia.com>, Lukas Wunner <lukas@wunner.de>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, William Tu <witu@nvidia.com>,
	Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v4 01/11] PCI: liveupdate: Set up FLB handler for the PCI
 core
Message-ID: <20260427210529.GA186381@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-2-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:05PM +0000, David Matlack wrote:
> Set up a File-Lifecycle-Bound (FLB) handler for the PCI core to enable
> it to participate in the preservation of PCI devices across Live Update.
> Essentially, this commit enables the PCI core to allocate a struct
> (struct pci_ser) and preserve it across a Live Update whenever at least
> one device is preserved.
> 
> Preserving PCI devices across Live Update is built on top of the Live
> Update Orchestrator's (LUO) support for file preservation. Drivers are
> expected to expose a file to userspace to represent a single PCI device
> and support preservation of that file. This is itended primarily to
> support preservation of PCI devices bound to VFIO drivers.

s/itended/intended/

> +++ b/MAINTAINERS
> @@ -20555,6 +20555,18 @@ L:	linux-pci@vger.kernel.org
>  S:	Supported
>  F:	Documentation/PCI/pci-error-recovery.rst
>  
> +PCI LIVE UPDATE
> +M:	Bjorn Helgaas <bhelgaas@google.com>

I don't think I want to be the primary contact here.  I'll see patches
regardless since they're on linux-pci.

> +M:	David Matlack <dmatlack@google.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +Q:	https://patchwork.kernel.org/project/linux-pci/list/
> +B:	https://bugzilla.kernel.org
> +C:	irc://irc.oftc.net/linux-pci
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> +F:	drivers/pci/liveupdate.c
> +F:	include/linux/kho/abi/pci.h
