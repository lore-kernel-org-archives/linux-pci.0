Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA93890F1
	for <linux-pci@vger.kernel.org>; Mon, 18 May 2026 17:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779126948; cv=none; b=GhuKuyocVDLlegFol/gU6ASoP+wX2wPQqOMx2PebpAPAjmMPyxNPSFWMqPRYh75sO7YabzFb3orUG9o+zvCXksWZJN0FJSh8yZ80EuDkXX6OseQ6sLomFQ+sVsZ4Tva5NO77KC1T2oKrLTjMj3/AjgdxaDwQlqCBiS7M448WpsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779126948; c=relaxed/simple;
	bh=3US0YCoQasumLMHZyrV1mk4zK84S38woyBwYT+8FoMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glKELyVivRAhtIZ9cK7Ncl2Yv9qKSRfkB5Nmy65/ftZv4a5Tpi2rve3Jf3VvVr3AOYJEHcT/IAHBRGPWgi3IyAdAPgYR27R68T4WVS5+bmPOuUnwv5ax2r3WOfxAJCYogHOYuRUYoPRqUfPm2vY3HIeQFjQfvViAckMYMpu10dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ieu3LmBh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ieu3LmBh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E3DC2BCB7;
	Mon, 18 May 2026 17:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779126948;
	bh=3US0YCoQasumLMHZyrV1mk4zK84S38woyBwYT+8FoMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Ieu3LmBhynHV9Rasp1kLF01G91Gns8mflcUJsaCMQQQpGpUH3eYDTmr/ErduUDrNU
	 NcfGT3Ar8ZVJc6uB05nTzyWylGhbmkJje+kj6e0qPtyOQQfbbo3oQb++5fjKiRCkw0
	 gLwKJYmmbpbU6iQcNlz2JH1EyXJcIHkiTYl4Zqs3pWzCI4lOfWR11tWYjeSKIKk3e1
	 8zO2lWhc7YpEj4VddtFS4U0gY2Ci7AboMvqJziqsEEQ94o4cwD9x1gf0xvR5l0dvoT
	 ucKJxL0WDjbel78GSNx7H2celX+eQB6xFIg6JRNcirpwzKxQOGGGpjfbyf7qNDiCP/
	 WalUZeNJfpVsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/5] misc: pci_endpoint_test: Add AER error handlers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam via B4 Relay" <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260518-pci-port-reset-v8-5-eb5a7d331dfc@oss.qualcomm.com>
References: <20260518-pci-port-reset-v8-5-eb5a7d331dfc@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 May 2026 17:55:47 +0000
Message-Id: <20260518175548.27E3DC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition in probe: pci_save_state() is called after misc_reg=
ister()
--

commit 1e7c4e54131311f06f05246675701727353fa564
Author: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

misc: pci_endpoint_test: Add AER error handlers

This commit adds AER error handlers to the PCI endpoint test driver.
It saves the PCI configuration state during probe and restores it
during a slot reset to ensure AER recovery succeeds.

> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint=
_test.c
> index dbd017cabbb92..3e89bd48c196b 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -1327,6 +1327,8 @@ static int pci_endpoint_test_probe(struct pci_dev *=
pdev,
>  		goto err_kfree_name;
>  	}
> =20
> +	pci_save_state(pdev);
> +

Could this introduce a race condition with userspace?

Since misc_register() was just called above, the device node is already
accessible to userspace. If a userspace program immediately opens the device
and issues an ioctl like PCITEST_SET_IRQTYPE, it will trigger
pci_alloc_irq_vectors().

This could alter the PCI configuration space (such as modifying the PCI_COM=
MAND
register to set up MSI/MSI-X) before pci_save_state() executes.

If this happens, pci_save_state() would capture the modified state as the
baseline. During an AER recovery, pci_restore_state() would then restore
this modified state instead of the pristine hardware configuration.

Should pci_save_state() be called before misc_register() to ensure the base
configuration is correctly snapshotted?

>  	return 0;
> =20
>  err_kfree_name:
> @@ -1448,12 +1450,33 @@ static const struct pci_device_id pci_endpoint_te=
st_tbl[] =3D {

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260518-pci-port-r=
eset-v8-0-eb5a7d331dfc@oss.qualcomm.com?part=3D5
