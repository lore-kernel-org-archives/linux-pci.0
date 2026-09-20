Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA513603E0;
	Sun, 20 Sep 2026 06:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887299; cv=none; b=jVqcaMXILzWNG57WOst7moTRppMQia0RaRSiJm3ZEZXfEtCaTB5xdMOkDTkE1Mn0KelBeyc4+rw1LMFRTQhwzIXsB70pawpfXwOBD5/sXROqGpWohDP0ENGXO3wTFc1bFMhj/3yxw0NjwD3Z8x8ZSc9RVrVl2BcTzuJcZOr0V7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887299; c=relaxed/simple;
	bh=oskMTIyV7i2gXAIDnjl4jU5EbhmDFjCKpO/fGhi1j8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kBdmsB52PdNyUyHzwGL6w43nq5HPvjetEoAUxu7xMURHB7hhtXwHOysAcI22poHQmODkno7bhGqrVidr8Ig6FPw4lxmD0xHUAyr4LDspAqJoe6FDzBw7PwSfqsLhb4sWI9GztwdCZlU47YKnN7WkkgTF5oDJZVkkORUia4WlRKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egt1unYd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egt1unYd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51A21F00893;
	Sun, 20 Sep 2026 06:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887298;
	bh=oskMTIyV7i2gXAIDnjl4jU5EbhmDFjCKpO/fGhi1j8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=egt1unYdPub2WqD6S0NhHtw32cl3vozmTt2TDdgrYFDdYcQDOHVe35WSYURKp81HM
	 zRZX1xaIh2Wbj4vmwvKqNNWb+sQr048h+4Xt1bYkFQFH13s2uhW8Z5s4wIpwMJDoAi
	 DrgxADwunOt4dz6cKPPYCzjnNdXDzIzYRG2tkcD1edg4D+e3mOGVSFYNfKjfBg642P
	 b1x8rPp8GrgDfTZz9dVSFEPkcjkCN/uH8zVXIeE/To0VQfErK7ekbq/tUG8Bt/3e3B
	 2rmAazWa7VzSzYnDN/eFXsPs3TP1fsYC9TmvVOOqWlwVMxPW0ObWH15v1hxceWN6oS
	 ePUWM4KFP1ZjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 05/12] net: pcs: Add NXP S32G XPCS driver
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: conor+dt@kernel.org, robh@kernel.org, Frank.Li@kernel.org, vkoul@kernel.org, olteanv@gmail.com, imx@lists.linux.dev, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260919-s32g_serdes-v3-5-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-5-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:57 +0000
Message-Id: <20260920065457.C51A21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Vincent Guittot <vincent.guittot@linaro.org>
>=20
> The S32G SoC family includes two SerDes subsystems, each made of one
> PCIe controller, two DesignWare XPCS instances and a shared 2-lane
> combo PHY. Add the phylink PCS driver for the XPCS instances, with 1G
> SGMII support.
>=20
> The XPCS PMA/PLL bring-up is a property of the shared combo PHY: in the
> PCIe+SGMII modes the two XPCS instances share the PHY with the PCIe
> lane, so the XPCS cannot be a self-contained PCS platform device that
> owns its own reset/bring-up sequence. This driver therefore exposes a
> small init/bring-up API which the SerDes PHY driver sequences (it owns
> the shared PMA and enforces the required ordering, e.g. XPCS1 before
> XPCS0 in the dual-SGMII mode), while the phylink_pcs ops consumed by the
> MAC live here in the PCS driver. The MAC obtains its phylink PCS via
> [ ... ]
> Signed-off-by: Ionut Vicovan <Ionut.Vicovan@nxp.com>
> Co-developed-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> Signed-off-by: Bogdan Roman <bogdan-gabriel.roman@nxp.com>
> Co-developed-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D5

