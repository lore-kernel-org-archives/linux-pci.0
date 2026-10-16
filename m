Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B125B0BD
	for <linux-pci@vger.kernel.org>; Fri, 16 Oct 2026 12:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792153900; cv=none; b=LJuv9ZarbrzSp4Dcskc4hC7tBpIWchXILAW0sbd5Jwiznv+kbcKu5e9QX7vDA8uX60MQuVOuDdd2ukAnnbqxoYXaDzDTBucKd0j5aHPtkjrvAyP34xSxBcPIW+ec5qLaPBqa3PO2/96vArCv2XfhQIlxmnzmkVTuq7LB6O+VCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792153900; c=relaxed/simple;
	bh=5AMVWSneSQWu0OI3AVOr5u5Zi7lrzcSC6Yi5oiq0tsw=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bhmCz8NKtH+4vqA6HQygCtTLqqa6AsmegEgXR9m3NcdMcXXrO4EOxUTNH9EGtE25lZqTRIeOCGGCkzpZBXiBZiebm6iPYjB/mNOEE5GIfiE291GJ8uy8oXYATU8mCXcmDWrVWHAAfh7GRuBfALc3qL0DMynJwvkFZ8oyIRBexb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwJM11zn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwJM11zn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C4351F000C4;
	Fri, 16 Oct 2026 12:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792153898;
	bh=sr39sHFy1/ilAQ7osr0PdieJBTK+mUfzDqGFBcj/T0g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CwJM11znF2+c/GS4e3y8t5zc9mTYS1Ne7MRpHYAvPDMIFwtIDWEFZU9mLKRfaqx8X
	 KkWEdqhGDlute9BAt91yd5mjqFKeVWD7Y0XrwWvc5FuIhxgv6kQnfiZFzlozV4tqwc
	 pmphP8TCdFFH/0bvmWKPLo3nr7TFkt25mkzBGcofQz2D4oeSwGnY/KiwoZICr27hdH
	 C5jKh+q5jtMxP88F670kWwEeIOLM+RFcnh/QDL7PIBStc4FvMuHHuUVZl/52i1X7Ec
	 3DcvXgKmBy4xsX4r59JObokeK//Fj4xIYYqXLA0S9hEM3div67h/snTO7blqjSfY8r
	 KtV76Db4qkZ/w==
Message-ID: <sashiko-outbox-174297@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: iproc-msi: Bound events handled per IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugen Hristev" <ehristev@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>
References: <20261016-iproc-irq-v1-1-ebaaf027f29e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 12:31:38 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: iproc-msi: missing dma_rmb() after TAIL register read
--

commit 8736e22d751e9208bad7bb267a7f08a76f8d4f77
Author: Eugen Hristev <ehristev@kernel.org>

    PCI: iproc-msi: Bound events handled per IRQ
   =20
    Limit each iProc MSI parent IRQ to 16 event-queue entries.
   =20
    A continuously fed queue could otherwise keep the chained handler runni=
ng
    and starve other work. The budget still drains pending events and lets =
the
    next parent interrupt continue processing, improving fairness and bound=
ing
    interrupt-handler latency.

> diff --git a/drivers/pci/controller/pcie-iproc-msi.c b/drivers/pci/contro=
ller/pcie-iproc-msi.c
> index 9ba242ab95967..6649807822d27 100644
> --- a/drivers/pci/controller/pcie-iproc-msi.c
> +++ b/drivers/pci/controller/pcie-iproc-msi.c

[ ... ]

> @@ -360,9 +364,11 @@ static void iproc_msi_handler(struct irq_desc *desc)
>  			break;
> =20
>  		/* process all outstanding events */
> -		while (nr_events--) {
> +		while (nr_events && event_budget) {
>  			hwirq =3D decode_msi_hwirq(msi, eq, head);

[Severity: High]
Does this sequence lack a necessary dma_rmb() before reading the event queue
in decode_msi_hwirq()?

Because iproc_msi_read_reg() uses readl_relaxed() to read the TAIL register,
weakly-ordered architectures could speculatively execute the DMA memory read
from msi->eq_cpu (inside decode_msi_hwirq()) before the MMIO read of the TA=
IL
register completes.

Could this result in reading stale hardware IRQ numbers from the event queue
on subsequent iterations of the polling loop, leading to missed or spurious
interrupts?

>  			generic_handle_domain_irq(msi->inner_domain, hwirq);
> +			nr_events--;
> +			event_budget--;
> =20
>  			head++;
>  			head %=3D EQ_LEN;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-iproc-irq-=
v1-1-ebaaf027f29e@kernel.org?part=3D1
