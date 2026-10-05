Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890244F566;
	Mon,  5 Oct 2026 12:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203372; cv=none; b=cJdnwL9tyHTozff8LQ1fihB0u4aK1wMnMjRZ8y2R2h8qhvAHQ8rwOfDvrb4Tvg6TjVPBjzkKGMXOl4p6UiZxCStp1SSxTKhsJnBhOSWmOv5YS3iwbyg5NczIhwRfuzg3UBCWOiZbt6H5xMBpy9317H3P6jQEIo1DWvIdk6YyAi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203372; c=relaxed/simple;
	bh=KZocpq2+8dHvo6Ut7tloIrvuigQtcREvTp6y3C2k9ww=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jgZgc8Dy7SYqIwu4qcNK20C+sCt3CMdoghiMOikAdbcxdQ5hjVn9OUa71td8mdvMju+IaBR/HsigN1DufI1csyoYfiJngx9qrBxqWrsE7YpOqWGdJssppvRxwAO0FW8jBB3H4X5WP24H+7fntna3OLHCqBWfDmv11m6Axqe5Ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrZAySX/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrZAySX/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB61F000FF;
	Mon,  5 Oct 2026 12:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203370;
	bh=KZocpq2+8dHvo6Ut7tloIrvuigQtcREvTp6y3C2k9ww=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrZAySX/6MbQ0eKYNOxY+2zJcPI4x/vurJ7OLIdj0AlN9zHt+VWHRnBJJar6e+x6d
	 JL4dXUsjp6WNGcoTRIMFrIr91U1tco7ZwR/4szg15Uu849Rn9dxmhcm/uiApkSA1ae
	 WW3k1WX2GRFjUXuVF+5gmvcfrmYOgiDVfSrYX7yso/tvHiod5HL13gfEFTra6VQtdO
	 yiTMDRPFmHERjzNHq+5caTqF05NNgKordg/3s9OuuPax8cJm2m5RepD+/53sVunvzd
	 SWJjO6TY3m5Gfj0krLSdXrM1YuqZhgTj8c3qqdezYGv+wBuMgsJFxojoTvFvRq4B7l
	 ZGmMu9eww/ubg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/8] Bluetooth: hci_qca: Embed bt_power in struct
 qca_serdev
Reply-To: sashiko-reviews@lists.linux.dev
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261005-monza-wireless-v7-4-5a6de7662dcb@oss.qualcomm.com>
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-4-5a6de7662dcb@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 12:29:30 +0000
Message-Id: <20261005122930.70AB61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> 'bt_power' is allocated dynamically only for a subset of SOC types, using=
 a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
>=20
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicat=
ed
> SOC-type switch, and removes the need for NULL checks on the pointer.
>=20
> No functional change intended.
>=20
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005-monza-wire=
less-v7-0-5a6de7662dcb@oss.qualcomm.com?part=3D4

