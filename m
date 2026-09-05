Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C0399018;
	Sat,  5 Sep 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788612009; cv=none; b=YRfe4I5F67IsTNym+edI8rHStQdtz3vLly1rqc3iacpivBO8CByYet+rtEv06jgp7JI+wCWmFKbUaFJ2wYWxyW72Aso94dBjsNvoUWZ6HNOM7szWuqZlvJCCN2nLGtRflhjrV0v7rRo+1QYV9jjMCnj53CGzWZXQJRnx237mM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788612009; c=relaxed/simple;
	bh=XITF6sOE6UTRduCSaBpEtJ4ErTUqB87zklG9ZsSf8Tw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TUCQdO/Ast/CZtZCmTSa/uEMV+BoN0Z1XAHrDTsjeDLrLdsG4w0MJEL5KkEMwja0jbfoUIsMNNHPJHOmAEVg00DaLGKiKo2y8Z/6GG1SBM2Jsiq8YKLbCH+BS6y13jxxsyoefQqB0P8o2xw0VF5KZ8Qnd5RfdYJLjnisUJo71Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzwNico/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzwNico/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79401F00A3D;
	Sat,  5 Sep 2026 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788612008;
	bh=XITF6sOE6UTRduCSaBpEtJ4ErTUqB87zklG9ZsSf8Tw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzwNico/W9bUT6GJruNV6tXwEFjtnBerE6RoYpPUoohPqZK2h5T3NEQuGGo+FdfQW
	 htdIdOvTIKssbRwNOOJ58S7Zc4QRAAViGkTEQu+SVgGmZTYstZGFRKyFYPilS2uBwT
	 iCIxAV6Qu3VawtrHssMV/fexWKLNqsG8bWXuRKSLKUnD2M5kvQUVecnkuS58ENo0jh
	 Lx99RON4eEeGZysMjgpjunopRCoNXDmppm2g8Ndb8WTuZhCe1eXTXtOOTC9gO33yqc
	 Ydx5QIndz1SEsBiibPB+6m+pJQvDD5XXfH3ZJ5G2If3uifNi2CvgnwD+UhqB4nRZdC
	 Vm0lGVyhWf+qg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] tree-wide: purge verified remaining legacy ghost
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, dmitry.torokhov@gmail.com, linux-clk@vger.kernel.org, linux-input@vger.kernel.org
In-Reply-To: <20260905123450.5620-4-breno3011alves@gmail.com>
References: <20260905123450.5620-1-breno3011alves@gmail.com>
 <20260905123450.5620-4-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:40:07 +0000
Message-Id: <20260905124007.C79401F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Clean up the remaining dead Kconfig weight from the tree that gates no
> active driver code, and remove the dangling comment inside drivers/leds/K=
config.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905123450.5620=
-1-breno3011alves@gmail.com?part=3D4

