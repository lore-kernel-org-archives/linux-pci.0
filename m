Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A523C5DB6;
	Thu, 10 Sep 2026 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024975; cv=none; b=poxYl197Vi4HSnudsJemxaSZSCajdh+ae5j/Wkbu6EDfPVE7e4NPBIJh9JPRSSD1fANxeluTqWyydMxYwN+Xkujv1siN0tWSbyWBu+pXMFgVXhu8NFcoS8l+G6d9dHGWJFuATNnUhBivGm+xQygPEnAh0/088pvuueLv8/rSMVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024975; c=relaxed/simple;
	bh=d3E5+Nugpn7JFsGIqYAnCkN+NB8mCGj38GT8XW4X00k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FFBZQPvYO818WerJr7iQUrXAKCr+rzohJFAmPwxEXGYIRp+u+DK71C4xYFfhVONrox70E4qGh1IodGZe9wVhuwGbNPokh5EBaWadpSFHHQiJxmkiNZ1QzOFw74OlQnmjgatRMKtED46wlmslkNHBMKIrZqIu2Ui2c3MAqPtVp5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xo6s3DWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xo6s3DWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C941F000FF;
	Thu, 10 Sep 2026 07:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024965;
	bh=d3E5+Nugpn7JFsGIqYAnCkN+NB8mCGj38GT8XW4X00k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xo6s3DWB4qDdTonIWzUDebnpJwwTE3rqh83bK9XgKURqkAk6KkxykEwDpfIqr4IOA
	 dn+7wjGFV8dTK7USkvf/c87usq8B0neQRd6tBgQ8NFsedcUJmNIypCkJ83LHmhmLRY
	 x8IU4H5VC2r++pQCBRHQ17zbOlAKBn35a8MiThqxi8l4lSWEuDlSFSF779FDzXYQoR
	 1VHVmDSQWQx6TpXupWK/VKG/hsZ8KZQ3Ia2WF4Q83dI+8mXPohJuoTtRmpsWWYW9Lk
	 L2kkhyWFpoOtYfWDRquZKuai7jRbpoRhtnzGZs02UgOxOFzrix7l2z88f1QSqha40n
	 JrG10spQOZEjA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 04/12] cxl: Cache decoder settings on PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260910070808.1444264-5-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:22:44 +0000
Message-Id: <20260910072245.73C941F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
>=20
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D4

