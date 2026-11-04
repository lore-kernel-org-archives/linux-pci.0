Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814903;
	b=ljVCsrY2aeNSHN+y+SCJ7fxWcKZjGSeuzQmvqCJS4hNk7dXjKnG8in1lW+9IwPmvsl5b
	 v0Nq1NILM+0AFF55cWunknGcP9aOqE3QAdtHHY4pTUoCHgx7Ve1obQ7Lqri1BteyD+bwW
	 kYlQhDHpgq2fmZH8M9VnSMmcoM534ZZSFyVV3n41sILN06wUndhn4NNu3O311GS91pk/S
	 j6M1vFPugnekao1rmzMYUSD2Tvy9Dhu+4voD/diIZ5US6Rr256n74Sg6XxIa2mwUh9VLZ
	 4tPoVexQIDRKQlBrCeS8pkUTxuwXBKCakp+p6zqsrJv5Hrx0+44qwLO4pFV1q+A9qQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814903;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=PY5BnPqOpEzILm/pwQ0SRDj3n4U4TC8x8WrWVFUHndU=;
	b=IRN7/3KoHqWzXCB06uE2bMEsrtPYVpXugZAldEc/UA7oUijElte03u+JWYpixhWIAWMc
	 noW2K3f7mDuBJL9PQIlcbiM6MYdsMqTLj118EOiMbh2ivYEw2oLlecEzC/tmG/NIWlFCF
	 Xr2o4mpW3voo+U5KSk7EPM/BqVaSywinW3BnTksdUEJRI8fqvGCu0Rlabnt/tPmJryC2R
	 97+7J1sS+db2O1pz/erSzCFneQkinHshrojVyp9F4EeCHLeQHIXd535BYNyP5sAEI8kPl
	 oS1b4w09ub+YoOlnAKwQt6pYbzQuCkAr6xuqHfPqHsTkr1p0E3ET6nJZfr8Vu3qhV1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbYUuPrh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AE360A381F;
	Wed,  4 Nov 2026 17:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GbYUuPrh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7781F00919;
	Wed,  4 Nov 2026 17:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793814902;
	bh=PY5BnPqOpEzILm/pwQ0SRDj3n4U4TC8x8WrWVFUHndU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=GbYUuPrhlCfQxi95k6+MF9mey6QLrKubSnhR4tXl8lBqok54QNrcY4GOyIfpXXoug
	 3lJEyKub1kW0RN3jb82yih1lpFC7wrj0MR/pVV9ibtOcwWvbviIl23BhIz+L6xhFIj
	 QO9dskSMTgspJwCQHR60oocAKhpQUe9sGiQvr8sjsInyiGqI0/8Zuse1HOwFFFUG/u
	 gjVwHU7AjembehxcvGhk/bt/LpYiH//FgSaNeuyHyGqFmJ6J1ZjofQTNSdqS0dbXDH
	 zBBTVcQmWlQWWd392wVPVpnNxHUsYJ5a/dPjxpOAwgvtFMTOSwIs1V4I12QDbliXZu
	 EbO0GEYY8mg+g==
Date: Wed, 4 Nov 2026 11:55:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yuho Choi <oss.patchbox@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rcar: Release temporary device tree node
 reference
Message-ID: <20261104175500.GA1357062@bhelgaas>
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
In-Reply-To: <20260924010418.726980-1-oss.patchbox@gmail.com>

On Wed, Sep 23, 2026 at 09:04:11PM -0400, Yuho Choi wrote:
> of_find_matching_node() returns a referenced node even when it is used
> only as a boolean test. Drop the reference right after the match check.

I guess this actually fixes an of_node reference leak, right?

> Fixes: a115b1bd3af0 ("PCI: rcar: Add L1 link state fix into data abort hook")
> Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
> ---
> Changes in v2:
> - Use an explicit of_node_put() instead of __free(device_node) (Marek Vasut)
> - Switch to my oss.patchbox address
> 
> v1: https://lore.kernel.org/all/20260801233841.469826-1-dbgh9129@gmail.com/
> 
>  drivers/pci/controller/pcie-rcar-host.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rcar-host.c b/drivers/pci/controller/pcie-rcar-host.c
> index cd9171eebc289..1f5e33c802b5b 100644
> --- a/drivers/pci/controller/pcie-rcar-host.c
> +++ b/drivers/pci/controller/pcie-rcar-host.c
> @@ -1122,7 +1122,11 @@ static const struct of_device_id rcar_pcie_abort_handler_of_match[] __initconst
>  
>  static int __init rcar_pcie_init(void)
>  {
> -	if (of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match)) {
> +	struct device_node *np;
> +
> +	np = of_find_matching_node(NULL, rcar_pcie_abort_handler_of_match);
> +	if (np) {
> +		of_node_put(np);
>  #ifdef CONFIG_ARM_LPAE
>  		hook_fault_code(17, rcar_pcie_aarch32_abort_handler, SIGBUS, 0,
>  				"asynchronous external abort");
> 
> base-commit: f0100363d8c374bd8e9ea7c9ba02744f0b802ca4
> -- 
> 2.43.0
> 
