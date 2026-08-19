Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA1537FF41
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787138225; cv=none; b=EPh9dvrS4zyJYvPnug2wjrq2hEntXvOI+ukydrEoNFlCJQFJHqAyvxGoTV2tQZHivw1/5jJMyvulE3HxVH9qZzjjDv1lPy1IfCP8CYHwmwI7RSZcTgF/Nd/eN2Xqj8iF5AjsT3xj6WX9jxX+BPu+KU+NaHNXEyw9Thqcdg7aD9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787138225; c=relaxed/simple;
	bh=7QMEZXtcVFWdFxCjS+LVDb4f5q0u26f8UxKETSGJR28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtKzkk1EgVr8Dsa8MAbC8I5+9THinqpsZPU5PHZmwFFMC/sj15Mu+BEKPvCqdsIzVLx53cIzUC3DOWMB7iQ31IL0P2R6JPg5yKgxT8yJOyinjCqS21jVmdbUOPPbhMykVJNfkO3uBm13yRZG9R3wPKov2V8yDjdMHGSG2HZhDO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PM3BM1yX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PM3BM1yX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5513A1F000E9;
	Wed, 19 Aug 2026 11:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787138224;
	bh=rpWPXVxzyxM9i3G0ilZk2iGJ3Kmn++Z5KFJ1T98nfpc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PM3BM1yXn1CvmJ3CT/wWUQQlCx5slzKqlIOqMVRgfG0mSvV+TKMSScNRaL203EeW1
	 bg8n7TrXGgOiZMQcg60TTtprKD9FIW46twY+f3VG//QKsruCRNv+4T/pu1rKYu2SBO
	 c0GBeK8dNX2e6XTSckrZ5hwrtsEcsGdTrXCKnp3276ZJgOSaZnpu2u2nXkrgUJmvxt
	 ZjhwiKtTUkMmtZ6/ftlXlumQ0y1i9WsH1SEbsud+xgEgces4y3Fw04ZgV40cB9mPTN
	 5AHqs9sLPT2duwu6hCyowpOEmd89JEK1t/KiL+97B+1D9CYLC1mdruZj/91hetND2r
	 9/clxt+vEv0bA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/16] drm/tyr: specify base type for registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org
In-Reply-To: <20260819-typed_register-v3-8-3699a75fadf1@garyguo.net>
References: <20260819-typed_register-v3-0-3699a75fadf1@garyguo.net>
 <20260819-typed_register-v3-8-3699a75fadf1@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 11:17:04 +0000
Message-Id: <20260819111704.5513A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Violation of vertical import style by adding a separate import stat=
ement instead of grouping with existing imports.
--

--- Patch [8]: [PATCH v3 08/16] drm/tyr: specify base type for registers ---
commit 34aca3035b4614556abef99eebb9d34305820b18
Author: Gary Guo <gary@garyguo.net>

drm/tyr: specify base type for registers

This commit specifies the base parameter for the register definitions in the
drm/tyr driver. It introduces and utilizes TyrRegisters to standardize the
base type across the register! macro invocations.

> diff --git a/drivers/gpu/drm/tyr/regs.rs b/drivers/gpu/drm/tyr/regs.rs
> index a62724378ced2..0c419c4e1186c 100644
> --- a/drivers/gpu/drm/tyr/regs.rs
> +++ b/drivers/gpu/drm/tyr/regs.rs
> @@ -57,7 +57,11 @@ pub(crate) mod gpu_control {
>          uapi, //
>      };
> =20
> +    use crate::driver::TyrRegisters;

[Severity: Low]
This isn't a bug, but should this import be grouped with the existing
crate::driver imports above to follow the kernel's vertical import style
guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-typed_regi=
ster-v3-0-3699a75fadf1@garyguo.net?part=3D8
