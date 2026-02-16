Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5052FD67C;
	Mon, 16 Feb 2026 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771241761; cv=none; b=QgIw8TVwF4V6nBvwo3NlVCd3xKeFEO8/CPbjg1By0WoLpokXkg2mzRlZjqE38/WK1Pf75J6HwMZBJiCxLiqsC/XSaLYK36lkZU19hRfhJi9QKC3pgJR1EvdZVHa18VzVrSd/hTucIbyhY8uv9nK0WJMLFCgysn0eWiB+Q8FnKzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771241761; c=relaxed/simple;
	bh=2ZtmfX1VyYQJwSOo38i56895CrZRW3hcdtPi871i9eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clBpcm/lfqJWptq+8N6Vn145EGcLjhr/S6NMF36EtTGzUTloD2HexNUT/yu2r/UO4UI1LDQbOFBr02fHKNmf8H937nypkOmp+VZ2CyFiC89lfV2aRgu7jbYxoXoJ6yuzq+6u/zSGltDljcXb4lxwNuGCSsGUp4zM6ookERXRqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QidHaixg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QidHaixg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA27AC19423;
	Mon, 16 Feb 2026 11:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771241761;
	bh=2ZtmfX1VyYQJwSOo38i56895CrZRW3hcdtPi871i9eg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QidHaixgC8TNMKGn1XCwtMEA86Ec/EAEh2EGOvn9oh2e+n4JqcXtPogym8FyM9NG8
	 VR+aAsUZ+xW7RucZWk7DfRPdRCR7iTxDEfRIQjBKPBvNK6/H69NdkG0IsCiiKJjmsx
	 Vzaj6DbMh/qqqA94Q41CaZlwjRNzUtOR4ixarhZSoxrLCM7rQMQYUJRJweR/DKuq9d
	 HuhzNNzXM4bTzo/yftHwWfNsRkhdTdew7q0EywOn4EtgYKY28Y9tcoYe7PGpzCAEZk
	 eLxEsROxRohQ9bTtxwXQR3y5Wmw1snHOFBUmQBcmqD+D8+FXMcxs0fpKl8mindt+kN
	 Q4sneC3WOLWfw==
Date: Mon, 16 Feb 2026 12:35:56 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com,
	allenbh@gmail.com, Frank.Li@nxp.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 3/4] PCI: endpoint: pci-epf-test: Don't free doorbell IRQ
 unless requested
Message-ID: <aZMBHNd5zOgDGYbu@ryzen>
References: <20260215150914.3392479-1-den@valinux.co.jp>
 <20260215150914.3392479-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215150914.3392479-4-den@valinux.co.jp>

On Mon, Feb 16, 2026 at 12:09:13AM +0900, Koichiro Den wrote:
> pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> the interrupt handler with request_threaded_irq(). On failures before
> the IRQ is successfully requested (e.g. no free BAR,
> request_threaded_irq() failure), the error path jumps to
> err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> 
> pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> doorbell virq, which can trigger "Trying to free already-free IRQ"
> warnings when the IRQ was never requested or when request_threaded_irq()
> failed.
> 
> Track whether the doorbell IRQ has been successfully requested and only
> call free_irq() when it has.
> 
> Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 148a34e51f6b..defe1e2ea427 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -86,6 +86,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	bool			db_irq_requested;

It would be nice if we could avoid this, it looks a bit odd.


>  	size_t			bar_size[PCI_STD_NUM_BARS];
>  };
>  
> @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
>  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
>  	struct pci_epf *epf = epf_test->epf;
>  
> -	free_irq(epf->db_msg[0].virq, epf_test);
> +	if (epf_test->db_irq_requested && epf->db_msg) {
> +		free_irq(epf->db_msg[0].virq, epf_test);
> +		epf_test->db_irq_requested = false;
> +	}
>  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
>  
>  	pci_epf_free_doorbell(epf);
> @@ -732,6 +736,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	size_t offset;
>  	int ret;
>  
> +	epf_test->db_irq_requested = false;
> +
>  	ret = pci_epf_alloc_doorbell(epf, 1);
>  	if (ret)
>  		goto set_status_err;
> @@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  		goto err_doorbell_cleanup;
>  	}
>  
> +	epf_test->db_irq_requested = true;
>  	reg->doorbell_data = cpu_to_le32(msg->data);
>  	reg->doorbell_bar = cpu_to_le32(bar);
>  

Can't we do something like:

-For all goto's after request_threaded_irq() success case:
jump to a label that also cleans up the IRQ.

For failures before or at request_threaded_irq(), jump to
a label that does not call free_irq().



pci_epf_test_disable_doorbell() should probably return error
if (!epf_test->db_bar.size)

(before pci_epf_test_disable_doorbell() calls free_irq())

pci_epf_test_disable_doorbell() should probably also memset
epf_test->db_bar.


Kind regards,
Niklas
