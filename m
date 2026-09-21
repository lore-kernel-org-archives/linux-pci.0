Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65448489A;
	Mon, 21 Sep 2026 11:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989575; cv=none; b=pr9z8kpvKKHxFcl/rT2cfSBXXcEXwj0RBmU191zfZxNCceiDEZz5TwJVQNziBtsnVGqJnau7P3W8DFoN2bUe5hajMDIY/h7R41oyAMGgmG3EekijmNJi/bQ2yKbNgIdMPTBcesNX3NyzsRpYA2SosFF6hi/9e72xcjifnyQK6zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989575; c=relaxed/simple;
	bh=Kmle2851CT2rrH/ZXl9tTf7iQH+HFLHgSHpYkxoiEtM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7iKXyGwS0jqX3DZ4dF6r7y8fmZxFStYHCvKTmZPT5+d6X1v+41yCUICFnv3F9RHNjymgQJg4Z+WlY20eKHhkxcwIq2wDr30h63DrDAUcAbTfnTCodiP1FPz9ER4dyO1GC2CDVUlVGaIK2qP/lC9nX2J/CjCUNaldIixux/Lqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQpNcSVr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQpNcSVr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE051F000FF;
	Mon, 21 Sep 2026 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789989573;
	bh=Kmle2851CT2rrH/ZXl9tTf7iQH+HFLHgSHpYkxoiEtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OQpNcSVrI8jWkTyBEIRPgC5hn0ARe7/4bMaLxMEINJd6DH/pTLw2eE6l42gqfJU4y
	 9kTVcC6Q9sqCw1DkwemWVJmVwOLLn7yFdU7HbavemZKvVdNzEoyKgQ6+OEe/6hdeM0
	 yGGlhNrIsR1fHEk3+NNWX1moUV0JmjWZtL8rFlLJUajWPN3B1THRBwdVp2P/lJM7gG
	 0pQUqdKmdPtF3JvFFIfdFMmcObA1GGZfPSzgRmLQ2R0Wnqy55E1h99UAk/1F4HyoZa
	 OqeTcjf5jpVx//Olce3lT4uRA12i0zupQWVUgS8KkHg1NV3vJM7tZiDf7Puui64rxp
	 AIkQ+9SD4/iXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] phy: qcom: qmp-pcie: Add endpoint PHY configuration
 for QCS8300
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, olteanv@gmail.com, devicetree@vger.kernel.org, vkoul@kernel.org, conor+dt@kernel.org, robh@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
References: <20260921-monaco_ep-v1-0-63c5282fb0db@oss.qualcomm.com>
 <20260921-monaco_ep-v1-3-63c5282fb0db@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 11:19:32 +0000
Message-Id: <20260921111933.5CE051F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Monaco supports PCIe Endpoint mode on both PCIe controllers. Reuse
> the existing SA8775P Endpoint PHY programming for the 16 GT/s x2 PHY and
> add a new 16 GT/s x4 Endpoint PHY configuration with the required RX
> tuning parameters.
>=20
> This allows both Monaco PCIe controllers to operate reliably in
> Endpoint mode.
>=20
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-monaco_ep-=
v1-0-63c5282fb0db@oss.qualcomm.com?part=3D3

