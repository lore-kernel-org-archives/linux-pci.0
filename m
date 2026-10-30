Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388054;
	b=2iKKjM5V1vN8pVUE6RTqa9oz4MQoYc6E2ypgpVJtI+bk/2pc8EwbhFf2IpJQ3VZNYkio
	 bjhT4sW2B+WlXedaw85woZowxKslN27a7jE/MWb2GQ5V0aISidnTAE0hVVyyzsTEgMb+K
	 9aCNgX7vmMkXnl6Q4HV2/hxlyg7o+OKAofQ6+uMP1JDrH8s+Vk6J4wbCGyU1RbOpBZPRZ
	 aRzV9t329D58wheVwjMkZAzwjgw/MtMCrWGNgTjzBNkNkOpAH5q0RBuvRtsJuzgTGsM12
	 7+OQn5jF4b2DYe6qX/1DR8+TfqBHuUBrimRy/m3CvxmaZ2wv/OpD02WGCICvaYQeUAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388054;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=ak/T7iiDiq9aYPCrGJcqObLcls1QnJw/rGVo00Drg/s=;
	b=aBpetTOxPtXPzpWe0axbrhvSel8NtYX744FaoGS6fUF/JdtSpWPftaKnB9EBr0gooy91
	 Y37l/sR4S8poz93nrZBpJKha3WGKFVZtMkGHO9im4ixNJK454zCCeitjAH3ArDVop4ZTF
	 CL5BQ3vGuzyERXp8k3uZz63BMQFWR16ANxF8j6h43i1mJAVy60ICVw58QlHjifdyO75eG
	 h+aQWoWESoPIsWCRcZpcm3OlCE9VlEf68ObUgO3PzpEtVRIe2htyq1Y5cTCYX1095zwL4
	 ByACMAOH3YyXkW+AjBFsnHumaCUkp5N4QHIzhbgstyEmA7Y4zHYR6UvYB2rUhPK6+oQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CNKU/Uir";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA11D606A31A;
	Fri, 30 Oct 2026 19:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CNKU/Uir
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB31E1F000C1;
	Fri, 30 Oct 2026 19:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793388053;
	bh=ak/T7iiDiq9aYPCrGJcqObLcls1QnJw/rGVo00Drg/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=CNKU/UirjQwoH27VwyYvo9M92YWR1EjCa1xdvGXCAmKw/el6SYOrCjiDoQOoy0JBP
	 X9oQ8OAB69evZt2l4tqXwpDIRvczAt75JBnk5XKYmcEcmft4nM9Bj3j99a+i3a++gy
	 UfKiEYHi5kuujsXHOruaKym8NM2mATPzTNZEo4pdgtiLWU/EDdCBAGIgVHO6PymToB
	 Rl50nYUTXiimIrQuo88H0D+q1kNZPXRfbecgx1vOtH6JZ7q1E0QCr8+Q8stZ1dc8nZ
	 tNp4TBot3t6eD/rjjD1/FvEK2oFb68DABWg89YtGBozLD2AdEV7qqQo8/1oeobzsx+
	 YasV7RU13NETg==
From: Thomas Gleixner <tglx@kernel.org>
To: Han / =?utf-8?B?7ZWc7IOB7JqwU2FuZ3dvbw==?= <sangwoo.han@nearthlab.com>,
 Bjorn Helgaas
 <helgaas@kernel.org>
Cc: jim2101024@gmail.com, florian.fainelli@broadcom.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
 bhelgaas@google.com, bcm-kernel-feedback-list@broadcom.com,
 robh@kernel.org, linux-pci@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Inochi
 Amaoto <inochiama@gmail.com>
Subject: Re: [PATCH] PCI: brcmstb: Reserve only the MSI vectors that are
 handed out
In-Reply-To: <CAFg7d9a2p2jtGyThS1M=2ZFDX0y5rpSK3H34ZuTz09R5r_ff0A@mail.gmail.com>
References: <CAFg7d9becn9_=ZzNwQ7bSBBNid28t_RnofL-Vb1cZVHVHxS9fw@mail.gmail.com>
 <20261013160612.GA1522005@bhelgaas>
 <CAFg7d9a2p2jtGyThS1M=2ZFDX0y5rpSK3H34ZuTz09R5r_ff0A@mail.gmail.com>
Date: Fri, 30 Oct 2026 20:20:50 +0100
Message-ID: <87h5i3xael.ffs@fw13>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Oct 30 2026 at 21:59, Han wrote:
> On Thu, Oct 01 2026 at 21:29, Thomas Gleixner wrote:
>   The buggy address is located 0 bytes to the right of
>    allocated 48-byte region [ffff8000053a6880, ffff8000053a68b0)
>
> The report is caused by the patch. __msi_domain_alloc_irqs() passes
> nvec_aligned (4) to __irq_domain_alloc_irqs() together with
> desc->affinity, which has only nvec_used (3) entries. alloc_descs()
> then reads all 4 entries. The fourth entry is read past the end of
> the array. If the data there has no CPU set, the allocation fails
> with -ENOSPC. Without PCI_IRQ_AFFINITY, desc->affinity is NULL, so
> this read does not happen.

Ah. I missed that detail. I'll look at it on Monday.
