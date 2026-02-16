Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A262FD1BF;
	Mon, 16 Feb 2026 11:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242983; cv=none; b=q9Kb4P9ZfVaNv6ZMMFFP2cnXO/NXecpznbu7YW8h0jKDIoQVVt17WQt/RvebpJK1BXel5t9JkBIoUETDOOPEi8G8+orsOHzEkvkSzlTQ7yN7DCk3hjBcGcFO/0imoFStSGtX82e92eC/9b5P+h60lMQXIhgFqskv1iGErkVqT+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242983; c=relaxed/simple;
	bh=vLU0gldfnw0OpEh6rDsPTA7Frgswp1lqv76c5LRSEUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzMCgwEwetuuoYWV7Z3ezWzX96U0YyqEp9UqYi8MsmAPAbTiNM9qg7EW5swhAIlwhrruOlGSLHwD7HqpvNp+4wq2eIE0I0tUNevTFHVYlJl91pzG4US5JYv4HMWNwSKGXewAhMhY580Mo/4WdZvViBV9SElHZzQVQ5Hjg6c0a3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2tcApNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2tcApNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DFDC116C6;
	Mon, 16 Feb 2026 11:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771242983;
	bh=vLU0gldfnw0OpEh6rDsPTA7Frgswp1lqv76c5LRSEUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2tcApNu2bNRz2A2OcAjNCHVQVCg0Uc0AOu5QVPcnDzgSwjJduwgKwqolLxJatOMe
	 ugC0bkxy9pZGBLl1Ux6cULVi5ROnX6CpCZVS3+Gz6pxFQTs4CKOYXU1tCN4cMy8wrn
	 IVBKi5MYUOejzYrQzsAE9RtJH9JfeXQx9lIrVKVp4XBj3OWxxNjs3/xOlo1bLAEUig
	 z/dGc6R/xamYV4if3iLr7bY4qmts7Z3dJz2Rx8wkWapPq0Nm7xxPikNIUzKdRIxqwS
	 2y2XyonpU2AZpQv6SWd4xlTUxz1ng462ZPCSxcrIR+wiIEc3L439Xg+76WzkkWhic2
	 xgaVTseWSCJ0g==
Date: Mon, 16 Feb 2026 12:56:18 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/4] PCI: endpoint: pci-epf-vntb: Fix MSI doorbell IRQ
 unwind
Message-ID: <aZMF4hsBT-v3fPIW@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150914.3392479-2-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:09:11AM +0900, Koichiro Den wrote:
> epf_ntb_db_bar_init_msi_doorbell() requests ntb->db_count doorbell IRQs
> and then performs additional MSI doorbell setup that may still fail.
> The error path unwinds the requested IRQs, but it uses a loop variable
> that is reused later in the function. When a later step fails, the
> unwind can run with an unexpected index value and leave some IRQs
> requested.
> 
> Track the number of successfully requested IRQs separately and use that
> counter for the unwind so all previously requested IRQs are freed on
> failure.
> 
> Fixes: dc693d606644 ("PCI: endpoint: pci-epf-vntb: Add MSI doorbell support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20a400e83439..20efa27325f1 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -523,6 +523,7 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  					    enum pci_barno barno)
>  {
>  	struct pci_epf *epf = ntb->epf;
> +	unsigned int req;
>  	dma_addr_t low, high;
>  	struct msi_msg *msg;
>  	size_t sz;
> @@ -533,14 +534,14 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	if (ret)
>  		return ret;
>  
> -	for (i = 0; i < ntb->db_count; i++) {
> -		ret = request_irq(epf->db_msg[i].virq, epf_ntb_doorbell_handler,
> +	for (req = 0; req < ntb->db_count; req++) {
> +		ret = request_irq(epf->db_msg[req].virq, epf_ntb_doorbell_handler,
>  				  0, "pci_epf_vntb_db", ntb);
>  
>  		if (ret) {
>  			dev_err(&epf->dev,
>  				"Failed to request doorbell IRQ: %d\n",
> -				epf->db_msg[i].virq);
> +				epf->db_msg[req].virq);
>  			goto err_free_irq;
>  		}
>  	}
> @@ -598,8 +599,8 @@ static int epf_ntb_db_bar_init_msi_doorbell(struct epf_ntb *ntb,
>  	return 0;
>  
>  err_free_irq:
> -	for (i--; i >= 0; i--)
> -		free_irq(epf->db_msg[i].virq, ntb);
> +	while (req)
> +		free_irq(epf->db_msg[--req].virq, ntb);

Please keep the for-loop.
Or if you want to change it, do so in a separate patch.


I understand that you need a separate variable for this,
since "i" is (re-)used in other places in the function,
but changing the for loop to a while is distracting from
the actual fix.


Kind regards,
Niklas
