Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EE42C0303;
	Fri,  8 May 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778249714; cv=none; b=PjX+Td/ZdShcv/1krNfDmO6E87JQ7gEpO+HxJGnMUfVGkQUPpfT39Ly9HZNnWErN8ecxy5qoZP/V5GXP0BpGCmpkZ5dcYT3KQuFcJiYck4wNztQOspAGcavV3uAkmhiuvCmgQAWL8eCxgqoH4UpHsaT1ilYY131DaqJ4h13qH0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778249714; c=relaxed/simple;
	bh=qsbH3+eW03Fj/HcDwpPglkcKSGLY1XP0l0QbTzX9qDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4n1PiOaSsa5TeKIoD4FyP5mj271/dMRbaKHb5+lWUtw5tn3G0N/5/nUZi7oMUqL7Vm17MZRLzfZEwAhQcyZ7T5n1lm4ilSVuWawAI9jtG1egnXa0mnyW2wNDO54knDx2hqifHrrwQi4NdhE3t8aw+9mBLCKDkFqs9Xjop82ZWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4Ufo8zQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4Ufo8zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C8DC2BCB0;
	Fri,  8 May 2026 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778249714;
	bh=qsbH3+eW03Fj/HcDwpPglkcKSGLY1XP0l0QbTzX9qDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4Ufo8zQkIt5WFQUo42oYT3/qJRXalOBBxcbTJu4Pszvx3WSOskhB8x0Kf8ZLBn8v
	 LHus5hQH9YsN/liWM0buyZkWS8P6MjBFgqIemiWwN9yi9gwrx9Q9/RrRsKCjH2HMaI
	 vmRwi6DpovYA4rVp/oC+I5rriVYP7uRBnxoY+oiecR1im4NHwPqie26BPVeH34djL7
	 cuyVoq0x+/RKcCLwNWLfF5czy7T/HDxZwPaDw07/xEMLpLKPwkkUGl6nlVkDHKG/iS
	 K0GHt9F4/VUOWWmXwcmw75w+MuzCAY0LK4b95eERsbNJk03aUm5F1imncI7nGgiL+P
	 +0hXXh84GlUrA==
Date: Fri, 8 May 2026 09:15:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, mani@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Hans Zhang's email address
Message-ID: <20260508141512.GA85390@bhelgaas>
References: <20260508023006.1787674-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508023006.1787674-1-18255117159@163.com>

On Fri, May 08, 2026 at 10:30:06AM +0800, Hans Zhang wrote:
> Update my email address as my work email account is no longer in use.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Applied to pci/for-linux for v7.1, thanks!

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..288f9e3a735c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20354,7 +20354,7 @@ F:	Documentation/devicetree/bindings/pci/cdns,*
>  F:	drivers/pci/controller/cadence/*cadence*
>  
>  PCI DRIVER FOR CIX Sky1
> -M:	Hans Zhang <hans.zhang@cixtech.com>
> +M:	Hans Zhang <18255117159@163.com>
>  L:	linux-pci@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/pci/cix,sky1-pcie-*.yaml
> -- 
> 2.34.1
> 
