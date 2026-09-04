Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1A33D9DBC;
	Fri,  4 Sep 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537652; cv=none; b=N9dYrSbIHxp/WtVil5+v3qxJ0fd3X0+Lqzgoz5YPBgfgojDJHOUrpT7ko79arQcCeCHXHAZrwv12+fayc2OPlzTOgZsdvkslMyFOb9aa15yQ2SA7UjTg+ui//rsV770fLbnHpa0l4HPqrXLfHw1G5ashFRHKJVvkim8fPbWBJEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537652; c=relaxed/simple;
	bh=mrucAIWgLBFuwl+Y4tc1MSHqYNwVAFxH2dMnaz97gjM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PDK1iao8b0ouRA5DCwq2KitdvFo/a+ILvmFW6QAxpZMvoZSGtqJpIwe8zj26RILk9uLmp1rHXJX+PMhBxKp0+WE3y9a8dep1nFAh4otDxChluvBXHesQcFwmSXnWw93dcCfPQ7gg5KF6S44MumEPyns5w582wTPMtu2fEKW2Fzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qe9tAwPd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qe9tAwPd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B19601F00A3F;
	Fri,  4 Sep 2026 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788537651;
	bh=edgO/1HgqUWGWFHclQJ7wiIyLJx/rDpCcvzCerlDSvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qe9tAwPdKa8R9tGlruhVj31MoAYWgGorpI1ytBiiZfYALwuUn5x74NdJ+iNR5WlI4
	 33wlElrLPb2DnV2/1quN067RN+3AsGVgiTlg/DHP/bHhVX4z7SDwaT54nuhjrIkaI2
	 Z+LtvVmSI9RsMDCWaGJFWkabMoTHGGDDGcclhOfIuSpQ4Zy6/v2wxQx/gYxqcIV6NU
	 TbPpr9M4qzMbNTphEwFxedCFgb1sE7+pcebrnKyjKX0jcVFs3926AX+f94yJQXmqM0
	 9lGwy+M52MmlDRT+tECuTCvAlQRVEokrGutcqqp3QtVZFtdD/tMTImuRdszE/PWU1E
	 tUT8f2kxsbONA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/11] Bluetooth: hci_qca: Rename
 'power_ctrl_enabled' to 'bt_en_available'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260904-monza-wireless-v6-2-d8c5042b3efd@oss.qualcomm.com>
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com>
 <20260904-monza-wireless-v6-2-d8c5042b3efd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 16:00:50 +0000
Message-Id: <20260904160050.B19601F00A3F@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Renaming 'power_ctrl_enabled' to 'bt_en_available' introduces co=
nceptually flawed and misleading variable semantics that contradict the har=
dware configuration paths.
--

commit 17c23b3051787bb7fc513728ad005355fa649bd0
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_availabl=
e'

This commit renames the 'power_ctrl_enabled' flag to 'bt_en_available' in
an effort to clarify the availability of the BT_EN GPIO in the devicetree
and avoid naming confusion with the new pwrctrl framework.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index c8ea5507bdc2c..f7a20138cb742 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2396,7 +2396,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>  	struct hci_dev *hdev;
>  	const struct qca_device_data *data;
>  	int err;
> -	bool power_ctrl_enabled =3D true;
> +	bool bt_en_available =3D true;

[Severity: Medium]
Does renaming this variable to bt_en_available introduce a semantic
contradiction? For devices like QCA_WCN3990 that use UART power pulses
rather than a dedicated BT_EN GPIO, this variable remains true throughout
qca_serdev_probe() even when qcadev->bt_en is NULL.

[ ... ]

> @@ -2504,7 +2504,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>  		    (data->soc_type =3D=3D QCA_WCN6750 ||
>  		     data->soc_type =3D=3D QCA_WCN6855 ||
>  		     data->soc_type =3D=3D QCA_WCN7850))
> -			power_ctrl_enabled =3D false;
> +			bt_en_available =3D false;

[Severity: Medium]
For SoCs outside of this specific list (like QCA_WCN3990), bt_en_available
remains true here even if qcadev->bt_en is NULL, which contradicts the
variable's new name.

[ ... ]

> @@ -2560,7 +2560,7 @@ static int qca_serdev_probe(struct serdev_device *s=
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
By renaming the flag to bt_en_available, does this falsely imply the GPIO
is actively present?=20

The commit message states the flag is used to indicate the availability of
the BT_EN GPIO. However, the flag actually seems to track whether the driver
manages the controller's power state via any mechanism (including UART
in-band pulses or pwrseq).=20

Since this flag correctly remains true for SoCs where power control relies
on UART pulses so the shutdown callback is registered (even though
qcadev->bt_en is NULL), could this semantic mismatch lead to a NULL pointer
dereference if a future developer relies on bt_en_available being true as a
safe guarantee to dereference qcadev->bt_en?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-monza-wire=
less-v6-0-d8c5042b3efd@oss.qualcomm.com?part=3D2
