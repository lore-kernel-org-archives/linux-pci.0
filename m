Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB2469829
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785344121; cv=none; b=UfgLtV5TFpYoYkA9/YbppTV0wBqDFA2qcm3uJ/Z7AYO2RPajbZCaF5yCyRghyu40qxT8LFqJczsUjnq9zEbr8DZKqn8Xpk6V5vtnm3xsuqQQ0EX6irPDTq/AB9XDm6iJfOso/5NFGlBC3JNTzgTVt6ZwYRR5avs055BDWgcfZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785344121; c=relaxed/simple;
	bh=V5qbUgLRfA66nvV2bGKUYGHXJ/0CA2esJTRYywn8jhw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lIzLrPza0EEbR4rDYplJqAQBPRkpdv7iRtuOM1FhmhE6r7cVY85NjX5P5AdM5Ww0bHQG+DvP/L7/KGYJmnvhBwhVU306ocsk3kYLAlfwZ0SrBZORL8pA5j4UHem71HyWyp9e2Y8wJa8jTSuOgAEkvsIPZZlALtD5OsOX8+b5cUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMqB2Uu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMqB2Uu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD131F000E9;
	Wed, 29 Jul 2026 16:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785344119;
	bh=V5qbUgLRfA66nvV2bGKUYGHXJ/0CA2esJTRYywn8jhw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OMqB2Uu0hl/n4L1C3/yRvYEaQpRRRUtYzDvc1HJV1/k792upQavPrFnfEOyJJINF/
	 1PWxR0fLlp2uc6v/iFznkmvqfFftU/IuidFl6rtrs7P2DkdxMNXMgJIkcK9bycojV+
	 NocvkVA02Qh2Js/3eAksQpW6jOyyN8yjRE++xH75YUTfJ7k565KuZYQm0R3307wpZG
	 um84sFvhGc6sh4bisL9T83JyZjHhaWsN4tsVndLKY9hIatjUKHHrpv4sJu9U4sq65E
	 gk+eDybD48g7kmNHa1v4ESYAS65DVa1p+9NIfSrsyKhJ3+Md4yEqU4nGfmwp/uwNQt
	 O7Gi5OJYmZfyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: Allow D3 for native Hotplug capable Root Ports
 on non-x86 platforms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manivannan Sadhasivam" <manivannan.sadhasivam@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260729165005.896725-1-manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 16:55:19 +0000
Message-Id: <20260729165519.BFD131F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Commit eb3b5bf1a88d ("PCI: Whitelist native hotplug ports for runtime D3"=
),
> prevented native Hotplug capable Root Ports from entering D3 citing issues
> on old Intel SkyLake Xeon-SP platform.
>=20
> But there is no reason to restrict D3 for native Hotplug capable Root
> Ports on non-x86 platforms. We recently enabled D3 on non-Hotplug capable
> Root Ports on non-x86 platforms (specifically for DT platforms) in commit
> a5fb3ff63287 ("PCI: Allow PCI bridges to go to D3Hot on all non-x86"). So
> do the same for native Hotplug capable Root Ports as well.
>=20
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.=
com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729165005.8967=
25-1-manivannan.sadhasivam@oss.qualcomm.com?part=3D1

