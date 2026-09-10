Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0886039AD2A;
	Thu, 10 Sep 2026 19:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789067776; cv=none; b=oY1p9+SfySToGUs76lID0QCcHT0qbn44bXVl+9Nw9EnWTGnDI1kVo0Kskqa7CGu7nFecibQ0H4FI9gO5O+Mo/po+Og9anOh8eRPpDFoCC9i+bMubzkBIWA7lfQDv4vKJLQYYgzBjsT4iLCEfX3Yc6BjfQQFLj4F07RFGRB46n9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789067776; c=relaxed/simple;
	bh=cczUuxqy4PgZFHgux79qhQCK0fGch5tivm6wnII7Eks=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=MLYvvA9fFKHO03EFFdlRE1XIQ2GlWk9GwN31CyG/QbAW+rjbjwdgfSUPui+sxonJwVEw3UDEphStTCED2MItwTCrS33vYB0wT7mFrEIlSS/QzWHCyEdsfyiNHQJbAW+gsteTSi5lOSJQufmt7IvEhLAUZxm/4LiOeWW4KKlbNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jADyzzJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jADyzzJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3937B1F000FF;
	Thu, 10 Sep 2026 19:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789067773;
	bh=oIOJdraHkZ9UpW60PXVbDH8Os8XbWM1AkU45Ek3qD/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=jADyzzJE/2kfTrpB7F8D2oRoUekV+vbcvurkvLf5X0iaZWLNbRHBnjGYPVf16cWEB
	 XTF35Vto6hX2MAsRLQuGIaY0BMue189Q6JbLk+xHwhHTuFJhEkVqIOTkMtWsmQsMKp
	 qDH1KvlHJN+7GikRH/oXu8Xke4rg+ciqj6aom6FLFdamOOzws5YdpB0trx69E8HkPP
	 nUaFJiB8wNDG3kGeOLYwryE93Ptq7lP5g8UFvoCl7bzdUa7tB5uljMa48RbZJqatjx
	 vfjju7BPPH++EA31kEiKpdjT0xPTtUA3tgYPd/fbtq1pCfZ0Y7X3nvOS0guvAU/egU
	 S1Cpy2eU8pX8w==
Date: Thu, 10 Sep 2026 14:16:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jiwon Kang <kkjiwon04@gmail.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Remove unnecessary static initialization to false
Message-ID: <20260910191611.GA338709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730053337.22427-1-kkjiwon04@gmail.com>

On Thu, Jul 30, 2026 at 02:33:37PM +0900, Jiwon Kang wrote:
> Static variables are zero-initialized by default, so explicitly
> initializing to false is redundant. Remove the initializer to
> follow kernel coding style.

Thanks; can you repost this with a Signed-off-by?

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 77b17b13ee615..ee2beaacbc73f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6671,7 +6671,7 @@ static void of_pci_reserve_static_domain_nr(void)
>  
>  static int of_pci_bus_find_domain_nr(struct device *parent)
>  {
> -	static bool static_domains_reserved = false;
> +	static bool static_domains_reserved;
>  	int domain_nr;
>  
>  	/* On the first call scan device tree for static allocations. */
> -- 
> 2.34.1
> 
