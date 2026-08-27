Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B0314D34
	for <linux-pci@vger.kernel.org>; Thu, 27 Aug 2026 07:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787815182; cv=none; b=ByHY7BHZe9CTL5249Hw3KSQ/va8jVrxCLy/dqdTJ3rYIL/GdzORtLVz5VSr4YPYOLu5Cjr9C/uXjIpC+yelIiu8JcTp+IdY+EpEv5Op907A+Eu4ipLsSd0FQ2+tgzfeCPqaxbh8MvMMFNejqPfETmqA4O7LzBVLDycovyYbrVhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787815182; c=relaxed/simple;
	bh=/c714WRAcC96riut2dB2pLgsXe8ZmjsZynrggT4ABm8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d6u4maP6swqSLcGvUjU7iHQn/5w3Ic8z+pmGx4gwkAsgAzp/C72hzZYcF4+TUTimWilfXcktKl1d6E781bPSHSHSUReHYUWxGmB3H1eeegpc5MXyY4J9NtH1pVXXSw91qw6l4dLvUIqaET4yKqhqoAx6HNOjP2/Gke9gvdurZis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwXzhIx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwXzhIx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC01F000E9;
	Thu, 27 Aug 2026 07:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787815180;
	bh=/c714WRAcC96riut2dB2pLgsXe8ZmjsZynrggT4ABm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwXzhIx5k91+qhdf45zt3vh/8aUJxr9+f7SgLAeFuDMfz/zouaujjR4hNIe3wqk/L
	 1+71gRxom2SzvajrYGRttNXGyen4gMfQwRBqc5vKVRfMPrW4qzDAWbxCX3jVPN1GpQ
	 uKFPHVzNHYdCDLgqBBMitfon9M+Er5XAIDn0RhKfYrfB8dpnsVb6VijBZtdTYL4vs6
	 9/WcFjVZOr0Qzon/s5M4luJ5Lx8TReRFVb75HT74c0/qksjdNQlclssjixQ8bOqVVH
	 GHLB6k6yjEFth9oHlNhtluZ1EEp6/O64I0EhYVSaMs/ocPqDChiORARR9leUp9KrCT
	 inGhG3p5O3uvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: quirks: Fix out-of-bounds MMIO read in
 mellanox_check_broken_intx_masking()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260827071439.4480-1-raizudeen.kerneldev@gmail.com>
References: <20260827071439.4480-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 07:19:40 +0000
Message-Id: <20260827071940.B7CC01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The mellanox_check_broken_intx_masking() function maps 4 bytes of MMIO
> memory using ioremap(), but then reads two 32 bit values using
> ioread32be(fw_ver) ad ioread32be(fw_ver + 1).
>=20
> Because fw_ver is a pointer to a 32 bit type, fw_ver + 1 advances the
> address by 4 bytes. Reading 4 bytes at offset 4 goes past the mapped 4
> byte boundary. This out-of-bounds read can cause a page fault or kernel
> panic on architectures that enforce strict MMIO boundaries.
>=20
> Fix this by increasing the mapping size to 8 bytes to safely cover both
> 32 bits.
>=20
> Fixes: 1600f62534b7 ("PCI: Support INTx masking on ConnectX-4 with firmwa=
re x.14.1100+")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827071439.4480=
-1-raizudeen.kerneldev@gmail.com?part=3D1

