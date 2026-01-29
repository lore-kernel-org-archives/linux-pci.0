Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C512F13959D
	for <linux-pci@vger.kernel.org>; Thu, 29 Jan 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769711490; cv=none; b=X8ml8JL+ObInEfPB/zJcbFYtNSNWp8LDutv6jzjv9pEpunNkdupB8tfI0WxLuG1Q6bu3hU8FeYYDG8rYvfBKrjxGebEzDHonSiKByIGcVTAhEui776pkKhFSNLcjgETsEN3l9EcxrDtaaGvXXbxfA+dFq1HH/nex435jAc+Eaz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769711490; c=relaxed/simple;
	bh=ykLaeq5otJwmNWDNmdJVUBbHc5uhFWoyYt2qSezCtB4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pdJWSwq7Pto7VuWE2CXEJuGm80JlweGVJjKtNcq/zJUIR0a7P5MBq49h8bJ6VZkr/nvJlnYt8B53vjHNExGSVEIfSJxjlDiM9w+/IPYdWSWZeWGWBmk/vdjUd5ktIfZJig0eIZuow5pRSNhZkRMXr7vMcgm8QWuXUgg5zGSpZPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4t1NGAq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4t1NGAq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A945C116D0;
	Thu, 29 Jan 2026 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769711490;
	bh=ykLaeq5otJwmNWDNmdJVUBbHc5uhFWoyYt2qSezCtB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=n4t1NGAq6iJlar86bg9wtc8jsOcfC7eQ60tamGJ2TpjOCwZ2DruNHHh/vH6d7Lx/O
	 r0L+LREBf/wAltIknVAYTNN/3++Nx95hB/SO9EL4+Hw8hLGtwiSmcKrx/wye5ykD5H
	 F5EnFnklhLlIdfPywtOD0Z2p7s4UdwcH6JdCazwI5GdXqM8UgAD4/UD7pOTyRB6LNz
	 yJ5O7920k9ZVta8sFDigThkQBcqxvSWgGzxyj/nnqWSPDWLKZyL3QloBX+uekE19cs
	 Zmdkm8taTlNSlMpJv3YW+GfmAZh1EW1fOWpLN47XChYJzMSp+IQBT26S+TMdLL6+4Q
	 VelhRBwd52odw==
Date: Thu, 29 Jan 2026 12:31:28 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergey Shtylyov <s.shtylyov@auroraos.dev>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH] PCI: Check parent for NULL in
 of_pci_bus_release_domain_nr()
Message-ID: <20260129183128.GA471057@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127203944.28588-1-s.shtylyov@auroraos.dev>

On Tue, Jan 27, 2026 at 11:39:42PM +0300, Sergey Shtylyov wrote:
> of_pci_bus_find_domain_nr() allows its parent parameter to be NULL but
> of_pci_bus_release_domain_nr() (that undoes its effect) doesn't -- that
> means it's going to blow up while calling of_get_pci_domain_nr() if the
> parent parameter indeed happens to be NULL.  Add the missing NULL check.
> 
> Found by Linux Verification Center (linuxtesting.org) with the Svace static
> analysis tool.
> 
> Fixes: c14f7ccc9f5d ("PCI: Assign PCI domain IDs by ida_alloc()")
> Signed-off-by: Sergey Shtylyov <s.shtylyov@auroraos.dev>

Applied to pci/enumeration for v6.20, thanks!

> ---
>  drivers/pci/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..9fc4c2226b03 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -6591,7 +6591,7 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
>  		return;
>  
>  	/* Release domain from IDA where it was allocated. */
> -	if (of_get_pci_domain_nr(parent->of_node) == domain_nr)
> +	if (parent && of_get_pci_domain_nr(parent->of_node) == domain_nr)
>  		ida_free(&pci_domain_nr_static_ida, domain_nr);
>  	else
>  		ida_free(&pci_domain_nr_dynamic_ida, domain_nr);
> -- 
> 2.52.0
> 
