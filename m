Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54BF2F3C10;
	Tue,  4 Aug 2026 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785881251; cv=none; b=GXEtTcZHDJhWIbo5FP/4imCovdaEYBUG6+SqnsheZqkl2f4ZaSfeDzm9eyL4SGTlLcAc3AxQRdS7AXAbaDKDL9hdl0niiVu4WBHRatyIwtRRTk+boUJNOSpXRrPZBsim+koWTul4IwgxxAxAzi4aLpG6qU7GTbLY7hRJ4/5Sk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785881251; c=relaxed/simple;
	bh=tr4gX5SugrlZEdS4jIbWiBibKVFwFlv4KjtFsEp+v4w=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=UCT+cZGHZxWCqG4gO6/IQDtlMavRMsRLIQhh+pJnhby+VIRzywOzVmh/ENjDXeCBMrleRePFv0ePXwg+decLFBUPr+x4zj1qAmGdE092TKC83fDvr7f0V0R0aCSlQBqUaipr0QXAvdA5FAmoVpcOW0wYkgijsdFPDmTdJlR4XE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=BthX7k0h; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="BthX7k0h"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=ezcZ0mk4rxjrcephDtzUCmBZDny0RSLvrsscZbYVmuQ=; b=BthX7k0hxi7PkXg+4gT1rBA1bx
	m1putEqavkEBeEcXum1ooYIX8JwT/43AFkfBPOM0L6pEHeH1ZyMdjm3WzdQoNxi8lTFww+yplpDyK
	PwcURsoOw/SwV6N03Hc7QsaYh+VHDnBaRbGR0SkZbc94IlGphImRj6hWVbM1tz5ylN3EvkY/0IHC2
	iZp+QbB4peqAqpNeJPQHZ6HU4sekApdTC7G05MBeDTxC1b1vA8o6cuZMvdEB2n0n4qsBUpEBbK/x7
	Z+NVQUIWJiW+MGAJT4TX3j6fDxSMqQEV2hm0ZDoA78B+iSL4K/5tW6G/fUi0Dbou047YPeQsU8t3+
	mkpaw85g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1wrNIG-000000002tS-1wMm;
	Tue, 04 Aug 2026 16:07:29 -0600
Message-ID: <461ab877-a5ab-44bd-8c24-1a77e42e9746@deltatee.com>
Date: Tue, 4 Aug 2026 16:07:27 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Alex Williamson <alex@shazbot.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, "Claude Opus 4.8" <noreply@anthropic.com>
References: <20260802-fix-p2p-acs-v1-0-a7c5eb64fff6@nvidia.com>
 <20260802-fix-p2p-acs-v1-10-a7c5eb64fff6@nvidia.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260802-fix-p2p-acs-v1-10-a7c5eb64fff6@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: leon@kernel.org, bhelgaas@google.com, corbet@lwn.net, skhan@linuxfoundation.org, alex@shazbot.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, noreply@anthropic.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 10/13] PCI/P2PDMA: Extract pure ACS routing decision
 helpers
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-08-02 09:09, Leon Romanovsky wrote:

>  static enum pci_acs_p2pdma_state
>  pci_acs_p2pdma_state(struct pci_dev *pdev, struct pci_dev *target)
>  {
> -	int pos, ret;
> +	int egress = 0;
>  	u16 ctrl;
>  
> -	pos = pdev->acs_cap;
> -	if (!pos)
> +	if (!pdev->acs_cap)
>  		return PCI_ACS_P2PDMA_DIRECT;

I don't necessarily disagree with the change, but removing pos in this
patch seems unnecessary and makes the patch more difficult to review
than it needed to be.

> @@ -1046,6 +1047,22 @@ resource_size_t pci_min_window_alignment(struct pci_bus *bus,
>  void pci_acs_init(struct pci_dev *dev);
>  void pci_enable_acs(struct pci_dev *dev);
>  int pci_acs_egress_ctrl_set(struct pci_dev *pdev, struct pci_dev *target);
> +
> +/*
> + * Peer-to-peer routing decision for an ACS-capable ingress port, per
> + * PCIe r7.0, sec 6.12.3, table 6-11.
> + */
> +enum pci_acs_p2pdma_state {
> +	PCI_ACS_P2PDMA_DIRECT,		/* peer-to-peer permitted directly */
> +	PCI_ACS_P2PDMA_REDIRECT,	/* redirected upstream to host bridge */
> +	PCI_ACS_P2PDMA_NOT_SUPPORTED,	/* no usable peer-to-peer route */
> +};
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +bool pci_acs_egress_port_valid(u16 acs_caps, u8 target_port);
> +enum pci_acs_p2pdma_state pci_acs_p2pdma_decision(u16 ctrl, bool has_target,
> +						  int egress);
> +#endif

One minor weird whitespace issue here. Probably the empty line should
come after #endif


But both of these are very minor points, so:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


