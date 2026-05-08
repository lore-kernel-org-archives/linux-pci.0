Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94AAB173
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 00:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778201092; cv=none; b=QYtPNjr6v5HWE9YZZRuInUwQ8d/b198cYEXkBjmb/srX64gvEjauQic2jh9Ajn21DpJOgTjpRNkhJqRcCgIceqLNgD1zWfFlJimNNoNO9jJrAFeQhGDz3eT2Stcp+yMBjcz4zDP6MHtdtowaNI9j4fATdA1W92jVg80QjgCA8bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778201092; c=relaxed/simple;
	bh=Kt9Q9QIejnk9XsTF4y8GWrpyaAZkPg4iKj3KFm5CGmg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MVL5cbigrJhLoZGptCztiILAr5XLLxFEoSeYLBuMzI/JVrFiIDnvxWa4jVnb0e1UkmrCR2m5FjvnF688D7D3iiBTmvsGtOBncowVJ5VVQD6HSJ1lHuI8oXMm92PvBBos1WJKJk0WMiA/jS5OY9MNlVFrtdigFin8tschKoFxj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PH3iOkWk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PH3iOkWk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FE9C2BCB2;
	Fri,  8 May 2026 00:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778201092;
	bh=Kt9Q9QIejnk9XsTF4y8GWrpyaAZkPg4iKj3KFm5CGmg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PH3iOkWkx+Ze1BZ2Rp3U6Z4R3xun41B8Wy4WIhJp2z2jrdCBowR6P9OplxZVFD/v3
	 dTmsc/aFrHoDv5ZMTgwA4RampF81d+xTaszTSTdwHZsgAD8B/OYBsD2QqdZkQ0xTX/
	 wchh6E0FFD5CL5sDqCaroesqtwp2XArTp8vEXu0BeEkxiapSiNmvgGKLQZH/3qAtiV
	 grMne7CKAcxDHQo4mF623TkIb5P1V0E2cO1fHbs69AnxaKxi7lKF/mI7WhQb/u2Yy/
	 qi/hBsm1EpRCKYI+ZKL5suTu1dTdK8yriPYrglE2xrv4o9V9miSllfRacbYV2WRjdn
	 14PD9ona/Gkhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-6-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-6-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:44:51 +0000
Message-Id: <20260508004452.10FE9C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Resource leak due to `devm_pwrseq_get` being called with the paren=
t UART controller device instead of the serdev device being probed.
--

commit f9b32f0ee9703eed7ebec9d68e29f842c80446dd
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq

This commit adds support for controlling the power supply of an M.2
Bluetooth device using the 'uart' pwrseq device. It detects if the device is
attached through the M.2 Key E connector by checking for the presence of an
OF graph link, and if so, retrieves the pwrseq device.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index cd1834246b479..c83fe72bc5499 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
[ ... ]
> @@ -2443,6 +2444,18 @@ static int qca_serdev_probe(struct serdev_device *=
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

Does tying this power sequencer resource to the parent UART controller
(&serdev->ctrl->dev) instead of the serdev device (&serdev->dev) cause a
resource leak?

Since devm_pwrseq_get() binds the resource cleanup to the lifecycle of the
device passed to it, the cleanup will not execute if qca_serdev_probe()
fails later and returns an error like -EPROBE_DEFER, or if the hci_qca driv=
er
is later unbound.

The device resource framework only cleans up resources associated with
&serdev->dev on probe failure or unbind.

This seems like it would leave an unreleased reference on the power
sequencer provider device and an unbalanced module reference, which might
accumulate on every probe deferral.

> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D6
