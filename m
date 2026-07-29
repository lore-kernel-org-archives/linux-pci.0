Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FD403EB3
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785358204; cv=none; b=ak9K84FhXZaGocw+SDKYhT1qeKIT0lMPfbpvHaxr9BpGL8X8HUnLZCHYCQACuMG3QuJyhc25nqloUpwIq+JJKAim+y7X+5yhTbuYM1IBebRzaO8TtgKgJjtxhvgAA83OtTag+UQu/DwzaOQiqM9gDYfp5LNKgI2yBhwoPc+teig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785358204; c=relaxed/simple;
	bh=Js0Liq/Ek/chpKLXF8B1rA8aCb35dhBL+PGNpFtaefU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdYZLvjYG2MWbxxIVHGk65zsU6QVGH8xiSC56m18K2LRXLbbSs/78YjCAPsgE4ztvRRpRGWHtIlVgejiEBbbv0lE+NXi7M64IhENrA/xB2BbPTtyPCnaxtkSfdzUP/SiRLDli05E5jvTypInrMl5W4j6etF+A8qcOlcjA4B6+T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QyKFd3A3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyKFd3A3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E651F000E9;
	Wed, 29 Jul 2026 20:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785358199;
	bh=SyqPfT2uqC9kwiEGQ5U+gS0E5okJwCHv9kXkqomyNVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QyKFd3A30yiFwGgiqf5u5zpoGBwZOFupDRW65S9m+/addM/hjt6mnFUakrhZ/rmg2
	 OY9nDbz8LoAW+hA/QfcB/UeO5cXE0IGv193btfKWN6fhZrSFNAFR8lGcUplE0Rq9yY
	 RqKJShpLOWOkdDqit3exCwEqhSyiBuIoeH+o1GYbYWjkdXnTl+3J86qRru1Z6STD4j
	 eTu5NPbeJ8KWXAXvp/9beyGaAUfYq4TVGB+sIUyIBxJgZOntje00Ug2HdKfkYENJhV
	 1XBW+LZx5UFCjU7pe0XX/Rjgu9+yM/6r+fmLiIWiQTcw6Ic0FADK41O6thm5qxYMbv
	 JG57RTLnDjsmQ==
Date: Wed, 29 Jul 2026 22:49:56 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: DWC eDMA weirdness
Message-ID: <ampndLtU32ODmncX@ryzen>
References: <20260729202821.1153443-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729202821.1153443-2-cassel@kernel.org>

On Wed, Jul 29, 2026 at 10:28:22PM +0200, Niklas Cassel wrote:
> Getting two IRQs when we are only expecting a single IRQ is a very
> serious error, and suggests that something is very wrong in the EPC
> driver.
> 
> Scream loudly so that EPC driver developers can see the problem,
> which might otherwise be very hard to detect.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/misc/pci_endpoint_test.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3635741c3e7a..a212e53654c6 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -178,6 +178,19 @@ static irqreturn_t pci_endpoint_test_irqhandler(int irq, void *dev_id)
>  	if (reg & STATUS_IRQ_RAISED) {
>  		test->last_irq = irq;
>  		complete(&test->irq_raised);
> +		/*
> +		 * The endpoint test driver performs all testing sequentially.
> +		 * This means that test->irq_raised.done should never exceed 1.
> +		 * If it does, then we received two IRQs in a row, without a
> +		 * successful wait_for_completion_timeout() call in between.
> +		 *
> +		 * While complete() increases test->irq_raised.done by one,
> +		 * wait_for_completion_timeout() reduces test->irq_raised.done
> +		 * by one on success.
> +		 *
> +		 * Please debug your EPC driver if you see this warning.
> +		 */
> +		WARN_ON(test->irq_raised.done > 1);
>  	}
>  
>  	return IRQ_HANDLED;
> -- 
> 2.55.0
> 

Hello Koichiro,

I created this patch in response to a problem that I saw on v7.2-rc5.

When running the pci_endpoint selftest:
# /pcitest
(snip)
#  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
[  215.256772] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
#            OK  pcie_ep_doorbell.DOORBELL_TEST
ok 23 pcie_ep_doorbell.DOORBELL_TEST
# FAILED: 19 / 23 tests passed.
# 2 skipped test(s) detected. Consider enabling relevant config options to improve coverage.
# Totals: pass:17 fail:4 xfail:0 xpass:0 skip:2 error:0


I saw the weird error:
"Failed to trigger doorbell in endpoint"

Ignore that the test case leaves things to be desired, since it passes even
though we see this warning.


The problem seems to be that the embedded doorbell IRQ handler is executed twice,
in response to a single writel() which rings the doorbell.

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 4802d4f80f78..7f4360579ffb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -714,6 +714,7 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
 
        status |= STATUS_DOORBELL_SUCCESS;
        reg->status = cpu_to_le32(status);
+       trace_printk("calling pci_epf_test_raise_irq()\n");
        pci_epf_test_raise_irq(epf_test, reg);
 
        return IRQ_HANDLED;


As you can see:
 irq/58-pci-ep-t-221     [006] .....    58.601020: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()
 irq/58-pci-ep-t-221     [006] .....    58.601421: pci_epf_test_doorbell_handler: calling pci_epf_test_raise_irq()

It is called twice for a single doorbell ring.

Note that you might need to run the whole selftest test a few times to trigger
the WARN_ON(), even if you can see the trace printks every time.
(Using printks instead of trace printks seems to affect the timing too much.)


My first thought was that we should add reinit_completion() calls after each
wait_for_completion_timeout() in pci_endpoint_test_doorbell(), but after
reading up on complete() and wait_for_completion_timeout(), this should
actually not be needed, and if we did, it would simply hide the read problem,
which appears to be that the embedded doorbell IRQ handler on the EP side is
called twice for a single writel() that rings the doorbell.


Kind regards,
Niklas
