Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900290;
	b=YxQquPKc1nP2kPKWCOBFJmgAhDKL5z38RmnWwjWdOt/8+/awMi8SX/GSaCy/0UujnghS
	 zSMFD9nRZoktIbd4ObIpr2eXZKD1RumMZyrJGWz7RyXx4DVFJVDCEZCDPr03M+fQHHI26
	 CZ8+wnnPBUWHAbC+reiWh/ueBxRM1XEjqAPtgc9pYEwmteOZk0Zx4UZjAJMGxZ7Uc1f60
	 Iz4vjkJYZHeadv5B490GtF/JRde+gE2tS9QGfNB1zIkvb+z9rGgQeQURLJz5hZqn2dmJy
	 Z7ILPii94Rszqr7kJA/P4is/jlMcFwMBxPqcjHzdtMfRpi4Fmi3u8B8amkeYZwFx5dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900290;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u97daDPbLSvJLC4/kWBpFhMk+GUB0qImCFzFeWlD+3s=;
	b=NyqKNM2mjV3C4BxO/9nEKGyd5b5/O0KxE06KHs64//Gmnc5P2QHaCqGf6dYYGU2VZgnN
	 YhOR9TGAX5zStlQFGSL/T8UOzVGohbKUoI6c0upfjVrasT3iW4BWvCBSkE/pXqxSTHRs/
	 +n/JbtnNl9IqLiKXL9RWErLlvxzOr0GAWsPdBaJtd3iirTU/2AmWLC7Kt32HLuEs+5YJy
	 BN5CGCYtWn8a2/DmymtlriebAn2ZFx5Bv6SH2C99LAc9Zdyj1+aqc2/lbVi2R2fl8hm6H
	 7LCBysr1ZXAHV4P/jPm1pG/c7H+L3JOunwgj23XafhL0v3QXtK2E3nv4Fbh8A9l5Wdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3vd+O2G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EC0606A331;
	Thu,  5 Nov 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l3vd+O2G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1E81F00A16;
	Thu,  5 Nov 2026 17:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900289;
	bh=u97daDPbLSvJLC4/kWBpFhMk+GUB0qImCFzFeWlD+3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=l3vd+O2G2SjYoKoPLf9g2HwDuqf6yOywdTDN34jdKJCkm4lDU/9pxH1c6wvdrUT3X
	 kTuoP7DIa+Ud2h3Xdxo9T2vCXxhQtEq+7t3naaQoPrw6vlsOWYjyP2AhSXumPw7Pgh
	 VrQoIxZkq08axZFxipuRNPD1PaGx99VMjm42Br6E6EghaBkPPE4Bd2ieXBdbfcvDxP
	 LOOSEldlqFc3THSgGa0An/Rl8c6psWvXge6Au9+vChIjsPhqna4baUBmv1VtdfQk07
	 rzlnmWSq+V3vV+/sqqDDpOU1iMIhodCwBFdSwHtAA/bTDx/DjhyXPs+DDangsP1Blf
	 UKL6FsgZ3ZidA==
Date: Thu, 5 Nov 2026 11:38:08 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Toan Le <toan@os.amperecomputing.com>,
	Mahesh Vaidya <mahesh.vaidya@altera.com>, DM@bhelgaas,
	Sharath Kumar <sharath.kumar.d.m@intel.com>
Subject: Re: [PATCH] PCI: altera-msi: Convert to subsys_platform_driver()
Message-ID: <20261105173808.GA1527544@bhelgaas>
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
In-Reply-To: <20261104113235.1634024-1-peng.fan@oss.nxp.com>

[+cc Altera, X-Gene folks]

On Wed, Nov 04, 2026 at 07:32:35PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the open-coded subsys_initcall()/module_exit() platform driver
> registration with subsys_platform_driver().
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/pci/controller/pcie-altera-msi.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-altera-msi.c b/drivers/pci/controller/pcie-altera-msi.c
> index ea2ca2e70f20..8c0696cbd4ae 100644
> --- a/drivers/pci/controller/pcie-altera-msi.c
> +++ b/drivers/pci/controller/pcie-altera-msi.c
> @@ -267,18 +267,7 @@ static struct platform_driver altera_msi_driver = {
>  	.remove = altera_msi_remove,
>  };
>  
> -static int __init altera_msi_init(void)
> -{
> -	return platform_driver_register(&altera_msi_driver);
> -}
> -
> -static void __exit altera_msi_exit(void)
> -{
> -	platform_driver_unregister(&altera_msi_driver);
> -}
> -
> -subsys_initcall(altera_msi_init);
> +subsys_platform_driver(altera_msi_driver);
>  MODULE_DEVICE_TABLE(of, altera_msi_of_match);
> -module_exit(altera_msi_exit);
>  MODULE_DESCRIPTION("Altera PCIe MSI support driver");
>  MODULE_LICENSE("GPL v2");

Looks like a nice improvement.

There are only three drivers that have separate MSI Kconfig options
and separate -msi.c files: altera, iproc, and xgene.

pcie-iproc-msi.c doesn't look like it has its own DT .compatible
string and driver registration stuff, but altera and xgene do.  I
wonder if it's possible to integrate them into the main drivers so we
don't need separate Kconfig and separate .c files?
