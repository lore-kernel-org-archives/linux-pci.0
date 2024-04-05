Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9987016D4D6;
	Fri,  5 Apr 2024 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712324015; cv=none; b=oio0hRsR90RimFeiUNBxeZdXO33jUTBck5CVPfbLuw4gtdEK7W+N5DInl99lvUK8x4Q7ZnWp3zmLfYH1Jy3MVCS+Q9HU0plWbx8h7ztAaqQsy+Ax0lCjRy5mn/hTasYEa34ca0tewqacECepe2bsd8PGreh9WPp6Vm2HnCbBEeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712324015; c=relaxed/simple;
	bh=zfEeXh3hz25nDeq9dAo0iY9I4+qJizPHM4+Hki6OxD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BkqPjaz+gqVNCShgh8KFeV6VWwyYnbljlfNkCqirXnfPrMaOjCwGm+ZFa8vnlup96upQOAXLx96Zd7qQK8MINkWdMgiulHO1vUmP8IokWazhyi9Xf+UVjNP7EKyJWjvA0M2y86t2WT1ftlpNfuYrKS94X/ZN2x5khD0LL9McvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RBlURaLr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RBlURaLr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF58C433F1;
	Fri,  5 Apr 2024 13:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712324015;
	bh=zfEeXh3hz25nDeq9dAo0iY9I4+qJizPHM4+Hki6OxD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RBlURaLrFBp1q2lYBiEiNbuJxjgEpFiuQO3t9ZQdjV4T24hplKn2qODVKd/6j7rKY
	 xpr5VtNZVRz8lS4VG76mWHUZnEWv4TD4GY4VWlOBJHOR2Ms8A7scVANGaXzXB6DkxE
	 5DlqbxBlew7Ko3emEWT1ERVFUUyn9sNNW8hDRLwFQjkMwMc0nT6e5TUqlv6a72moFR
	 8ILiJGYHMSUf07W6OPLKy/9Zq26BChP7WKtwcG0O1BTKSFumpjKGr71ZuirCloJs3/
	 N5dRgMkN9XyKnItvKsbeCjfpUpt0j3AW+C+hKKQFulSoiCz5BdHLTBLhkG15kB/CHs
	 /6AwBuyHdaYdg==
Date: Fri, 5 Apr 2024 15:33:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v2 01/18] PCI: endpoint: Introduce
 pci_epc_function_is_valid()
Message-ID: <Zg_9qNgh4KZIoHMX@ryzen>
References: <20240330041928.1555578-1-dlemoal@kernel.org>
 <20240330041928.1555578-2-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330041928.1555578-2-dlemoal@kernel.org>

On Sat, Mar 30, 2024 at 01:19:11PM +0900, Damien Le Moal wrote:
> Introduce the epc core helper function pci_epc_function_is_valid() to
> verify that an epc pointer, a physical function number and a virtual
> function number are all valid. This avoids repeating the code pattern:
> 
> if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
> 	return err;
> 
> if (vfunc_no > 0 && (!epc->max_vfs || vfunc_no > epc->max_vfs[func_no]))
> 	return err;
> 
> in many functions of the endpoint controller core code.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Reviewed-by: Niklas Cassel <cassel@kernel.org>
