Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AA242AD83;
	Fri, 16 Oct 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174887; cv=none; b=O+SAJ68/5OFqWVcEJyLpGGEKAvrnEmo2IbEaOGxjnLepBsifkZiuJFuaG1plKDu3FsAr9INvAMVrRYIgco8I9uzX6iyZjqoCPdSK4SGtzux85CWdsiAxK2MvHuWZnxRGzFZzaT1S+rz60HWFJPBi3NpSRcFoJPXVbOmifdT0gnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174887; c=relaxed/simple;
	bh=JVdkMJsRCn1XSDVkBaxNUZpS/5OGuKe2hDMPAxbQrkw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iMkvwoHdahUlXchgtBOefeqWWtXql/ROHmwQ1kByJwkPfF2uz6Eo94hlodJKZNYgvdp3ghswfTG9HRLNsjcOPfmJRU2RiWceQN2PHDZ6Cejgv7E3AlmCyAk5q1oWVSxVYHkCGU4Pbult1y1eeRmeMm+StZZ/r173u7ix2havb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ru5sFJDI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ru5sFJDI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26CB01F000C4;
	Fri, 16 Oct 2026 18:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174886;
	bh=FtiGdjgqtjT1pvwqeEY6y9aTlaYLGZB6OmGXYll3xpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Ru5sFJDIojnoKUslABrY/JiS9gVMLdFF+C6MPIMI4ixlj6hyIKP8xDr/FB+iNQog4
	 t13WWgvXQQSY5wkHVZ9bshp2LLRGLN5S58md1dn8fawhIGs3+G7FYPwN59D6s4Tgis
	 WiWMX+qVuwLiSNR0r1Kw87MxAG5Usxd6XhaxMZqLq9Fe+skj+F0JEEbi/O8nOZ6XSR
	 Xka4+4l83bYE9AJ+TjeZTd0Q8lqQ5I/j+eADQhZ0lNjlKw3AkVD4fLDxPIzF0fiq/W
	 BlRoXKw8UG+a4XV7eo+ti6DlMIudETfY7emrUvSm4IOImIuCYB36pHI8DFZGswhRJG
	 lDILvsAIjPXuw==
Date: Fri, 16 Oct 2026 13:21:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Eugen Hristev <ehristev@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
Message-ID: <20261016182124.GA1884550@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>

On Fri, Oct 16, 2026 at 03:18:53PM +0300, Eugen Hristev wrote:
> Limit each iProc MSI parent IRQ to 16 event-queue entries.
> 
> A continuously fed queue could otherwise keep the chained handler running
> and starve other work. The budget still drains pending events and lets the
> next parent interrupt continue processing, improving fairness and bounding
> interrupt-handler latency.
> 
> Without this starvation avoidance, one CPU can stall indefinitely
> in the loop and not serve other interrupts, timers, etc.
> 
> While testing it with an Ethernet NIC,  when too many MSI interrupts
> come in, CPU might get starved:
> 
> Connecting to host 192.168.30.1, port 5201
> [  5] local 192.168.30.2 port 52586 connected to 192.168.30.1 port 5201
> [ ID] Interval           Transfer     Bitrate         Retr  Cwnd
> [  5]   0.00-1.00   sec   240 MBytes  2.01 Gbits/sec    2    334 KBytes
> [  5]   1.00-2.00   sec  63.2 MBytes   531 Mbits/sec    1   1.41 KBytes
> [  5]   2.00-3.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   3.00-4.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   4.00-5.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   5.00-6.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   6.00-7.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   7.00-8.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  5]   8.00-9.00   sec  0.00 Bytes  0.00 bits/sec    0   1.41 KBytes
> [  177.568497] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  177.568913] rcu:     0-...!: (1 GPs behind) idle=28ac/1/0x4000000000000002 softirq=28922/28930 fqs=1
> [  177.569457] rcu:     (detected by 1, t=5256 jiffies, g=21629, q=819 ncpus=4)
> [  177.569870] Sending NMI from CPU 1 to CPUs 0:
> 
> With this bounded approach, IRQ handler will complete and continue
> to serve MSI events on the next handler invocation.

Is there something unique about iproc that makes this an issue, or do
we need to worry about this in every MSI interrupt handler?

> Assisted-by: Github Copilot
> Signed-off-by: Eugen Hristev <ehristev@kernel.org>
> ---
>  drivers/pci/controller/pcie-iproc-msi.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/controller/pcie-iproc-msi.c
> index 9ba242ab9596..6649807822d2 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c
> @@ -29,6 +29,9 @@
>  /* Number of entries in each event queue */
>  #define EQ_LEN                         64
>  
> +/* Bound parent interrupt handler such that a queue cannot starve CPU. */
> +#define IPROC_MSI_MAX_EVENTS_PER_IRQ   16
> +
>  /* Size of each event queue memory region */
>  #define EQ_MEM_REGION_SIZE             SZ_4K
>  
> @@ -326,6 +329,7 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  	struct iproc_msi_grp *grp;
>  	struct iproc_msi *msi;
>  	u32 eq, head, tail, nr_events;
> +	unsigned int event_budget = IPROC_MSI_MAX_EVENTS_PER_IRQ;
>  	unsigned long hwirq;
>  
>  	chained_irq_enter(chip, desc);
> @@ -360,9 +364,11 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  			break;
>  
>  		/* process all outstanding events */
> -		while (nr_events--) {
> +		while (nr_events && event_budget) {
>  			hwirq = decode_msi_hwirq(msi, eq, head);
>  			generic_handle_domain_irq(msi->inner_domain, hwirq);
> +			nr_events--;
> +			event_budget--;
>  
>  			head++;
>  			head %= EQ_LEN;
> @@ -373,6 +379,8 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  		 * head pointer.
>  		 */
>  		iproc_msi_write_reg(msi, IPROC_MSI_EQ_HEAD, eq, head);
> +		if (!event_budget)
> +			break;
>  
>  		/*
>  		 * Now go read the tail pointer again to see if there are new
> 
> ---
> base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
> change-id: 20261016-iproc-irq-9c58cfe39158
> 
> Best regards,
> --  
> Eugen Hristev <ehristev@kernel.org>
> 
