Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536F03DCDA3;
	Sun, 20 Sep 2026 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887296; cv=none; b=mpLYQZKZq4N8+I8YgoNJ55JwmgwWtwnupIF8AbYlv2C9vlAEjBA/g5EQfPF9orPGBhKfQxXRMa7eYcdHL4lnwI2Pi1EFk4cXshlypHrYWLXuOjORXnoOVhChCyIfTENjdAMf84HsKoZYsLiE9LpkM/4+o/jWKlrcdIUWLgUZN9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887296; c=relaxed/simple;
	bh=5+2YEPlp4H+FPCcvFGKV7EJU6cgtDOP682wYV1LF5EU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FZS53ukGPgZggdqcHOI4B0VDDMYi5WuiQAno6xGTdeBRTi8yVRWknNWuci4ZCnT2uxaKCZJgyDE8csIaCQhnzC1CUF1ZHrTsfzbB3aePFp11qPEfF6VfWsKbev9HROFEaATR8EYvrGoZOkT3i19qpEPoOIfKvhsTw6TSq125uHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfzFlEdo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfzFlEdo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E881F000FF;
	Sun, 20 Sep 2026 06:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887294;
	bh=5+2YEPlp4H+FPCcvFGKV7EJU6cgtDOP682wYV1LF5EU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RfzFlEdotszJ5Fcqgq//0+n3CGJGTchZODJe2UR2Egc+Z4TxewWSAwwnu1N6AgPT0
	 X3LTbCUh7PdT56mp5CIfhwndaH/vqnyFIglAM92RRr4GPR4WYhhVQhbXQn73Kr9Meu
	 TAgcGRo1xbnZfFglPGxS/YskONGctW2HKRof/9V4Lef5L4WU2zy1ypsrJH7diKwSl7
	 pfVtwOVEgEzAArjS8tiquwh6kXf9URgERTrXeYuVeGP9p3gRALNwTd+xiN1INBNwOy
	 DzLpXSCPzjHrUI5p0Dr6LYsz8oevJoDfqcqZ+dq6cs8IsIU/zdaHc3z0/B/thLwyxD
	 HjQMWGWSHD23Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 09/12] arm64: dts: s32g: Add SCMI reset
 controller
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, vkoul@kernel.org, imx@lists.linux.dev, neil.armstrong@linaro.org, Frank.Li@kernel.org, conor+dt@kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260919-s32g_serdes-v3-9-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-9-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:53 +0000
Message-Id: <20260920065454.56E881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
>=20
> Add the SCMI reset domain protocol (protocol@16) node under the SCMI
> firmware node for both S32G2 and S32G3, so that on-SoC controllers can
> request resets through the SCMI reset controller.
>=20
> The node is labelled scmi_reset rather than reset: a label that
> generic in a SoC .dtsi invites collisions and reads poorly at the use
> sites, and the sibling clock protocol node already uses the shortened
> clks form.
>=20
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D9

