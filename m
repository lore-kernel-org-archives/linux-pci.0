Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9AE926D4C3
	for <linux-pci@vger.kernel.org>; Fri, 27 Feb 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772211982; cv=none; b=RUA7P7n2XGBAz5VYOPsN8fwnWvfv28pifwDN3/X3LzO4M0RMrzNAydxs8b8y4gstXMRvTXlArmOy7SYl1003mFKQFXv9YoeOaYBA1qnrYpsnbrO9vkjbGuFrOzhwXiWdjKb3EZacUo1BVsz5wnk8nul3vGvX/n2fYEeVQkkrJ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772211982; c=relaxed/simple;
	bh=u4cnBmp1+s0bCU1pYa/9RSQ0jw1GMHSt3yjxofDLA3k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t7HIv2eUMp4hm/m/haRjY80RLmBgXmTIbmEK8ixrX3Rv8JfDUENlIA6s61ZoDokUrYncFmpoM5mUWgHkqC+qj/lIPlhV9xUV9a9zhI19oh8bpuyJsH4QdvQK4qL8Apjm4i8t+USizeGtWmkZo5hDkStkTPFGK+PKNiGY2+Q1bmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ova4w3u5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ova4w3u5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762C9C19421;
	Fri, 27 Feb 2026 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772211981;
	bh=u4cnBmp1+s0bCU1pYa/9RSQ0jw1GMHSt3yjxofDLA3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ova4w3u5EIBJojn02hwX4KjfNjhMFywBZ4j8cdmhEuHoMpanieKuCCDF1Li3/lxnu
	 ApTHXrBYUbvEyFkRhl4ns8DUrO3SB59lMLL0OIx3SCbDR/Pl+kJYMQtQN2hMLfdKoO
	 CKkeM1vOOngQB4dwzrKcvXYCtkQwXKkzmD5rYrpo/ff/FxYO5TjSzsEjA+PQ6VS4/E
	 RnEWUPzRG2+vJKjgCYKqzzdZcOH7HOVxx4DIWYs1ae7So1ynlFJfQCYUwNbmMPB9Mh
	 czCAjibNXM0jqXZlPv3N/SQsMqwbAmYrrr/SWAHXWRYeTXYc/JdgmkfoVoiHVqno3W
	 6m4flu5AyFB9Q==
Date: Fri, 27 Feb 2026 11:06:20 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kishon@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	alok.a.tiwarilinux@gmail.com
Subject: Re: [PATCH] PCI: endpoint: Propagate error from pci_epf_create()
Message-ID: <20260227170620.GA3898635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227030701.40533-1-alok.a.tiwari@oracle.com>

On Thu, Feb 26, 2026 at 07:06:53PM -0800, Alok Tiwari wrote:
> pci_epf_make() overwrites the actual error returned by
> pci_epf_create() with -EINVAL, which hides the real failure
> reason. Use PTR_ERR(epf) instead and print the error code.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index 0f3921f28f17..7ddf9e3c04d3 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -624,8 +624,8 @@ static struct config_group *pci_epf_make(struct config_group *group,
>  
>  	epf = pci_epf_create(epf_name);
>  	if (IS_ERR(epf)) {
> -		pr_err("failed to create endpoint function device\n");
> -		err = -EINVAL;
> +		err = PTR_ERR(epf);
> +		pr_err("failed to create endpoint function device: %d\n", err);

Unrelated to *this* patch, but messages like this that claim to be
about a device, but don't mention any related device, e.g., with
pci_err(), seem dubious to me.  I don't think users can really do
anything useful with a message like this.  There's no obvious device
available here, but we at least have a "name".

>  		goto free_name;
>  	}
>  
> -- 
> 2.50.1
> 
