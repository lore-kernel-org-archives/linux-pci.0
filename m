Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB8A1C3BF7;
	Fri, 10 Jul 2026 20:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783715576; cv=none; b=rK43TXsO1Nw8xziFEMyABq+aZEauyVA7M6vQcDsWZfCY7BtdHw6lAHk4kTsXxSKWuiGSUqp7eOLnSG8Dtk0qtzfiX8+ubEtLA6fGkq3tLlSPsUYVAgZFKBi+eDNNRmm1HU3OtYazLoJoDw1e1qEX/ObA4dnphWdtE1MK3VeCauA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783715576; c=relaxed/simple;
	bh=FSy4jwxyQ59esSyBRhQmrEfTjzZcMjXq41qYxVIJ5QA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iIfOxLuACT8ztbZHUGx/bcElbJvhFbG7W9VMNv/BZTVaYrAZl+hdes55POuci6YxEVggSvE+JI1dFA2Z30tij7hslLbdmZxbMGwrK0EgHZ0uWYCi+0/e7aNimE2+6tsG1kPzwxeLFj19Eb1eToOww5ThswdI6fJV25bNN1MTaiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IrvND1j+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrvND1j+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F15E1F000E9;
	Fri, 10 Jul 2026 20:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783715575;
	bh=b11VeVAjomHNx2suD7mMVJxmSoUMdq9YZhyW8JZN954=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=IrvND1j+0x6bspf50eB7800KJZ+zfhPj6fLZkVRLzEPTPfqhGrmPPGL+oWwSUx1Yt
	 uvJKuHoH40HgbaaC+wIeo9TDx7KXrBU7EEfikQXho7Y5hx5LgGMRVgCl2TwIem1C9d
	 i29rlcyFWdLTH5r7rDUdaHzathV0YTipmThI96rjU+UP2q1CMDJD4q0aRTpHen80Oj
	 QfeD+bjqGwwBwmhJlSSWx5TvWS6TU5fB86zBriOtPoik8DkR7WVNUNh0wN/FmwxP0B
	 tfG3aa3Au7q0j8VM72LGjcn0FfN/qM2D+r+i3KLNmQGiya4WysCwjqas+Hu4KhlyJa
	 OBToKH/4FpSnQ==
Date: Fri, 10 Jul 2026 15:32:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-alpha@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] alpha/PCI: Fix I/O port accessor argument order in
 pci_legacy_write()
Message-ID: <20260710203254.GA993990@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260706175423.98305-1-kwilczynski@kernel.org>

On Mon, Jul 06, 2026 at 05:54:23PM +0000, Krzysztof Wilczyński wrote:
> pci_legacy_write() in arch/alpha/kernel/pci-sysfs.c passes its arguments
> to outb(), outw() and outl() in the wrong order:
> 
>   outb(port, val);
> 
> The Alpha I/O accessors in arch/alpha/include/asm/io.h take the value
> first and the port second:
> 
>   extern void outb(u8 b, unsigned long port);
> 
> So the port number is written as data to the I/O address taken from the
> user-supplied value, and the intended write to the requested port never
> happens.
> 
> The arguments have been reversed since the file was added, and the
> function returns the access size regardless, so the caller sees success
> while the requested port is left untouched.
> 
> Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
> Tested-by: Magnus Lindholm <linmag7@gmail.com>
> Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>

Applied to pci/sysfs for v7.3, thank you!

> ---
> Changes in v2:
>  https://lore.kernel.org/linux-pci/20260612232400.585195-1-kwilczynski@kernel.org/
> 
>  - Collected Reviewed-by and Tested-by tags from Magnus Lindholm.
> 
>  arch/alpha/kernel/pci-sysfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
> index 94dbc470cd6c..7050f0f7fe3d 100644
> --- a/arch/alpha/kernel/pci-sysfs.c
> +++ b/arch/alpha/kernel/pci-sysfs.c
> @@ -224,17 +224,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
>  
>  	switch(size) {
>  	case 1:
> -		outb(port, val);
> +		outb(val, port);
>  		return 1;
>  	case 2:
>  		if (port & 1)
>  			return -EINVAL;
> -		outw(port, val);
> +		outw(val, port);
>  		return 2;
>  	case 4:
>  		if (port & 3)
>  			return -EINVAL;
> -		outl(port, val);
> +		outl(val, port);
>  		return 4;
>  	}
>  	return -EINVAL;
> -- 
> 2.55.0
> 
