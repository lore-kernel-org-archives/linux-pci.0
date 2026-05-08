Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780A52F8E8E
	for <linux-pci@vger.kernel.org>; Fri,  8 May 2026 02:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778205997; cv=none; b=crPUaNf6OCCjjAAD2+l3bHSmcFSCdLd7E+QqvldzxVbqMkgFxS3E+xJK/7tmbF/fNKzQ1MrmPRyflfc9io+Y/977VZvBvYupUYt9AcpwTVM91SyhPuuuQkR8AFhfLXRzh/poTZq/Ajuot2D35QapMlQoFbi4t5JfPrWrwF5ja2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778205997; c=relaxed/simple;
	bh=CCiIeLuMWYgqcCKibfBJfIG1qCgqGcDtRaEsURWCeIc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GZoSkfWztuGijaiKxI8HCGJfu1IL2mfDbcdlXRzz4wFXAaiSm7oefP2jorEsd+CmAjQPV7hQmB+CU2X0sq2764+ZhdjOPBc4plg/xuIcGI6YzJjleUGz1DMFs87E9Y3SR1ZKYPzofwrr9OsMOVYQJKmPOQBxudraCF+Prh8T2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rE9ruymf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rE9ruymf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0512C2BCB2;
	Fri,  8 May 2026 02:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778205997;
	bh=CCiIeLuMWYgqcCKibfBJfIG1qCgqGcDtRaEsURWCeIc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=rE9ruymfW348psVG6X69CWVz0kj0Zlr/bNStaWYmKLzvnihAbLcsH6Ph7ah+CDDTv
	 HK3GqeG5bXQJR9LT8wOG+hR1hXDaEzxpm+hBSHVSXyMuSYH2FxYVX9xQL/LfNIxSNy
	 Ow8CLL6YySEpWZEYcxWXrCREtO8KT0NFohwgZ0jOOBy8ynzpatA1cq6IyZMmXaNicl
	 lZKf20epMFArTG+PKKoD7ShLhwwYmDx7PV8mYvhaoSaJT236zGDv4bTT6Fag4BY1vo
	 Vb+vDI8XpRTZEvpBUTX2HoE6Alj4A/+lHwUbs6008/UI3T8bqUViveUbB3HM2AbSZq
	 mB2EhzXNyD3kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_qca: Set 'bt_en_available' based
 on W_DISABLE2# presence in M.2 connector
Reply-To: sashiko@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260507-pwrseq-m2-bt-v2-9-1740bd478539@oss.qualcomm.com>
References: <20260507-pwrseq-m2-bt-v2-9-1740bd478539@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 May 2026 02:06:36 +0000
Message-Id: <20260508020636.F0512C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Architecture/Layering Violation: Bluetooth driver inspects inter=
nal DT properties of the power sequencer provider.
--

commit 30256477703156517ef407c26086261c2d43650f
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Bluetooth: hci_qca: Set 'bt_en_available' based on W_DISABLE2# presence in =
M.2 connector

This commit checks if the M.2 connector supports the W_DISABLE2# property
by querying the power sequencer provider's device node. If unavailable, it
sets the 'bt_en_available' flag to false, which is used to set the
HCI_QUIRK_NON_PERSISTENT_SETUP quirk.

> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
[ ... ]
> @@ -2449,10 +2449,17 @@ static int qca_serdev_probe(struct serdev_device =
*serdev)
>  		 * the M.2 Key E connector.
>  		 */
>  		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> +			struct device *dev;
> +
>  			qcadev->bt_power->pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev,
>  								   "uart");
>  			if (IS_ERR(qcadev->bt_power->pwrseq))
>  				return PTR_ERR(qcadev->bt_power->pwrseq);
> +
> +			dev =3D pwrseq_to_device(qcadev->bt_power->pwrseq);
> +			if (!device_property_present(dev, "w-disable2-gpios"))
> +				bt_en_available =3D false;

Does inspecting the internal properties of the power sequencer provider
break the pwrseq abstraction model?

By extracting the provider's device with pwrseq_to_device() and directly
querying the "w-disable2-gpios" property, the consumer (Bluetooth driver)
becomes tightly coupled to the internal hardware details of the power
sequencer.

Could this cause silent failures on platforms using ACPI, or if a different
power sequencer is used that handles resets without the "w-disable2-gpios"
property?

Would it be more robust if the pwrseq framework exposed a generic capability
query API rather than forcing consumers to parse the provider's device
properties?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507-pwrseq-m2-=
bt-v2-0-1740bd478539@oss.qualcomm.com?part=3D9
