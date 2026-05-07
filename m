Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D137756E
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 07:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140799; cv=none; b=NPjHeMzjdqXPGoSAIbiwi6KG0ACu/+azzdJj6+JQjkTqxjsCOhR6S6ZRtrKMjFE9n7WKq47BbthnwFJrTqNBMXPmhVFuTlrTOnAZ+5IHGZuZ3H3JrlBO+7dNrhEFqA97iA9Bzv78JLL+2mlCY8dF9xgbJSRaI7KZ75mpeWU/jn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140799; c=relaxed/simple;
	bh=ma3trTyqcR2zMHbTmP1FiSJo20kbC7/PwNHpY9rd2rk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDO3G8RIlZYCC9v+zOOuTe+SmV5WaRdkGWhuZWfpws/Q1eQEDsyGiqDkLDYzTiDtYoNpyEimhXmW3nQTXsdB7cw6AByHSi2n7mnfiJYgmzAPeEDwQDV5RUBU2Zi7N1vFUMYIvYVG8r8XvGXtRq5H4X6/Ifsu18F0utLQUqh+SOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBwdMWz5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBwdMWz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CD8C2BCC7;
	Thu,  7 May 2026 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140798;
	bh=ma3trTyqcR2zMHbTmP1FiSJo20kbC7/PwNHpY9rd2rk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cBwdMWz5PGG8LWy4eLLEb3C7KMNwLhItullSociv6CWpY24TTTMS3Ko3/f94JzCMy
	 f2ejsYRco+bUyHtj+DGcUjrDsdWmafHeYFvPRozJHEkbsgqz1Hfo6oPdQpztrS0UaC
	 QhBEV2hHg2I8v1PRnZrmyGT+jzOaSQNNBDBx8Ai9wKjb35KsUl5NUDe7BRg7ueEjAX
	 WyHrzRWAyJ7y1Rfx8TU6duZx6aD3ZoPRW1W9CDNDGKqbkUnKnrjfnxK573HLmRKt+z
	 U7W6mBRZBpyTM1RkvdUmtSxokN3Ojtgipkj1ttNL8FzNfkr32M3zuOQgmOM9LBo/jI
	 DDbDSnsjKYDjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 02/31] ata: add <linux/pm_runtime.h> where
 missing
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260505100523.1922388-3-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 07:59:58 +0000
Message-Id: <20260507075958.82CD8C2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Callers of `ahci_rpm_get_port()` unconditionally ignore the return=
 value of `pm_runtime_get_sync()`, potentially accessing suspended hardware.
- [High] AHCI interrupt handlers process interrupts without checking if the=
 device is runtime-active, leading to spurious handling and MMIO reads on s=
uspended devices.
--

commit 4c8bdcda88f27ad5b4d7ed5e7d48bab865cfb2dd
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

ata: add <linux/pm_runtime.h> where missing

This patch adds the <linux/pm_runtime.h> header to several AHCI drivers
that use runtime PM operations but previously relied on an indirect
inclusion from <linux/phy/phy.h>.

> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 1d73a53370cf3..1396a53bd6df3 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -26,6 +26,7 @@
>  #include <linux/device.h>
>  #include <linux/dmi.h>
>  #include <linux/gfp.h>
> +#include <linux/pm_runtime.h>
>  #include <scsi/scsi_host.h>
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>

While reviewing the addition of runtime PM headers, I noticed a pre-existing
regression with how interrupts are handled in this driver.

Could ahci_single_level_irq_intr() be invoked for a runtime-suspended
device due to shared interrupts (IRQF_SHARED)?

If the device is powered down, would reading HOST_IRQ_STAT return 0xffffffff
and cause the handler to call ata_qc_complete_multiple() with fatal errors
(like PORT_IRQ_FREEZE and PORT_IRQ_ERROR), eventually triggering severe ATA
error handling and port resets?

Would using pm_runtime_get_if_active() before accessing the hardware regist=
ers
prevent this issue?

[ ... ]

> diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
> index c79abdfcd7a9b..e0de4703a4f2d 100644
> --- a/drivers/ata/libahci.c
> +++ b/drivers/ata/libahci.c
> @@ -30,6 +30,7 @@
>  #include <scsi/scsi_cmnd.h>
>  #include <linux/libata.h>
>  #include <linux/pci.h>
> +#include <linux/pm_runtime.h>
>  #include "ahci.h"
>  #include "libata.h"
> =20

I also noticed another pre-existing regression in this driver.

Does ahci_rpm_get_port() need to have its return value checked by callers?

It looks like it directly returns the result of pm_runtime_get_sync(), but
callers like ahci_show_port_cmd(), ahci_read_em_buffer(), and
ahci_port_resume() seem to unconditionally ignore this return value.

If pm_runtime_get_sync() fails, could the callers proceed to access
memory-mapped I/O registers (such as PORT_CMD or HOST_EM_CTL) on a suspended
device, potentially causing a synchronous external abort on ARM or invalid
reads on x86?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D2
