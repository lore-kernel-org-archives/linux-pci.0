Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5768237104C
	for <linux-pci@vger.kernel.org>; Fri, 15 May 2026 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809020; cv=none; b=kebkbL/rp5ukaha7pvHCuPA+vhhiIkb8Szaxk/2FLooEm4beFKD+2lxn9rKh1kjKcUdZS1i6tyTgj1XrrOzDV57e87zsdSn9f5/yJ/KHY2Isxw1qIXhv6ZOaalCMOAHW5b5KkLyggXWnmk+w6haSJlI98+yp8RU0xFcRLwKpvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809020; c=relaxed/simple;
	bh=Ka3rYjcHv5fDpaxp5l/D8Ef3lLVdGTHdLn01Z9GUC8I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BmfkP7WknBWpmkcLX86KgXjr+gn1W3mRv9dNFepql211jdoZusfSaSs/wXGFR1DfAgFHsjjPJzT5flSKmnKch9tEk4h4h/UAWdYCUclzKv4UxzZEoDEdQt1exI3h+JCjf5pEDEiWYfqHGOQ7fo8mWSaZ9SbT3N3qozDSwJHFSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1dp8erG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S1dp8erG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC03BC2BCC7;
	Fri, 15 May 2026 01:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778809020;
	bh=Ka3rYjcHv5fDpaxp5l/D8Ef3lLVdGTHdLn01Z9GUC8I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=S1dp8erGDErc0l+ZAKI38nNX37869Zl2TP8jk6UsGw69bo4yOOgA1sga8itkjW90Q
	 dN1VtQNDwUL44CtnaD1qM3WAe9a7uH/ZfnY6oyA9oyrn79NDmubTcoAbTDkhyDZpSB
	 kGP5tGayf8rT2d2caT8aOOhMOrK/SVubETYLEp3YoK4QtX4JaLmL/0yZd6WmDSmfiW
	 1JnNpSaMhsEwIY9OI1KsrlsFhV1Qp/bUxnmvmN+BsM0Qw+ltktMGIeLJDuZldyQwWe
	 pNgbqFjQ8yNHJdPd3yJT2jkxTKUAsQNziyk6+Ft1zAQdNwgUx8Vlo2c/d+1VWsbBeE
	 4nN1AZCipnuxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek: Fix operator precedence in
 PCIE_FTS_NUM_L0 macro
Reply-To: sashiko-reviews@lists.linux.dev
To: lirongqing <lirongqing@baidu.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260515005552.2343-1-lirongqing@baidu.com>
References: <20260515005552.2343-1-lirongqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 May 2026 01:36:59 +0000
Message-Id: <20260515013659.DC03BC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Fixing the macro changes the configured FTS number from 0 to 80, c=
onflicting with the comment requiring 250 and potentially breaking L0s link=
 recovery.
- [Low] Missing explicit inclusion of `<linux/bitfield.h>` for `FIELD_PREP(=
)`.
--

commit be16aaf8543160340df684dc520cc762167effe3
Author: Li RongQing <lirongqing@baidu.com>

PCI: mediatek: Fix operator precedence in PCIE_FTS_NUM_L0 macro

The original PCIE_FTS_NUM_L0(x) macro was buggy due to improper operator
precedence, where ((x) & 0xff << 8) was evaluated as ((x) & 0xff00).

Instead of just fixing the parentheses, use the standard FIELD_PREP()
macro. This makes the code more robust by automatically handling masks
and shifts, while also adding compile-time type and range checking to
ensure the value fits within PCIE_FTS_NUM_MASK.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 75722524fe744..00f0e29183f2b 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -61,7 +61,7 @@
>  /* MediaTek specific configuration registers */
>  #define PCIE_FTS_NUM		0x70c
>  #define PCIE_FTS_NUM_MASK	GENMASK(15, 8)
> -#define PCIE_FTS_NUM_L0(x)	((x) & 0xff << 8)
> +#define PCIE_FTS_NUM_L0(x)	FIELD_PREP(PCIE_FTS_NUM_MASK, x)

Should this file explicitly include <linux/bitfield.h> for FIELD_PREP()?

While the file compiles on ARM/ARM64 due to implicit inclusion via
<linux/irq.h> and <asm/ptrace.h>, missing the explicit include can cause
build failures on other architectures like x86 during COMPILE_TEST.

Does this change introduce a regression in L0s link recovery by altering
the configured Fast Training Sequence (FTS) number?

The driver configures the FTS number here:

drivers/pci/controller/pcie-mediatek.c:mtk_pcie_startup_port() {
    ...
	/* configure RC FTS number to 250 when it leaves L0s */
	writel(PCIE_CONF_ADDR(PCIE_FTS_NUM, func, slot, 0),
	       pcie->base + PCIE_CFG_ADDR);
	val =3D readl(pcie->base + PCIE_CFG_DATA);
	val &=3D ~PCIE_FTS_NUM_MASK;
	val |=3D PCIE_FTS_NUM_L0(0x50);
    ...
}

Before this patch, the macro evaluated to 0 because 0x50 & 0xff00 is 0.

This value of 0 might be safely interpreted by some hardware as 256,
satisfying the comment's requirement of 250.

By fixing the macro, the driver will now actively write 0x50 (80) to the
register instead of 0.

Since the comment explicitly requires 250, could reducing this to 80 cause
link recovery to fail?

Is 0xfa (250) the intended value here instead of 0x50?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260515005552.2343=
-1-lirongqing@baidu.com?part=3D1
