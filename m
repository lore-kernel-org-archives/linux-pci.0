Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1012B3CB563
	for <linux-pci@vger.kernel.org>; Wed, 16 Sep 2026 05:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789535736; cv=none; b=K48sTzRfyuUHHt3CRY7NxpMoWr8nd1MUTj9ThulcPQSpCh3c9ErZthBF9VL9OhEvW+R0JF7LxjlNVOZV6WqOU1q45cMhazVd6KC+vcmn0+Hfx1jI6Lkn1ywrOr1HZsseO2fGmyy4XEZAdcrojBUjz5HbX7G8vsGQzWkVF8MkX7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789535736; c=relaxed/simple;
	bh=kHDUtmfSUn10ZqmZ7waQB8CbJJh6VYSMDRGnwqjrvQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YQe4LCBzcrQqcaUOyrwkXdUsN41kCzuNnuTfpFwrYlQVLCIUvsWH1MQfOpraxAWxwykdSP9HKwxg0lVXrpo6i2GmQV9Vpu5GZSRE2uleCOf5QJ2d6PrxSR5P+avGLwyq0hQIu9t++qOPvofBuEIZf1vJp1FItjm68tYQX1/mVv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjnTiR4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjnTiR4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EED31F000FF;
	Wed, 16 Sep 2026 05:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789535730;
	bh=2w0fHwIvmkqtIvYmqMxI99mGSLqSRlmmXw5Uff7xt2w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjnTiR4kIIyLXQjreN5ib1gbLbNuTRR+Vr6gHkAdiGazg+D6VDNb0gIbdp0FhMgb4
	 EGmTgG7bnbZnldiprIfmVt6iT8cS4zfjN9pcYkjHjokJ+p8Dm+UsyDR4Piti17zaR/
	 FnOa4a6qhOCMm0kEZnvu+kfRdRK1pSyQOqYmSpK5IbFLY6mElqI4sjHFrYzgqJLigj
	 qMHV1GpvWLGO3W0ZpfVYll52NXApWF2f8Oc4E/Nb9cN6NP5w41wIWTXfzVbt29Z7vN
	 x+33JoHU/RQC/GgCb25Ix6RaEFQF+6GyQNXDoeAt1FXK/BU2wyErdmlQE3YgJGO6cG
	 1Fmop2meOCJ5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/2] PCI/PM: Split out code from
 pci_pm_suspend_noirq() into helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260916051034.180226-2-mario.limonciello@amd.com>
References: <20260916051034.180226-1-mario.limonciello@amd.com>
 <20260916051034.180226-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 05:15:29 +0000
Message-Id: <20260916051530.5EED31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: "Mario Limonciello (AMD)" <superm1@kernel.org>
>=20
> In order to unify suspend and hibernate codepaths without code duplication
> the common code should be in common helpers.  Move it from
> pci_pm_suspend_noirq() into a helper.  No intended functional changes.
>=20
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916051034.1802=
26-1-mario.limonciello@amd.com?part=3D1

