Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DC83EBF02
	for <linux-pci@vger.kernel.org>; Thu, 18 Jun 2026 11:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781780940; cv=none; b=NjD/kS0m7g3is8ArqroY58i0f3w3BtOq35XrR32NT5OUNSRmMWwMEbG8Lf2S6L4sh2nUxHW679LRuTAk7bk3dI5wS6PTalZuPMFpe5t2ZDjpWJlpzuFfjsqY4HnMdJh4L6YLr/vSj5gSZOJhCWgTWBJv0tnrnsJ0GhquzinIFE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781780940; c=relaxed/simple;
	bh=RJys3dS9AKZJF4zhHUzS0txa1hXmI9v4dxk5HgEjwMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G+nYwJ9cTSY+yJWdeAEGp+2693vkt2FFoaFYe8damxsfBn0pDLJYkQsSVyInyP7nzI/v+8sjK2rVcx14i5LdKZShOgUGpppL19lypdmWpGemPRKjIazCUO5W0CLPT5wCcM6gFoN7UhvCAvPaggpz5oizstnS2gmPbD11xf2LcCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp3rcg/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp3rcg/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503BF1F000E9;
	Thu, 18 Jun 2026 11:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781780938;
	bh=vHfQK7xWbHXSF2aqE1dFwBuSW2CBJBaIr3t3KPW37s4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mp3rcg/0FB0xIOhun7GpoMeA7GL1PNVBGT/efQBYNbwA0E9Px1YrVZ3HwPFXDp/56
	 rG1I0HS/uWzZEciJbz7xB1nXk7qWqfl467Y6PEUdE8IsFR5QX+wR5FGizJxuSfNQJ6
	 ga3P1LUNq02rxJcUj6ioZ/xJsy1EFoax3DmhRVd7t8WVU9MjX/V2MRgNtedc1ohbgA
	 YBzxunov9vLh3NZwzn+JubmyT4y7yl/TrHKfhvNG5mrrHV6ji6lNBa+7gLXOKLLKCS
	 a9YY3O56H22ln0XkbQgEzjTZVvRzSp2qTnyzpbEd7KetxkaZULgbMCdATgcFQ8k6N2
	 Dx//bbGIYd2PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Bluetooth: btintel_pcie: Fix TOCTOU race in
 reset path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chandrashekar Devegowda" <chandrashekar.devegowda@intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260618085016.9173-2-chandrashekar.devegowda@intel.com>
References: <20260618085016.9173-1-chandrashekar.devegowda@intel.com>
 <20260618085016.9173-2-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 11:08:57 +0000
Message-Id: <20260618110858.503BF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Kernel panic due to unconditionally dereferencing a NULL `hdev=
` pointer during PM resume if a prior reset failed.
- [High] Non-atomic modification of data->flags causes data race with atomi=
c bit operations, risking lost coredumps and permanent lockouts.
- [High] Unprotected assignment to dev_data->reset_type in btintel_pcie_hw_=
error can corrupt an ongoing reset.
--

commit c9025f5524eb70c6235927f87e97777af4f0b9ab
Author: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>

Bluetooth: btintel_pcie: Fix TOCTOU race in reset path

This commit fixes a Time-Of-Check to Time-Of-Use race condition in the
reset path of the btintel_pcie driver. It reorders the RECOVERY_IN_PROGRESS
atomic guard to execute before checking the SETUP_DONE flag, preventing
concurrent reset requests from racing.

> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel=
_pcie.c
> index d3a03cf964216..f4f400421833b 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -2686,11 +2686,15 @@ static void btintel_pcie_reset(struct hci_dev *hd=
ev, u8 reset_type)
> =20
>  	data =3D hci_get_drvdata(hdev);

[Severity: Critical]
This is a pre-existing issue, but can this dereference cause a kernel panic
during PM resume if a prior reset failed?

If a reset fails (e.g., in btintel_pcie_setup_hdev()), the device is
unregistered and data->hdev is left permanently set to NULL. If the system
goes into a suspend/hibernate cycle, the resume handler unconditionally
calls this reset function:

btintel_pcie_resume()
    set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
    btintel_pcie_reset(data->hdev, 0);

When btintel_pcie_reset() runs, it calls hci_get_drvdata(hdev), which blind=
ly
dereferences hdev. Should there be a NULL pointer check for hdev here?

> -	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags))
> +	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags)) {
> +		bt_dev_warn(hdev, "Reset rejected: recovery already in progress");
>  		return;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying atomic
flags operations, I noticed a potential data race with data->flags in the
worker thread:

btintel_pcie_reset_work()
    btintel_pcie_start_rx(data);
    data->flags =3D 0;
    err =3D btintel_pcie_setup_hdev(data);

Because data->flags is cleared non-atomically immediately after interrupts =
are
re-enabled, could this erase an atomic modification from an incoming MSI-X
interrupt, such as test_and_set_bit(BTINTEL_PCIE_HWEXP_INPROGRESS, &data->f=
lags)?

Would it be safer to clear the specific bits using atomic operations instea=
d?

> -	if (test_and_set_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags))
> +	if (!test_bit(BTINTEL_PCIE_SETUP_DONE, &data->flags)) {
> +		clear_bit(BTINTEL_PCIE_RECOVERY_IN_PROGRESS, &data->flags);
>  		return;
> +	}
> =20
>  	data->reset_type =3D (reset_type =3D=3D 1) ?
>  			    BTINTEL_PCIE_IOSF_PRR_PLDR : BTINTEL_PCIE_IOSF_PRR_FLR;

[Severity: High]
This is a pre-existing issue, but I have a question about how the shared
reset_type state is handled concurrently.

In the hardware error handler, dev_data->reset_type is overwritten outside
of any lock before the atomic guard in btintel_pcie_reset() is reached:

btintel_pcie_hw_error()
    if (code =3D=3D 0x13)
        dev_data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_PLDR;
    else
        dev_data->reset_type =3D BTINTEL_PCIE_IOSF_PRR_FLR;
       =20
    btintel_pcie_reset(hdev, ...);

If btintel_pcie_reset_work() is actively executing a recovery and reads
data->reset_type locklessly, could this unprotected assignment cause the
worker thread to observe an inconsistent state and corrupt the recovery
sequence?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260618085016.9173=
-1-chandrashekar.devegowda@intel.com?part=3D2
