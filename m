Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F7F3A8F7;
	Tue, 10 Feb 2026 12:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770726996; cv=none; b=T9LkRUe3h1cTtCB1uHDq7eFayVw7x338rml9qHmktMqHPVMTol6aGmSYEw5z+13xIPKH5zpPL88eEexBbbf8QqpMFVGk643rEyIB4CkYtHbC8ZbUbnWzikik5CkrkqX30g6s5mCQHfOmapTYfm6CxAcb82Zbv1o91MWRdpCAPLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770726996; c=relaxed/simple;
	bh=gzH2YGvZRc9iV5d+RW89R0NxYY96RI7zn+dgQ4Iw8Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ci/TeL59/zf3JQDMAD9s3fVuHlyi29IGW/zLokKbGJPocS+Yh7/4R9tyH518ko1gfNdy9TnUMAKPSaBYXK6MvKQTiQBI2ORcFSRriHZG+61bP0kywOqKKIPsp521pqqbZ7DHYLGbV3a4B6ZqpKm7yT08rc7E14QXS69zdQgWAJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLuRfnSy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLuRfnSy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A888C116C6;
	Tue, 10 Feb 2026 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770726995;
	bh=gzH2YGvZRc9iV5d+RW89R0NxYY96RI7zn+dgQ4Iw8Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nLuRfnSyt3b6YxGjiBXA0qXmaewKKdJ2NbcH9G7Tw04N4Pk9HtXZJT+M8pK4QfOxM
	 x32Ezkv0H+gRZrnfBr1HqfKrLIMrlrtW6p6RkVBqycsS0oU0hjVcmnkXRGHVwEWo4o
	 vL7N7dcp2J1g9G+Zjmcu5k54PxwJuiXFVbLjjkAjYsBXZR0VJ85B2qauMMEXj9RVGY
	 uG8D90P5bKHgByMr/bGkV9obU0jEK/vWX8I+8vas3QbBQzpYiCjHs40SSEtaqNi5Ap
	 tXapki1uRBWBkAqMlU2DW2ZTvN3GKknO95KfPGb6Q3uLwFhyVZYL7Af2lzYethc4lU
	 GAQkeKJ3G+MRA==
Date: Tue, 10 Feb 2026 13:36:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, kishon@kernel.org,
	jdmason@kudzu.us, allenbh@gmail.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <aYsmTbSmn94J6uN0@ryzen>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209125316.2132589-7-den@valinux.co.jp>

On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> the interrupt handler with request_threaded_irq(). On failures before
> the IRQ is successfully requested (e.g. no free BAR,
> request_threaded_irq() failure), the error path jumps to
> err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> 
> pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> doorbell virq, which can trigger "Trying to free already-free IRQ"
> warnings when the IRQ was never requested.
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
> index 6952ee418622..23034f548c90 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -86,6 +86,7 @@ struct pci_epf_test {
>  	bool			dma_private;
>  	const struct pci_epc_features *epc_features;
>  	struct pci_epf_bar	db_bar;
> +	bool			db_irq_requested;
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
> @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
>  	if (bar < BAR_0)
>  		goto err_doorbell_cleanup;
>  
> +	epf_test->db_irq_requested = false;
> +
>  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
>  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
>  				   "pci-ep-test-doorbell", epf_test);

Another bug in pci_epf_test_enable_doorbell():

Since we reuse the BAR size, and use dynamic inbound mapping,
what if the returned DB offset is larger than epf->bar[bar].size ?

I think we need something like this before calling pci_epc_set_bar():

if (reg->doorbell_offset >= epf->bar[bar].size)
    goto err_doorbell_cleanup;



Kind regards,
Niklas
