Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52D37B025;
	Mon, 31 Aug 2026 07:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161687; cv=none; b=QQGXrjo1Mtg31OpSe4ENPxkHaGocGmVom06//4v4vpm9QNg4oxTw9M9qKqEESzqmBDu91mkTuTwZduv4mCIeK6/22sA8k306lnfJs41Owp9xyz2Dl9VGyFm87JeSMlR5VYn32WR/Qh+BttUP8L+a1CTr0Ylwfxd+RlP27fUhb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161687; c=relaxed/simple;
	bh=cOTWeZHeGJJD8RT1MIjvhM/90p/j7DZvaY7cSnltyMY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s9Ufunf0ip/wb+6fINW/SbBcREKvB1nmLOX/M4QwUlEc94QzEmnFjPuOv8CkfkpqCVlbQh7yeoG31MEV56c2eTV2+D5xySodPp3V9d7d5BJZPx3nhTPxwJe7JOuzZpqOX0gUnbTCVLk7tigzqLT0Wim/t9JQ5Lxuda3LqaXtXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHZUH7g2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHZUH7g2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDE71F000E9;
	Mon, 31 Aug 2026 07:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788161685;
	bh=cOTWeZHeGJJD8RT1MIjvhM/90p/j7DZvaY7cSnltyMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fHZUH7g2CBmqUKaEmL41vc60jvK4phoK81BGEO+4lcI8pwkckueH0tw8/sXaY0Vcm
	 NRK+L2SSEJigeqcG7vf3itef0UuqOhpBwt+MzCpZf6dRJuJJk40t2uF6k58ZD5FDWy
	 M5H4/EguZ87Rj8kho1rDtQy1XvL7HHKKG427BkqrKPQB4xWTfobW97zuq04kF7XYLX
	 vXiv90hcSTdMFKu6tOCzwcedyqgk2pssnqoXX8KVlzjeG4r3UiDzUUltHOwWJTGy+/
	 YnTpVoGrtfIAMR85VQXgJFMn5NH6rRGZPO4RzUZImAFtV8XzUVyFoOf0bGZuWqoMPa
	 H11Mt7sscNfLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/5] phy: qcom: qmp-pcie: Add QMP PCIe PHY support
 for Shikra
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sushrut Shree Trivedi" <sushrut.trivedi@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, conor+dt@kernel.org, devicetree@vger.kernel.org, vkoul@kernel.org, linux-phy@lists.infradead.org, robh@kernel.org, linux-pci@vger.kernel.org, olteanv@gmail.com
In-Reply-To: <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
References: <20260831-shikra-upstream-v2-0-406661d75afa@oss.qualcomm.com>
 <20260831-shikra-upstream-v2-4-406661d75afa@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 07:34:44 +0000
Message-Id: <20260831073445.5EDE71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add QMP PCIe PHY Gen2x1 support.
>=20
> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-shikra-ups=
tream-v2-0-406661d75afa@oss.qualcomm.com?part=3D4

