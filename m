Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD5F55198A
	for <linux-pci@vger.kernel.org>; Tue, 29 Sep 2026 15:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695263; cv=none; b=UsMkdepdpqvF5yBJ8YZFnn6YD+FttiJChDbMrI1ykA6d+GAa9LynkFX8gLi14KYl12EZOZR8l3jFlU5nBHByahgyux6ocBYXAYxwTBcIu2mfcLY8CmSniAe+9ss5LKPJ6iZFp94OARDiPP62vljmYj9Igjdh8uGd48t5MqTn2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695263; c=relaxed/simple;
	bh=FJKiZMywhJlFwPlUwx3u19M4tdkpCG4bjZ2F+qAVUNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JFaWO9E3djh97NhRH2eFQB373Rpm+BsTlDQhp87FA3q9WLhZRr7Ehn0OI+2ZZv8k1pn8Gkjng5GvW/GnZETaZeB6WVT1dnEHueFNPr4Y3HbH1VbtpotdOeP+RKTG1re8GyoByMuIRWi7qqmxirqpW8iLWNNUsZ/6yM4XHnENdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbK2iYXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbK2iYXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F7E1F00899;
	Tue, 29 Sep 2026 15:20:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695246;
	bh=lpHuRIzrYGUzaVM6GIRkYmmqyuJHVc04M1FookNMDXQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PbK2iYXxkJSypuJvi1+CKtPDpwo+gzokaUowuTP+iojzC3Y9rq2ffjbK8L4jSrqzN
	 qt0b8orqR1zQpiV7HP3uViEXVVLVNYSlxWjcr2uxItIlBk1wk59p6huUywygC+k2fg
	 KCQ/13bjv6amnHaw2nLr7tmFDvtBZf7YldMP9skzowkwHY3yr75G+TfE/Tfz8rNbHX
	 sSbzmztZPcDNwvtWl5z6F4825ylr9pDJ9BclkpHmMCTEO19p0Tcie4dfNVedU0cbst
	 LJqOHqdE/fJLuij3/YbG9WZM6ac6CMKfQ8e5n/ASI/i8372PsyjSaSpSkW6K68B+jD
	 JrktHco7JI45w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Add function 1 DMA alias quirk for Toshiba AHCI
 SSD controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Stolovitzsky" <emestee@catnarok.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260929150924.2376309-1-emestee@catnarok.net>
References: <20260929150924.2376309-1-emestee@catnarok.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 15:20:45 +0000
Message-Id: <20260929152046.05F7E1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The Toshiba AHCI SATA controller [1179:010b] (subsystem [1b4b:9183])
> used in 11-inch MacBook Air models (MacBookAir6,1 and MacBookAir7,1)
> issues DMA with the requester ID of function 1, which does not exist.
> With the Intel IOMMU enabled (intel_iommu=3Don, or
> CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy), these DMA writes are blocked, IDENTIFY
> fails and the internal disk never appears:
>=20
>   DMAR: [DMA Write NO_PASID] Request device [0000:04:00.1] fault addr 0xf=
ffe0000 [fault reason 0x02] Present bit in context entry is clear
>   ata1.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=3D0x80)
>=20
> Add the controller to the quirk_dma_func1_alias() list. With it, the
> SSD is identified and the system boots with the IOMMU enabled.
>=20
> Link: https://github.com/omacom/omarchy/issues/12097
> Link: https://github.com/omacom/omarchy/issues/13010
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Opus 5.5
> Signed-off-by: Michael Stolovitzsky <emestee@catnarok.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929150924.2376=
309-1-emestee@catnarok.net?part=3D1

