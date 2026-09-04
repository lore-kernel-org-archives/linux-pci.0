Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2EF4F052C;
	Fri,  4 Sep 2026 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537776; cv=none; b=H1jeyRfZvG5xRaG6J2Q2Eun0InnSYHSdmg8HP3pO18np290jeg5nAlupfQnwo8vyamEkVzDAgMGgAZ/K3A6rUQSNDiXFkt16aDIhzMwHxeew0vTAurrWKsTxzD5x3QswLyQvJPANaKvC5Q2ZRygq55OYvpjlqWZmvdNkjoojGYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537776; c=relaxed/simple;
	bh=RhacsX2K6A9EfdaFgNBGyOJAgC43Kr1l/Xk+3Oov/l4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1UiT50+Kt0t87dmbeHwHDjI8TNWXZ1Qpr/lKXrLn2JqsOeoJ9opqfeG2Z2oOaBQoB+XlU3PfQASPOQoMTDrRdHwXLndh6FGTFz/gaOiPkFuaMJamS0bx0KfAWPT5mcMBxyizwaeKe2K8mZC7QD2MWgkmhZRtnL57PBTxig4ivw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOa5GbBg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOa5GbBg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7492B1F00A3D;
	Fri,  4 Sep 2026 16:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537767;
	bh=VbZ18LaHEfwIDqA9UqMa8YGraqoyvYK+awuZncJqg5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DOa5GbBglkO90uA7biH5vDdIrby1cLej7uwkdryF4Dyyd7WvHY5KkhbS82++ho9SV
	 FHqgYppSwliE9iiJoUMRmmDXTiqpK35GAcjHK6doY7PkUQutSA3sjcJpyP9ufjV0jQ
	 JAD2OWHiO4eWTAxiRhXI/UAZzahZ1afkEozM1gGNiI9UQO8DhNoI82hfHwGuotMFPc
	 46VOY0J663DpjY+vI3ycGfsx1DAEiDCri42Ra1YG4dY+xb/imNhn9mjHV8JyTOw/JC
	 MNRxulGGyGlnqaZ3DfEQgNh0wu8AUw+FxtRMxQOQ5pRMBv0hs5tNxaAzM5luggyq+k
	 QVjC3jcarr1Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/11] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-1-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-1-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:02:47 +0000
Message-Id: <20260904160247.7492B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Brittle heuristic for M.2 power sequencer incorrectly assumes any =
OF graph on the UART controller signifies an M.2 setup, breaking probe on n=
on-M.2 boards.
--

commit af259a50ca6baccd2776acd6a7d13d750b4519f3
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

    Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq
   =20
This patch adds support for M.2 Bluetooth devices by getting the 'uart'
pwrseq device if an OF graph link is present. This pwrseq device is then us=
ed
to control the power supplies of the M.2 card.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index faa964735adb1..c8ea5507bdc2c 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c

[ ... ]

> @@ -2448,6 +2449,18 @@ static int qca_serdev_probe(struct serdev_device *=
serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> +		/*
> +		 * OF graph link is only present for BT devices attached through
> +		 * the M.2 Key E connector.
> +		 */
> +		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +			qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev,
> +								   "uart");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);

[Severity: High]
Does this unconditional error return break probe on non-M.2 boards where the
UART controller has an OF graph for other reasons?

If the UART controller has an OF graph (port or ports nodes) for something
like audio routing or debugger sideband signals, of_graph_is_present() will
return true. The driver then unconditionally attempts to acquire a "uart"
power sequencer.

On non-M.2 boards where this provider does not exist, devm_pwrseq_get() will
return -EPROBE_DEFER. Because this path returns the error immediately, it
aborts probe and skips the legacy "bluetooth" pwrseq and GPIO initializatio=
n,
causing the Bluetooth driver to fail to probe on valid, previously supported
device trees.

The serial.yaml DT binding explicitly allows UART controllers to have both a
"bluetooth" child node and port nodes, so this is a valid configuration.

(Note: A devres resource leak in this block was successfully fixed later in
the series, but this logical heuristic issue appears to remain).

> +			break;
> +		}
> +
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D1
