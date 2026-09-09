Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F58372EF3
	for <linux-pci@vger.kernel.org>; Wed,  9 Sep 2026 15:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967974; cv=none; b=lYHIrgXUjofowUOU7M5vIfTx046lwIawema5R+3krRJtCA3BdIFxTZenDlUz710o4ek4Nl0HKjXSeYS9mmDEMWP56ei1PkIOHB01PBkxacLMlUOsv08c6EU66lZ9vdpltI0JCf03K1XxjFpgXOrPjclSZkmmB2rZDhJwavizwkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967974; c=relaxed/simple;
	bh=TlQxyP7m+6nBYOfwzu33w3zdLI2dJvqm/2DIspdzjhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bbuXqY/rmMQ7FUpu1VD0gdvMcjhQi88psyH3HPJXPDYMnxxyrbz6Z6SRMMg9ezX6Rh88iaOM9ZXyRZeGFBmsJUfwjwadbvy8tRbhP19oGC0tb7TIGRPSMlE3t4GzDA3RR6ZL5qSaaus0QH0xX0bFKJOb8R77EYEeSllu2iGoNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HawUfGdJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HawUfGdJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2041F00A3A;
	Wed,  9 Sep 2026 15:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967972;
	bh=TlQxyP7m+6nBYOfwzu33w3zdLI2dJvqm/2DIspdzjhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HawUfGdJ8T+EGLfa0TedKkPG2bc6Fhtg/f9MaLlJW+8dm3DTeQw+qRXQ11JXQCU/Y
	 hkEbnLfnEmF0WwZlo0hAGMEtbB532DTjWgA5/eUxynBq6ghckobkKfBsKzTZzv2qbH
	 TlRRxYafD6AVLGERSS8EbTs//IPvCGEG80SeUxqhzAuXtMO2WrlVV9mE+FdgwS44IT
	 eIkHU9BVME7U7TYCsA2ZR3AnV0p3eFIIuCPlDUZBq/4rnCLBL1y70eM2lkK1Sh3o8M
	 EpFz7zKNR9cwBhViolXGtz8/Obgmk13+mEKEcKrlA+QPZYxAqDHMbUrBnRY9kWiFwc
	 9tiI+Z/kSpLSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: Power off child devices on power-on
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
References: <20260909-pwrtctl-power-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 15:32:52 +0000
Message-Id: <20260909153252.BA2041F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_pwrctrl_power_on_device() recursively powers on the child nodes
> of a device before powering on the device itself. If powering on a
> child fails (e.g. returning -EPROBE_DEFER), the function returned
> immediately, leaving the sibling children that were already powered
> on in the same loop iteration enabled.
>=20
> Since probe deferral is a standard boot path, this leads to unbounded
> regulator and clock enable increments across retries. The error path
> in pci_pwrctrl_power_on_devices() only powers off the top-level
> children processed before the failing one and explicitly stops at it,
> so it can never clean up the siblings leaked deeper in the failed
> subtree.
>=20
> Power off the sibling children that were successfully powered on
> before a child fails, and power off all children if the device's own
> power_on() fails after its children were already enabled. Switch to a
> manual child iterator so the failing node can be tracked and its
> reference released in the error path.
>=20
> Fixes: b35cf3b6aa1e ("PCI/pwrctrl: Add APIs to power on/off pwrctrl devic=
es")
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909-pwrtctl-po=
wer-on-rallback-v1-1-412ef996ba27@oss.qualcomm.com?part=3D1

