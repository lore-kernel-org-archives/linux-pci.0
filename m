Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C57346AC0;
	Thu, 23 Jul 2026 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845790; cv=none; b=bWlXxHC2aO9euISqBvYRe/jtBsdTRunPVek3B1zilKNn7dj5iTWTllA13tVIcEQ9W2RaYLs1RiqWCCoHa3dgO9NCs67d1//37xVwu/camHEW/HHEfwl6Y7U2V6X/tjKDHGdydB6ZhcgnQjNylGz7eUcD1GE/+Ux2ct0khCWsvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845790; c=relaxed/simple;
	bh=aKyCgd4CWQduVuiehy3Iu+k2MAqu07TbXXQW9PtvkBU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VXNlkLD/7MSvgvDcHu4BHlx4HPImEUQaxF5t8Lzci9f1tTK5L5ugmzvdSPI6vTNw0YXNkEyPPOymMnx+D4KgoF4T1RyWYr4H1FQN7iZ9cvNxa9zsmoucJNG5AUpkelpkxbWoB7Es4vIV3n2Gmr/WOtF+WQkl59jCJzHtfUfhZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxZW/nu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxZW/nu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF061F000E9;
	Thu, 23 Jul 2026 22:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845788;
	bh=AzhkvE35OLgSJeDoG4ympV/KpNSWvwXjJ0euGOpNYdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jxZW/nu3CXPiWcwj+x6K4YRDb3DrW8DFXGAxUW/O/c41NSdn+3EAAGfV128mF4txX
	 u1ujjcA2PwqcZUC9bf9hS2Igqo07ugIeH4d/G8zLSxxVkDF7rKuq65okwe/EbAMegB
	 Q4xAVC4G8ItofSVuXKgtcHFDz5EW1+Gq4nEZ9boWdkh1PIO7Io9jIZG/LzQCZyMfU2
	 Pfk7jJNctcfToZeLftnQ4AJ9ZmSCbwyht6uQ60I3sWz6Mqc3m4v9iNVllRdCQa8Xu7
	 rTzvBICrwzL/iafIpRv/MiTC0qsCRlGWXIrWPdBjdTl/ewxIJAvdwUrV5Ya/ZhAOYX
	 gev15MW3uJHEg==
Date: Thu, 23 Jul 2026 17:29:47 -0500
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
Subject: Re: [PATCH v7 02/12] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260723222947.GA868047@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710212616.1351130-3-dmatlack@google.com>

On Fri, Jul 10, 2026 at 09:26:05PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.
> 
> Drivers must notify the PCI core when devices are preserved so that the
> PCI core can update its FLB data (struct pci_ser) and track the list of
> outgoing devices. pci_liveupdate_preserve() notifies the PCI core that a
> device must be preserved across Live Update. pci_liveupdate_unpreserve()
> reverses this (cancels the preservation of the device).
> 
> This tracking ensures the PCI core is fully aware of which devices may
> need special handling during shutdown and kexec, and so that it can be
> handed off to the next kernel.

I guess the antecedent of "it" is a device?  Maybe s/it/they/?

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com> 

> +static void pci_liveupdate_unpreserve_device(struct pci_flb_outgoing *outgoing, struct pci_dev *dev)

Wrap parameter list to fit in 80 columns.
