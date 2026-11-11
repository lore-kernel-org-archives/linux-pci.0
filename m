Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416659;
	b=DqiPDxwv17UxFpJyozIN7dTmJn0qAq1dDHdZD77Rf6XU+EP6h4HsSWr6+c8ocB43lbNo
	 EXbR2jbt5B5q4xXmLHKHgy/g5PgQodSfRfgPMUvITu2jB3IxsO51JU9C8VL7Hb2x6gzlr
	 WIsLlqqc+JvG6kf30CboNykxj1tAtsSN90rnKPrWDwsZMKS3gf81fuCrNNoEdnBJxQ6EV
	 op38irYZa3mbP0tW4793AostOCnwQQyl+Aw2faw5PKBulji3lQirDHqttfzZRAgg2qrpV
	 uxNjcuFXsGRpQ6zqSwK2w9fxNF6o/bT7JxLul6gLC7YIasppbI3356jt0n7/KlLKROA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416659;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=u8Ty3HMMMgR42+PP+L/DzYcGfH7I2/ZGMWkY9tvSChw=;
	b=1QyCdVNwSZMj48FHiuiXkJ+lp+lvNSKXcweQxhtyCQ4MxmRZtCzXRW0eD3D0jYYeAgB/
	 WL9sWUVfV7VIYpaHF8Zw4z7VuHj7sMhzFs6+tpORXGQPNX8R8syfwPDxbTWMvm7kS0y8W
	 XftfyGQnLpFcThb93trNvsePINuefdL4PVjhQQaK5a7VkukcTWjldObXS/dZs0tMonJ/j
	 qCRZxkVREQcZSlfX8L8FRsLr41owzYikbe/BUfwX7lhshpUlrFMFQjMrwS+B83aj2A7yV
	 RtnL/6caoSr8uhqMl+bpigJxn6kmJcc9N9UgHzNMscBt4gv61qTyzEsgFTUDbTyvG9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIxrqUug;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9250860A2610
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 17:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dIxrqUug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33B91F00A10;
	Wed, 11 Nov 2026 17:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416659;
	bh=u8Ty3HMMMgR42+PP+L/DzYcGfH7I2/ZGMWkY9tvSChw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dIxrqUugSVJ0XRwvNonLx0P9510JjHrioQ51z4FWX3/tVDSOI/BQC3jJNwMYQ8zKW
	 uT4euoKbVx5hL2EeOnwLCIodySk2R/UrwBit1X3sALFYXUvj4cZKlouYQcstdVPqnL
	 +JdqXPA6sLhcnR1sCdhk8iPrlpQ3URwaA6ObdXzxyZh0KEnK8rUPk6hdDrXoX3HjpA
	 JH2pOvm9hQoMlGTQHEiKbSQw1VWAcE3dOwbUX49rpFRYAOvf9R/6QLktJ+70sUIHvt
	 dKzJcyicaprHj2AnYemh74o8i+riTSU7JOl/rASk2QbkYe85Rco0hq+tAoqAiw6LFH
	 pwoTylBZHYhhA==
Message-ID: <sashiko-outbox-209366@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] PCI: Start the reset of WD PC SN730 NVMe
 controllers early
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paul Menzel" <pmenzel@molgen.mpg.de>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
References: <20261111163145.75027-2-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:04:18 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> [Please consider this a bug report.]
>=20
> On a Dell XPS 13 9310 (BIOS 3.17.0) with a WD PC SN730 1 TB (15b7:5006,
> firmware 11170012, the newest available for this OEM drive), about one
> boot in ten mounts the root file system 100 to 700 ms late. With the
> nvme module probing at 0.29 s from a small initrd, the time from probe
> to Identify grows from 9 ms to 74 to 229 ms, and the partition table
> read and the mount get slower too:
>=20
>     nvme nvme0: pci function 0000:01:00.0                 [0.293894]
>     nvme nvme0: passthrough uses implicit buffer lengths   [0.522525]  (+=
228.6 ms, usually +9 ms)
>      nvme0n1: p1 p2 p3 p4                                   +27.3 ms  (us=
ually 3 ms)
>     EXT4-fs (nvme0n1p3): mounted filesystem                 +82.2 ms  (us=
ually 8 ms)
>=20
> Tracing nvme_disable_ctrl() and nvme_enable_ctrl() with function_graph
> [ ... ]
>=20
> That boot was not traced, so whether the reset outlasted the 100 ms head
> start or the enable was slow is unknown.
>=20
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111163145.7502=
7-2-pmenzel@molgen.mpg.de?part=3D1

