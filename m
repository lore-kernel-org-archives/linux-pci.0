Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573043F58F5;
	Fri,  4 Sep 2026 14:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530768; cv=none; b=tP5+Zqkkg6Wjsaf14fakl/no1MuGQqsIseDRty1Raxdwt2nGDGfSrCMbU/UQPCdspN/GXzmuxKdXFuCUo++Sni3UrwulHdcDRdDBv53TYxjBbJn+XGrr+VdTYMJnjlKgPt1gqv08dCK8l90OqNo5mVm51XRmj2C9rz3lopqc4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530768; c=relaxed/simple;
	bh=VpJiM6yXAVhITnLfDbD+WdOj5r1lj6leQy96y+W87mw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iGyJAWg/57wOZiGEd5Qg69Chu1QhzykhSWXKWTWUcxiDLLa+1FoDzw5UhcEnwwxCnEa9ay61NEz7cvG5f1PrpgqKsdfWZseYfSyNp6LhcvXtlUegNLC4c5vwmd0NRYu/dXlHt4s4MLXMIk7CGLrYAI4ER677O6DQfKSLgNiRNTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqJsF2wK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqJsF2wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBB1F00A3D;
	Fri,  4 Sep 2026 14:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530766;
	bh=Z59rNKIcJtfH0btLsXLZX3xer4PZePBPZAcEyJHqPI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oqJsF2wKpn30DDPvt0sReTFhjFue7GlsvER4AIimy84vLvyibTCrKu1PoUNyrm0o6
	 WDPd5+rTyaF2YeBz9jUMLv90r9JY3cGSO8KJVZHff7CH3/RVWJWLZUNE95UO5tGvmq
	 FyK6u/IUtqSXxWSuVyUCnkc1rAeeMw9v0d8zNh/In5HgjED6Xz91s/MtK7GytrsaN2
	 GMmfGl0H9mTTb5jh2P5NL9S3/FsKa90KQdEbc/b9Wgl5iBuBXVLRYwp+NaNSPDlLQi
	 zkfmCHUEUGUfpZqbRVXq8RvznnVIWwpkVS6d251ZzJ/rEbuWu0hLspGhttCXisu1v3
	 FsySnNrM2k5eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] PCI: of: don't zero flags in
 of_pci_get_addr_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Elder" <elder@riscstar.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260904134607.1856121-4-elder@riscstar.com>
References: <20260904134607.1856121-1-elder@riscstar.com>
 <20260904134607.1856121-4-elder@riscstar.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 14:06:05 +0000
Message-Id: <20260904140606.71FBB1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The flags variable whose address is passed to of_pci_get_addr_flags()
> is zeroed before assigning a value to it.  Skip the zeroing and just
> assign it instead.
>=20
> Reviewed-by: Herve Codina <herve.codina@bootlin.com>
> Signed-off-by: Alex Elder <elder@riscstar.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904134607.1856=
121-1-elder@riscstar.com?part=3D3

