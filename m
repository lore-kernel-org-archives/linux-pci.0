Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349454071E2
	for <linux-pci@vger.kernel.org>; Fri, 10 Jul 2026 10:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783679346; cv=none; b=oief69zR9hpjdzLB3a06wBrHBkU+rmSNjdbHN8UPAvBWpVip2DSr3wgY0qDKvey9pvVkfPLJoIA2G/Z+lwI4ZFHr5ntQqVK+4YFPot4DI+Ynu0IGyernTFF4IK53yQQJ2B7VDAtjmiJra8z/MK4hDobx8Wj5tFGUQiISmYXf6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783679346; c=relaxed/simple;
	bh=LrDTnYOAMnl6e4yKuuCnRep5OeH18gjI3JyyUJakUgg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhMJ0dnG+XuGAJN1SxBUezRDT4ggnQ4B8jFhJiG3aU5WxOdL7ldkEONZxlS0yLnOP9AkUbp/FizVg1BCD+Uni6K+qYv1DhWo953hzE0dPOcH9vudMrxwBytj4lIpY7rKlK/0SDILRez+Q1N/J+KtTw5fJIXSEnUrqkLjS3AuKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEQBWisC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEQBWisC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DA61F000E9;
	Fri, 10 Jul 2026 10:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783679344;
	bh=LrDTnYOAMnl6e4yKuuCnRep5OeH18gjI3JyyUJakUgg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LEQBWisC2ApjICTvpHATPOZrTznVok3Rqg/8+dorMX6y4Pc+6YLIqHVACRVDbGR15
	 uYCQEeR9VSRq7jPpu+lpq4SVntuYoWQ4QKWsk9k7EeN5bzUasIzNI/6IJA+EweCD9T
	 ww9bI+DZXTOwy4eQMD/k3DkfN9fn4AASkFZ2V0pzBko6qrdh+RCIrO2P6w7cVK7TV8
	 kuZlN2KyLw3egaAVFDB+7vzz39kjjyR2QkgWrq8rKQ0zTXqrc5hT/3XnX3d7QOv7rr
	 ANasNWqjOhW0eGlPM9bQSHFKJAV4yOMWGxzN6hktobJiCnINVTQCx6xGAyhv6Ot9S4
	 QbI3tyoWczMEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 v2] arm64/pcie/pmu: Add pci id for LECARC pcie pmu
Reply-To: sashiko-reviews@lists.linux.dev
To: "Braden Zhang" <braden_zhang@lecomputing.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com>
References: <20260710-pcie-pmu-v2-1-a3d73d4d9051@lecomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 10:29:03 +0000
Message-Id: <20260710102904.A3DA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Brett Zhou <brett_zhou@lecomputing.com>
>=20
> This patch adds support for the PCIe PMU found
> on LECARC SoCs, which utilize the DesignWare PCIe Controller IP
>=20
> Signed-off-by: Brett Zhou <brett_zhou@lecomputing.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-pcie-pmu-v=
2-1-a3d73d4d9051@lecomputing.com?part=3D1

