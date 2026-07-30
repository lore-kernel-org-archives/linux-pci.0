Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563AB222597
	for <linux-pci@vger.kernel.org>; Thu, 30 Jul 2026 04:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785385936; cv=none; b=O74qEJ8TPUazpuLNuScJ4tESo27txTQ9Ll1LAQOOjRhvaon8OOo4ymAjmdqrFnYPOc/zRLwHYhNsKd0RrViK1T2VG0bLpibaHYfmgzy8JP2mMkruxRBzXxYbZxa95L7QjSpyRgg5hr1gnHn3sjasZAxt7bfG0xeqAekK7tVN/yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785385936; c=relaxed/simple;
	bh=dZA/NlUz5CDEZ+b1tHYMV5fUaTStt36AXLqcRlawA4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b6Z/D7NTJGpiVx6fRTsA8XgkcJB2SpM110ybSAWt8suoM5c5vzBGwb/hTAStc7DbK+CJwVSeQyL9TG6BvktyBrgQP4F3PWShga6+caz5d3jqjSTlaLfbxnUQjFfleRO0dGMiM9+BN1ihm0XRcYetBw4teZ1HTwFW6nD5ukgVe+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i59kUElE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i59kUElE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D8A1F000E9;
	Thu, 30 Jul 2026 04:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785385934;
	bh=s1J+yCtYVoCxfU1R7c46QILzINTJneu0RZRWIpUiT4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i59kUElEjdxLlb/3FdnaDclWnQRm65CtaIyx0SX2dluUwArpt6D6p5pqryGPtpCtp
	 6lDEhQ0hVQ+a5a+1hoV5VK4qFaIF5OjkhSUAxaFhhiFTqAxEFRVB+3Pgf8vhqIKZDD
	 Rrr2L+8atEmjZbik8eD2dlLW0vdZFd2KB5ASzschODKX8idU3Q+MUjFX0CtkYAHUg2
	 LYr+299FvF7RpXtDEPGna0WGTzAEf9cV1MLtj5A7qSL7+GZIa5+Wos9CBo5TWyE2Ed
	 i5/LM0I0JkKjzc61WdLs7QZVMyboHDUOC2mNBvqn95W9WPx8ZcGaKfPRxaAxAs8WUH
	 q4Ix8DcebYYkA==
Date: Thu, 30 Jul 2026 06:32:08 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: DWC eDMA weirdness
Message-ID: <nvpa2qlo7rbhmeuk3ijf2pzsqp43o4hnexafk3ep3gho3w27sk@lbpqgyaelqxc>
References: <20260729202821.1153443-2-cassel@kernel.org>
 <ampndLtU32ODmncX@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ampndLtU32ODmncX@ryzen>

On Wed, Jul 29, 2026 at 10:49:56PM +0200, Niklas Cassel wrote:
> On Wed, Jul 29, 2026 at 10:28:22PM +0200, Niklas Cassel wrote:
> > Getting two IRQs when we are only expecting a single IRQ is a very
> > serious error, and suggests that something is very wrong in the EPC
> > driver.
> > 
> > Scream loudly so that EPC driver developers can see the problem,
> > which might otherwise be very hard to detect.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> > 
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 3635741c3e7a..a212e53654c6 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -178,6 +178,19 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
> >  	if (reg & STATUS_IRQ_RAISED) {
> >  		test->last_irq = irq;
> >  		complete(&test->irq_raised);
> > +		/*
> > +		 * The endpoint test driver performs all testing sequentially.
> > +		 * This means that test->irq_raised.done should never exceed 1.
> > +		 * If it does, then we received two IRQs in a row, without a
> > +		 * successful wait_for_completion_timeout() call in between.
> > +		 *
> > +		 * While complete() increases test->irq_raised.done by one,
> > +		 * wait_for_completion_timeout() reduces test->irq_raised.done
> > +		 * by one on success.
> > +		 *
> > +		 * Please debug your EPC driver if you see this warning.
> > +		 */
> > +		WARN_ON(test->irq_raised.done > 1);
> >  	}
> >  
> >  	return IRQ_HANDLED;
> > -- 
> > 2.55.0
> > 
> 
> Hello Koichiro,
> 
> I created this patch in response to a problem that I saw on v7.2-rc5.
> 
> When running the pci_endpoint selftest:
> # /pcitest
> (snip)
> #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> [  215.256772] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> #            OK  pcie_ep_doorbell.DOORBELL_TEST
> ok 23 pcie_ep_doorbell.DOORBELL_TEST
> # FAILED: 19 / 23 tests passed.
> # 2 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
> # Totals: pass:17 fail:4 xfail:0 xpass:0 skip:2 error:0
> 
> 
> I saw the weird error:
> "Failed to trigger doorbell in endpoint"
> 
> Ignore that the test case leaves things to be desired, since it passes even
> though we see this warning.
> 

How come this is possible? Doorbell timeout occured, but still Doorbell got
triggered in EP?

> 
> The problem seems to be that the embedded doorbell IRQ handler is executed twice,
> in response to a single writel() which rings the doorbell.
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 4802d4f80f78..7f4360579ffb 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -714,6 +714,7 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
>  
>         status |= STATUS_DOORBELL_SUCCESS;
>         reg->status = cpu_to_le32(status);
> +       trace_printk("calling pci_epf_test_raise_irq()\n");
>         pci_epf_test_raise_irq(epf_test, reg);
>  
>         return IRQ_HANDLED;
> 
> 
> As you can see:
>  irq/58-pci-ep-t-221     [006] .....    58.601020: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
>  irq/58-pci-ep-t-221     [006] .....    58.601421: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
> 
> It is called twice for a single doorbell ring.
> 

Which doorbell is used here? Platform MSI or Embedded one?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
