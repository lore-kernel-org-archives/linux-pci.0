Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA703B19B7;
	Fri,  4 Sep 2026 16:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537622; cv=none; b=gNLshhKCHMbH3vj7f1nEv5bXjfq2DluwcgZjWIQ6eywQBDulfV2SrWo9LaA07l1puZfjjQu/M/l3Bg9mj97680NB5Q1iBp0sIn/M//wBq+aVDD8WG8oa1wQDy2TC878T72Tw2vANsva+y4HQNySlAMQJNiYicpK1oi1j8fnS1CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537622; c=relaxed/simple;
	bh=C31f+IdKCSe5OiOMovtfMz8L3UhbOp5YgNTCuEbUlYE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gdUuXIoFwJ5qkp15PlTEfdayGVIJums7wbjugeMoh6OthQo4w3EkCIxSjYOqCL6pIxD8/CStNpwBVOU3jl9Yv8iQvm58f+gkwPYwSthOVpEZgXtu89lswmr+3rHCwIZ3SyNPMhAtWaeWXaY7XPMb1JUjG/LZfqFbJqpAG2ltCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDxByVp1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDxByVp1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D221F00A3E;
	Fri,  4 Sep 2026 16:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537620;
	bh=2gEcomDI9zcmWimU/TXsxfeHau2uhxfowYW9nOtMnXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDxByVp1VQPnRP02AOEZlDBMSU59Nm4cDzF7MubDBQyIBWKOlEyE8zNuwXvKgCLKI
	 9C2v+C34a83POys5ZG2ii864Qt41xnUu/VOVB0GoQMePEQpKQFZK4uG3kApH+bWYXS
	 RlYDUAwAKxa0WSiwDG1xTDz1I1B6qOhpQrCfOdsEcE28K74ygUObXzJK4sXhbt6A4W
	 r8+Fqj+jLUErolEmveqX9ZAgbM2sPjq+qTzNEQ4bxj/m617stleIGXzLBhq0Xzzk7T
	 lgRRnHE7usHP8e2Q7AAjuk5Lko21KzQ/WMiLixqP/EjquVhds3HJGJxRDXDVGCvhwQ
	 X69meAlCHfCRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260904-monza-wireless-v6-8-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-8-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:00:19 +0000
Message-Id: <20260904160019.C4D221F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Early return in `qca_power_off()` skips GPIO de-assertion for de=
fault branch devices with a power sequencer.
--

commit 6c86f185e6dc88f0462c04e46b64a4f809caeae3
Author: Loic Poulain <loic.poulain@oss.qualcomm.com>

Bluetooth: hci_qca: Support QCA2066 on M.2 connector via pwrseq
   =20
For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
rather than a dedicated BT enable GPIO.
   =20
When the serdev controller has an OF graph (indicating it is connected to
an M.2 connector), acquire the uart pwrseq target from the connector's
power sequencer and use it to control BT power instead of the bt-enable
GPIO. This is factored out into qca_serdev_get_m2_pwrseq().

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 30586120c4a73..db0a968dfb00f 100644
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
> =20
>  	clear_bit(QCA_BT_OFF, &qca->flags);

[Severity: Medium]
For devices in the default switch case, if the device tree contains both an
enable GPIO and an M.2 power sequencer, qca_serdev_probe() will acquire bot=
h.
This block asserts the enable GPIO and then turns on the power sequencer.

However, in qca_power_off(), the presence of a power sequencer causes an ea=
rly
return:

drivers/bluetooth/hci_qca.c:qca_power_off() {
    ...
	if (power->pwrseq) {
		pwrseq_disable(power->pwrseq);
		set_bit(QCA_BT_OFF, &qca->flags);
		return;
	}

	switch (soc_type) {
    ...
	default:
		gpiod_set_value_cansleep(qcadev->bt_en, 0);
	}
    ...
}

Will this early return cause the enable GPIO to be left asserted indefinite=
ly
upon power off for these devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D8
