Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49EC647F2E7;
	Mon,  5 Oct 2026 12:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203310; cv=none; b=TZ2tUVaJufO3qzBsW08ME+EQWfYAgdNnDrIUoxQiF38VZ9KXLmqxTmhIyokgqc8LR0pAfPbKiwPbXh56+vkJmrm+Pks3e3z0ojunPj98jj+r+Wy3y+R9C3O62++c9T0iPOBzTxptUKR1zBtD4gBa/XI3sdn/yYCottRXY0OGM0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203310; c=relaxed/simple;
	bh=6zQuuMhcb39BM2KOghBjKkrglohlPjkgorhf2dTMSz0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qo5Vs29hsNccbwkT2/GZKiatkHhZM9huYppv4WpK5zRHZHWdoqoG1NaukhPmP3InSBFUVty40PtZdTXyzPTvu6FzccxPwNHR27dWVjV2b5NKHYzv4MbcVkecn9QB1NaoxgUPyETJ9fZTREM9Ji/DsbA9Gccbmcv5c+iK9jNnimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNlzTdLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNlzTdLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89CD1F000FF;
	Mon,  5 Oct 2026 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203309;
	bh=H51O/q2/1qkx7BA3c8wTyBDgC3WhYEKTO8vni0OYrTo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SNlzTdLuA202VIzs9JSPQyz0B8prnIiDRXR/jNi/p1GvaW5FRtxfPxhVB7TDfyJ8L
	 CYPznGZ5OjWizX5D3DctmO+KfIWeOBpoiR6MiN51+a2KQej6iLMqG30D8VKMP+xtUX
	 0v2wg8oXMGOsfrxNINn5XIHmr8uYBx+wOn+BtazNLEQY4gLXkUv8IHAu5e/HjaFv58
	 ItzRV/6ATOmkaoq4j8oJmYkHkOIS8ar/WpiwuvaGzzKwF341wsT8+uo+T1wfG9VHQW
	 puZO+P8rOWXMeweKYvwW0fsYr8oGypE+OlK3MdO5QiF9W0rqjNrZOr9zLKKXDwNrYj
	 hn7Wjey5SPXOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/8] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20261005-monza-wireless-v7-2-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-2-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:28:28 +0000
Message-Id: <20261005122828.A89CD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bluetooth: semantic mismatch in renaming power_ctrl_enabled to b=
t_en_available
--

commit a629aed3c3c3f22e42d5d786579731613da2a200
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

The commit renames the 'power_ctrl_enabled' flag to 'bt_en_available' to av=
oid
confusion with the new pwrctrl framework. It claims the flag is used to
indicate the availability of the BT_EN GPIO in devicetree.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e249fc6e44479..f53f95601693d 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2402,7 +2402,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>  	struct hci_dev *hdev;
>  	const struct qca_device_data *data;
>  	int err;
> -	bool power_ctrl_enabled =3D true;
> +	bool bt_en_available =3D true;

[Severity: Medium]
Does initializing this to true imply that BT_EN is available by default, ev=
en
when it is not?

[ ... ]

> @@ -2510,7 +2510,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>  		    (data->soc_type =3D=3D QCA_WCN6750 ||
>  		     data->soc_type =3D=3D QCA_WCN6855 ||
>  		     data->soc_type =3D=3D QCA_WCN7850))
> -			power_ctrl_enabled =3D false;
> +			bt_en_available =3D false;

[Severity: Medium]
For SoCs like QCA_WCN3990, if the BT_EN GPIO is missing but regulators exis=
t,
this variable remains true because the logic to clear it is strictly limited
to WCN6750/WCN6855/WCN7850.

Does this create a semantic mismatch where the variable name suggests BT_EN=
 is
available, but it is actually tracking whether any form of power control is
active?

[ ... ]

> @@ -2566,7 +2566,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
> =20
>  	hdev =3D qcadev->serdev_hu.hdev;
> =20
> -	if (power_ctrl_enabled) {
> +	if (bt_en_available) {
>  		hci_set_quirk(hdev, HCI_QUIRK_NON_PERSISTENT_SETUP);
>  		hdev->shutdown =3D qca_hci_shutdown;
>  	}

[Severity: Medium]
The qca_hci_shutdown hook is assigned based on this flag to ensure power
control teardown.

Since this flag must remain true for devices like QCA_WCN3990 to execute the
shutdown hook to disable their regulators (even if they lack a BT_EN GPIO),
was the original 'power_ctrl_enabled' name actually more accurate?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D2
