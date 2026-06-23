Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68DEA1E8826;
	Tue, 23 Jun 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205331; cv=none; b=UelaIXXNqxRxw2rzlODfG2VBgLraZ2OBPCk/47RFS+8Hj9VWnCiizHdFX7UyS/GCdyPA2N3D9LHTPwNB+1ZhIzA9OSwoy8Tcijozqo4t2cN8KBqmIqSLcaeGwLZL8LL3lzUHLnwKKlQzCNmOhm/sz/wWqklBqlgqOvfMlurbiIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205331; c=relaxed/simple;
	bh=G1c77IjbbZ5ExsfY6+jgULPPuA5WNrcKyj3tS2lTSNc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MsyadXMGv61gMB9+ZqFJB0cwBATNmG6T2KLXPYniVaAmqKwCEqAAB+Qm9fp872Ev/cwG0GFmLaUhX5r7L8iUMyV3dCM/tVGll2v1ljzszxJwyi5cnDGGGBcaQKY6ZUEaoCb97IQzEcYJ+L6q5BEe/esPtYh4aV0NcRsVrgXzpYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NH2xd2St; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NH2xd2St"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E051F00A3A;
	Tue, 23 Jun 2026 09:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205330;
	bh=XxJRsoUTgrNc5b477mpfeDO8DHwsy2D/uQ3mHp0tEsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NH2xd2Stv6m3iHrWWfRASK8+YgDGFVonEVhZmK2U/KvBV2Sh3z91mD8weXwcxyHEs
	 pSgdoCrQun4CjWe2VfzGrL9YaTQ/vBWYIDE6Cv2XNbQIYjO9/guCU3FQUCD/z4M+rQ
	 xzi1Ll60YNLE8vZU17voTms3NxmvnjUuqWNY2iAp78eUh/6Ry5FYNLxuqRvqYdteq5
	 xaWkxBjQ4ghr0eX6tjOVeqQhfqQAc0a93asguh+R0qrWxSOkMTkgVILWqsn+aefezK
	 F1QEF0TOhMZAGitu8aBezlZ03pnZQux4G4c/TA8wxJ3IOhveXEWDNCUoYKtYeRmy40
	 3FruzruDI75Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 05/12] PCI/TPH: Refactor pcie_tph_get_cpu_st
 & add explicit variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-6-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-6-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:02:09 +0000
Message-Id: <20260623090210.30E051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Refactor pcie_tph_get_cpu_st(): extract core logic into static internal
> get_cpu_st() helper accepting explicit requester type parameter.
>=20
> - Preserve original pcie_tph_get_cpu_st() unchanged as auto wrapper; it
>   uses existing pdev->tph_req_type automatically, existing callers require
>   no change.
> - Add exported pcie_tph_get_cpu_st_explicit() with bool 'extended'
>   parameter for manual STD/EXT requester selection, consumed by upcoming
>   VFIO TPH code.
> - Add capability check: reject explicit EXT request when device does not
>   support extended TPH requester.
>=20
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D5

