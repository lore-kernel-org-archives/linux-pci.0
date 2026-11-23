Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430267;
	b=fYZK+U133JMJUEHCE5oKyBYgury/KOO9DHCmTwsTIF052IKKZmxmkiuM0YYs9zwvxZYt
	 k1Unqj+H+Lo6pi//Z26kDHIdrk8PXaPt4h4yH8RuSz/k2LMOesRXcA7YEIWNoHCAuMax+
	 neSw/GP0AZAhCd7vX/ZeBrfP74Yhh8lTOjMn2kRgmmh+ff10agCLRCSYKSGeOelHXz1wM
	 NO0jWP3jyqlwgCb2LoK719N8kMn7tR6XCWzBLrCIvUEzcQEhfznykIQOtYQ1cCXgxsuMG
	 VaVTeD1dSsAMbm69OkAWP0crz3nvEX2/eWi0P1WgsEwLUo9TSpl7zRnMwv+KGZfgvRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430267;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=X0P6T5TIyeZHejLWQgv4Ks9BJmqVUBnGiJMfvXesVpE=;
	b=ywBy4bvEKZ3hQu53nDop5Cjw0XP229TfgeX+lI0nrZFr8LDyfoOHqj3vL14w5PKdecaw
	 2Dk22kGs5VnD+keVLUttL1YyE+ZukV1nMmG/fW5Gw4IKS93/ZPchBeKSANbjbHHIrlnkF
	 J/DJDPvfMxtw7wU47VqhDaeVwV8ZwS+YCrxGAygXNZBspqkRYvzim3ReBMK+BbR6NyJrU
	 qLHrAUez6+IALQwARY9wjENtM/3Pf6/tft84gjEyj1yFoiVTCJ1kcsMhtLzk6J9NkttxO
	 Ws2g/BgBPT9gl7LcAvQNNHD/yaJim4ij7FU090DjL4v+HjlNkfbOIZwLNVGoYfi/CQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfIbnBam;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F283C606A32A;
	Mon, 23 Nov 2026 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GfIbnBam
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824951F000D1;
	Mon, 23 Nov 2026 10:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795430266;
	bh=X0P6T5TIyeZHejLWQgv4Ks9BJmqVUBnGiJMfvXesVpE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfIbnBamiMU9Mqfr4xnzJ+DIxdGX8VN3SJx5xURfj+N1LSyxe3EO15kOfvfT7Q5HA
	 ehgMLXQ0qYgPthiwkM0HdQXI6yvAOMvlb5Q7mN/sPc3/l4tmgXaSXmmSytuNQZVWf2
	 WVg2c+r97ROZt+inJoGFUCENyfmNUJ2XB2dmcP22ljHOFE+7HWupnp1VSFTtmb8xyq
	 UOXt0XwPtyPYOvdOPoP8tkArG85kWFmBi4vIkSTDzasmKl+/uHPNh/RD0vuXlrXTC/
	 whDgQSfLzy9fd+AgYhN9VGrPIOl6/tLi5pLiAlg87uV4cZX1JssOB1Vr0a7ngkerZu
	 Ceixe0FOZFj8A==
Message-ID: <sashiko-outbox-229057@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261123-monza-wireless-v8-5-a8b38604be6c@oss.qualcomm.com>
References: <20261123-monza-wireless-v8-0-a8b38604be6c@oss.qualcomm.com>
 <20261123-monza-wireless-v8-5-a8b38604be6c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:37:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] Bluetooth: hci_qca: unguarded QCA6390 and default cases in
  qca_serdev_probe()
- [Medium] Bluetooth: hci_qca: stale QCA2066 default-branch logic in
  qca_power_on()
- [Medium] Bluetooth: hci_qca: asymmetric bt_en GPIO handling in
  qca_power_off()
--

commit 85edd5303f1b81a5f668119805aeb29135fdf56f
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq

