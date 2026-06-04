Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD71F30BB
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 19:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780600327; cv=none; b=dpJpfJokE+WQAhnTtvrnuGcDC1mEBw5t/xmH7eNah2amkSq6A/HB6PkyeioLRYSH9owf4KG7e0wx9BbEbH38ojfBumDJPIzrHIz8FqBqqbVyaO5skT1xFqHUvnh5s8SNF55gONjSo99mFOdV4MddTXAabKOnI5rNOZHry2WfTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780600327; c=relaxed/simple;
	bh=CbQSSw25eXLmweuGz9KliNL75/R/JZRLAlEaPsmDjMs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d0/tzJBUvfBaBzPOxSc2idBlVOtaTIwRRXP656Z4+JwRpNkCqBuyA50Kht6meeylWAFtuO/KxQJ7h1AgnPnP6dg7kog92uxJyympnDIJMgWIwouKI9wACPGf9YZtSuWLSOxFHcZL7YuT04H9CxMrOTm0NgT4835RiDbK3JJ2dj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o1HeDLab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o1HeDLab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905A81F00893;
	Thu,  4 Jun 2026 19:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780600325;
	bh=zbflrSgw+AQjspbuHuK7YbXNGyxQ3ih9tDGR4/qlEbA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o1HeDLabyOCu3lfv+2PGXdlrrdIA7StUrVpGGqnkqJ6KUl9Kkq4J+Wj2ShXn5m0LY
	 VSwCK4OIpQZiI99iTm0ZxFqdqZ1haJezoGJwxroBqLJHXPZkZILaEhj/GYM7b04aXG
	 idSBSTHe6U9vzZPxNe17am5lr5jG00IKt/ZROtyjM5tPlqLntespyNKVLcUQbNnS4S
	 kT+4N9Su/bHEiGGKo5BhCo4//dXThQsOynHQfnznnqwDJKAeioLkGfv0a6IDG1Tmav
	 bCOMN4nm9Ji91hckSpmRAS6ghL2BsNTXkO1CYPlm7tqLLEkbGj3v5bMlsKphi7ksDb
	 RLTSrWyFrmufg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow
 Lake-HX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Alaei" <ali.alaei.tabatabaei@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
References: <20260604185953.17177-1-ali.alaei.tabatabaei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:12:05 +0000
Message-Id: <20260604191205.905A81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unchecked PCI configuration reads can cause device removal or re=
ad failures to be treated as a valid configuration (case 3), falsely contin=
uing probe.
--

commit fde973a5965da08fe76816c224c875b5ef1e4a2e
Author: Ali Alaei <ali.alaei.tabatabaei@gmail.com>

PCI: vmd: Handle BUS_RESTRICT_CFG value 3 for Arrow Lake-HX

This commit adds support for Intel Arrow Lake-HX platforms where the VMD
controller's VMCONFIG register returns 3 for the BUS_RESTRICT_CFG field,
mapping it to a bus number start of 224.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index d4ae250d4bc6d..9cf5ea2e1e20f 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -648,6 +648,7 @@ static int vmd_get_bus_number_start(struct vmd_dev *v=
md)
>  		case 1:
>  			vmd->busn_start =3D 128;
>  			break;
> +		case 3:

[Severity: Medium]
Does this change unintentionally mask device removal errors?

If the device is removed during probe, pci_read_config_word() does not
necessarily return an error code and the hardware typically returns 0xFFFF.
Because BUS_RESTRICT_CFG(0xFFFF) evaluates to 3, the driver will now treat a
read failure as a valid configuration instead of aborting the probe.

Before this patch, the value 3 hit the default case and safely returned
-ENODEV. Should there be a check to ensure the register value is not 0xFFFF
before evaluating the configuration?

>  		case 2:
>  			vmd->busn_start =3D 224;
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604185953.1717=
7-1-ali.alaei.tabatabaei@gmail.com?part=3D1
