Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12F336402A;
	Sat,  5 Sep 2026 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617026; cv=none; b=dUBwI4O4Cj0oCuXwgjxyt0YjjDbkW/GGGzEQ4yCtSWSvYClSSafZbyEd4/KUB6xgp6OFGs26EH8dX2wlCaticgLICdbjIwtRSxyhmA+ReUdMs+kD3+WxhuoGec8C/7ve2nUfGuJv8yfJgkkhW0Y0WGEBaM8v9Gmvihzge+ig0h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617026; c=relaxed/simple;
	bh=oWawZU8yNxp5DPGZZcFIPliCLuEem0bcDKzewpMVi14=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RahF8Pu3Vv1e905tClFnEzzAXc0BVpdE551dHd07A4Nz7UE0DUWKXDaPzQHoX1ussEBeKLRvzzW081U/9qifDypEqbdQ7v6NUelQZAp4O/XO3FEVdhn17Ihcx0glGuCXh+cE6aXYipqzD8DvHXeoQP/3Wf0YvSw5gWkGvjrzWa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4tjYLlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4tjYLlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB751F00A3D;
	Sat,  5 Sep 2026 14:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788617024;
	bh=oWawZU8yNxp5DPGZZcFIPliCLuEem0bcDKzewpMVi14=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e4tjYLlFpmrA0KPQv1nDRggTxGvxOkRugf39I/Lish8bfakXE9wdxMswnYt15ZCt7
	 fcg8xqHfAo3RpaLgFB5ZDmxR1+EFwuNibanzQmiFIt6cR5SWjeuB0Dyl/J1zEhiQxO
	 4ZV/rpGIv+qBaBQjtMl86uqIN2uRwl0GG/UhRDuyiDyq0+z/vaa7sRyV+SzKDTBZPu
	 BoTB3amO7DCUtW5V/LuHZ5auFgLeXKcRPRnZllvERolODbb+XzMGduAFxourpVUYhv
	 uShqAYj/gcrPjbVQbLb4e5DA+pp4SNaUjsZTuXAsdACEcKgfjtc/fvdldGp5Q08HGy
	 WbapBRAAYIAow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 2/3] regulator: mtk-spmi: fix Makefile typo for
 mt6316
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: media-ci@linuxtv.org, linux-input@vger.kernel.org, linux-pci@vger.kernel.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905140113.21638-2-breno3011alves@gmail.com>
References: <20260905140113.21638-1-breno3011alves@gmail.com>
 <20260905140113.21638-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 14:03:43 +0000
Message-Id: <20260905140343.EAB751F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Fix a Makefile typo that incorrectly placed the mt6316-regulator object
> under the old CONFIG_REGULATOR_MT6315 configuration flag.
>=20
> Assisted-by: OpenCode AI
> Signed-off-by: Breno Rodrigues Alves <breno3011alves@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905140113.2163=
8-1-breno3011alves@gmail.com?part=3D2

