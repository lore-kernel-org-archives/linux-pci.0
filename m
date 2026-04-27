Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364BB36EA93;
	Mon, 27 Apr 2026 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324050; cv=none; b=SruYgohuXSW8wC1zV+nGrPYJ39bewOZxqP0xzc/sNAx5SUCqNGZr1DlZRkOeTNiTZugGxpSv8Phbpz1nfEgxeUWe/oaQL585QdDLJjJ0OFZdHWLySrD5yviHFChb4t5rj+Apd+KXXqFiob+imt3pWW9OU5UVzy1mVl/ooizBFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324050; c=relaxed/simple;
	bh=eTCpxLZv7LpMubk8KJGg69LwpKjJ4rCvsaQuqSw9Ybs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B1WT9Vk06HqrtY+cO22uvKLv/blCwZ3WgrlVzujpTO0WZCD3+1xfd4tSGCCif3waBEv10ubdr6kMyrtJ7IaCP9vAmEHEvuH3qCbQRT63EScKCl4wX/i42K2EU/IZQbRVp6hOag7ixCgasOAX68B9J/jlcjgkptBRLyKi2i1MUXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXALoBTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXALoBTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5968C19425;
	Mon, 27 Apr 2026 21:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324049;
	bh=eTCpxLZv7LpMubk8KJGg69LwpKjJ4rCvsaQuqSw9Ybs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YXALoBTZ96HEbK/in8Mcqf+FcEg3cZ5fOQmzXfQw8l37KdDHJKEmdE1SvjbZeiRUV
	 VjQLZPadaTR3oR6VVLBF0kc78fhKbe+XimUyJpt/bNLks1VVxuBNFtwP4Eey0qEitS
	 d5cnToMQIQCGp38txEqfX8AkS3c9uVTSLVP9ETBVw0YALt9UsN8VG7oBDzRgckokRb
	 tVJHOiw5mnG6eLdlPfV7lNskftueKD74BpFt5HaWzYuh4tsk9k1bgjN+gzC9jPc4vn
	 BLwseIuVEzRz0DUfkLvXU9vK1VX7WcRcJJ10fQd2yr6magkpA+cv8wcamZrmJjRPwO
	 QDO5vWHVk853w==
Date: Mon, 27 Apr 2026 16:07:28 -0500
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
Subject: Re: [PATCH v4 05/11] PCI: liveupdate: Inherit bus numbers during
 Live Update
Message-ID: <20260427210728.GA186712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-6-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:09PM +0000, David Matlack wrote:
> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved.

> +++ b/drivers/pci/liveupdate.c
> @@ -93,6 +93,19 @@
>   * bound to the correct driver. i.e. The PCI core does not protect against a
>   * device getting preserved by driver A in the outgoing kernel and then getting
>   * bound to driver B in the incoming kernel.
> + *
> + * BDF Stability
> + * =============
> + *
> + * The PCI core guarantees that incoming preserved devices can be identified by
> + * the same bus, device, and function numbers as prior to kexec. To accomplish
> + * this, the PCI core always inherits the secondary and subordinate bus numbers
> + * assigned to bridges during enumeration, rather than assigning new ones (the
> + * PCI core assumes that the previous kernel established a sane topology).
> + *
> + * If a misconfigured or unconfigured bridge is encountered during enumeration
> + * while there are incoming preserved devices, it's secondary and subordinate
> + * bus numbers will be cleared and devices below it will not be enumerated.

s/it's/its/
