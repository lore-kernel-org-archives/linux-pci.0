Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB82380FD3
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 05:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790659345; cv=none; b=KTGzUX66GgsKphlmLlFf3Ao/UJLcJ0bYyYT/bXtgcHspiHEwDVtPIq1FgcKjCA3S8ew16NDwHjmMrbQLpVB4QodMYuu+NEvrPNIr7CfX105HQYXkvi3EMm7mg+LI4bS+KCsesjXJA/Vz9witLyFNHM5tq/bsl4cttNY+UANzQ3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790659345; c=relaxed/simple;
	bh=vpYfKTxXIpxKgJEb9n7egaOBtxw9oYnxjiKtlRW0SIQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Npbzf2KhIeRmaQwYHslvPtA+L6J+h4J8zUWlsz0BswogQBcyMXpmT7I8kTR//J2kDBvltAVW/gLhz3pyc2rfEP+uwHwsaMzxaeA/33kFlvbd6PjotFKIBlXNVKCv8D/o12UXKve3OlgnpaHHvIeloC8Tx21LoNS28znpNzOtGxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E6vjG2wV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E6vjG2wV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A411F000FF;
	Tue, 29 Sep 2026 05:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790659343;
	bh=VrHvnck3xXFZI308etuoNKJN0R9izo8g9wviEigIcyk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E6vjG2wVbjMZiip2AZiawSfq3o61umRxyVcGHc2rce/F+6TMwlMxjH/6perO27tZd
	 pt2tjmtK27zbhE+1t8sCmFb0NHIyIISu2Rvv+f9MKthDyLVe6ld562cD1oa7jftf2p
	 3CWa4DSp4FzmJSaCf/tRQLHHBxdG7GBuisMvE2aMmTYEH7MvVGNnQ9gmtOiaqA+C/Y
	 Ohvttz1nlvQHANYFtFAv4ba/27W8JHxRPoJ9qXo4At5TCIdRQ4aTAWK9/vn0CX2VvY
	 ofHmVi1rgHj8qCgrzVeJeo43P1aSWckQ4mQUqr5XkUw6rG6qWkHDoECIA2hpXYIbls
	 WJ39Wq5XUNUSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/16] genirq/msi: Provide
 msi_device_domain_restore_msi_msgs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929034510.2023173-9-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
 <20260929034510.2023173-9-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 05:22:23 +0000
Message-Id: <20260929052223.C3A411F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] irq/msi: NULL pointer dereference in msi_device_domain_restore=
_msi_msgs
--

commit 095b22d878464bc6c7b357c12fc988c69e1487d7
Author: Thomas Gleixner <tglx@kernel.org>

genirq/msi: Provide msi_device_domain_restore_msi_msgs()

This commit provides msi_device_domain_restore_msi_msgs() to iterate over M=
SI
descriptors and rewrite cached MSI messages for devices that lose register
state during power transitions. It iterates over the associated MSI descrip=
tors
in the device's MSI domain and rewrites the messages via the irq_chip hiera=
rchy.

> diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
> index df460a574d800..8fb855b5e09f3 100644
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
[ ... ]
> +	xa_for_each_range(xa, idx, msi_desc, 0, info->hwsize - 1) {
> +		/* Only handle MSI entries which have an interrupt associated */
> +		if (!msi_desc_match(msi_desc, MSI_DESC_ASSOCIATED))
> +			continue;
> +
> +		scoped_irqdesc_get_and_buslock(msi_desc->irq, 0) {
> +			struct irq_data *data =3D irq_desc_get_irq_data(scoped_irqdesc);
> +			struct msi_msg msg =3D msi_desc->msg;
> +
> +			if (data->chip)
> +				irq_chip_write_msi_msg(data, &msg);

[Severity: Critical]
Will this result in a NULL pointer dereference in hierarchical IRQ domains?

Since irq_desc_get_irq_data() retrieves the top-level irq_data, data->chip
points to the top-level irq_chip. In hierarchical IRQ domains, the top-level
irq_chip typically does not implement the irq_write_msi_msg callback.

When this top-level irq_data is passed to irq_chip_write_msi_msg(), it will
dereference a NULL function pointer:

kernel/irq/msi.c:irq_chip_write_msi_msg() {
    ...
    data->chip->irq_write_msi_msg(data, msg);
}

Should this code retrieve the specific irq_data for the MSI domain that
actually implements the write_msi_msg callback, rather than using the
top-level irq_data?

> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(msi_device_domain_restore_msi_msgs);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929034510.2023=
173-1-praan@google.com?part=3D8
