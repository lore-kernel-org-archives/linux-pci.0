Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906049;
	b=Sb8iedLH4WORjIIW6ljbKZ4ai/ZCahpyYS0M+LPALCSIdwr2C2FqUeGMWTVw8QU3t1N5
	 gB3z6MCY0vnSKt0Qv/Ck3CzmF/ltnVjeNRM4Wj3jF1zh8GjOnUhaJh7HPdLZpVtC2dQbM
	 U8lSatjtY02hmbf7HfslXG3gHMHC5zVvivkfAyuYpw8YWjtrkIDGq51jAMuDSeyf0gfYA
	 atrJqh3o0tF5x70Xi47CsYR0GFp9F7hzdOQwhXK+aG7JwqTSnutucLIJg7fEZUSXDNZkL
	 LwpiWpuOQOJxCDZJDgnTnciQXhio1DxB9Nc8b9tHTp0x8mmcWKnDd2GJvN8JsfDv/Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906049;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aGIFwy8ritfbrPq0fH4i2XrU8IlQUYUyUPjdHaMCbGg=;
	b=abknDbQmRv/xZmCcs3945PLXkt+U1Dc2z5HTTf7pN7MnHRXdMoanz5DD4Bm6E9WbE41j
	 yPWFl0Mo0KLQPnLATX5h1ntdNgN7Le2WoyBXDTo+0BvIg85nApSIFT1q4NI85thvwfmGL
	 +X4AuGyG3+/7ahoePA+7FqDkGztVt7C1Hx2+o+MNpTzwZuXEcDX4VVEy+JG4s6nU9F6iy
	 UIWArWB4tEK9wOEUywK6N0BCtwFqAA07Lts0Pxme1M8STuXwjKq0kgfROTZRl8ENWrCow
	 3tidlUNe7wpyM7zTVnjKjth9bXG8T6Qd4HOrFa8mtskAZmimRDCepQPscBOoMc2kgpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU2jW1zx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B0606A328;
	Thu,  5 Nov 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU2jW1zx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E821F000C1;
	Thu,  5 Nov 2026 19:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906048;
	bh=aGIFwy8ritfbrPq0fH4i2XrU8IlQUYUyUPjdHaMCbGg=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hU2jW1zx5BsvozhHzIf69hREVHTMNQLjdHRvXqnxYu4ZvU+rHRIdw4szWD0I0kOPU
	 SsZzE7e0hNbvYGBu2Lkwtl6H7IY17Y7DO8bE96vL5g8Ncu3BOLaMn0dlZ7iw4T3IKI
	 +I+Izhi4R0hCi/fLLKhXTStOS6FoT1VGcnhlpa1cvSKhqmxl/l4xhAVIjhT1gQoERu
	 Pm1D1OPSUgnQGPQPD/coDCoFgCiApwwDKzy8r3R1bWvzPpokCH4NlgYFs/AaAh8O+g
	 C2sCdWO6IexA0EveQiOVXp8g2V7jfxdoUZ2UEIqlsh728l5IrWduH2odQw8rcbt/Go
	 wLKCSnrSnK+SA==
Date: Thu, 5 Nov 2026 13:14:07 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yige Jiang <yigejiang86@gmail.com>
Cc: linux-pci@vger.kernel.org,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Daniel Stodden <dns@arista.com>
Subject: Re: [PATCH] PCI: switchtec: Fix PCI device reference leak on probe
 failure
Message-ID: <20261105191407.GA1548833@bhelgaas>
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
In-Reply-To: <rc-review-20261105-vc-149-07fa7f0c8a18@gmail.com>

On Thu, Nov 05, 2026 at 03:55:01PM +0800, Yige Jiang wrote:
> stdev_create() takes a pci_dev reference for stdev->pdev. When a
> later step of switchtec_pci_probe() fails, err_put drops stdev->dev
> but omits the PCI device reference. stdev_release() only frees
> stdev, so the PCI device remains pinned after the failed probe.
> 
> Return the PCI device reference before putting stdev->dev, matching
> the existing cleanup in stdev_create() and switchtec_pci_remove().
> 
> Fixes: df25461119d9 ("PCI: switchtec: Fix stdev_release() crash after surprise hot remove")
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>

Applied to pci/switchtec for v7.5, thanks!

> ---
> Based on linux-next next-20261102 (2637bdec0535).
> Compile-tested: arm64, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
> COMPILE_TEST=y.
> Baseline and patched target objects built from this exact base.
> No full kernel/module-link, hardware or runtime test was performed.
> AI assistance was used for analysis and patch preparation.
> 
>  drivers/pci/switch/switchtec.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
> index 5711aaa5df11..56a370ac9f27 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c
> @@ -1698,6 +1698,7 @@ err_exit_pci:
>  	switchtec_exit_pci(stdev);
>  err_put:
>  	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
> +	pci_dev_put(stdev->pdev);
>  	put_device(&stdev->dev);
>  	return rc;
>  }
> 
> base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
