Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4986A47F3D2;
	Mon,  5 Oct 2026 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203617; cv=none; b=kbtqSJLGaeEp0LNLxU8g3Xq/BrHCGeKwuaE+NBnYXwH02c1mGZS18DlVHtm3l9NIKJVreQaaMEOL/PREXhvOWYPNrVa7O8pv/JzZpZ7kHp0xwnO0u8dxVlZjyJxpthT05E8Cf55wcVlSo2r9lOnwlvjlmFbXj8KKTDRsVwD1O8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203617; c=relaxed/simple;
	bh=sv3g1B5KofY2UxAcLPxCocr718zgmi8KJ7fOJAtVyKo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t4RHOQinfTUftRbrK1RGnazMbKyhecp32/hgsPt1sdxLwcNMdVSHiFH0znujM8slj2FwliU+NGcfNK+qmjJdEng7yIoqf4QM7bsj+0B/n0umVXpPDeVQJI+5U5wiWxoYLUvgFsEqlQY1NhvoQC1eAVSy5EM+Vqr33HplOOEblUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEWX/Rou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEWX/Rou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDAE01F000FF;
	Mon,  5 Oct 2026 12:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203616;
	bh=3GJMIDEq3GMLJxrBLmLIihKdODSmlMF1hxTGS4Eku1w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KEWX/Rou2J/awQDihfxg7t9apccZ5gccnwxFHIpW0l6tSZMFP1zFwM/rQL97QfaJQ
	 KbO2mXXbN5IfB8smFYtWyZshuEi8nhE2rkpkzqJbxtrCapZpq73vAh4gD/UuOYGWf0
	 LgHqiZCnI4FcblTJYSjwSGtePYfBqzoHKQiPw+BlJjmLFUlPtO00RDDEuG3im8O57l
	 vxE20lbCQAXFwc03qnKHQ9F/HyH1WA6rIFPeCO/GMaIwKj25IoGAVR+tdK2QIuKu0D
	 vHEU4ox3nS/bjmCWONVb23ZUwhizZQTz5WWzf8NenQtIsxwcsOd9iptT4wYj8WHwuK
	 hSIN/z6SbEBsQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/8] Bluetooth: hci_qca: Set 'bt_en_available' based
 on pwrseq power controllability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-3-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-3-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:33:35 +0000
Message-Id: <20261005123335.CDAE01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bluetooth: hci_qca: missing error check for pwrseq_enable() in pro=
be
--

commit 842e42b3b693b54c6eab8132c98045df38fc5343
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

Bluetooth: hci_qca: Set 'bt_en_available' based on pwrseq power controllabi=
lity

This commit updates the driver to query pwrseq_is_controllable() when Bluet=
ooth
power comes from a sequencer. If the power is not controllable, it clears
bt_en_available so that the non-persistent setup quirk is not set and treats
the device as always-on.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index f53f95601693d..20d8c5e890a89 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2557,7 +2557,20 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>  			return PTR_ERR(qcadev->susclk);
>  		}
>  	}
> -=09
> +
> +	if (qcadev->bt_power->pwrseq) {
> +		bt_en_available =3D pwrseq_is_controllable(qcadev->bt_power->pwrseq);
> +		if (!bt_en_available) {
> +			/* The host cannot gate the BT power individually.
> +			 * Treat it as always-on and drop the pwrseq handle.
> +			 * The descriptor itself is still released by devres,
> +			 * so dropping the handle here is not a leak.
> +			 */
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);

[Severity: High]
Does this code need to check the return value of pwrseq_power_on()?

If powering on the Bluetooth hardware fails, the driver incorrectly continu=
es
probing and returns success. This leads to silent hardware initialization
failures and downstream communication timeouts when the host attempts to
interact with the unpowered controller.

Note: The undefined function typo (pwrseq_power_on) present in this patch
is fixed in a subsequent patch in this series (commit 'Bluetooth: hci_qca:
Flatten struct qca_power into struct qca_serdev'), but the missing error
check for the corrected pwrseq_enable() call remains unfixed in the final
state of the series.

> +			qcadev->bt_power->pwrseq =3D NULL;
> +		}
> +	}
> +
>  	err =3D hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D3
