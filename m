Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC02D37B020;
	Mon,  5 Oct 2026 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203611; cv=none; b=G4mVIVXAq7PXmhhHreriYpPuDAh2CzSu6Z5V4M2GiG+2O9s9h6RHSXM9DJ0fw+zJBRMGiyL7FmUKzppMOaBoypyUasVK+1o14/0LbBuNiPIdQ9Ulvw9e2euuksIZJn8gYRsLBFTYXOCPptyI7rTCuQi5eO3NedtfUZZJhYdnZCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203611; c=relaxed/simple;
	bh=u4HuPTg+keLpCkUYt8XtTGMZOEUdv6tFWYV3odakScY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zlw2tcm9HcFfxSmz+auCm2BUiauDKsNutJqshd0cQk9Ca+Pl78V7rsmsTU/OBm0BWiuEYEqm/Rnmn5vd9CVNnnp4Kqj9M6E2n5UC7ZY/regGxRleMySqgUckZ763HUEjDDGoomwedvwZSb20XDmBB3tn1+4G1q1OFGrsY6XgekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2uoAnsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2uoAnsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117BC1F000FF;
	Mon,  5 Oct 2026 12:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203609;
	bh=7gmJYAQc0qOXKiEua0aL6pHo9jFB2zQLsPoN+PalvAY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e2uoAnsQoJpDknBRm3FtocEl1foD8ZadmOhJyXIqMvIp8BDROwZ4DpzEUs1lsd6qX
	 KcW89+xAfW7lUGnM/uuyHjDeA6KgFrr52JJ/ZTqSQBjGaSEc8+pFCrRdslJZ/ZDob1
	 JPqmHwrhuCyc4CTSV3FDjeyOQnK6LuRv0JvzjgGjGBAuWa7GQP/VNzwlf+QnhtdXZO
	 ZTEiF+jPVE36QEw2RwSwdLbjVd95PFrpdSMb9dmkzy6TfXlMm8fnTQvFjoxTxuS1WB
	 C8/EO50rM7/7/sqD0G1EV0IkWkwwjNZjL8TL2FYwN6tkb9Ctwm71oQf/NBKm9AyIRK
	 eRkhjWVgRpyTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:33:28 +0000
Message-Id: <20261005123329.117BC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] hci_qca: QCA6390 probe fails on M.2 connectors due to overwritten =
pwrseq
- [Medium] hci_qca: missing error check for power sequencer enable in qca_p=
ower_on()
- [Medium] hci_qca: asymmetric power-off leaks bt_en GPIO assertion
--

commit d33d72433b2dc1cfeaa1bb5a87c7d716233a54a5
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq

This patch modifies the QCA HCI driver to support QCA2066 (and similar chip=
s)
on M.2 connectors. It updates the probe sequence to acquire a power sequenc=
er
for the M.2 UART connection instead of relying on a dedicated BT enable GPI=
O.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 1d27ff98034ba..b6ec1a57248e2 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			pwrseq_power_on(qcadev->bt_power.pwrseq);
>  	}

[Severity: Medium]
Does this code need to check the return value of pwrseq_power_on()?

If the power sequencer API returns an error (for example, due to a regulator
error or timeout), the result is discarded and the driver will incorrectly
assume power-on succeeded.

This causes the driver to attempt communication with an unpowered Bluetooth
controller, leading to HCI command timeouts and driver malfunction.

[ ... ]

> @@ -2426,6 +2457,10 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>  	else
>  		qcadev->btsoc_type =3D QCA_ROME;
> =20
> +	err =3D qca_serdev_get_m2_pwrseq(qcadev);
> +	if (err)
> +		return err;
> +

[Severity: High]
Does this code overwrite the M.2 power sequencer and break probe for
QCA6390 chips?

Because qca_serdev_get_m2_pwrseq() is now called unconditionally for all
chips before the switch statement, it correctly acquires the M.2 power
sequencer when present. However, the QCA_QCA6390 branch further down in
this function lacks a guard to prevent overwriting it:

	case QCA_QCA6390:
		if (dev_of_node(&serdev->dev)) {
			qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serdev->dev,
								  "bluetooth");
			if (IS_ERR(qcadev->bt_power.pwrseq))
				return PTR_ERR(qcadev->bt_power.pwrseq);
			break;
		}

If the serdev has an OF node, this overwrites the M.2 power sequencer
with a request for a 'bluetooth' power sequencer. This fails with -ENOENT
and aborts the probe.

[Severity: Medium]
Can this early acquisition cause an asymmetric power-off that leaks the bt_=
en
GPIO assertion?

For legacy/default SoC types (like QCA_ROME), the default branch of the
switch statement doesn't check if the power sequencer was already acquired:

	default:
		qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable",
					       GPIOD_OUT_LOW);

If both exist, qca_power_on() asserts the bt_en GPIO and enables the power
sequencer. However, qca_power_off() disables the power sequencer and
immediately returns:

	if (power->pwrseq) {
		pwrseq_disable(power->pwrseq);
		set_bit(QCA_BT_OFF, &qca->flags);
		return;
	}

This early return bypasses the fallback logic that de-asserts bt_en, leaving
the hardware partially enabled.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D5
