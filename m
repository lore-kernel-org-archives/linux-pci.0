Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00D3314C3
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 13:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123632; cv=none; b=GaC7k3vVMBgqT5u29aYC9pqhKXg2TCmWTMntqY85lOq0xb24E7bJWxAfBb/zbEPIey1zqf8aLwxRMCYNEQ416bGfmHYUZz4tSK5LHm8U7xobjaVHtBKup70Wne9EgdwW2JQvVPYyTJte7ktCzmkWOXVHNkC2Qhgs9ts0WK+zSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123632; c=relaxed/simple;
	bh=HFdWGK0W3zT0UiRNe9a4c1Gglk7cr9+dgM4tym3Efxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nnONhwn8/xklVYRxZSBTwsNRIHNFFAS28d3HHwBAx53QL7cCncouUGA1nntXfjQB/y0ieMQy3uSr96mk9YIkwUgUJudOZkJf54sLFB2Qx6FmokT4/37UPqfqWqwp3GIrFHrBnqcnIp1v/U1eyr37PFz3pxJs1RMnkr8q7uf6COA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QAy2m+ee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QAy2m+ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5221F00A3A;
	Wed, 15 Jul 2026 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784123631;
	bh=HFdWGK0W3zT0UiRNe9a4c1Gglk7cr9+dgM4tym3Efxs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QAy2m+eevDNsAq/ZHF0lzQYDpjtDYRebCmIVW4KqrUtIYSXoqfuQrt84Ix5i67qzg
	 JW/7PGxO78fU6buN1JsrLdZeJocZ5vrzbb6jf1k2TdVX9NYpI9DPfxX1M675hApsrs
	 4TAxzGVKtGsBHSGuT3qcl7kRosNfiGPZ7tDbapbz8X4fCR1g5hrPHZg06HG3iKEqc9
	 vDrK4Pe1uL7akrTCqUG8cP0QtWG1o18keCD9r/xwIgEMMCHgXDkS2ZsX4B2pyhbZWq
	 91/vZfmCT2dM2oEeGot86BUwEH5CUzw4WnTF70IM949q2LbSjzB77wDQ7zAc2B82Mh
	 TCp1ybZbec2jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: starfive: Fix resource leaks on error paths in
 host_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260715134532.619566-1-alitariq45892@gmail.com>
References: <20260714113029.326207-1-alitariq45892@gmail.com>
 <20260715134532.619566-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 13:53:50 +0000
Message-Id: <20260715135351.0A5221F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> starfive_pcie_host_init() acquires the PHY, clocks/resets, and an
> optional regulator in sequence, but does not correctly unwind these
> resources when a later step fails.
>=20
> If starfive_pcie_clk_rst_init() fails after the PHY has already been
> successfully enabled, the function returns directly without disabling
> the PHY, leaking it and leaving it powered.
>=20
> If regulator_enable() fails for the optional vpcie3v3 regulator, the
> failure is only logged; the function falls through and returns
> success, leaving the driver believing the regulator is enabled while
> continuing to configure PCIe hardware that may be unpowered. This
> also leaves the clocks and PHY enabled with nothing to clean them up.
>=20
> Disable the PHY on the clk/reset failure path, and disable the
> clocks/resets and PHY, then return the error, if the regulator fails
> to enable.
>=20
> Build-tested and boot-tested on StarFive VisionFive 2 v1.2A
>=20
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715134532.6195=
66-1-alitariq45892@gmail.com?part=3D1

