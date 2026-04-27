Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04076373BE9;
	Mon, 27 Apr 2026 21:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323978; cv=none; b=B/xwzGFwbxvx5C4bTsC/nPVs3fwC3CIBpIywnLXhIFgHZRJUjpHkaWjMA+lMB/qkgalkhr8jGN1IWIdMq8ekWZ4PbVjkFBhrHxUsvcefDHkB/IiK7FtLITE1k9065h3b1dw9wxBxtfGlQwYhrJpLBDCpYQuAQ+4Ys51D3tUsE+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323978; c=relaxed/simple;
	bh=CIswUHjtV6oSUsxjeWT06cacL6KEcFHO+pUSNAd7kso=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZzzXa32G5psX9rPtuGSyjEQXJNDA1JnhWLjiex/HBea+s1D102raPO/pH5Ho7rGY49eE/DgFO81j2PhQYltfj93rl4fub4ZqHX80rmXDgSalhKHmeyYjKKGEmtvddFMUhK2h0ejqAGKRoZO1aj+Hpx8AZc6h+Z++9Z24TOsSUs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoNJN0KK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoNJN0KK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE4DBC19425;
	Mon, 27 Apr 2026 21:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323977;
	bh=CIswUHjtV6oSUsxjeWT06cacL6KEcFHO+pUSNAd7kso=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YoNJN0KKRc41UjoNkjKTVxHCQ9uHmb1vXRgaeoA4tQWz/iAKTXe43aboUj7ZhDG0t
	 grNENZpJKNHzFBJy7Y506+AuuCHjO1qZfDRXYgBS/0Yw8y5dlIOWegmRBKPba4bB6Y
	 5VcibMz6TPsiqAgZkvXp2IBx61Yw3YfO9M4cAandeRfDj83rXbzcmH2WqXx6KVwMY1
	 tFRBliyM+9VjS8JW20gNO4qb1z7tkpfpIBwBl3Wh8cGH9NaUQh2VAbsD4l95ckOfFr
	 7cMHIO7JOZkCSv8VfoEMbGIMwpAhmicK4vHq6YczTKvrrB2AuD0Nao69SvIM0v/DRr
	 xVcZfTO9P4O2Q==
Date: Mon, 27 Apr 2026 16:06:15 -0500
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
Subject: Re: [PATCH v4 02/11] PCI: liveupdate: Track outgoing preserved PCI
 devices
Message-ID: <20260427210615.GA186434@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-3-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:06PM +0000, David Matlack wrote:
> Add APIs to allow drivers to notify the PCI core of which devices are
> being preserved across a Live Update for the next kernel, i.e.
> "outgoing" devices.

> +++ b/drivers/pci/liveupdate.c
> @@ -43,6 +43,26 @@
>   *
>   *  * ``pci_liveupdate_register_flb(driver_file_handler)``
>   *  * ``pci_liveupdate_unregister_flb(driver_file_handler)``
> + *
> + * Device Tracking
> + * ===============
> + *
> + * Drivers must notify the PCI core when specific devices are preserved or
> + * unpreserved with the following APIs:
> + *
> + *  * ``pci_liveupdate_preserve(pci_dev)``
> + *  * ``pci_liveupdate_unpreserve(pci_dev)``
> + *
> + * This allows the PCI core to keep it's FLB data (struct pci_ser) up to date
> + * with the list of **outgoing** preserved devices for the next kernel.

s/it's/its/
