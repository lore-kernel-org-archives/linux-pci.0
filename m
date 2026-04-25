Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70045393DE9;
	Sat, 25 Apr 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777112541; cv=none; b=sgo3scEdaWg2HXqG6+GMC7KrW23j7nKmluYM8HMG/KOADZ+XjUJyIs0KHe9hz0txhOBMfqtEL/aGlECHMoEpknV/6U+Rczeq8WRmEHUI/lONK3V+/S0VWvr2XHM8GRntICUBricJwriYGL/YhlCJF2W1jql+ZE4RmmnmfOpxTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777112541; c=relaxed/simple;
	bh=ZUPPhFVZQbljNA332u3LYRTprpkVR+YVWiGn+DzoKto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iYh3ka2sBXRkqDqMTSuXaiZrDv+yGjxOIard560DPbFZv1Ii8xvLbOPCHtnC7CVEipLEcpUEuurIUTcXTJSSDRUKlMNnQcKRSM0gC14m9M2EA5Hj3vTIQ96OfAqBpS/QprEXWkrglcOSHQH7gU9EY4gKayCLSwFSX2W6t8JhWc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVigzOjT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVigzOjT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D4DC2BCB0;
	Sat, 25 Apr 2026 10:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777112541;
	bh=ZUPPhFVZQbljNA332u3LYRTprpkVR+YVWiGn+DzoKto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVigzOjTrHYv7Ua8lBOX9q+n9FsWYiyPo6WTeju8Fq6eKONInM+g4ZnN+90LbTky9
	 2E7Ch0CVEOC36VYM3o/VzOL3wrryEfnGTxKVS4YrFG2aW2wYcRkNMdejOnDonyJOt/
	 n7jc2UAa2zZwgnV0HLAabusZcazKhRuT+cJB7f3Br1q2gwdrAMs9Q3DX6929DvjSWc
	 s610BDZRiB6gjdqJWlpk6Ne2XkUsKNXl/vKMwKHeeh2HCdAHAmCKdWvulItHY+aJNo
	 cbS7XMDADiW9k5cz3Ah6opxkaWex5RW0dugONUJ7Te69LHUgs287Cx2H8RUd8X/NJV
	 1Ca7YP7W2leig==
Date: Sat, 25 Apr 2026 12:22:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mahesh Vaidya <mahesh.vaidya@altera.com>
Cc: joyce.ooi@intel.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	mani@kernel.org, robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, subhransu.sekhar.prusty@altera.com, dinguyen@kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: altera: add binding for Agilex 5
Message-ID: <20260425-witty-heron-of-perfection-cedddd@quoll>
References: <20260424094913.522123-1-mahesh.vaidya@altera.com>
 <20260424094913.522123-2-mahesh.vaidya@altera.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260424094913.522123-2-mahesh.vaidya@altera.com>

On Fri, Apr 24, 2026 at 02:49:11AM -0700, Mahesh Vaidya wrote:
>      enum:
>        - altr,pcie-root-port-1.0
> @@ -25,20 +26,15 @@ properties:
>        - altr,pcie-root-port-3.0-f-tile
>        - altr,pcie-root-port-3.0-p-tile
>        - altr,pcie-root-port-3.0-r-tile
> +      - altr,pcie-root-port-4.0
>  
>    reg:
> -    items:
> -      - description: TX slave port region
> -      - description: Control register access region
> -      - description: Hard IP region

I don't understand why you are removing this.

>      minItems: 2
> +    maxItems: 3
>  
>    reg-names:
> -    items:
> -      - const: Txs
> -      - const: Cra
> -      - const: Hip
>      minItems: 2
> +    maxItems: 3
>  
>    interrupts:
>      maxItems: 1
> @@ -80,18 +76,25 @@ allOf:
>      then:
>        properties:
>          reg:
> -          maxItems: 2
> -
> +          items:
> +            - description: TX slave port region
> +            - description: Control register access region
>          reg-names:
> -          maxItems: 2
> -
> +          items:
> +            - const: Txs
> +            - const: Cra
>      else:
>        properties:
>          reg:
> -          minItems: 3
> -
> +          items:
> +            - description: TX slave port region
> +            - description: Control register access region
> +            - description: Hard IP region
>          reg-names:
> -          minItems: 3
> +          items:
> +            - const: Txs
> +            - const: Cra
> +            - const: Hip

So it's the same... Confusing or I miss here something.

Best regards,
Krzysztof

