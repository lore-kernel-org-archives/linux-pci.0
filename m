Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591302;
	b=LAh60X9y46YrSxf3nkF7IbtXyOaSSNqhaKrjVb6kDtO42jgriAkgsVzu3d2xQD8MnwhY
	 YlN+u/Bklxh1EU6H9i5p9zcE+xepzdT5lSBYUvpqAqqrNNkAMWMIfzHt2dMIVmGq3ZqA0
	 RMR1e0opuoSxGRdixmsyXIyilRYENys3A16mBfxQuIHTsMeOQ0VRMf3Fwdkncfs880VoP
	 lvrz4sO+/rL1nQJf6O7XNY+D68PFep6/W3pNEGPBtkdc53h5iNR3QvVdbBLWyXTrvVuft
	 YhVmGsn87ZvFliCI5Rd2yHmVEyinSyp8/uAERBylYqxz0EDWGOUGKM+n7/q2YTreIGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1ziJKi5qDCw//9maDfIIGdrzkIqA1EuCku+uXgzlWT4=;
	b=w8YZEYkwtUpyV6A5GFnngmy5+0SZ3RArvR5wcBiyyQedXSTM/BHob3b6w2s8v/54xoZs
	 Y9hH5X9gAthW9XWjWlb50HayudM4C+Ls22SMw/4OJdsC/dHqEOfaKmAgRtK/0P6/LOR3C
	 xoSQQUQc3owdcDQBwAHjnOALG9VmtlTVzHjRYYA84DagPrWcayLEcMograHHt+A0ut1Ot
	 TghZGAMaB3HcbUG5+FNH7oW4NFyirsOjX8KV1zg0TDUvEYJ31iYVeSw6P0DCjLhqR5cNX
	 ST3oDJm7xzzUa16BtGHTvFteI/LfObCVT1Fmn+OXcDxkHXqNETWDDCy75/gRMslj5vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzQ0l4QG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D6A606A31B
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mzQ0l4QG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDFD1F000C4;
	Wed, 21 Oct 2026 14:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792591301;
	bh=1ziJKi5qDCw//9maDfIIGdrzkIqA1EuCku+uXgzlWT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mzQ0l4QGJ//oj/9B+/nUGOA2Pn28VYMzHPBCTC9DXK2FwYSZa96ShlysNL+fcPkmv
	 eWoW/KxBoY+DLadnzl6k8D09JSTsSikvT6mNoG9ve49M/mUIrsIhP/W244jLdNSvfj
	 reEn4pLa4UJdnEHWXXMbBeynlZdhs2VF1X7LaMeZChXkmlRJ1OyIgTre9kSRs5/eie
	 dlHj0HMio/ubOmxZbPiAH/dGuNW3zgQAgsZUwjKSxt4YkaLH3P8PoS4sqYg4Ax7ed8
	 jU+EQLIv0sNjSQOBvJCCPMM/fdc77sE7qipF+JRwhIf9kx5CgfqciPMq+EYsHriuBw
	 AHk0PdXH40u1A==
Message-ID: <sashiko-outbox-180343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021-pcie6_fix-v1-2-ad37134c35a3@oss.qualcomm.com>
References: <20261021-pcie6_fix-v1-0-ad37134c35a3@oss.qualcomm.com>
 <20261021-pcie6_fix-v1-2-ad37134c35a3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 14:01:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add support for handling the power sequence of the PCIe M.2 Key B
> connectors. These connectors are used to attach WWAN Adapters to the
> host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
> 2.0.
>=20
> Currently, this driver only supports driving the 3.3V/VBAT power
> supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#/2#
> GPIOs as a single "pcie" target, since Key B Adapters expose only a
> discoverable PCIe/USB interface and no non-discoverable bus (unlike
> Key E's UART-attached Bluetooth device), so no serdev creation is
> needed. The optional WAKE_ON_WWAN# and DPR signals are not currently
> supported.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021-pcie6_fix-=
v1-0-ad37134c35a3@oss.qualcomm.com?part=3D2

