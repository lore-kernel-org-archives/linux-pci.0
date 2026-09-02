Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41743AD50D;
	Wed,  2 Sep 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334642; cv=none; b=L8gLlguMagv35olqcL2pKQIVWUovAcK58dpyETo+saiDvdRT07E3JuX2JQce6XEuTR5YtsmBal+kBCTGiGV7eXDlxr7peXetzU+ZSoSP5osNz5R7Mw42xcYmd5l4umSM7ns92PeLiPgAI3nO6+hzF7CcibMNularMs9fKlz5IWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334642; c=relaxed/simple;
	bh=BuHsCgDUSFuMbs1SQc434i2Lq8w34OpHb4OyYv9vNl0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BiLNgzGj/9r2XZfnL361QrJRqWApX5/UwOa/M416bzXIx5CZaDsMu+4oLxYxdDf3rVKdZDYZvWvpzMdBpjWyP7YgZvm7WpB8pDkan4p7yaUSxmDIs1sNf2wr8+a5Qs/BPyTUb2ce8o/9Zup29BzF8rY2oTYk79li/3eXj+hfgLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J06yknaf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J06yknaf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F261F000E9;
	Wed,  2 Sep 2026 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334640;
	bh=BuHsCgDUSFuMbs1SQc434i2Lq8w34OpHb4OyYv9vNl0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J06yknafG8vCKoF9xXi8s6T1ujs8YMNbSnhyn5z/R5CWebmscoat9R/NpJhoxTcNv
	 Lrhcm95EYus1blovqIRXu4SyJfrqDJ6hEdjlmYUezJS5XxbdZRmYUScbd/w4W9Yvxj
	 15o3d7HX4FB0zTQrpO81LBXcP3iWxzttPEXU0fNcjVLxHMcNEEefRgXfZa2NTX6YFO
	 V74ytFeH+0pMDH01zl1ngh5PZoU0FPbR9hWi/zommtYLifY2tUWwqjKrzY+hw/M+pX
	 D5EtD3pFNvyrSW2EFczXJXhkqawlB63/InBgaYUwEzJ8BaSLzF1PoF2a4ESV05mTn7
	 ljeJdjGkaJkiw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/12] cxl: Make HDM commit helpers available to
 reset code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902072804.665639-3-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:37:19 +0000
Message-Id: <20260902073720.71F261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Build the generic HDM resource helpers under CONFIG_CXL_RESET so PCI
> reset paths can use them when cxl_core is modular. Export the lock and
> commit entry points consumed by cxl_core, and leave resource.o out of
> the mock cxl_core module once it is built into the kernel.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D2

