Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4365221D9;
	Tue,  8 Sep 2026 23:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909715; cv=none; b=XlJcqsSoE1k4o1t+qsB7Wc8dCpp+vTVFGqvnnOsOi25+xse9MUpjwXIqd/QW4C1PdL7SXHhnLD6lTMSOAwr8EzvTKfdEqgQDcKhAWYkRY6kwBjVnjjk029uirQ2khlusoCYaWrntn72k0enjw+YkB7QAM4UG49R2LmdcRns4IZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909715; c=relaxed/simple;
	bh=yQy3C20jHoJxnOr0MiUkNqcxgp3fW/JsyluhuzjAQCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKeVgbimFqc6/knJRW3eaL1IK6x+qy+V1QzqowtYMx/k/MehgxwzHqezhkwtfHgiAo7B4g1egIur8azUE/6Dr4lMKzHaY4Sx1fi3yFXguSywGGu+uzdfnTTcMKL4Kvdoem+5Ph39g3ajfyYSf+ZCDJD7/I7/W1KYhnK+drJzy88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDFbIPNJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDFbIPNJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D11F00A3D;
	Tue,  8 Sep 2026 23:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909708;
	bh=NLvH9u4KzvhJ0LMUBoEDzEmZPA+sdK1nFAVbS9YzTTw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UDFbIPNJTkuujIyYJ35I07fgmj6iilC3ms1rPcsRaEtxVwo3lTQEmQW+j+WGKfyX6
	 YGS4KR9mRLrP6RgJ/TkGujy3TWYChrCM/RvPWDS0ndaeCdYior8wsDaDw+ovruBvXT
	 59dfkIHk70YepneWjz/RgCI8yMjP2jmO2jjBBF1BTPzC6QsawE1OShdeM3YcL/qRyU
	 +UNaRBw1UROEKuoWfg6a0/fTDclMqSHqMWrzi//wzzIzoai7a1c9ltG3k+j+njVcg7
	 uuYzsGAla7lcaY71FrSrnrE6VjU7/m1LML0fQf7r/Ibohz3iLY0RyzIewXAbIsFp66
	 0Y/2lNzG33k4g==
Date: Wed, 9 Sep 2026 00:21:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, lukas@wunner.de, alistair@alistair23.me,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com, Alistair Francis
 <alistair.francis@wdc.com>
Subject: Re: [PATCH v3 12/21] PCI/CMA: Add a PCI TSM CMA driver using SPDM
Message-ID: <20260909002142.2d863d2a@jic23-huawei>
In-Reply-To: <20260901010347.2614656-13-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
	<20260901010347.2614656-13-alistair.francis@wdc.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 11:03:38 +1000
alistair23@gmail.com wrote:

> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Component Measurement and Authentication (CMA, PCIe r6.2 sec 6.31)
> allows for measurement and authentication of PCIe devices.  It is
> based on the Security Protocol and Data Model specification (SPDM,
> https://www.dmtf.org/dsp/DSP0274).
> 
> CMA-SPDM in turn forms the basis for Integrity and Data Encryption
> (IDE, PCIe r6.2 sec 6.33) because the key material used by IDE is
> transmitted over a CMA-SPDM session.
> 
> As a first step, add support for authentication via a CMA TSM driver.
> 
> This was previously discusd here:
> http://lore.kernel.org/69976d7d39c60_2f4a1009@dwillia2-mobl4.notmuch
> 
> By utilising a TSM driver we get a lot of the TSM driver probe policies
> "for free". Currently there is no mechanism to provide evidence to
> userspace, as the TSM system doesn't support that at the moment. That
> can be added later when support by TSM.
> 
> Credits: Jonathan wrote the original proof-of-concept for a CMA implementation.
> Lukas reworked that for upstream. Wilfred contributed fixes for issues
> discovered during testing. Alistair reworked it as a TSM driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> Co-developed-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

A few things inline.  I have no idea if I'm poking holes in 
my own code or if none of that is left :)

>  
> diff --git a/drivers/pci/cma.c b/drivers/pci/cma.c
> new file mode 100644
> index 000000000000..9f2cc0b2ec8a
> --- /dev/null
> +++ b/drivers/pci/cma.c

...



> +static int pci_cma_tsm_connect(struct pci_dev *pdev)
> +{
> +	struct pci_cma_tsm *cma = cma_tsm_from_tsm(pdev->tsm);
> +	int rc;
> +
> +	/*
> +	 * The DOE mailbox lives in the device's config space, so the
> +	 * device must be runtime-resumed for the duration of the SPDM
> +	 * exchange.

Oddly short wrap. Comments go to 80
	/*
	 * The DOE mailbox lives in the device's config space, so the device
	 * must be runtime-resumed for the duration of the SPDM exchange.

> +	 */
> +	rc = pm_runtime_get_sync(&pdev->dev);
	rc = pm_runtime_resume_and_get(&pdev->dev)
	if (rc < 0)
		return rc;

See comments in docs for pm_runtime_get_sync() for info on this.
Basically it doesn't mess up reference counting so you don't need
to fix it in the error path.

Mind you, I haven't looked ahead but we have ACQUIRE macros for
runtime PM that might apply nicely here and remove need to release anything
at all.

	PM_RUNTIME_ACQUIRE(&pdev->dev, pm);
	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
		return -ENXIO;

	

> +	if (rc < 0) {
> +		pm_runtime_put_noidle(&pdev->dev);
> +		return rc;
> +	}
> +
> +	rc = spdm_authenticate(cma->spdm);

If you can use ACQUIRE stuff
	return spdm_authenticate(cma->spdm);

> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	return rc;
> +}

> +
> +static const struct pci_tsm_ops pci_cma_tsm_ops = {
> +	.link_ops = {
> +		.probe		= pci_cma_tsm_probe,
> +		.remove		= pci_cma_tsm_remove,
> +		.connect	= pci_cma_tsm_connect,
> +		.disconnect	= pci_cma_tsm_disconnect,
> +		.bind		= pci_cma_tsm_bind,
> +		.unbind		= pci_cma_tsm_unbind,
> +		.guest_req	= pci_cma_tsm_guest_req,
> +	},
> +};
> +
> +static struct tsm_dev *pci_cma_tsm_dev;
> +
> +static int __init pci_cma_tsm_init(void)
> +{
> +	struct tsm_dev *tsm_dev;
> +
> +	tsm_dev = tsm_register(NULL, (struct pci_tsm_ops *)&pci_cma_tsm_ops);

So this is casting away the const.   Why does tsm_register not take a const?
Can we change that as seems unlikely it will actually modify it?
If there is any chance of a modification in future then we need to drop
the const marking on the structure above.


> +	if (IS_ERR(tsm_dev))
> +		return PTR_ERR(tsm_dev);
> +
> +	pci_cma_tsm_dev = tsm_dev;
> +	return 0;
> +}
> +late_initcall(pci_cma_tsm_init);
