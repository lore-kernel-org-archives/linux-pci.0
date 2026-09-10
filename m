Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B3215161;
	Thu, 10 Sep 2026 23:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789084228; cv=none; b=cyTm4qGiemDzB95Ffc3GWGSdihaGsQr/N5kCDfgqFoxk9HMq8u5CZpsKsTzpjTg/QldPDb7F0o4hW/TVA3FpIRj13y5EOob2PXWdvo5aNlhpwVjqV2xM0F6m9zCghyUJhXSy/euW2AJttuf3a8S31CxbMqVAi5DmgVoD6p8Wyeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789084228; c=relaxed/simple;
	bh=05ntqJ2r+0F1Oez5J4BRRAUx75pWOJU1V08rd6DTiro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=tMD0EtXrbCWcR2TNpa+iKCKlEbIcUtuTkwpFGI1NQQlKZqbLBdAZaMVfZoMjmx5eR2V5vI0jPff+ce0rU/VYgd6HBu28Ws5LFiMx5QKdU0KJYFQE7Y15HvuyKVcPMvB4NSM7cLRwQ0xn3oXibQSEKd8npeqGvLBeETf1l5yj5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWvdIX1B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWvdIX1B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4762B1F000FF;
	Thu, 10 Sep 2026 23:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789084227;
	bh=c7OopUXEb/cYzDlfPWlrvtnzMRjL5zmzmrpAgsq/8e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=SWvdIX1BHb3G2mc3DqyJOJjeon1cveuDPti+i3UgGtydjKjjIuLAZjugxNUQntTsi
	 k7tFsAfMxEDD74cLH2E2ATVZW0vSV7mAZi8xvAU2u/v2UxvgpL1SiJ9zaZfiPnkOwz
	 FlvYWyzKMnXsILexLoAROHTxfm7tg95B/q1KUSnYjg4TEInmOHalF/wvvi2ASprk1o
	 OXiwI6ZzjvtlQrp+guF0OjE8unAGgEOS6gN2HtwPZSxLM/IE4b+fN5mwOdiAeGLFyH
	 aMCTxt7YV/SH4HFLDZzz6tKLnsRLto5qr9a8Vh1Akv8a3F/OwlToXzlyvB6J85vUbQ
	 CbfiU/LHnbcNQ==
Date: Thu, 10 Sep 2026 18:50:26 -0500
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
Subject: Re: [PATCH v8 04/12] PCI: liveupdate: Document driver binding
 responsibilities
Message-ID: <20260910235026.GA367309@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728221007.2098560-5-dmatlack@google.com>

On Tue, Jul 28, 2026 at 10:09:58PM +0000, David Matlack wrote:
> Document how driver binding works during a Live Update and what the PCI
> core expects of drivers and users. Note that this is only a description
> of the current division of responsibilities. These can change in the
> future if we decide.
> 
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  drivers/pci/liveupdate.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
> index 5ce5f8b36902..0f7a018ddc66 100644
> --- a/drivers/pci/liveupdate.c
> +++ b/drivers/pci/liveupdate.c
> @@ -71,6 +71,22 @@
>   *
>   *  * The device cannot be a Virtual Function (VF).
>   *  * The device cannot be behind a PCI-to-PCI bridge.
> + *
> + * Driver Binding
> + * ==============
> + *
> + * In the outgoing kernel, it is the driver's responsibility to ensure that it
> + * does not release a device between pci_liveupdate_preserve() and
> + * pci_liveupdate_unpreserve().

Possibly "the driver must ensure" or even "the driver must not
release ..."  Also could apply below.

> + * In the incoming kernel, it is the driver's responsibility to ensure that it
> + * does not release a preserved device between probe() and
> + * pci_liveupdate_finish().
> + *
> + * It is the user's responsibility to ensure that incoming preserved devices are
> + * bound to the correct driver. i.e. The PCI core does not protect against a
> + * device getting preserved by driver A in the outgoing kernel and then getting
> + * bound to driver B in the incoming kernel. This may change in the future.

Same "i.e." nit.

Not sure we need to be reminded that things may change in the future :)
