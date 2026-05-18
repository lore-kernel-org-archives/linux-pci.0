Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C593E1D0B;
	Mon, 18 May 2026 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122567; cv=none; b=sZyhYlSNpe5qUKrcZrP8XKzuwkj59EHQY4Dfsu63p5pNTfKXDqrBg3rvr72/BG+Jj01QOw0sVugHugTD30YOjV+3Rkl8IeZ2MNt5nyy/R+rl/OrI9pjcU934tmvc7uG0N6OQbMpd8UpRfC2jx8gp6o0Dl1kfQKXMUAvhJrrQuu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122567; c=relaxed/simple;
	bh=6Wr5FGpHc7y9iunwUXV/RjsGZXwN/lghPoM+jfK19B4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZSf0KpdGsN2enmmg2VC/0hz2QQVU4EO2HjmNJpwiDUMs9ERSickPPODRP+4pezBG+CtwygOLDXnvvRua6Mzvxj6MTUEXkFXXYYNvCVVqT7GAhNjnw/+cIAvhP+G7TQPZKlEiploRzXbKZapPprON5beA3TIqASD1oHyVJ8L/o3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPhq3+wZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPhq3+wZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330B4C2BCB7;
	Mon, 18 May 2026 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779122567;
	bh=6Wr5FGpHc7y9iunwUXV/RjsGZXwN/lghPoM+jfK19B4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=OPhq3+wZIq3FJRrcVm5KAi/UkiLTams4yXC5y+MF+FaVjuNRlIzu4SntgRAUm1zWs
	 TGxNUad6kyEAalPBP7ARBOsAsqQvkG0veRQpxp7sya6XfEFR33Yl35KSRdFpwACLJ5
	 ObEILdP53DdYYFo3UbSpX/WN+UttDtacJEhaSViSom1cZQJot7o0IqUGLrQGAo0ooS
	 aGt4t+lExPLbUS8UodPCeNjWsZDolZv+dBDG3xAuIl20+FKrKFb9pJbRB0XrJKqFg8
	 OSJkLzWQbhXGDEXnTSYh+covsXsshBz/GNBexWXwgCB8EFtg4r/aGJBjggeQyuIoh9
	 NsSH79C7tyrYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260518155324.168948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260518155324.168948-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 16:42:46 +0000
Message-Id: <20260518164247.330B4C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Missing chained IRQ handler cleanup in error paths leads to Us=
e-After-Free of the host structure.
- [High] The `rzg3s_pcie_resume_noirq` callback unconditionally executes `f=
sleep(5000)` while local interrupts are disabled, leading to a system hang =
or scheduling BUG.
--

commit 41ddeeaac37e089f4b9cce52ea971db3b995ab04
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s-host: Use shared reset controls for power domain resets

Switch to shared reset controls for PCIe power resets to prepare for
RZ/V2H(P) support. On this platform, multiple PCIe controllers share
the same reset line, requiring shared ownership of the reset control.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index d86e7516dcc29..a5192e4b58dfb 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

While reviewing this code, I noticed a potential regression that was not
introduced by this patch.

In rzg3s_pcie_init_irqdomain(), the driver loops over PCI_NUM_INTX and
installs chained handlers for INTx interrupts:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_init_irqdomain() {
    ...
	for (int i =3D 0; i < PCI_NUM_INTX; i++) {
        ...
		irq_set_chained_handler_and_data(irq, rzg3s_pcie_intx_irq_handler,
						 host);
    ...
}

However, if an error occurs later in the initialization sequence, the error
handling paths do not tear down these chained handlers by calling
irq_set_chained_handler_and_data(irq, NULL, NULL).

Since the host structure is allocated via devm_pci_alloc_host_bridge(), it =
is
automatically freed when the probe function fails.

If any of the mapped INTx interrupts trigger after probe failure, the kernel
will execute the stale rzg3s_pcie_intx_irq_handler which dereferences the
freed host pointer.

Can this lead to a use-after-free regression on the host structure?


I also noticed another issue in the resume path:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_resume_noirq() {
    ...
	ret =3D rzg3s_pcie_power_resets_deassert(host);
    ...
}

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_power_resets_deassert()=
 {
    ...
	fsleep(5000);
    ...
}

rzg3s_pcie_resume_noirq() is registered as a .resume_noirq PM callback via
NOIRQ_SYSTEM_SLEEP_PM_OPS.

The PM core executes noirq phase callbacks with local CPU interrupts explic=
itly
disabled.

Within rzg3s_pcie_resume_noirq(), the driver calls
rzg3s_pcie_power_resets_deassert(), which unconditionally executes
fsleep(5000).

For a 5000us delay, fsleep() delegates to usleep_range(), which uses
schedule_hrtimeout() and sleeps the task.

Because timer interrupts are disabled on the local CPU in the noirq phase,
the hrtimer may never fire to wake the task.

Could sleeping with interrupts disabled here trigger a scheduling bug or le=
ad
to a silent system hang regression during resume?

If a delay is strictly required in the noirq phase, should a busy-wait
function like mdelay(5) be used instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518155324.1689=
48-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