This commit moves the M.2 pwrseq lookup in qca_serdev_probe() ahead of the
SoC type switch and enables pwrseq in the default branch of qca_power_on().

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 08efce663eea4..f8b572a5c3d2d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1907,6 +1907,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			ret =3D pwrseq_enable(qcadev->bt_power.pwrseq);
>  	}
> =20
>  	clear_bit(QCA_BT_OFF, &qca->flags);

[Severity: Medium]
Does QCA_QCA2066 ever reach the default branch of qca_power_on()?

Commit a57a255ce204 ("Bluetooth: hci_qca: Reopen the UART after enabling
QCA2066") already added QCA_QCA2066 to the switch cases in qca_power_on()
(calling qca_regulator_init()) and qca_serdev_probe(), and the earlier patch
in this series, commit "Bluetooth: hci_qca: Add M.2 Bluetooth device support
using pwrseq", already factored out qca_serdev_get_m2_pwrseq(). As a result,
this branch is only reached by QCA_ROME devices, where calling
pwrseq_enable() directly bypasses the UART close/reopen performed by
qca_regulator_init().

[Severity: Medium]
Can qca_power_off() leave qcadev->bt_en asserted when a default-branch SoC
has both bt_en and pwrseq?

The default branch of qca_serdev_probe() still acquires qcadev->bt_en even
when qcadev->bt_power.pwrseq is populated, and qca_power_on() asserts
qcadev->bt_en before calling pwrseq_enable(). However, qca_power_off()
returns early after disabling pwrseq without driving qcadev->bt_en low:

drivers/bluetooth/hci_qca.c:qca_power_off() {
    ...
	if (power->pwrseq) {
		pwrseq_disable(power->pwrseq);
		set_bit(QCA_BT_OFF, &qca->flags);
		return;
        }
    ...
	default:
		gpiod_set_value_cansleep(qcadev->bt_en, 0);
	}
}

[ ... ]

> @@ -2501,6 +2507,10 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>  	else
>  		qcadev->btsoc_type =3D QCA_ROME;
> =20
> +	err =3D qca_serdev_get_m2_pwrseq(qcadev);
> +	if (err)
> +		return err;
> +
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
> @@ -2511,13 +2521,9 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>  	case QCA_QCA2066:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> -		if (qca_serdev_is_m2(serdev)) {
> -			err =3D qca_serdev_get_m2_pwrseq(qcadev);
> -			if (err)
> -				return err;
> -
> +		/* M.2 connector modules are powered by the pwrseq acquired above. */
> +		if (qcadev->bt_power.pwrseq)
>  			break;
> -		}
> =20
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*

[Severity: High]
Does hoisting qca_serdev_get_m2_pwrseq() before the switch break M.2 probe
for QCA_QCA6390 and fail to skip legacy resource acquisition in the default
case?

Only the QCA_WCN3950..QCA_WCN7850 switch arm checks qcadev->bt_power.pwrseq
and breaks out:

drivers/bluetooth/hci_qca.c:qca_serdev_probe() {
    ...
	case QCA_QCA6390:
		if (dev_of_node(&serdev->dev)) {
			qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serdev->dev,
								  "bluetooth");
			if (IS_ERR(qcadev->bt_power.pwrseq))
				return PTR_ERR(qcadev->bt_power.pwrseq);
			break;
		}
		fallthrough;

	default:
		qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable",
					       GPIOD_OUT_LOW);
    ...
}

For QCA_QCA6390 on an M.2 connector with an OF node, case QCA_QCA6390
overwrites the M.2 "uart" pwrseq handle acquired from &serdev->ctrl->dev
with devm_pwrseq_get(&serdev->dev, "bluetooth") and aborts probe when the
child node has no "bluetooth" target. For QCA_ROME (default), probe still
acquires the legacy enable GPIO and susclk instead of breaking out when
qcadev->bt_power.pwrseq is already set.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-monza-wire=
less-v8-0-a8b38604be6c@oss.qualcomm.com?part=3D5
