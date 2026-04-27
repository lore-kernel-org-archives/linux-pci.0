Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6373A1D14;
	Mon, 27 Apr 2026 21:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324082; cv=none; b=CAyx3zfMKmkVMQtcvYKeB2EqSXUCOi5OcY4sIyMofU4pFPeNb0mMH1Ken1fRSFGUH0vrh5ohLfpdvcdkangkLDOtjooWJ7T4791Ny76TQAxN7suA/J4EEba+nuhmk/Z/aNL/mqxUhWFfRoHs6Av97RK4k2O6WIBRQ6EbXehcOhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324082; c=relaxed/simple;
	bh=HAhIww82BvlkJia3sROkCN1IHhF5mIbxG7w4f+smGgw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FDAQaM+GoFg1wpc8paFtxCFWnSQuolnsEEfoLpgZMtPe9Ho+2mL3vlCT2NxaaoyouBi7TcINhfbA4sfnnglodhL/8adeK3nHVvA8Wtl457cyDjsPmYp71eodZWW2N87lZtUaBz0JivMZBXKHVQsfVrvydgnOwdOxqb9duEAXgeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGEjjy4F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGEjjy4F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010B0C19425;
	Mon, 27 Apr 2026 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324082;
	bh=HAhIww82BvlkJia3sROkCN1IHhF5mIbxG7w4f+smGgw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FGEjjy4FAaFY3A5PuDOdwJ8Xj4EEJiA4g1yL5cIGR7Vn92lO9AV/7gQgs0RIJp88+
	 RSTByY/JniJOtzZ0Blkp+9wjKoA/q3uA/W4Os0CJ2ORUAWPdqd+ACdpKfo/pIUhQ/n
	 Qz/f5MkmYFlb4sXREbt/X0QQc7hmBvgosVjVBeM8qOrO81b8+/BOPDEXGa885+Ix5I
	 avII16tNuOj8GG1TOOxM4oUwXtc8+P8ELkjcrD4GHUMnMVFQWLd8ZhsTj4bKZOsp2d
	 akjmbU2gDr8yaabA9KPzS3D4e/OQNnGX3sOg3vJEwuK7mMSs6wnM/Ur/TEtpTvdF36
	 lF/CQTdsWnCAQ==
Date: Mon, 27 Apr 2026 16:08:01 -0500
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
Subject: Re: [PATCH v4 10/11] PCI: liveupdate: Do not disable bus mastering
 on preserved devices during kexec
Message-ID: <20260427210801.GA185338@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-11-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:14PM +0000, David Matlack wrote:
> Do not disable bus mastering on outgoing preserved devices during
> pci_device_shutdown() for kexec.

> +++ b/drivers/pci/liveupdate.c
> @@ -132,6 +132,10 @@
>   *  * The PCI core inherits ARI Forwarding Enable on all bridges with downstream
>   *    preserved devices to ensure that all preserved devices on the bridge's
>   *    secondary bus are addressable after the Live Update.
> + *
> + *  * The PCI core does not disable bus mastering on outoing preserved devices
> + *    during kexec. This allows preserved devices to issue memory transactions

s/outoing/outgoing/
