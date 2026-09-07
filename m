Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938C4466AEF;
	Mon,  7 Sep 2026 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778748; cv=none; b=KE5jeRJoHSCxLtiJMorSCRysybXAyNF2xNs83TVNLRo9GCt+CVAhl75qGnf7GybjHO/VTlSDFoPJjviW6ODGotGWB0IduczCwb/ZXs0x4JZBICilGROTjZS9JXDtQ4tgkh4XSqpSa7MXRKdbLaPpq8/GPAsxitiH3nHgDQHjMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778748; c=relaxed/simple;
	bh=zQK0nozXCk5JvLwKfdzwnloni9Ljh7AhEDfaJHiy1q8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8MKNtw0cw03P9QDRtv8lGH5kjHPb4h5BrN3MsLjcoNxch/1MbKIiwbLKLJ5iynwBoNMJtUZ5MhC0j5tQSmGmfri+yBVP8g9n2of/OrvczAfDi/kjLHlXYjyfVQnGYufWFpQuIpKus4NcTRIn5kuxOmiFlQjDEwUDMlNg5SQ/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVLomuva; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVLomuva"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF66D1F00A3A;
	Mon,  7 Sep 2026 10:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778747;
	bh=zQK0nozXCk5JvLwKfdzwnloni9Ljh7AhEDfaJHiy1q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mVLomuvaH5J4OCy/Z+pt+klV002FPmXJMSiSclOFQ2vD15tDfZJ+h3wgdhPf1ofFE
	 NF5MQabNvzypSwuYBgXSeYJ1Xz914kc2cZa9+dxFQjlx593QnPJRx9noFIlPF9iByO
	 cih1JCUV8zfQNHh7v6CVURUQabxg0Sqj6Nor6YDh2H9AY0UGSjeCBTHcWSm4lx3Qwe
	 rkJSZW/n3hGxPowtFmahMSfL3NStzdssZjTZBUKF/e8cXrLUZ3E+un1Tq/VaQ06aFe
	 k1fj2nxtc7qzItGO+CNC/8iPuM3GciWkK/BlocyzwUBwAtz3ZyRGBJFvIsGKcGCtzC
	 mTI9+mggyKBHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] dmaengine: dw-edma: Macro order as per reg bit
 position
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org, vkoul@kernel.org
In-Reply-To: <20260907105453.1940646-2-devverma@amd.com>
References: <20260907105453.1940646-1-devverma@amd.com>
 <20260907105453.1940646-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:59:06 +0000
Message-Id: <20260907105906.DF66D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> For a register the macros providing masks for bit ranges.
> These macros if placed in order provide good view of the bits.
> Placed macros in ascending order.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907105453.1940=
646-1-devverma@amd.com?part=3D1

