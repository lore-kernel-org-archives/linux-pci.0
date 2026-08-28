Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A08536606A;
	Fri, 28 Aug 2026 17:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937269; cv=none; b=mshjcaoIC8I/wfKMY/K+lM5Dd4SDj79lCIOe3S6Gc8UBBEJkmrsNt/hbtgvAtZ1yyyvf2mSlfOuQP4YbnOc4fRFJxHK5Rvz4HqY3KpEEJZF4oRjN02ej6igbndcD8OXcJxV4k+MGQsEMuoqbrJDsJMNi6ocxa7CUOr9DcmRWpNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937269; c=relaxed/simple;
	bh=H6WEAeQWugotvwKIE3cA0+aRloKp3S1TRkEzT21cu9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rpur3iaJVzWZyVvS0HgPrabVkra38175m3s0Kkgs23v98x9rmBxLiupMmAQcWcWIkDZk0nLQUV9pv4wVkY1LwDUf+FJzWM2L/trptYfleK68EXOg2OU7kr5psl6ZJ2E6HxGlRS5bwZma4RVkIJtn/oU1x/5wO+BaFXg8MZm5vRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0LT48Iq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0LT48Iq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5361F000E9;
	Fri, 28 Aug 2026 17:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787937268;
	bh=H6WEAeQWugotvwKIE3cA0+aRloKp3S1TRkEzT21cu9w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O0LT48IqlKMohMesP03VQUuZMbwTb2v5movu4O6BLkR4IdK2XQbt/vO56AO32jpa8
	 WY1b9qO6+RGntDVwEXwRW7ozzrFJaFXMlu11g4bSl3npPjOBxUAvoeBAiBFqg+HKts
	 fcymNoslbdv6iYSZWMImG+EmQQ6jWoZ7/xR75MpqWJ7/QlmOm+0qxIw04YBL48q/sD
	 3mP8XcX8Hp8SoTzNkmf+gD7Q+MqZseaQEn+V+SJBeumu2OlacqiEGTCg4R6snQFZaw
	 twrCYR+3BBaDoJr7Q7d2T6uJ1lJsJ/TcjHUXKtoqZDevfCmi5tpPALH0NbihqTzCAS
	 60ucvDMzB7u1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] PCI: endpoint: pci-epf-vntb: Move
 epf_ntb_is_bar_used() up
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org
In-Reply-To: <20260828170932.2735807-4-den@valinux.co.jp>
References: <20260828170932.2735807-1-den@valinux.co.jp>
 <20260828170932.2735807-4-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 17:14:27 +0000
Message-Id: <20260828171427.DB5361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move epf_ntb_is_bar_used() up so later BAR selection code can call it
> without a forward declaration. No functional change.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828170932.2735=
807-1-den@valinux.co.jp?part=3D3

