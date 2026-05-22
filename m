Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606DE360ED6
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 07:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779434942; cv=none; b=kGYj78qrVddS6NFmwfO/FUzBk104foSB1HxJMBzT40XI0MqPC+kFMXrLGU9FjtUZTOMBXEPru/726m+SAKz/wSneT3InD3GcvAcKiAu0ceTVYQZTPBQDs6OK9d+R016R72Eaiagk5TcuUiy2eqF91ipzw+kLQd2vuSCViE0GJJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779434942; c=relaxed/simple;
	bh=vGbCR4uUEfeTRtY6yEMryKtE4OsC75Y6iyYXfIx3NOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o9wGMbNLEH1Bcs9IGDagy78a3UB3ayBz09BfOuk14gkH6CNDaBFS9PvrtdEIzTZq0Rr4BvnGOQnMF0tC/e8S2WmkZ9yTTLnO9Vb2CSFyOvpT0+aJg84pZoTOfmfX5x649+O7C735rn0BMgxw+L8ue5dpZQDOuK0NJEKtHXUp7Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyOvlOYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyOvlOYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286DB1F000E9;
	Fri, 22 May 2026 07:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779434941;
	bh=Q3H301ej4xUQC/FKcHnAu5siK/m8sSm8X7H0SaXwSpM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DyOvlOYSSywCv1I/F5SEkCue9ATtETZb/UPCrbVn+AVvnWJ+8+tL75DGkQTEI2oET
	 u8rsuwiSxKxMnYWECKRi7+RAN6k6PFHSSLX1kwsmnSM4g33JCHyw/ydY3QeEgz4vIB
	 16k5pdMIsshMbWo0+Mjz8XKhY2ddmvUyCSw5n5IbyGRto/wuZBT5eMHnAv1j4vJ6IA
	 tA90WUbg8xB4RPJnigWV0w4TH8Z8V0iGpUSqmc/YC+6qoXkUbIhDHIhYfC0Cpz4nKG
	 BAMrUV0MYUk0WPO1o1jNkZ+sVaYOkRg4dj0gTAQwBWbIbqG9q6Ynbk9sVqttbE9vww
	 OtOYX0PFFfhXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: Disable broken FLR on MediaTek MT7925
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jose Ignacio Tornos Martinez" <jtornosm@redhat.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260522070646.203115-1-jtornosm@redhat.com>
References: <20260522070646.203115-1-jtornosm@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 07:29:00 +0000
Message-Id: <20260522072901.286DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The FLR disable quirk for the MediaTek MT7925 is incomplete as it =
misses the alternative PCI device ID 0x0717.
--

commit 05ad422b1a9dbfc144c4f93e78328e8fa0ea98dc
Author: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

PCI: Disable broken FLR on MediaTek MT7925

This commit disables Function Level Reset (FLR) for the MediaTek MT7925
device by adding a quirk for device ID 0x7925. This prevents the device
from becoming unrecoverable after an unclean VM shutdown in VFIO passthrough
scenarios.

> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index caaed1a01dc02..e49136ac5dbfb 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5605,6 +5605,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443,=
 quirk_intel_qat_vf_cap);
>   * Intel 82579LM Gigabit Ethernet Controller 0x1502
>   * Intel 82579V Gigabit Ethernet Controller 0x1503
>   * Mediatek MT7922 802.11ax PCI Express Wireless Network Adapter
> + * Mediatek MT7925 802.11be PCI Express Wireless Network Adapter
>   */
>  static void quirk_no_flr(struct pci_dev *dev)
>  {

[ ... ]

> @@ -5619,6 +5620,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x17f0, =
quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1502, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x1503, quirk_no_flr);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x0616, quirk_no_flr);
> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_MEDIATEK, 0x7925, quirk_no_flr);

[Severity: High]
This isn't a bug introduced by this patch, but the FLR disable quirk for the
MT7925 appears to be missing an alternative device ID.

Looking at the MT7925 PCI driver, it explicitly binds to two device IDs:

drivers/net/wireless/mediatek/mt76/mt7925/pci.c:mt7925_pci_device_table[] =
=3D {
        { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7925),
                .driver_data =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
        { PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x0717),
                .driver_data =3D (kernel_ulong_t)MT7925_FIRMWARE_WM },
        { },
};

Since both IDs represent the same hardware family and share the same firmwa=
re,
could device ID 0x0717 exhibit the exact same broken FLR behavior?

Should 0x0717 be added to the quirk list to prevent it from being permanent=
ly
bricked during VM crash recovery?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260522070646.2031=
15-1-jtornosm@redhat.com?part=3D1
