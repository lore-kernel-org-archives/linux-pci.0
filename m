Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24594F30ED
	for <linux-pci@vger.kernel.org>; Thu,  3 Sep 2026 16:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788454389; cv=none; b=G9fDgzT034YoRAkuzqKme/85VbpTWKld0Oz1aQ3sDKAbtpr3sWmU7VyfSIHdkV06loqI3xDCd37Z2D5Axk4ifIo3L8vzZV3VR/bqQdqy91hjNz5jmj8hRQ/pHwZpQMdTHnNNXBwle40jOS2Fe0bgh9ydFHg8vit+OFjlQvOnZ6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788454389; c=relaxed/simple;
	bh=MZg3qAt1xbpO2oIsDMwCHXOqBPit8LFdBuU8xytmo1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5iucNR0gss2X2Hyv5PkKR8q2dcG6QS0GBR3YStY56F0Zk3FVAVxlAzXbE4iIC2cWi6pE7qW99fOoOSem3Kav6lnRI2tzxFBz7/mlb/+MeXh10boDuY/6sTqjemQBjZObAP0qLSlKHys60IOEWZcYkMh7EmQGLBuiAYsoMC+J/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L+z4Yeyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L+z4Yeyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D4431F000E9;
	Thu,  3 Sep 2026 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788454387;
	bh=MZg3qAt1xbpO2oIsDMwCHXOqBPit8LFdBuU8xytmo1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L+z4YeyoKqA+k3E0UUdNoV6e2dV3HOeedvrjJpwYVkOiyAWzAZBYA81BEuht/C3n4
	 SBbFI7Oehk6vSUaBjxY+tsfoUWucCvV5Ps/lYVQ0DP0A5vWHonLGdLJbrkHelB2sRa
	 JfGnuEc/uyWpQQIKfi61wQvhWdbqWZ/msYPV6tRj+dV1L/ksVOjkH6jV2Ws/BFZBHe
	 5gy2hFzpKufuCT2n/POOCIbPB1MD1yremlVrbJ6yVCaQLWyLucZlM5J0oB1kp9OByQ
	 pYJAq/uvNUm+urNiWQTFfdJjpEsOGNU5/xNCErogj8CWuiE54Xd21KwVgb/TOGbmVF
	 b2X0ZurDFmPsA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: quirks: Fix out-of-bounds MMIO read in
 nvme_disable_and_flr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamad Raizudeen" <raizudeen.kerneldev@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
References: <20260903164615.5744-1-raizudeen.kerneldev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 16:53:06 +0000
Message-Id: <20260903165307.5D4431F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> In nvme_disable_and_flr(), the PCI bar is mapped using
> NVME_REG_CC + sizeof(cfg) which is (0x14 + 4 =3D 0x18 bytes)
>=20
> However, the function later reads the controller status from
> NVME_REG_CSTS - offset 0x1C, which is outside the mapped 0x18 byte
> boundary. This violates the API contract.
>=20
> Fix this by increasing the mapping size to include NVME_REG_CSTS. Also
> change sizeof(cfg) to sizeof(u32) to make the intent clearer.
>=20
> Fixes: ffb0863426eb9 ("PCI: Disable Samsung SM961/PM961 NVMe before FLR")
> Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903164615.5744=
-1-raizudeen.kerneldev@gmail.com?part=3D1

