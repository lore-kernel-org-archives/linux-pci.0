Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517FD364EBF;
	Wed, 25 Feb 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772059668; cv=none; b=Ya5GSwaF/0flEROpx/A/9DTslIZ3YF4E5J0iHztnUGK8M4VRfGDuMlr+pP3tXAo/scpKCAwjOmsLQSJlUcUCOpTf8pVZg8M6+hm2fFIadT20lmk/9LntFEijgv/uyMyOsigitvybKWtq1HGIl+VZE9QoQ6cg0Cbi7phpB9ToNBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772059668; c=relaxed/simple;
	bh=xWdLF6QkhbCc2tLcZVVjn/HGUxUqWIXlhi0KcVCVHrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QhpsiANXViaOfuvUmRtu81IcoIGqAe+CQiCzjT9VqddggxxUBgRuVUCIYIRKL5llAsuUXxsiEgfP/rVOl9Zx6FmEmUX8YC5bB+jFTxJN5Ms1Hx08EMFLfNBdaAh+N9Pa+P1hr2H6NlnsygSwO73UEfKEyC6XgjjT5AiwK2PzUEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KN3WnNG6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KN3WnNG6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB83BC116D0;
	Wed, 25 Feb 2026 22:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772059668;
	bh=xWdLF6QkhbCc2tLcZVVjn/HGUxUqWIXlhi0KcVCVHrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KN3WnNG6ESqaiUtKkFDTZzH5NwOfPaEq3SyKjlnj2BVvSVQdzrUGi+rO3bBGnd9Ho
	 LpbZbnimfO8+EWuNKwp9Kq/5DffXALvIy8g8aExAHiolfdguYmdbVu0XP84pBoVoDG
	 2ANaWg1zO/7DOmKgmZKDkcv1ZqdjQpAE9igTSVdboUsROFqdafQ4Ta1ZmMLSBkwm5g
	 zQZOt3jfGQKtw6ZQ2AYAzx6QVBaEg7bthNexA/udyyfyBqcl3NkKXPxr3odyqMidAa
	 N9Jhv8lkZdyJYuDO5Mg8YthFxaBnptnFCNCrWT2+YaGtcpTMCUtsROxDVq68gXD+2b
	 uimsyOI0k4irQ==
Date: Wed, 25 Feb 2026 16:47:46 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: David Matlack <dmatlack@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Alexander Graf <graf@amazon.com>, Alex Mastro <amastro@fb.com>,
	Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Chris Li <chrisl@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan Corbet <corbet@lwn.net>, Josh Hilke <jrhilke@google.com>,
	Kevin Tian <kevin.tian@intel.com>, kexec@lists.infradead.org,
	kvm@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Leon Romanovsky <leonro@nvidia.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>,
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>,
	Mike Rapoport <rppt@kernel.org>, Parav Pandit <parav@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pranjal Shrivastava <praan@google.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Raghavendra Rao Ananta <rananta@google.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Vipin Sharma <vipinsh@google.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	William Tu <witu@nvidia.com>, Yi Liu <yi.l.liu@intel.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH v2 03/22] PCI: Inherit bus numbers from previous kernel
 during Live Update
Message-ID: <20260225224746.GA3714478@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129212510.967611-4-dmatlack@google.com>

On Thu, Jan 29, 2026 at 09:24:50PM +0000, David Matlack wrote:
> Inherit bus numbers from the previous kernel during a Live Update when
> one or more PCI devices are being preserved. This is necessary so that
> preserved devices can DMA through the IOMMU during a Live Update
> (changing bus numbers would break IOMMU translation).

I think changing bus numbers would break DMA regardless of whether an
IOMMU is involved.  Completions carrying the data for DMA reads are
routed back to the Requester ID of the read.
