Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989672F8EBB
	for <linux-pci@vger.kernel.org>; Tue, 19 May 2026 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779190210; cv=none; b=pVtwiOS+4aUcxk7p7oHoqUZgAHercp4Gk1uerD7iJe5K+q7Fo3T2wnXWFYAQ42vLfp12NSXvG1XX46fnVxN751rUDz44LL+e1AYY82cp2okPRUNvF9zxJfwro5FZA2TVvdyYoF6DTl9LiKoxAuiCDXmprfXRNxvMcqP5IVV5Ty4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779190210; c=relaxed/simple;
	bh=3WRfoTMcNYnRYQns7IRrmMKg1AwpqTCV7QwJHTTEReo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OS/UgS32JziYOHwSaWoXcheMM4PDnhOnorqOO0+fItmOOJs3qZj1FL4fMZ4d0Vr+bhZnl5ksP/5IeIdDlKLO07qjaTRvfyHSSO2RfHqwHCkut5oC2M4j2l/Ap12nuLQT05WPKCSxN+bMd41HHWkks43Sw5ipuRfH0dSl7IsJBp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zeq6KllO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zeq6KllO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C9AC2BCB3;
	Tue, 19 May 2026 11:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779190210;
	bh=3WRfoTMcNYnRYQns7IRrmMKg1AwpqTCV7QwJHTTEReo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Zeq6KllOqsyE6iQkekGCXSMol5OO0Pco4whwJ7dvDHUHplo8VujyFnv9/8VbIx8pW
	 QghKplRWMZBaZhcOvj5z5U2mMaGRmnGSH29k7LHy2BBT6w78xaUkCa4dDOEX/FUYjl
	 Yq0/vew89xtw2YRV7MxRiviWrfnUBQMoi9bYPsufonbW/NUErFBioEXcbOZlw3Y1aH
	 OjT05yLSVNmgPkoaVUaJEe3mvDbaUtc5Ap8hJYe/7YkftqANtzqinTKapIPqU8lDBn
	 K3ww6EQkAYZ762dbEP4kGaNJMMlc4CgI74Z73XJ3Squ89aUL6FrH69t8VgbKpr8BJq
	 SPFgQ4folufvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 7/9] Bluetooth: hci_qca: Add M.2 Bluetooth device
 support using pwrseq
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260519-pwrseq-m2-bt-v3-7-b39dc2ae3966@oss.qualcomm.com>
References: <20260519-pwrseq-m2-bt-v3-7-b39dc2ae3966@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 May 2026 11:30:09 +0000
Message-Id: <20260519113010.17C9AC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Resource leak due to `devm_pwrseq_get()` being tied to the parent =
UART controller device instead of the serdev device being probed.
--

commit cdecabb47fcbe744365c9b9d2fe977b061bcd9d4
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth: hci_qca: Add M.2 Bluetooth device support using pwrseq

This commit adds support for controlling the power supply to an M.2 Bluetoo=
th
device using the uart pwrseq device. It retrieves the pwrseq device if an
OF graph link is present on the controller device.

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

Does this leak the pwrseq descriptor if the probe fails later or the driver
is unbound?

By passing &serdev->ctrl->dev to devm_pwrseq_get(), the devres cleanup
action is attached to the parent UART controller's lifecycle rather than the
Bluetooth serdev device (&serdev->dev) currently being probed.

If the driver probe fails in subsequent steps (like hci_uart_register_devic=
e),
the driver core cleans up devres allocations for &serdev->dev, but this
allocation would remain permanently attached to the still-active parent
&serdev->ctrl->dev device.

Could this cause multiple leaks and keep the provider's module reference
elevated during repeated probe deferrals or bind/unbind cycles?

> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
>  			 * Backward compatibility with old DT sources. If the

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260519-pwrseq-m2-=
bt-v3-0-b39dc2ae3966@oss.qualcomm.com?part=3D7
