Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D8C46A5F0;
	Sat,  5 Sep 2026 12:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613158; cv=none; b=XoZTI6GAJYwW0yniVspwXQ4zjrKARXl0IaCRwzuRaZpm5N2o2CpwxNnWQCb6C0MB7gqxfDXq+68FjI6dXnrjiI5Nn1XD8DxbINSPc9+Zbo9IUz+pYV4jENQDBtoHwPjbdD4QI03FUEzQxtOL0+yZRodHrfhwSRIy8O/RFEfmSgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613158; c=relaxed/simple;
	bh=qvuq4TTR3chBmb3zIlfROWQbNfnnxy6h8ifzVnz7E4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZynLl8IvfQyTadsPGoW+GwHSD36wFbK0AttHXvFGyjUwfzG8H//y5FoCKO5clC80JLcDZyAB/XX3szHOQYXbKSd2p1bFaUBYEGl2OAHlGKO2uQzuBxC2g4mxnYKvDJpMRL3BEzqAx+hrMqcyepOjsYlXgzrHDFxCmtSxHTcWdmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ht5rZECr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ht5rZECr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFD31F00A3D;
	Sat,  5 Sep 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613156;
	bh=qvuq4TTR3chBmb3zIlfROWQbNfnnxy6h8ifzVnz7E4c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ht5rZECr7KMoSY8C5SxwQVweazGNgVcJgjRM52WAC54sWo9mnW7JCPknu0q4KVNRf
	 nX3GooXBsoHSedoOsONG/0V/+Csh0qTM21mP42ezbO+M8JLMyuiSCxDAzsZjtmf3vc
	 cCUSTYovdPTHcJwB7MoK7F3PQavXLk4UQekwHuDpDPmngn5Vz1s0ke+/OMKw9dtJzV
	 z1p8B/MCt9c5hFsXqfxHDKbRRvInMdTGGKgM/JW1uutSW9qy95UI4U4VyDxTAEHm4T
	 BoX5Bnx3K4N+ZNLBzn71jysOg6XeWJwsNiMZy52QKmXcuG30NHegOJVR2kSdC3hfBr
	 4brDlEpJ0uvpg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 1/3] interconnect: mediatek: fix Makefile typo for
 mt8196
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-clk@vger.kernel.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905125706.6550-1-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:59:16 +0000
Message-Id: <20260905125916.7BFD31F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Correct a copy-paste typo in the MediaTek interconnect Makefile that
> mapped mt8196.o to CONFIG_INTERCONNECT_MTK_MT8195 instead of MT8196.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905125706.6550=
-1-breno3011alves@gmail.com?part=3D1

