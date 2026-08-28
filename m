Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B635B657;
	Fri, 28 Aug 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937344; cv=none; b=IrJysl7ogkoF2XCNNgSZEFs8kYSlXWnXSjWP33M+AJb+lD6Pe6rnJzVor7P7ry3IOY2VbYfIeCJbSf05LRkDK/teUG/0ViU1q8qOrVpe1qT6/xF4jOt2nPTc+/5mobhHkuJiVi2zFG7pcaLbOz3Uq4pldHeuwAd/yyC9DNVpVII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937344; c=relaxed/simple;
	bh=a1Crwzrj2OloYF5AdNLfpJsEzELNuZEkPLpHGTxbL7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kMc74CDWM4EK7S6jC1wXJknRs+szaC/ANXC9npk/B/Y2yj3aP/gcGq6CDYn/zOyKItV+8BgSJZ4B1vHDYpvGJGvFJ14/XQiGe5+f0f0fB6dpjATnYpwEwTF5E5SYtwNyQdxgVFlcdTlNDnu5pwGrqB9hZc+J5+hj/hAFniLEKF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJqQffIN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJqQffIN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D121F00A3D;
	Fri, 28 Aug 2026 17:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937339;
	bh=a1Crwzrj2OloYF5AdNLfpJsEzELNuZEkPLpHGTxbL7A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DJqQffINM0LKslMh2UgC2qTfu8YHwdFfGEAiMtfJ1QXSfrmMKN2P9k/wMP4/m6TOj
	 Qt0OZ7pgKqq7iYxp3uPfhKB9VwbKW5MlpbUalIE3fSjppBM5DpY06sfgjfBkqGFfD4
	 6wnPXPmiG08AKledkSKwkkFxqGGdtbyEkb76t6ej9qX2cH/nMkyEVJQrmEcokkZzGn
	 taMMv7QwlES+roPj2pAmANwOdGbh0P9dTgxCeCkj3d3UHB71mL8jsN4AxBewZz3+fs
	 zrkFcQTL+RdN4JWu2yNg0RrYegLWy4KDn3zHrSrVrfrQwoeEr7ttXg9TqJ8xH2YgH9
	 I6BUUFG0j7U3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/5] PCI: endpoint: Add DMA auxiliary resource
 metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260828170932.2735807-2-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-2-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:15:39 +0000
Message-Id: <20260828171539.A2D121F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Endpoint functions that export controller-local DMA channels need the
> controller register and descriptor-memory layout.
>=20
> Add DMA control and descriptor-memory resource types. The control resource
> carries the register layout and channel counts. Each descriptor region is
> associated with the static channel ID assigned by the local DMA driver.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170932.2735=
807-1-den@valinux.co.jp?part=3D1

