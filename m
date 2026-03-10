Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EE5309F08;
	Tue, 10 Mar 2026 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773158996; cv=none; b=PKNuGySkwX+UCFYToKWKluuooHg7cHOKuc+aefJeNPFqEaNpQV6GfmHMYZi8Ogjkrza/CtJ80NDjPp90QhOdUDZX4mEgUzZiUEW1eMN5pfD9liSadaDBet17yY6oojX1ZtbHkoX3g6IJPEsPpi2SuN5l75gbwQFSNfyKpYuKoTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773158996; c=relaxed/simple;
	bh=/u5ToRGUYQeBmSQ5KOibb/buWYss9cKiWPPn1ZPU6a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IZjsCGvXQNtaUvmODdAZ8H/yBA98nhtPMgXbPi59NXHFvvPRRHq7rIEuFTQitjm+OkCtHLycI5m6rkqGsvBBMHTZ8mS/bGJHV9wYHC8DG69VA5LsvM0czLxMqOvtEhjngEqCWDvB4FrY2k1cKmwhCK+MKcqla8p1ufUZxEVQvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmlBIPWa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmlBIPWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046ABC19423;
	Tue, 10 Mar 2026 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773158996;
	bh=/u5ToRGUYQeBmSQ5KOibb/buWYss9cKiWPPn1ZPU6a0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EmlBIPWaKCFdyZ30bnuFlVKVbfiYLP9vYWq7zeBabad5/I1TXSJ/iK5ZmmhXbozI1
	 rdCPfrFX3WDqdB2sQjEFLWoA8WncHA05oksjQ+DQUST35zRAdcVmx3VLbMc1PG8p6H
	 Z9Qv55UZjaPo/0+02no43xuv2m/ao0KC4heIOZ9uqPjaMHfUdVGxGVK9inbLGJgDzU
	 ZvcuiOCfd2nDUL4LNDQY4mtGAhMS3se5+t8RLkpyFXpgyBqKY/thXFuRUkHJ0BXpiH
	 e31jDj6Oz2KW+R6JUwiXKj3bplMorUu7K7HqwHuuEi0itBsYtv6kiLGa9/vvg9jT/o
	 NFjv51mskmsqA==
Date: Tue, 10 Mar 2026 11:09:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gary Yang <gary.yang@cixtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, peter.chen@cixtech.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	cix-kernel-upstream@cixtech.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: update CIX Sky1 PCIe Root
 Complex bindings
Message-ID: <20260310160954.GA691804@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310065338.2337761-2-gary.yang@cixtech.com>

Re the subject, every patch is an update.  Can you include something
about the *content* of the change?

Also run "git log --oneline Documentation/devicetree/bindings/pci/"
and make yours match.  In this case, something like:

  dt-bindings: PCI: cix,sky1-pcie-host: Add power-domains

On Tue, Mar 10, 2026 at 02:53:37PM +0800, Gary Yang wrote:
> add power-domains and power-domain-names property
> 
> Signed-off-by: Gary Yang <gary.yang@cixtech.com>
> ---
>  .../devicetree/bindings/pci/cix,sky1-pcie-host.yaml         | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> index b910a42e0843..1d8ee8310588 100644
> --- a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> @@ -38,6 +38,12 @@ properties:
>    ranges:
>      maxItems: 3
>  
> +  power-domains:
> +    minItems: 1
> +
> +  power-domain-names:
> +    minItems: 1
> +
>  required:
>    - compatible
>    - ranges
> -- 
> 2.49.0
> 
