Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1103C3F5F
	for <linux-pci@vger.kernel.org>; Mon, 17 Aug 2026 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786959252; cv=none; b=hC+NAkkTWNjnU0vQ99WAGr3yY5hB1Jleo6XlnYEwj5DZ2zM9CXjS2LlGU5n+K2vNaKa67A5ZJhFpQaU5shfx6XpOVqzqOd1tZo6I5aJmG/PxbNBkpFLxaURG6+WQWW2MnDam8xNYeckYv/9J5UnSQtEcZ+4wPGat6/CJHu+14pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786959252; c=relaxed/simple;
	bh=bW55G9T3xXI+E6C68Ktrfo23IcZL97VBoMvbnvnQ8+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iBLhwXjFXby7cEy+mMxRPSp731V/KmU1I2XaHvsj4pWNx91JTRjodFqkReBD0K9vAmjBJNoK9f7uEBG3y5exnBX0iafIYaUasOoWFgoL8sJWrHVCFAUFiuLLL75lQ5y88eQYhG5xrh7zxcBpMveMwfMoyBcnGWK953f9hLJBDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P4IV665e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P4IV665e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EE91F000E9;
	Mon, 17 Aug 2026 09:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786959245;
	bh=YjKOzUZS2Fs2JMvAyLTzS9gHVbbdwQGhxTTtmcpa0mM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P4IV665eGZ42umZT9SnI7GZbYeBxD+KPfWqfweAnueoMo7dv+xTjaWzXYWiGgPq9N
	 jh5BF1LBCh6h0oVl7gkAfusTGWFgrzTYYppI37cFU6iwtpG5RAcQA466/LMi5tuKEH
	 rs+PmVO9iGN8rfRuC1RAyHfT7RmXn/KjAeKagXd5MWZtxGKVG1CPzXoxp7cBIp7VjJ
	 z63d79MWcJ43V8jpiQLRlr39P4QQrjEnaW76YaR3EqTJexfvHFOjatAsFOy6WGxoie
	 w0k99JQ4sILvjLXr3h6xZaoeBmcvpbdFLyIhkOt2EGjjjgjqqqmHN8wmKIuRa9LGM3
	 gYNvB7AVEKrZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
References: <20260817092448.4395-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 09:34:04 +0000
Message-Id: <20260817093405.26EE91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but missing checks f=
or PCI device disconnect (0xFFFFFFFF) in MMIO reads cause a 128-second kern=
el thread stall.
--

--- Patch [1]: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in nvme_dis=
able_and_flr() ---
commit df33f68f6dbf217384a1bdde080cb5742ca0e99d
Author: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

PCI: quirks: Fix out-of-bounds MMIO read in nvme_disable_and_flr()

This commit fixes an out-of-bounds MMIO read in nvme_disable_and_flr() by
increasing the mapped area size to include the NVME_REG_CSTS register.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b09f27f7846fc..ed03892cc960e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4090,7 +4090,7 @@ static int nvme_disable_and_flr(struct pci_dev *dev=
, bool probe)
>  	if (probe)
>  		return 0;
> =20
> -	bar =3D pci_iomap(dev, 0, NVME_REG_CC + sizeof(cfg));
> +	bar =3D pci_iomap(dev, 0, NVME_REG_CSTS + sizeof(cfg));
>  	if (!bar)
>  		return -ENOTTY;
> =20
> 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
> 	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
>=20
> 	cfg =3D readl(bar + NVME_REG_CC);
>=20
> 	/* Disable controller if enabled */
> 	if (cfg & NVME_CC_ENABLE) {
> 		u32 cap =3D readl(bar + NVME_REG_CAP);
> 		unsigned long timeout;

[ ... ]

> 		timeout =3D ((NVME_CAP_TIMEOUT(cap) + 1) * HZ / 2) + jiffies;
>=20
> 		for (;;) {
> 			u32 status =3D readl(bar + NVME_REG_CSTS);
>=20
> 			/* Ready status becomes zero on disable complete */
> 			if (!(status & NVME_CSTS_RDY))
> 				break;
>=20
> 			msleep(100);

[Severity: High]
This is a pre-existing issue, but does this function properly handle PCI
device disconnects?

If a PCIe device drops off the bus or encounters a fatal error, MMIO reads
such as readl(bar + NVME_REG_CC) will return 0xFFFFFFFF. Because 0xFFFFFFFF
passes the cfg & NVME_CC_ENABLE check, the code will erroneously enter this
block.

It will then read 0xFFFFFFFF from NVME_REG_CAP, resulting in a maximum
timeout of 128 seconds. The loop continuously reads 0xFFFFFFFF for
NVME_REG_CSTS, which fails the NVME_CSTS_RDY check, causing the kernel
thread to sleep for 100ms in a loop for the full 128 seconds.

Could this cause system management threads like VFIO teardown or PCI hotplug
workers to stall?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817092448.4395=
-1-raizudeen.kerneldev@gmail.com?part=3D1
