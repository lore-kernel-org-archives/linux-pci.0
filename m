Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC637C906;
	Mon,  8 Jun 2026 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780902502; cv=none; b=A4PDSdtrRYP0jNRS9LDUq67WYlpV0oQ4EKU0fvxatN2J2PGO506gYEcmUKr+r8JsHea8nEEDJa+Z5V835hE4npfKF0RC3bu2/fV4OJHyYQoxT53/UScL3et6l7nOvwBdJvXQgjv8F2OagD/61oLdK7vLb8ck3zArRZfdY8x6B40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780902502; c=relaxed/simple;
	bh=MSp1zFVTzzyrEteGAegFOP1tnfbkgBe1/3oS6QZ68ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gqh3UzD4Cql82deybvDaZTyneCq8L0YdvEwJGZjvN+a26r4JphnPVTog0GpcN77/L9Wx51HdWUOO+uoTLWI/JWv8iikH2nqDSCHnc3CqaPCZETS5mk9PvmniM0Px+CU7H9E4JAJxcMYeZ//0xntldfR1cQhEFNLC75Es4PrzUjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVumnqtC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVumnqtC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCBF31F00893;
	Mon,  8 Jun 2026 07:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780902500;
	bh=awD455x8uXP7MLUpzp45rI5BDx4pZOgCn5eBKrrLO5s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lVumnqtCnKdebttKd4BmkKf/740e6B8KpHSWTbG2oszOk1NX/Dspa6ozIezKd+7Lw
	 MEyHXNxrSTDoZEfKLKrbqYWPRqsgnGawCdDmv9cRjsalR98vdjaYz3ILU8LkMblzIe
	 Jbc+5V3BprpnpEkTMQg01gwToUq1vDGwiZgDZ1PYz06/CPanV0UIxbWiSfVIxxdTpV
	 Q5AjqHqWOxdaKkSdYxVgG7NGetK79gMPlxvYsSmOUPB7J2AU0vdLTPHlnbFAxQ1ZrV
	 +nwkRrDLNgQKIxgkul5mZ9tBovBNrqAs/+RA1SVHq32iucStTfuA/pCdL+UQrOKa2b
	 2NcSr92Fa40RQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/7] wifi: ath11k: enable support for WCN6851
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
References: <20260608-sm8350-wifi-v2-2-efb68f1ff04c@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:08:19 +0000
Message-Id: <20260608070819.CCBF31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added WCN6855 hw1.1 support is missing a corresponding=
 MODULE_FIRMWARE() declaration in pci.c.
--

commit f54482207008ed0cfb8ad9e52b108a170f4c03af
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

wifi: ath11k: enable support for WCN6851

The WCN6851, found e.g. on SM8350 platforms, is an earlier version of
WCN6855 platform. It identifies itself as hw1.1. Copy WCN6855 hw 2.0
configuration to support hw1.1 version.

> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireles=
s/ath/ath11k/core.c
> index 8dacc878c0068..78a226ca081c7 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -393,6 +393,98 @@ static const struct ath11k_hw_params ath11k_hw_param=
s[] =3D {
>  		.cfr_num_stream_bufs =3D 0,
>  		.cfr_stream_buf_size =3D 0,
>  	},
> +	{
> +		.name =3D "wcn6855 hw1.1",
> +		.hw_rev =3D ATH11K_HW_WCN6855_HW11,
> +		.fw =3D {
> +			.dir =3D "WCN6855/hw1.1",

[Severity: Medium]
Since this adds a new firmware directory for hw1.1, should there be a
corresponding MODULE_FIRMWARE(ATH11K_FW_DIR "/WCN6855/hw1.1/*") declaration
added to drivers/net/wireless/ath/ath11k/pci.c alongside the existing
entries for hw2.0 and hw2.1?=20

Missing this might cause tools like modinfo or dracut to not recognize the
dependency, potentially leaving the firmware out of the initramfs.

> +			.board_size =3D 256 * 1024,
> +			.cal_offset =3D 128 * 1024,
> +		},

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-sm8350-wif=
i-v2-0-efb68f1ff04c@oss.qualcomm.com?part=3D2
