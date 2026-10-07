Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152C942DA53;
	Wed,  7 Oct 2026 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368547; cv=none; b=DJgDy3HOjkEnv8jV/p/0oiBlwHC61qGTEaTOuTkhjGqlpWrmjfME9/TFbdd6oq85TQRon7yB/+5U5iBYkyTDrD03jDSxOxTS1u55WTx7DeSW+jfAFPrDUVZppRDWsygp7qzb+fXScI8+UGsqdtFz6gATzeUk4Kw0ucW9ENQ6YBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368547; c=relaxed/simple;
	bh=umxrsptqHW3apRAuMsiE6vBqqNF8RjMx4YWqUi88PGY=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=i2ZJe4YwhHv79kDevmx1E0NFPH1ttxQAcXMbyor4FE3pi01Lyt3DWSx5ExWTSpoLrjktP1XJV2OWNAHt4kbKKvWMDcaK1hJ/QWGWZRqLI1H9SHMsqcN4bkj7wna2TA6SRWE64FPBQf794Vn0HHx38dgtcvYk6ZNtK17cr9k/oqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7YjkhvQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7YjkhvQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9601F0089B;
	Wed,  7 Oct 2026 10:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368536;
	bh=umxrsptqHW3apRAuMsiE6vBqqNF8RjMx4YWqUi88PGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J7YjkhvQALk1XWEAIM0MjXkCpKAMHmsRt1XCK/hxqqLsVsfsHTVyMRlOsUeHDRevz
	 CgCxhiSewNDL+Sm9/ct5b5aZ0+GX7r8gx+6qd54He9vHDGz01T1fgNA+oTHWqqpQGy
	 zQXR7FvGzYLd6SCITdNPK6kzXJJhzSo+P3E/iINYWMxIrn6z2DGzIPbXhnV5CfU1eC
	 FCjMPwmYnWduNnv5DWQdv3B30IQMXKIsaFcqYDC1M70gs+ZrBVS2ZtRkKII1pQz++4
	 hxZd8ogFEySv7uvSdJt9VJfzF5a3DrKONnW8AhccH3gf10sYeImdADnLorxa9BiMaf
	 GrGMSShNBObQg==
Message-ID: <sashiko-outbox-162855@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v2 1/2] dmaengine: dw-edma: Sort Register Field
 Macros by Bit Position
Reply-To: sashiko-reviews@lists.linux.dev
To: "Devendra K Verma" <devverma@amd.com>
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, dmaengine@vger.kernel.org, vkoul@kernel.org
In-Reply-To: <20261007100336.4009004-2-devverma@amd.com>
References: <20261007100336.4009004-1-devverma@amd.com>
 <20261007100336.4009004-2-devverma@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 10:22:15 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Sort register field macros by bit position to improve readability.
> No functional change.
>=20
> Signed-off-by: Devendra K Verma <devverma@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007100336.4009=
004-2-devverma@amd.com?part=3D1

