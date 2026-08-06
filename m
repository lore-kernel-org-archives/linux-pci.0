Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6C44C4EF
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786015957; cv=none; b=THl+K5c2Y6FP0Qcxq/clLh8QNx2z3kaBPLnkVw/wOiKD5dm2NCKrwmm1dOMFLQ2xnEyieFpRVVOs+d/x2WoOY/v9FnfbbsuT3jBsux/m+xwdmd/NwBJFSIDH+DfJRurRbwzhwaqYeMbwMHVAPg1Kh0S1Fn/KHKtahSTvrT2BXcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786015957; c=relaxed/simple;
	bh=QV6JdefkH/DMU9HU7BTtV73cymDzRXGJoxsOr9iniPA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i+AX1D+JIHltGUTpg5HX0XHd3Z8kG+sNGo5W/bWr/wmMqFPPRvlU/9YvgrMcPPfQk7kHvNZpFt4C2sqt2uEe8iBrY9WCNr+OJKKrSQaSEMCImZNczbQsMSbBFxoIWKiDIdmCCGyB7XDiakLgjo4Wz7/ZtWqAB9qyvkPzg0J9o44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gaYJvBPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gaYJvBPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC8651F000E9;
	Thu,  6 Aug 2026 11:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786015956;
	bh=QV6JdefkH/DMU9HU7BTtV73cymDzRXGJoxsOr9iniPA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gaYJvBPu5AEqcq/4WkAbfvBSuluNHIesppBNvxSF+EvvOEaPRI5AizsqUNGTMnLHF
	 Ks33c0wphX6Tq7epx9QGtzqTTBjDux/zQVdfyv7K+cYZmQOT6HbeS+9m8h7dBRPIRg
	 Iu6JTmqbBP8ekFQLQmMqwfSnHb4ATReHSje3af0mVxk84oh77WvV67h/pHINRxJNYK
	 htCMrl9W/rmHUf8Eput5bXJWgk9oKxqTgxqTKsTKrungqbMUzYQqlabFK1Z2s05Nov
	 7DFw1Xjym0RBiSW3ltxQo4IH06o6QL1iCzTIOJwr17tZxFRhO/AT5OtlvPUOFjeGHU
	 F9ManSKwS4gEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] PCI/P2PDMA: Safely terminate ACS redirect
 lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806-fix-p2p-acs-v2-1-0cec14812965@nvidia.com>
References: <20260806-fix-p2p-acs-v2-0-0cec14812965@nvidia.com>
 <20260806-fix-p2p-acs-v2-1-0cec14812965@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 11:32:35 +0000
Message-Id: <20260806113235.DC8651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
>=20
> Use seq_buf_str() to terminate truncated output safely and remove the fin=
al
> semicolon only when the buffer did not overflow.
>=20
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806-fix-p2p-ac=
s-v2-0-0cec14812965@nvidia.com?part=3D1

