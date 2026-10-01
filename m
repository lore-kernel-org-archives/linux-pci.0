Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5F3B47D7;
	Thu,  1 Oct 2026 10:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790849909; cv=none; b=gr1tghGLUDWZmP2G/8Ypuo6Z12eeH3MXgpSGvMisbiV3lffobqqKP9d2ubT+6OlCrm0Zf3BWHZH1opiO/DNyTjUEUUdcWPX5nFLEeBCjb3pSqQC7osw6f5E89tg55sEi6tS9XuX8h2KFUhHHWn/NX1Mc5fed+ruIdnzaCyHux3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790849909; c=relaxed/simple;
	bh=yM3Rgrqy0XxFNY5BnGmDddKm7bbfmij8jL8LzXjXA8k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z54ALcEC6hUXjLdFrBZO5YxHz7UimA1qjMo80XZFI166bDOi4Z7V7W9Dt0Ep2XFZ9RwGmuKLJjdbZ8XPYEnaCy5azyIOc1nBn9zI7FvodiAbW0jTag/Znf3LyBzQfbbL4R1Y0rs4Ru1+1PEJVKM7UquUoxeSUC8dBfiTRedD+qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJJWlSF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJJWlSF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A6C1F000FF;
	Thu,  1 Oct 2026 10:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790849907;
	bh=yM3Rgrqy0XxFNY5BnGmDddKm7bbfmij8jL8LzXjXA8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJJWlSF6eUtK6LiCEV7QVvVLHrgCSRwB7wJCiEpRVYN3FNSdH/wsLjrtXfLCHZX+d
	 mp+8snGQ/lh4e4H8ePaz4T2ZRj78nfLWg7XcwGwo77TsvATGfUFYEECvFYGc7297Mj
	 KfOMnN46jNA2Kh4xiOvVG78Z6vcKJ6SH5RqV22T3dknfxLiAoUAzsSSz2GVR2Yjgzr
	 TS0UrXwr0lirmg7Td9DR3ckVtJa7hS2VRg5tbvTUxOO58PStaP/LHqiDxB4AamvE3y
	 xBeeznlnju/rmBqvUhMgOruVPZFcbamFpCvGiP+gKAtjWcNxZADHkNQK9qTVSG4Gon
	 DtSVIjiML2fHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 11/16] cxl: Add CXL Device Reset sequencing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261001092227.3004747-12-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-12-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:18:26 +0000
Message-Id: <20261001101827.63A6C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Implement CXL Device Reset for eligible Type 2 devices: disable CXL.cache,
> perform supported writeback, drain transactions, prepare the IOMMU,
> initiate reset with Memory Clear enabled, and wait for completion.
>=20
> Observe the 100 ms post-reset quiet period before polling Status2, and
> treat an all-ones read as not ready. Treat Control2 command bits as
> transient state, restore cache policy on exit, preserve the primary error,
> and abort when IOMMU preparation fails.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D11

