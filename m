Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087953BBFD8;
	Thu, 10 Sep 2026 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024714; cv=none; b=GYZ8jUXy/0SHmK0X7R85BSKB4sgl78CD9PisBm/DAow19an5rR6eWiLR+b4+h+rVRBxyf+9KoYpO7Qy04w9AC64mKK+JzoIfiS4AJhahxDoVwRuhq1Z0PQPXAZA2EPkxMIcP3tuF53pCWrTCsf3o24KMCcC/cxfYbihB/3P1w6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024714; c=relaxed/simple;
	bh=nlMsLJGcWJjaCx960fcmF+fuHxPz3JpkgIFGcJXJi2M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E53HQ3p1zwdcaYJKlDj14YeXaq2pbS4FshVIyVrzmUTdASP8+OlnjSuUHA4p/jVR21ZyR8HNpseNdAZWlbhk4W3i500bAOOR5rVNrBXRQdtE+lqHEI7PhHmJHu2+WDuynF6hgQiIHf5DB/9E+FMQvzEd021mmnaBoqT3zjNco4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hk5CyzeF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hk5CyzeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DF5C1F000FF;
	Thu, 10 Sep 2026 07:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789024712;
	bh=nlMsLJGcWJjaCx960fcmF+fuHxPz3JpkgIFGcJXJi2M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hk5CyzeFc7XxZ+oSsk8zqZ6kSwXT0crbU9m68u6V9XzCQMtYislhBEnLKtZYy1TcU
	 aEp2lriSCAmciYj44exUjlYYSK00kv2w0UzS/DHvmFZ+WtCZOOEcZmfIHuOA588Nvs
	 4Amam97adtqlUbQ3F7I6NSGmStGeBxSKFvd/uKVqF8C8cEzfb8pMzg7YPFBid7bJDl
	 S8CNElgPM9uVi4WMg/AdGN0eLppLPJ42LLHHsb7ac5itMNCyeASmgCy8BrWXvuv0R/
	 DMDfFvzzMImQM4ykcQSFvPKaPtNOPoUUpL7ryxyVzml+n9NGhLa5xHrnLdyzmz+KUC
	 06Lm/wAmuQshA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 03/12] cxl: Share HDM decoder decode logic
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-4-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:18:31 +0000
Message-Id: <20260910071832.6DF5C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move HDM decoder register decoding into a helper shared by normal CXL
> core enumeration and early PCI HDM cache setup. This keeps validation of
> base, range overflow, interleave, target type, and enable state in one
> place before adding another HDM parser.
>=20
> Keep caller-owned policy out of the decode helper. A committed zero-size
> decoder now decodes successfully, while init_hdm_decoder() retains its
> existing zero-size rejection.
>=20
> Preserve endpoint DPA state ownership by using the decoded skip value as
> a local input to devm_cxl_dpa_reserve(). The reservation helper updates
> cxled->skip under cxl_rwsem.dpa.
>=20
> Reported-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D3

