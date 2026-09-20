Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EE1E7C18;
	Sun, 20 Sep 2026 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789884728; cv=none; b=Nugkcx6bHVLrpPSX97GGGy8Q36d81mRWCn1q2QcOLiZrNx0zdDMWLasSuPh5bhhHMf05xd7H1Yzuvj65dYMkt+jKQuN6bhYiFnVBLvyTYATWmoMBYM3t5DVoG1C/fBcKBMd/L1d3Cs9JQoEVaP/dqHmEXcPQ/Yoh81rKRB3v7hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789884728; c=relaxed/simple;
	bh=uGj/cjs1juN48xRJfjqqvRQgae7uiKkxG3gI1nWfePE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPbsKx54m9+wSN1PVGAvo8yLEB0RckQse9FOv0zLzXLeE4M/hghVig5D82L2M/OFAv8ZZ9+z8ovWDjc6cDwLDf5+nEuuyWgzxZLKyHYR4wm3M9Y2mbAOcoJDUU/7zKfYANucUhOC5etqgdx38oGT8Iz0U4T4dUnCKIZlm8IrzAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.95.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by mailout1.hostsharing.net (Postfix) with ESMTPS id 47E094A19;
	Sun, 20 Sep 2026 08:11:56 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1A2FA61ACEA5; Sun, 20 Sep 2026 08:11:56 +0200 (CEST)
Date: Sun, 20 Sep 2026 08:11:56 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rafael J Wysocki <rafael@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v13 1/5] PCI/DPC: Ignore devices with no AER Capability
Message-ID: <aq95LGUHL-pnmTlr@wunner.de>
References: <20260919162655.3499010-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919162655.3499010-2-sathyanarayanan.kuppuswamy@linux.intel.com>

On Sat, Sep 19, 2026 at 09:26:51AM -0700, Kuppuswamy Sathyanarayanan wrote:
> Downstream Ports may support DPC regardless of whether they support AER
> (see PCIe r7.0, sec 6.2.11.2).  Previously, if the user booted with
> "pcie_ports=dpc-native", it was possible for dpc_probe() to succeed even if
> the device had no AER Capability, but dpc_get_aer_uncorrect_severity()
> depends on the AER Capability.
[...]
> +++ b/drivers/pci/pcie/dpc.c
> @@ -477,6 +477,9 @@ static int dpc_probe(struct pcie_device *dev)
>  	int status;
>  	u16 cap;
>  
> +	if (!pdev->aer_cap)
> +		return -ENOTSUPP;
> +
>  	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
>  		return -ENOTSUPP;

I've got patches which make DPC work (again) on AER-unsupporting ports:

  https://github.com/l1k/linux/commits/aer_baseline_v1/

In particular:

  PCI/DPC: Avoid access to non-existent AER capability
  https://github.com/l1k/linux/commit/85f209fd4732

  PCI/DPC: Reinstate support for AER-incapable ports
  https://github.com/l1k/linux/commit/2de89b762d79

I'm almost done with that series and hope to submit it this cycle.
Your patch [1/5] will cause a conflict with my patches.
Would you mind holding off on patch [1/5] for now?

There's another reason:  I know of one product in particular,
Intel "Ponte Vecchio" data center GPUs, which support DPC but
lack an AER capability.  DPC was tested and made to work on
those cards (see 53b54ad074de).

I didn't realize back then but know now that validation engineers
specifically used pcie_ports=dpc-native to be able to use DPC on
that product.  And I believe this was also communicated to customers
as "best known method" for DPC on Ponte Vecchio.  In other words,
using pcie_ports=dpc-native to make DPC work on non-AER-capable products
has become a feature.  Your patch breaks those use cases.

That's why I chose to make DPC work (again) on non-AER-capable products
with the above-linked patches, instead of closing this loophole to
force-enable it.

Thanks,

Lukas
