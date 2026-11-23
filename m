Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471103;
	b=tx8U660xgjdprsCgmoMniKr6muSnl/emudciLGdYvzd0ST/Ou/BAcDnytY/5CfxfQZaZ
	 xYor0LoIhkF8LZmGAr1vdnDHxTrvHUE6ij48qKswyCvU0tksM+F2VWtKz+r2Qx5x6i0Px
	 qH5OD2esp3oDYHqAftEmFVFL8CxWfBBXZxoHN/wxgYg5hlvk+YzBdhn9B+rtCVPchTCzy
	 vLGFdI4lqMySbuNYxQtg9nrrWdWcbN00SRduqZdKr8XqxszfrCZ/mk2ZCT0/7tUUIFSA6
	 SJ/6VtQxSyJKgrpcpnuTjW9ouoHky0KgBBWmHcl5CnlIoNEwAWhMyvT1cLQQCGumRWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471103;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oh+YAjw4yS5IgbAMl5SS7gswZDifgwLXxkrUQBpjItM=;
	b=myJni5Vxh9831GrOTPpKQxf39Fx+bY7qYLdet77uwogBwiSd027Cx7d5OxPkXTAgQyqc
	 xHbjZHbOo88u4PqrIS2Q4zC78igqv19u1mVPCBn4crOb1guE7fiyoH4EUr2f4avwTyIxY
	 oCX9tWJIFoQVAge+GeS3NQzSpTVomz4M2tumOSP/sRNq/qSGLGSM1QDtdD5SZgleOBmJl
	 xYQfuFqmx5P9YPijDZaEupherl27VS6lQ0YBoU7jqBkFHq8cEAgSnr1H5fMbc5Pm+im0C
	 RnHrlqRpgWy05MRHxLBjXHWb4rQAnY8OKUd+IeXgLQrk783y1c/EE+u+tzL5FkGMIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVWUo8En;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8B2606A31E
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jVWUo8En
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141181F000C0;
	Mon, 23 Nov 2026 21:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471103;
	bh=oh+YAjw4yS5IgbAMl5SS7gswZDifgwLXxkrUQBpjItM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=jVWUo8EnOKNkPQ884I8bzqCvGIY5ugM8cv6b6pi2mBAtSWeAWqG9vwdxIFiBpMFyy
	 Dh3CyVGaMiHF60DE6/Q8OvAEitF1qTaraJLsuNgYnXTisJtZFSNA22MZBW20KDcrrx
	 aLHoGYD02fhDTG237gZhXTrguT6j+lN67nCzHHwX39a1qPSa6gg7rA5a3zs/lEiXCU
	 9BW1sntn66/1niTnHADQI5aTV6L1othKtO5pa5qdlZ/kAP6zbhf+TN3YzUqdHXyZZQ
	 tOyi6GePRMLbOaYYfwSkvmekfJWMlJUWbd8Eck45zEXDCAIWcJbrSMTV5Ot+Xz3K8Z
	 W9LmzwP5TPl0Q==
Message-ID: <sashiko-outbox-230094@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: Ignore Immediate Readiness for Samsung a826
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261123215308.1285-1-alifm@linux.ibm.com>
References: <20261123215308.1285-1-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:58:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The Samsung NVMe SSD Controller PM174x [144d:a826] advertises Immediate
> Readiness, so pcie_flr() doesn't wait after FLR, but the device isn't rea=
dy
> yet and config reads return ~0 after the reset. This happens with
> firmware version SNA6SNA6 or older.
>=20
> This was seen on s390x with the nvme driver bound, by resetting the device
> via the sysfs reset attribute:
>=20
>   # echo 1 > /sys/bus/pci/devices/200c:00:00.0/reset
>=20
>   nvme 200c:00:00.0: Unable to change power state from D3cold to D0, devi=
ce inaccessible
>   nvme nvme0: Disabling device after reset failure: -19
>=20
> Ignore Immediate Readiness on this device too, so pcie_flr() waits.
>=20
> Fixes: 10baa9b4df40 ("PCI: Drop unnecessary retries when restoring BARs")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123215308.1285=
-1-alifm@linux.ibm.com?part=3D1
