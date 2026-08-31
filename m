Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22C7471D0B
	for <linux-pci@vger.kernel.org>; Mon, 31 Aug 2026 15:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190982; cv=none; b=fSHwogzVx89P+0O1IHfRyd2eFk8faAF9+q4JgzVtyFoH4zW6E63EyF7QA+3fzZNO4dycx82jG52VpaN1WpzHztLItrCPzT7TXBlQwAnBDA9VJIAn0Vls/lWaJZmickQ8ZRva0vbbsDftsrMD3DGMBD2CMuPhm7Hs8IvIVafd7Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190982; c=relaxed/simple;
	bh=49q7UWDyQojyfcQBltK708ihB1WkXMKlx2N/DBIOo0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n+UO/WNwZyjeRc/eI/vcx/RnMiqrTln1YwN5imv33FAPN2d9qLTXOHmOGlWVVfKleRhOgdViYhJf0eg13WrrSVJf8wFqv/u2p8aI8MvfNhs72X0J8SaOzvDIbcpYoazAgoi27MjNjy3WQV2Saf6I4IE8YX18oWK+mYJkEfMGX2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAye6nFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAye6nFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6321F000E9;
	Mon, 31 Aug 2026 15:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190981;
	bh=1jbolT1XgGry5wCTIhqzSGWUTkNgrAhVm0Xr0uaTCYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gAye6nFKx6jSRrHU5Mv0M/CohYwjuxGsRXvZpK62bZFMcbaXse0L/c2x7IX5oJEht
	 ZwOMpb2duAU+RAEAGx3deYnlnwHJP//yw1eye0r2zWuykgfxHR7ds4MnxBotdSJ3Zx
	 pThfMCZVjYq60cgHGQXuzsU4J9dKkQUPoZR2QcOfcmQ4dXipOpk9FhIH8D42/6Ba/V
	 HWJdwtR4LyMTaXOuch+y7simID4EVp0L1zdOsG5WABnTnj/J1PVLlJ3FTOwXsD8lB6
	 m+FWndKRfmei0Wu2zfMCo/PNuPwh4nOhtTCPa9vyecI57gNkglB4jWrKxw9XQH2FN8
	 /af6Gu4vfNf6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-6.1] PCI: switchtec: Add Gen6 Device IDs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260831133314.4125787-341-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-341-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:43:00 +0000
Message-Id: <20260831154301.0C6321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in error paths and driver teardown,=
 leading to IRQ vector leaks.
--

commit 0bbab4b0d204e1f22ee16e8e7ffb4b1a30c43568
Author: Ben Reed <Ben.Reed@microchip.com>

PCI: switchtec: Add Gen6 Device IDs

Adds device IDs for the next generation of switchtec products. No changes
to the driver were required with the new version of the hardware.

Link: https://patch.msgid.link/20260505161633.67454-1-logang@deltatee.com

> diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchte=
c.c
> index 5ff84fb8fb0f4..f32ddfa79da99 100644
> --- a/drivers/pci/switch/switchtec.c
> +++ b/drivers/pci/switch/switchtec.c

[ ... ]

[Severity: High]
This is a pre-existing issue, but while reviewing this driver for the
addition of these new device IDs, I noticed that IRQ vectors allocated
via pci_alloc_irq_vectors() do not appear to be freed in several error
paths and during driver teardown.

For example, in switchtec_init_isr(), there is an error path that
returns without freeing the previously allocated vectors:

drivers/pci/switch/switchtec.c:switchtec_init_isr() {
    ...
    if (event_irq < 0 || event_irq >=3D nvecs)
        return -EFAULT;
    ...
}

Similarly, during driver teardown, the remove function fails to call
pci_free_irq_vectors():

drivers/pci/switch/switchtec.c:switchtec_pci_remove() {
    struct switchtec_dev *stdev =3D pci_get_drvdata(pdev);
    ...
}

And the common exit function used for probe errors and driver unload
also omits the cleanup:

drivers/pci/switch/switchtec.c:switchtec_exit_pci() {
    if (stdev->dma_mrpc) {
        iowrite32(0, &stdev->mmio_mrpc->dma_en);
        flush_wc_buf(stdev);
        writeq(0, &stdev->mmio_mrpc->dma_addr);
        dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
                          stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
        stdev->dma_mrpc =3D NULL;
    }
}

Does this code leak the IRQ vectors on unbind or when probing fails?
Should pci_free_irq_vectors() be called in these paths to prevent
exhausting system IRQ resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-341-sashal@kernel.org?part=3D1
