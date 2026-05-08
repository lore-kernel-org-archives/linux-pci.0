Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BCD2F8E8F
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 00:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778201581; cv=none; b=KF1aO/KaYd+JdbhOecGbkwZE04xIwOf2aRNNyUT+PXjmHflciFlvk2vZDuxAB+2GjKeDrDWJ+NbfbN1/UZNLKzhtXKqkWcDRG7HJbcel07WPuJrnPbrp1oIkhpKEnANWKxccOoYyyxLgNQNmnhP1Bn7IN4bMNArnocfVNaAAeNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778201581; c=relaxed/simple;
	bh=fk41o2uxL+FlCpUXW5ppFJDQt5EmuLvsNDY4pvNHw4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bSpVMqn6sfIfieka/M2Yey+eDbp4M0pqZMfzK47+szMUCVBsaKKJwwkxyvN3wPtsL+tLF341EO+1VkHyuulcnHWitM1MB+QCO0OkzufxK1wMgKNNFQO6VgP/BLmOuCi0YKzsTcaR1+eSJINnfliU9mE1ijyuZGsvn9Zx2J6L+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCyspxa6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCyspxa6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB0FC2BCB2;
	Fri,  8 May 2026 00:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778201581;
	bh=fk41o2uxL+FlCpUXW5ppFJDQt5EmuLvsNDY4pvNHw4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=eCyspxa6nZ1b6pT01Ra0Rhgau5X3G/F6He/nuTQQ7OfIR/+v9PWSWgbuH/xB+V9+C
	 BRy0EHXr9uZQCKdwgwQpgaqRRf31GMl2Q7mhBqYSHzPUsiw1jMiHVRIXL1yhBEwKFy
	 K7zKfAzB5Ya231h0AgCeK0LmFXLOy9vSjWroB14OYCbaejvMFcTeiUWMzZ96Swv8Uu
	 gbTQ6GcmxV/Qe7Xvp7dSxT7VmIQ8LzBNdf+523m9WoqCNSIPqswckp/bsIp0Lz71cz
	 8scuZcZnguHQ+rCXhV+A1CxZcO6GYiIfeC5l3lGMAMeSTrV6kr9k3ALTi3iU0/AuGe
	 Q2vKzGGXuUrqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/9] Bluetooth: hci_qca: Rename 'power_ctrl_enabled'
 to 'bt_en_available'
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-7-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-7-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 00:53:00 +0000
Message-Id: <20260508005301.1DB0FC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The rename of 'power_ctrl_enabled' to 'bt_en_available' introduc=
es a misleading semantic mismatch and contradicts the commit message.
--

commit ebe40bb62789f8cbdbd8baa6c8be848d58c9f72b
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth: hci_qca: Rename 'power_ctrl_enabled' to 'bt_en_available'

This commit renames the power_ctrl_enabled flag to bt_en_available in
qca_serdev_probe(), with the commit message stating that the flag only
indicates the availability of the BT_EN GPIO.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
[ ... ]
> @@ -2391,7 +2391,7 @@ static int qca_serdev_probe(struct serdev_device *s=
erdev)
>  	struct hci_dev *hdev;
>  	const struct qca_device_data *data;
>  	int err;
> -	bool power_ctrl_enabled =3D true;
> +	bool bt_en_available =3D true;

Is the description in the commit message accurate?

Looking at qca_serdev_probe(), there are several paths where the BT_EN GPIO
is not present, but this flag remains true. For example, with a QCA_WCN3990
device, qcadev->bt_en can be NULL. Since it doesn't match the specific
SoC types in the checks below, bt_en_available is never set to false:

qca_serdev_probe() {
        ...
        qcadev->bt_en =3D devm_gpiod_get_optional(&serdev->dev, "enable",
                                       GPIOD_OUT_LOW);
        ...
        if (!qcadev->bt_en &&
            (data->soc_type =3D=3D QCA_WCN6750 ||
             data->soc_type =3D=3D QCA_WCN6855 ||
             data->soc_type =3D=3D QCA_WCN7850))
                bt_en_available =3D false;
        ...
}

The original power_ctrl_enabled flag tracked whether any driver-managed
power control (such as regulators or a generic power sequencer) was
available, ensuring the qca_hci_shutdown callback is registered.

Does renaming this generic power control flag to bt_en_available introduce
a mismatch where bt_en_available is true while qcadev->bt_en is NULL,
potentially confusing future modifications?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D7
