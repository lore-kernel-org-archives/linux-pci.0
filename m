Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6221B373BE9;
	Mon, 27 Apr 2026 21:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777324021; cv=none; b=CfHqhlnaTTaM+juwvbJIHP1AHxWWdv7DlPWsTPra1dLAdCJXJmK5vLp5x8I6EbSrt+eN1vdT9tQK7dMq1ImwuQ/p0ARLnGv+0t7YA6dCMORnP2RFjOqIw6Xman3NREP0Qq28fnx2QxS5Db1zbgerqW1aJKFqkPlTu5FNNafNXWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777324021; c=relaxed/simple;
	bh=Ji6QG+tICOp3jZRjVIPmRNoeZX3XNm+1s3nZGqpXmws=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V6n6CO2AiEe3BFDUgN6jCIcKpbE6oYSY/dQtVWh4lJs8jtaLdqdkaZUhOzWBUwD+D82CMQHRipfeqTzw0gRHkZRZsykn1Xlf9cxqkcyIHcNf9QnigP7lp+iQluaOZ/EgSnqlPkJlEoKYj8awpD8t57pikstWJhi6yRBEQErL5/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFGNDaTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFGNDaTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11644C19425;
	Mon, 27 Apr 2026 21:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777324021;
	bh=Ji6QG+tICOp3jZRjVIPmRNoeZX3XNm+1s3nZGqpXmws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QFGNDaTGW9a6kdfYz+Q7sP5WR3ZkbzEL1ZCMz/x/Se8P+hqKd3UU21B0gzVx4pqBl
	 kykxyVYNOR7VMHGZ+ds/id+OC9sE4OJiDDrLvBJuAtwrEL/oYKUj25SReZiK63RWqV
	 zqLGHgGm4CQzNaDmqo+Ta83Ay0qv+7jcHNQkaY/6E5JQ9nFVjxzjC2iuYoPQaq1/27
	 0XleZbQtLDheHJpPJP0IVRsnCI+hQSiEFIetIZfoCYJn1sRQx3kn2wlhuvPKWYM0G1
	 nI8/zJ/fR1QDFe6OK/JGPNIwx73t5SJiu7g/Tn0MksDCYe357ycHL/XROhv+A4Hhfc
	 cSXQLsRyl3SJw==
Date: Mon, 27 Apr 2026 16:06:58 -0500
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
Subject: Re: [PATCH v4 03/11] PCI: liveupdate: Track incoming preserved PCI
 devices
Message-ID: <20260427210658.GA186673@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423212316.3431746-4-dmatlack@google.com>

On Thu, Apr 23, 2026 at 09:23:07PM +0000, David Matlack wrote:
> During PCI enumeration, the previous kernel might have passed state about
> devices that were preserved across kexec. The PCI core needs to fetch
> this state to identify which devices are "incoming" and require special
> handling.

> +++ b/drivers/pci/liveupdate.c

> +void pci_liveupdate_finish(struct pci_dev *dev)
> +{
> +	if (!dev->liveupdate_incoming) {
> +		pci_warn(dev, "Cannot finish preserving an unpreserved device\n");
> +		return;
> +	}
> +
> +	pci_info(dev, "Device is finished participating in Live Update\n");
> +
> +	/*
> +	 * Drop the refcount so this device does not get treated as an incoming
> +	 * device again, e.g. in case pci_liveupdate_setup_device() gets called
> +	 * again becase the device is hot-plugged.

s/becase/because/
