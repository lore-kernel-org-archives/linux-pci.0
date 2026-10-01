Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A06364EAB;
	Thu,  1 Oct 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790847438; cv=none; b=QmKMRMd883gcvkGPguXBy9lqgxb0RnGlz2KQMzpuC9NXYlo/lM13AbejceZgfZl8BGR8dp7zgQxJ+7VEN1ImhzyQvlF0ucmGOzxqMW02Dz0ManMmYp5DXdcVjx1PXJES4Sq80eRGBSAX6C9cOzW5R7HyuVfDgCebVyDnSzLaa0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790847438; c=relaxed/simple;
	bh=vdcsVkiZRdwc9g5/+1L4Khs/u2zqs60vYNDVuDLFSa8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V8pyC6JfwWcLFEXP4UeoNillrK+bpfGe1YJ1gUgvAEBWOKrvCN+u+GS32yptE2efm+kb5tQoKVP+viS4jMIyHJ2QTa3gKpzJ5ivzHm0BmafvsRUVee2mJanmTn/2r7FJDY6RhtGu7fm0B2e9pP9j9mP47LSxwFsQnIM6Su1vJbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CIiFCOtg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CIiFCOtg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A22E1F000FF;
	Thu,  1 Oct 2026 09:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790847437;
	bh=vdcsVkiZRdwc9g5/+1L4Khs/u2zqs60vYNDVuDLFSa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CIiFCOtgA7LPW9oGw1Swa9S9BKjnb7jgy82WbuK5W3I7apy6FoGTKEtLLvWh+1CD5
	 lpvYUep/NSNEdRMlGxj3HHnrs0leVohj9o7/YjtJzEGfuhkbuuZCwndq5JtAwvSr61
	 u4h7iWDrQ6WH7xnM3hTJKPqss7/NPrgFFiy975GGsHZcthj+SmeZTmJhsrnKNGmRXB
	 54Dn40GqPYx4nBRNGtaRWQ/EOsv9L+MDntaK7/rds+6V6bwqVT0G3FGpm2rFWlj1pr
	 2u+WEunojuBRXq/o6O01Xc0955iwAGngF+9t/adtXaq8aYStJwBmPRR9LYPzaUwfMD
	 nQO7jxDtLx1rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/16] cxl: Refresh cached PCI HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20261001092227.3004747-10-smadhavan@nvidia.com>
References: <20261001092227.3004747-1-smadhavan@nvidia.com>
 <20261001092227.3004747-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 09:37:16 +0000
Message-Id: <20261001093717.4A22E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
>=20
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Ignore updates when no
> cache exists and reject decoder-count mismatches.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001092227.3004=
747-1-smadhavan@nvidia.com?part=3D9

