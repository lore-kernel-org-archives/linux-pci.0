Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93F403AF4;
	Fri, 12 Jun 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282791; cv=none; b=bQeU7Q8PiQiEI5pHWExZv3nCHE6MAI3PUThCflWPCDHD9XZzuiMbVeW/ZkeHo2jDlTuQyzHX+Cjag3O6cwN8PPguDxBu+OjtkAhbCTKkCagNvK/OF0HlH/fWfscXDLYAcVGoQZvmbSPGZsvsLvjjU75DhkPy2w5N1O3J7qJzFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282791; c=relaxed/simple;
	bh=z3cN2YNTSqj1GppNhVITMb01UlRSfK533h86PTstYe8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B9GHlCayq4ByMu+nHy/OFvrmmROZmmi3jleq/gHqnxiECVZHv1fqsxSHTSal7QkniYDtkltPi3T9csgnq7abPlErH6JUSrkoB3zgro2CZkKNqhaTJt224sQADQuaBLExNd034v5z8xjufg+ueXratA5oLNoBe3RVQKwOutVawOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuTbxKr4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuTbxKr4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EA51F00A3E;
	Fri, 12 Jun 2026 16:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282788;
	bh=z3cN2YNTSqj1GppNhVITMb01UlRSfK533h86PTstYe8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IuTbxKr44MkWBs54JcmT2WddU10iS17yV0rdIfw3Y4Ql8jZC1NXfYBLdQMTEdaPkD
	 v8tJKzfSbEsZ25prYg5v9daA9Cr1gaCY1KOY1S32INra1cNSz27BUCY8ADsnXFYUR9
	 21pvTMvci/EqXeJTfSIe671z1vzaS/+736SrtxDHk5yAek1heuZEfg0Yov1YPsXz8Y
	 iKjG5o2AWPCOq9DORioT7zsc7eJuB18/j66Cvcho1Cal5oOW3He9OaGIKl0joU7x1u
	 EeNWBxOgPqBAWHOwpU68VB3UwVOdhUZe0QnKUUKg1v0A47H8JF8pItDSkIPsAxqb9I
	 HjEPlF3+qtB8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/5] net/mlx5: free mlx5_st_idx_data on final dealloc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260611161546.4075580-2-zhipingz@meta.com>
References: <20260611161546.4075580-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:27 +0000
Message-Id: <20260612164627.F2EA51F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> When the last reference to an ST table entry is dropped,
> mlx5_st_dealloc_index() removed the entry from idx_xa but leaked the
> backing mlx5_st_idx_data allocation. Repeated alloc/dealloc cycles
> therefore accumulate one struct mlx5_st_idx_data per cycle.
>=20
> Free idx_data after the xa_erase() so the lifetime of the bookkeeping
> struct matches the lifetime of the ST entry it tracks.
>=20
> Fixes: 888a7776f4fb ("net/mlx5: Add support for device steering tag")
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D1

