Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89C33914F6;
	Tue, 17 Mar 2026 21:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773782262; cv=none; b=mpe+YgtPwExvlMArivYNXIK5b0UAp8TX0siU4Jg8UxhPUwHJL2y+IMMyWXY7R1jhjopA63YjHtbgnGCZYv2hRIc2XE7qZuKmCpr4VybsNvg0hI71SJyrRXxUZuyC8Mz1LDd1Y9N23V8rPqNVO3epXEhFcdWjk405/hBJwAU9w90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773782262; c=relaxed/simple;
	bh=JT52uBLGV5ljWG+JY/WaTZrb6IrBecqVaFgib3fuOKA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZMkLjlqM4IET3hlqxmwHBx/WwDEAH3+rzyO61nxkXRRp64MO0E2/hU2LOCoeLgCcIQh6YdFhZn6gMZZYCMHB9ERxlhbQT7RSPTGdKshHAqUW/0+ejbGJ+uy8+WPGsXWLqcqwq9oNK7HdebgQqcvMR9fySkcoR8OMIQl2AUdFpoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkEi8xFQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkEi8xFQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D20BC4CEF7;
	Tue, 17 Mar 2026 21:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773782262;
	bh=JT52uBLGV5ljWG+JY/WaTZrb6IrBecqVaFgib3fuOKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lkEi8xFQJd3G+WLwgq2G8dCaeKuS7YlOQfamqotFa23cvE17OqRh7nXj6KK/FXjF6
	 w68Tn0dmFWtfYOAb9tpBqTTPPlnb/veU9UP52AfffVMyqvwJfxVqhSb3aDuzd8ABSj
	 Q6jeqsHKjEN8BtcYFnlrmgf7TyyR9BlNA0q6jm3NtU86JkblYtWB0JqpF6R2ZwnOVe
	 1D5lavIR2tBFJNGGiFtvloV+P6/X9AcCGcVmPshS1TTNC8p03csUedsk8dbEj2MOcN
	 yDUB07WDMYP4Y9+58tnKk/dqxganyAJidHxFO+9ZKr7joYqmfb36PiD3Lkb1Y0mdWb
	 SZkoYToS5natw==
Date: Tue, 17 Mar 2026 16:17:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Fix device reference leak in aer_inject()
Message-ID: <20260317211741.GA107878@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317172732.58053-1-adiyenga@cisco.com>

On Tue, Mar 17, 2026 at 10:57:32PM +0530, Aadityarangan Shridhar Iyengar wrote:
> In aer_inject(), pcie_port_find_device() returns a device with an
> incremented reference count. The function returns this device but never
> calls put_device() to release the reference, resulting in a reference leak.

From AI
(https://sashiko.dev/#/patchset/20260317172732.58053-1-adiyenga%40cisco.com):

  Is this description accurate? Looking at pcie_port_find_device(), it
  uses device_for_each_child() with the find_service_iter() callback.
  Unlike device_find_child(), neither of these functions calls
  get_device() on the matched child device to increment its reference
  count.

> Fix this by calling put_device() after using the device in both the success
> and error paths.
> 
> Fixes: 0e98db259fd8 ("PCI/AER: Reuse existing pcie_port_find_device() interface")
> Signed-off-by: Aadityarangan Shridhar Iyengar <adiyenga@cisco.com>
> ---
>  drivers/pci/pcie/aer_inject.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
> index 09bfc7194ef3..5025843157b1 100644
> --- a/drivers/pci/pcie/aer_inject.c
> +++ b/drivers/pci/pcie/aer_inject.c
> @@ -467,11 +467,13 @@ static int aer_inject(struct aer_error_inj *einj)
>  		if (!get_service_data(edev)) {
>  			pci_warn(edev->port, "AER service is not initialized\n");
>  			ret = -EPROTONOSUPPORT;
> +			put_device(device);
>  			goto out_put;
>  		}
>  		pci_info(edev->port, "Injecting errors %08x/%08x into device %s\n",
>  			 einj->cor_status, einj->uncor_status, pci_name(dev));
>  		ret = irq_inject_interrupt(edev->irq);
> +		put_device(device);
>  	} else {
>  		pci_err(rpdev, "AER device not found\n");
>  		ret = -ENODEV;
> -- 
> 2.35.6
> 
