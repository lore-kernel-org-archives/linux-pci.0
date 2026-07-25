Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A6F399357;
	Sat, 25 Jul 2026 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784970748; cv=none; b=qiJQLPHR2oK7FWyN3S/NuqpTFbYuXHVtyB2o+C0T2mJOn3+WLf0XkJtCwJqVlfev0fgVMHtne3XIZaSrAgd8UOtK6PVnM1nJCPLsTXcOq4tZemAaTJxSjSaypAZnq07ciLg5p/JRL9HI9B/3lLNu+rMVcFtcVnkNeV/Xw2vByjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784970748; c=relaxed/simple;
	bh=m0+7pk4+i0sf6Z7z+ec3HyOnsz0I5LQR3WcpJPDDTBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hhwMzgJc2vmhayKKZviKj+rAiw3OITHKtjhFsO0K0bcvP9Lw5770B1YTDIijzuFB6jk96Qo5iX+N6MzqYtBbmULwidNq/ACcyA7Y66eKg8laqurf8iprS4teIcjpD/WuotI3Vrg2hpxMl3xYZv/Nuvp1DlQkJBV96zWLq+Ria2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJXzJQUH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJXzJQUH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3331F1F000E9;
	Sat, 25 Jul 2026 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784970746;
	bh=RJ0sP+1TDfVPlG380xwnI0JB6DvFeDeCIPxL51vUSCA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JJXzJQUH5bKBbMy0tOL/CKe0ZgvLWlXJolxEjOs+THCOw4hiZEikHqx0Ndcz0qTXq
	 PT/xWUoF9bErYoE6VsBtZz+JXvOwUKT3bhEfTb+IQCmjYKaSQ95hmdIJLZt4vz1g7D
	 aZif+iODK5fUORFB08L7g9/hClxlWSK84kBBuCG1nktA0DM9CEGOeGbiqV7pUStYGq
	 ax36LiCdiv0BOKisUYLMDh3qIszj0ihusON0Pgy5IMRjTNOaeEgSl4kpAIfURM4TXc
	 DMcJwFeZtC35PQED5dE2vkQOLJNXjUkDrU4CcaPB671pYT6C4JEYBpeS7Zyg/sziU9
	 0hPm6MipEHwSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE
 tuning for DSP3
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
References: <20260725-tc9563-fix-v1-0-ec4286e31331@oss.qualcomm.com>
 <20260725-tc9563-fix-v1-4-ec4286e31331@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 09:12:25 +0000
Message-Id: <20260725091226.3331F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The error path in probe and the remove function unconditionally ca=
ll `tc9563_pwrctrl_power_off()`, leading to an unbalanced regulator disable=
 and GPIO reset.
- [Medium] The patch adds a skip condition for TC9563_DSP3 to prevent drive=
r failure when tuning properties are present, but fails to handle TC9563_ET=
HERNET which suffers from the exact same vulnerability if tuning properties=
 are erroneously provided.
--

--- Patch [4]: [PATCH 4/6] PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE t=
uning for DSP3 ---
commit 1ca1e7c52e5adecc6adfed2aec9cf99588aec9d4
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

PCI/pwrctrl: tc9563: Skip Tx amplitude and DFE tuning for DSP3

This commit skips Tx amplitude and DFE tuning for DSP3 by returning 0
when these tuning properties are passed. This prevents the driver from
returning an error and failing to probe.

> diff --git a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c b/drivers/pci/pwrct=
rl/pci-pwrctrl-tc9563.c
> index ca19bf60d290d..28e9ec3e172ae 100644
> --- a/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
> +++ b/drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c
[ ... ]
> @@ -327,6 +328,9 @@ static int tc9563_pwrctrl_set_tx_amplitude(struct tc9=
563_pwrctrl *tc9563,
>  	case TC9563_DSP2:
>  		port_access =3D 0x8;
>  		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "Tx amplitude tuning not supported for DSP3\n");
> +		return 0;
>  	default:
>  		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but should TC9563_ETHERNET also be handled
to avoid returning -EINVAL here?

If the device tree mistakenly provides tuning properties for the Ethernet M=
AC
Endpoint node, the driver's power-on sequence fails entirely because
tc9563_pwrctrl_power_on() iterates up to TC9563_MAX.

The patch fixes this exact flaw for TC9563_DSP3, but does TC9563_ETHERNET
suffer from the same vulnerability if tuning properties are erroneously
provided?

>  	}
[ ... ]
> @@ -363,6 +368,9 @@ static int tc9563_pwrctrl_disable_dfe(struct tc9563_p=
wrctrl *tc9563,
>  		port_access =3D 0x8;
>  		lane_access =3D 0x1;
>  		break;
> +	case TC9563_DSP3:
> +		dev_dbg(dev, "DFE tuning not supported for DSP3\n");
> +		return 0;
>  	default:
>  		return -EINVAL;

[Severity: Medium]
This is a pre-existing issue, but does this default case also cause the dri=
ver
to fail if tuning properties are provided for TC9563_ETHERNET?

>  	}

[Severity: High]
This is a pre-existing issue, but does the error path in probe and the
remove function unconditionally call tc9563_pwrctrl_power_off(), leading to=
 an
unbalanced regulator disable?

If devm_pci_pwrctrl_device_set_ready() fails during tc9563_pwrctrl_probe(),
the driver jumps to power_off:

drivers/pci/pwrctrl/pci-pwrctrl-tc9563.c:tc9563_pwrctrl_probe() {
    ...
power_off:
    tc9563_pwrctrl_power_off(&tc9563->pwrctrl);
}

Because probe never calls regulator_bulk_enable(), does the error path disa=
ble
regulators that were never enabled by this driver?

Additionally, tc9563_pwrctrl_remove() unconditionally calls
tc9563_pwrctrl_power_off(). The PCI power control subsystem automatically
powers down devices when they are unbound, meaning remove() calls
.power_off() on an already powered-off device.

Can this unbalanced disable produce kernel warnings and mess up regulator
use counts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-tc9563-fix=
-v1-0-ec4286e31331@oss.qualcomm.com?part=3D4
