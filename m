Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF7288B8;
	Fri, 26 Jun 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782465998; cv=none; b=laKdE/fjKrPyRw7xoHzswo+qDNxc7Sm/c9WqesfvxUa7DYMMD+EW3C8QrzLZx0nTokzttFui7z2vUwpvmTl9TcmKJfInfOKVUCu3mvrnP2xHBt7qLhcmsPQ7YNfDURl3It0Mv7qgSep5d4kf2rkrX7grDA/MorqhjjgopOmGbOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782465998; c=relaxed/simple;
	bh=iluvErhpoIFWDmAtkJJcnEKhv22pbYqY7UXZYN+JITc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WNBnO6kZhq3gPHZ/ZKcGoOAuGJ/LrytjCyrTMXsUekFvFZZXy0sxv8PrGRWNifk0AT0wSFXtWmTy1qi+73Xw6efjGxzyN1HJ94PTTitdUNz2+Gd8anCE5HmOpLv7ZGsNIpS+Kgb0gM77Q0o6PlE0lDz33wF2ndRFvRVzjSJ2PXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSeVRuco; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSeVRuco"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2471F00A3A;
	Fri, 26 Jun 2026 09:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782465997;
	bh=iluvErhpoIFWDmAtkJJcnEKhv22pbYqY7UXZYN+JITc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSeVRucoaYbGyouQEmE91f9bj1sgQbVBLcIyfdTp7fVAP3katYubImj4bxOCfoSeP
	 l5Og+dz7Bey5GoYMvS8vgvHqPOsI0K2+C51hVD0jZNURFYV2RG4KntQYBg/4w9ByF3
	 r/PBV3RHeBHU0+kjNn/+2zMLFKxbDqoBtIH8S245qbCOXliToterxIOt3m6eRrU/pg
	 O+QS5Azl00WGkte3qbHzg7YXc0QNC5Y5HKcxHEzuVgZ+vX0aufqMpqDJjaEJvD7SyI
	 /uW/c/owuuQOuRkeBECCIpt35JRJbA4ehUaG3w/fR2cVatRynLtPg4qso7ZgePoA4Y
	 LX4x/6BPejF/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: clock: airoha: Add additional reset
 for PCIe PERSTOUT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Marangi" <ansuelsmth@gmail.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260626092029.3525264-2-ansuelsmth@gmail.com>
References: <20260626092029.3525264-1-ansuelsmth@gmail.com>
 <20260626092029.3525264-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 09:26:36 +0000
Message-Id: <20260626092636.BA2471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add additional reset to control PCIe PERSTOUT reset line for each of the 3
> PCIe lines.
>=20
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626092029.3525=
264-1-ansuelsmth@gmail.com?part=3D1

