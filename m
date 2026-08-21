Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CF3B27C5;
	Fri, 21 Aug 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302291; cv=none; b=HVfSC5e9XtlG7PzBfnXBs9HJit0g+DZyz2tIDC8HRIIeztH+IJLZj7NMJkwERNjDZkPGGLY3Yhvom6aKJkqWx3j6+9rOyxgG2zptnc/Itq8EGtoSpt/i5HBGIZVB9x2ZoeE35iHwAbR8+0rgys50kRDYq5c965HGy+27V3n/gYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302291; c=relaxed/simple;
	bh=j1FoU89fN2y4DurSzZe/Qp6pierX5/lPM9E39TyUfiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mC3nURrhBPNFtHQKTe4TT+OGquovpK9N7B1PkxXOMOxuSoLlV/Xv4lc25AvG8VRcf1ER/cGBaBi42Z49I9Mn1/PwRZBXUz0M2tkwZywvVCXvfelOo1M9pU53vOTTggXWlzcU2VE1/DUA9Owuu/oqfuPUZ/rzDIVRAVSW0gtcr4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oq8TniQl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oq8TniQl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9191F00A3D;
	Fri, 21 Aug 2026 08:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302290;
	bh=NAyXdu1AhLKU2EaVtwbyJuN/dH6zxKa7f15VJvl+Qgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oq8TniQleLqPzlLgot4WpbShzIDrkTxKM11VVhuHE5C63oYpjXcMJmwll/+IjXPTR
	 f/REWKgNjt+4BaFjXx+T57nKepCVzNwdzb8malR+4KcgFltiWH/h/q9E+QRgEdsD6N
	 liS9JVS4J8ou3qg33/NFARRhTrVl9Z1Vi6KwwIgwlPHSK1/wAxEdEKbG6fu9x+4NL2
	 6aHaVf70wUA/v0xXTsA/TAgEsdFaAvjxmwB9yYGATVJnicIFiirJuA5GXfCmBnByvz
	 cB8jOqkaFhicdwsCRkH5zleX4cCmgGoz0wZO1vxlG9htiod2aRcGr6WS2EfLDzPm3l
	 vbetFlqlyg0EQ==
Date: Fri, 21 Aug 2026 10:51:27 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>, 
	Sebastian Brzezinka <sebastian.brzezinka@intel.com>, Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Disable not supported reset methods on DG1 0x4905
Message-ID: <aogQ4fNchLVm9Pbg@zenone.zhora.eu>
References: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819102509.1662504-2-janusz.krzysztofik@linux.intel.com>

Hi Janusz,

On Wed, Aug 19, 2026 at 12:24:53PM +0200, Janusz Krzysztofik wrote:
> DRM CI consequently reports failing device reset attempts on Intel DG1

do you mean "consistently reports"?

> discrete graphics adapters.  Manual reproduction attempts allowed to
> narrow down the scope of that problem to a specific revision of that
> hardware, SKU 8086:4905.  It has been confirmed that both reset methods
> claimed by the device, i.e., flr and bus, suffer from that issue.
> 
> Since consecutively failing device resets may lead to system hangs,
> disable both useless reset methods.  A respective CI test will then be
> skipped instead of aborting whole CI jobs.
> 
> Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/11814
> Signed-off-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>

Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>

Thanks,
Andi
