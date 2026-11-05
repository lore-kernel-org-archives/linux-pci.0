Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874074;
	b=Noa6nIQtGeCO/6lw8poJvApLUqKBYLc88AMR3PIIIUwczyYBS8CMCcW5B86SZJXLUiCC
	 LdvRL4/JB6wSuRnMgCmbi/0Fb8Fe3taXfdvF7kw+/LmnChtsdl9qHuOqaAHeE2gDyPnr4
	 fGqcIDn1xl+OpVarcixeJ0p0AG0cnB5W4NMVc2nyACAlrbxKBkG2IsVojgPfGupBL9Dek
	 AoN6efiE2b9NqYPewdJ9uV39A7qnCFg42riCWaHzTwQD7KVOBb8FiI9znXl2zrOzCDqQ+
	 7LZ9Zujy5HAVU37a440hCpo/t3G2TnyYaFhFHdkKK9IldRzQBBp+XhIGXe9Vm8UEGOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rycshPMxBLQTebfgXnzrTIk1/i2j8dLx1M9C85/E5WM=;
	b=E308mNo3NcZuwnWIhGlmfjPxWgzFErIZlV7+f3PhXEmT4l3lsVu1ncikNTzSNQTDD3YE
	 GOfoWZEorEMI5BvK9WS/rZ1rr8o7G2thmy/YTADd6dP9TbO1scdVexzk3uAYjY43rOPdh
	 7I2N0oM9amjkkmSqTJYbqZJXRjnbJyttrP7NBJD7MywnFx9gpDkh7uPzYzqDByp9OWoq9
	 2qBQVtjq0YSdq5j1Ha1vtEmkWWRubraUtY1tGJRg5BNOuI3MPyFY0+JH5+w8yyhdr64Dj
	 +QiXqmdZ0h/X++7mHzC+TN2ATUblseZ1NLAJdHmXTFedq2vT7pfoIauteZRlr353Hag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="kQ1nq/ys";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5101E606D807
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 10:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ1nq/ys
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139D61F00919;
	Thu,  5 Nov 2026 10:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874074;
	bh=rycshPMxBLQTebfgXnzrTIk1/i2j8dLx1M9C85/E5WM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=kQ1nq/ysGR5m/+mqu/94nqGgHJLPL+YsNDZs7ikI1/gWRJQqp7Ee+7vVyUFscq9zV
	 anv0GCDZqhTR5coOKRLANiSbDKNgE0TM4Dwf/8cjItN0wmmDqQquicxbu4UvSJMNib
	 DleNXNX9oAohSByy87d29hgPZt/G2pZtFbu5KF0FY9fOW4RFksVLrn3olY4Nd7LAKB
	 1G5npu9JZpzreAr17CiMTzzhsS6Rv36s3ydKM2CN2v+4lyrFTLvvmTBnkhTViT5hX5
	 jdYzs87PJu/qIyM24TqjVLH56vld+fnoFztd3fdZ7xFeeA94D8FajIXl3OLK+E0r0m
	 OxuM4kurolE5A==
Message-ID: <sashiko-outbox-198843@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: qcom: Power on pwrctrl devices for
 firmware-managed hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhangfei Gao" <zhangfei.gao@oss.qualcomm.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
References: <20261105101521.434361-1-zhangfei.gao@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 10:21:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> commit b921aa3f8dec ("PCI/pwrctrl: Switch to pwrctrl create, power
> on/off, destroy APIs") switched PCI pwrctrl users to explicit create and
> power control APIs, but only added the calls to the regular DesignWare
> host initialization path.
>=20
> Firmware-managed hosts bypass that path and probe the ECAM host bridge
> directly. Endpoints already powered by firmware, such as NVMe devices,
> remain discoverable. Endpoints that rely on Linux pwrctrl and pwrseq,
> such as WCN7850, remain powered off and cannot be discovered.
>=20
> Create and power on pwrctrl devices before probing the host bridge, and
> release them on errors.
>=20
> Fixes: b921aa3f8deca ("PCI/pwrctrl: Switch to pwrctrl create, power on/of=
f, destroy APIs")
> Signed-off-by: Zhangfei Gao <zhangfei.gao@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105101521.4343=
61-1-zhangfei.gao@oss.qualcomm.com?part=3D1

