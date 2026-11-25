Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600006;
	b=HvdA5mmogu1WXZl48wWTN5vLNqg+9+N8Z61G5EaGF3yzKLtvPkHuM7tqgKG2BoB3DM11
	 MZmbxC9tGvQ7iTZjBQas31JN+eFCWSeJiAVfZCCIMLo+Br26Drz+DsxXR1XopiIGDBC6+
	 PpuoSR+4o64MGuAwjO7B4inedBYTnsi48NuhNa6bhM4KvfzKIGmn3slMcgVtySpR+HpwN
	 lkcIIV/dWkxyoV1Hw2gl7o/j7VbeRqjdjhytWkZX4+u9vi7b2dIsrEbK7vBGmXFblOIYx
	 T09u77IW2g/XaI5ipK+h/vEimZ0C66TYvoJO8jrCxQjDAI/2MHxbjdMAkBS0j5sR5EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600006;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/Eh8dKls9dDcjChp/2O20SX/hrmZEc3s5jBA21WJabQ=;
	b=CvStKgCvVrRSgs6VQSJtiNv71u+nFqN4AHgzoc/gIarySFXMiHj8KolKwI0ahs/EQRt+
	 fD6Hw7iOe3pr5EiauIuf0EDkrtOGvDGjRQk9RFHsjrZsSXtJzbGu0QGu8kJL45J6pgzpk
	 lNz7BL+5kctct9xxK/Zc+tsVxH4GIO2c4NtYSt11tWkmhLFMItoonhJuxCn1EqueG3nZb
	 3755jhTGn5RUwtt6oYhxfnEHLmHFEiF/QKcmGt7dbhLca+NVOMc72ouktbF/uXZC4lgng
	 AYK1JsmWgyfL8EMYD9Dn7bgdJCCmFeofDunQfskKhCS0mWD7yf7+sDw3ieLI1bV2DIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j91NdL6y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB07606A327;
	Wed, 25 Nov 2026 09:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j91NdL6y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74AE91F000C6;
	Wed, 25 Nov 2026 09:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795600005;
	bh=/Eh8dKls9dDcjChp/2O20SX/hrmZEc3s5jBA21WJabQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j91NdL6y8QKt2hpfQAJs2gzzbqZNHs8KlAnYG1OibSsu7lI/paf/Xn9OG5t061t3w
	 27ERcMVA3jONKH9RCsftl53dWHSBLdLXOVpg/gTa3uV6cRX+TzFYTx8CfF8vXROMcS
	 s2DRMQzZLE4BRligI5o8J412bG1HyD9t28zNXdAvqY7jjzQpxC+B2n7yxnJtIz0RNr
	 aguJuxaH/KtrGiCZL9DKjV9AkuqtgesNdF9PbEmwyF41LCBeFxDEc6GoutZOk3FJFQ
	 Z+NiM+D4x0smOnJP4AXxkLqW72wMmSX4ofCLhsixCUJlpRHTd/dsLPWNAj05G5spfA
	 KIPrdAM/u2vqQ==
Message-ID: <sashiko-outbox-233065@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 28/33] PCI: Use device trust for platform
 restrictions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, linux-sound@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124-device-trust-core-v4-28-037eb0d17b1f@nvidia.com>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-28-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 09:46:45 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] PCI: of_create_pci_dev() runs pci_ats_init() before
  device_trust_init()
--

commit a65ec3ba4c9db1ced18be2126bf20a6e9f67645c
Author: Leon Romanovsky <leon@kernel.org>

PCI: Use device trust for platform restrictions

This commit maps PCI topology untrusted device classification into the
device trust policy and checks pci_dev_default_is_restricted() when
configuring ATS and ACS translation blocking at discovery time.

> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 9cb23780093dd..c8c96acc26343 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -21,7 +21,7 @@ void pci_ats_init(struct pci_dev *dev)
>  {
>  	int pos;
> =20
> -	if (pci_ats_disabled())
> +	if (pci_ats_disabled() || pci_dev_default_is_restricted(dev))
>  		return;
> =20
>  	pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ATS);
> @@ -40,7 +40,7 @@ void pci_ats_init(struct pci_dev *dev)
>   */
>  bool pci_ats_supported(struct pci_dev *dev)
>  {
> -	if (!dev->ats_cap || dev->untrusted)
> +	if (!dev->ats_cap)
>  		return false;
> =20
>  	if (dev->is_virtfn)

[Severity: Medium]
Can pci_ats_init() run before device_trust_init() populates
dev->dev.trust_policy on OpenFirmware PCI enumeration paths?

On PowerPC and SPARC, of_create_pci_dev() allocates the device with
pci_alloc_dev() and calls pci_device_add() without going through
pci_setup_device().  Inside pci_device_add(), pci_init_capabilities() ->
pci_ats_init() runs before device_add() calls device_trust_init().
Because dev->dev.trust_policy is still DEVICE_TRUST_POLICY_DEFAULT when
pci_ats_init() checks pci_dev_default_is_restricted(dev), dev->ats_cap is
populated and pci_ats_supported() will return true even when the boot
trust policy restricts the device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-device-tru=
st-core-v4-0-037eb0d17b1f@nvidia.com?part=3D28
