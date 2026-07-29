Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35F848CD69
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 13:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332592; cv=none; b=hN2FKsDTWCXDrvPbZvousLD4+Ua/Ou7juOcOHCGHlLQr/RFs82yR4DRlhBKqGEyw4rz3H3uEE3GfctoF50ZhTvJWXaO1p8VFnAk87gLQtQWhFJVTt0InONeOaAJtNFNHURlCveYq4z7zWq1hRCwilm2RwIlUNWA/bu9LqdsSERc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332592; c=relaxed/simple;
	bh=+7xnwg0/Q+lE0TKWcFKpWkmfZQ/laEW1iGEKOjlx9lU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmp/OZNqF9NzaPS0IitxPJHT0C6M7uzVy19EeAbOgEOAcWnx6aTMXuREztkZVxygRTSAD20Qf3QYMX2O423fZIUrcdUgLfmWNf9CyUVEazL0f/sPQTTKljdnwp+Pxh4w3iCTSJAyJWuG6344kU02bCxGsuZD4GaJca6CreeubgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xf553kpb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xf553kpb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149121F000E9;
	Wed, 29 Jul 2026 13:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785332590;
	bh=+7xnwg0/Q+lE0TKWcFKpWkmfZQ/laEW1iGEKOjlx9lU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xf553kpbnGY0Qr4/Xq7B+6VEWsxhKHPr9d528Mv1kb6ZPEblgNAG6C2UI3dxR23Ik
	 WogZV9TKUoBV+GYreJrUBePQQBRbXKdTwogeZwfink59DPQCGjduBn0wmX2+xYw0yE
	 2J1aim6iSCCclTGwE8yn08czxgoGpg+OiOJv4QM2rZDXz/YMc+Q0Bmq+0iPLNTcwGk
	 d9SsJQYP/lr7ykdIMmsgIADAIqDst1QeOaRscLM304HUYah/7m5zRuRylSoO13advl
	 y2UbKerGe6C+LmyMQy8NyGcNx/NtfHb6ubvS4riUJVBdTp7QOJGlaYVnYJjZ2LbOD7
	 ssuE9LHa3eTvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/pwrctrl: tc9563: rely on regmap APIs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729-pci-pwrctrl-tc956x-regmap-v1-1-20ce61a3ce12@oss.qualcomm.com>
References: <20260729-pci-pwrctrl-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com>
 <20260729-pci-pwrctrl-tc956x-regmap-v1-1-20ce61a3ce12@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 13:43:09 +0000
Message-Id: <20260729134310.149121F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Replace the custom tc9563_pwrctrl_i2c_{read,write,bulk_write} functions
> with standard regmap APIs. The device uses 24-bit big-endian register
> addresses and 32-bit little-endian register values over I2C, which is
> directly supported by regmap.
>=20
> This removes the open-coded I2C transfer handling and lets the regmap
> core handle formatting, locking, and multi-register coalescing.
>=20
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-pci-pwrctr=
l-tc956x-regmap-v1-0-20ce61a3ce12@oss.qualcomm.com?part=3D1

