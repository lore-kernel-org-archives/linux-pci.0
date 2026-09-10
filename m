Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6712D3A7C;
	Thu, 10 Sep 2026 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024816; cv=none; b=TbPV0IQQ7Mbgbo5M1PyEsKFAyTQxnT1ddKp6qh9BkzMu15zEJOi6z6jVw30L5OjBQVdZQmdzK/956ltEr4q6Zjqe0AqaiHa+vSHAa2j/qYZSp8nFHQYfEjPYNdANCCGwUnAz3+PioicNrzsIWBPCj7kb3c7KaxKiNE4trubxgdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024816; c=relaxed/simple;
	bh=Kpjwv8sMBrBkvDYWeiPEh0xW8VTgbn6KY5VtFyj7Rzc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=A1W/U7qTbSr+xp+vETQL/YQ7O7kNY0vUnCgxQ5GVmHRb6QqPBDdM5KyPeR23riyoXYDyzjBSCdJg9Yz8XMjVzIFZy2eZ3G2Cw/2mZzcRgy+e9bVmU+AXbcyFv+wUTYjsFYvzFkkurRmFRLLjEG5jwrYgE25BvRiqYikL7R8ATsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCmmgPMU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCmmgPMU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBA391F000FF;
	Thu, 10 Sep 2026 07:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024815;
	bh=Kpjwv8sMBrBkvDYWeiPEh0xW8VTgbn6KY5VtFyj7Rzc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RCmmgPMUjlIUQKcbmCsHEpRxQyejITzOxQrxDtFfrpYGFSDnEoNLxRv8nezdOlAJY
	 zTYTYIpUqTma9SGgqMuNabeDOBegQbp9Q95FQGkCAvemet/FfQX9OH9BBev0DYImNX
	 A1cy9Fy+ctVxS54gl3/Y3GXYrCN9wFFHXmJQW2Uy73lE6Z4HMrKDb0fzQj6G3ZDJfU
	 nBZciqtfhvUnk4D68lIP7AhDFBw9gy+cGqLV0xYVl2n8PN4PtWAyM8837FM544Xjxl
	 LFlvpFHZepbdrSF7EbLcGdjeZvqRRnRAmnACm+iarHtLyq3gHDSGbSvXpTYUTZGtpu
	 k6n+chqYafzxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 01/12] cxl: Move HDM decoder programming helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-2-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:20:14 +0000
Message-Id: <20260910072014.DBA391F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Introduce struct cxl_decoder_settings as a snapshot of HDM decoder
> programming state. Collect endpoint skip and switch target-list state in
> hdm.c while holding the DPA lock, then pass the snapshot to generic commit
> helpers.
>=20
> Move the low-level settings-based register programming into resource.c so
> later reset restore code can reuse it without depending on private decoder
> types.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D1

