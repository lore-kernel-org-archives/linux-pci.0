Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5D361970;
	Tue,  4 Aug 2026 19:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872444; cv=none; b=sz0pvoHnMZXz2ikO65DJ4zecYQP7bVBLWGlAYrVNoU+CyGHM3m4BcTlQa4qDaYS1+KIbLYldIz4ojDU9fukHk/Zm4LL5znP4Ewz6rjxgH/MfWDHtmuhplfNjBGbNQ93wbVTKSAf6Uj3JI3wJYTorsSsW6E9mGMcAYkJvg3Wpfg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872444; c=relaxed/simple;
	bh=BSdBJrBzncqMqb5h2RMjIi5GII18SoytIgvGGt5LXAE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UbWNi6uN/4iXUPdHZnjJ7fKElWnaHWG47GyjquOpdc4777CVf3VjeVc3F88ZgDmnHrLhfS9rUuYPVlL0zOKSNiiWvzHTHLmldXpyKudyC9FpzPjxgIrsUWGbfPZl777fcKSt04sIK48gN+bEL8BVoMCVzVCJssqQ8gDfOW/fUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0G8U+Hp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0G8U+Hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F031F00A3D;
	Tue,  4 Aug 2026 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785872443;
	bh=BSdBJrBzncqMqb5h2RMjIi5GII18SoytIgvGGt5LXAE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J0G8U+Hp4LtCLA9gqYRPop+wYY2rfrVAzjsiG/MGJjFx72FVRfZQn9gumO0Vc3fav
	 j6cufmWNwli8Db2u0GRgpVHc5p33lUbiGolMwum5waPd1SRZARcZRl8ER+X3xULwOJ
	 ti+SBrYuIMjV0NP6uod3V1fRGj733MXBm3ZDEQjq3vgFb5TlgjRlp6olhyy2xpEWJ9
	 UPcAfcMYK4rCfvzZ7usN6pPXzrqFGPcxERLMqAFgmX2jwpAyYQx60UKQtE+PguRRZH
	 Sa+LR8wkVQ+gcaleBFWRb5D4Pali5rHiKXOpuQfVRH2RH6/vPjOit0UZsAFmUvLE7F
	 ZkbC2tT5c/n5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 04/12] cxl: Cache decoder settings on PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260804192958.1823952-5-smadhavan@nvidia.com>
References: <20260804192958.1823952-1-smadhavan@nvidia.com>
 <20260804192958.1823952-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 19:40:42 +0000
Message-Id: <20260804194043.43F031F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
>=20
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804192958.1823=
952-1-smadhavan@nvidia.com?part=3D4

