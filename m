Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEC533F58A
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 20:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778789186; cv=none; b=St+MBXvOOm8N/IhYPYrYEd86vggrp71mv3pxK9vk0u1Ao9cur7elyd3p90Od3k0pY3T0Hm224nAQJuVD7uS9dAR2WP2CB7tafTKfK7dwpuepKwfUqoCe99+KxJRR7sTnui64kiUzElypIZ6/gVzilSJ6f6Ppe/k+JExgPUuoHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778789186; c=relaxed/simple;
	bh=vGa4NFIbtwzZt6a9hhjxi0ibpEfeRiO1662hY6VTH0o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=avQi2TjYMglLg8j/Dc2cYBZWqwQZIc7/YPhi+N+8w4xeDYuVLg4Q9BRTtW5ZrqGgTEIKZgw1TFB4HDTJYsoBabplaIJlrqP4npWGpo4yItwMXO+fs1XKCmVCZNtNi5a5jNRWipyZbLbDcFNZ+2WyrOHdK7gw5Vu7F2PsoXBae7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNMkzR/H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNMkzR/H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6877C2BCB3;
	Thu, 14 May 2026 20:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778789185;
	bh=vGa4NFIbtwzZt6a9hhjxi0ibpEfeRiO1662hY6VTH0o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=qNMkzR/HzQ4UDbX8SrX+09UkwEZiCjq4qMStBMpKrFXbwbUd9Uh56MMCUR+qg2P7M
	 KjuaXpyzdngDVMb4GtfEHUkykTrJm9tsENwIGarsMGTgM2Wt/3aPTdPYyTQwzKXYCq
	 YvahE7r3gaSrkCkMjAZO3TsUXnxF2yChV+aEQpJvUlQXBWZ7EOkyf1TiB5jZPJMpCG
	 +OOVB7poqwkCvmfEiWwTPX2j27qSMvm4TYxYbcBIgDJdCWXzTcOsidgBt3cpMgCh1d
	 UCwUJGNaldUdt+bOPZ/fVIEcaUHiXKVfxqNIOStNWfxHMPxpbcledc4F1IyD+Q6330
	 BQVA70CKh8IUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: Wait for device readiness after D3hot ->
 D0uninitialized transition
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bjorn Helgaas" <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260514153124.404060-1-bhelgaas@google.com>
References: <20260514153124.404060-1-bhelgaas@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 20:06:25 +0000
Message-Id: <20260514200625.C6877C2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Ignored return value of `pci_dev_wait()` masks hardware readiness =
timeouts
--

commit 606c3a6294de4df52ee7dc27a7792cef6c8f72c4
Author: Bjorn Helgaas <helgaas@kernel.org>

PCI: Wait for device readiness after D3hot -> D0uninitialized transition

This commit adds a call to pci_dev_wait() after transitioning a device from
D3hot to D0uninitialized. This ensures the device is ready to accept config
accesses, especially for devices with No_Soft_Reset =3D=3D 0.

> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 8f7cfcc000901..9d0fc9fbb76a0 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
[ ... ]
> @@ -1341,10 +1351,14 @@ int pci_power_up(struct pci_dev *dev)
>  	pci_write_config_word(dev, dev->pm_cap + PCI_PM_CTRL, 0);
> =20
>  	/* Mandatory transition delays; see PCI PM 1.2. */
> -	if (state =3D=3D PCI_D3hot)
> +	if (state =3D=3D PCI_D3hot) {
>  		pci_dev_d3_sleep(dev);
> -	else if (state =3D=3D PCI_D2)
> +		if (!(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
> +			pci_dev_wait(dev, "power up D3hot->D0uninitialized",
> +				     PCIE_RESET_READY_POLL_MS);

Is it safe to ignore the return value of pci_dev_wait() here?

If the device times out or disconnects, pci_dev_wait() returns -ENOTTY. By
ignoring this error, pci_power_up() continues, unconditionally sets
dev->current_state =3D PCI_D0, and can return success (1 for need_restore).

If pci_power_up() returns success, will callers like pci_back_from_sleep()
execute pci_restore_state() against an unresponsive device, which could
potentially trigger PCIe Master Aborts, AER events, or system crashes?

Should pci_power_up() propagate the error from pci_dev_wait() to prevent
this?

> +	} else if (state =3D=3D PCI_D2) {
>  		udelay(PCI_PM_D2_DELAY);
> +	}
> =20
>  end:
>  	dev->current_state =3D PCI_D0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514153124.4040=
60-1-bhelgaas@google.com?part=3D1
