Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A305221D7;
	Tue, 22 Sep 2026 08:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066865; cv=none; b=TPUB680TYoSqnD7Rl/Z879DmmYdT0gPG7HJuLnZkwyLsZS6LpXi8ji+O57HEKUGhONFi37UyA/0F2SyPKeQ+NVw19BEwHWHsw5OvpBW1LayvLrcfqsMGmTyUXvdfBT2gg0hy5L4+sL1sqnguWTedxUgbMIApLJmCwSOnQjnWpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066865; c=relaxed/simple;
	bh=EfIGzSlq/47OhWcPxvhjNesPPke3sBBgRyXwBQZSVP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=S4WZl6FOh1BtV9n0+MCZYKzMYbz9LB53enb8SOy5dEIyHf6t9FySdACYDfRcIquvtYJn7+PpM0rRMaviR+fknRvjVT9VX7feWH2x8hYq72l3N7v7fpatR8wZluNzT94xcwSNv2oSVnnUE+dOMw0+d0ft0LMxcgZtHkirFOqJA6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y/QYXNph; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y/QYXNph"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE331F000FF;
	Tue, 22 Sep 2026 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066864;
	bh=EfIGzSlq/47OhWcPxvhjNesPPke3sBBgRyXwBQZSVP4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y/QYXNphu44I9U0koB9ProrLojtjnB33gD+F0e94Qd9ESuzcvZW6P89tfCwdGjZNx
	 VbX/mKQZKD04EhiMhkliIKPy2P8zFOreTiV+SnvotMB2oauiwQSam65RX35Oppg/95
	 r6TmaXyZa1H0BmDs4dX6j57EyZpwyvxBg+0hNbXqN71WakRuP9igF9bZVAYXFhOMIw
	 gjbtH+em/XrZmHc+Wuq6LWD0Mz7AYvZvc8fR/4Ts1DesD89YdbUO3WeiNLkXFGuKmY
	 X36GrWKMDZTztjCgVwwCz2vnHJndy5UinDPMSoaz9Pf2f+eHMe5p7jhMl6QlgKh4Sw
	 PJ/3ycqZENYJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 05/15] cxl: Introduce reusable HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260922083924.2451158-6-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:47:43 +0000
Message-Id: <20260922084743.DAE331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Represent HDM programming state with struct cxl_decoder_settings and pass
> it to the commit helpers. Keep endpoint skip and switch targets at their
> call sites, place flags with the programming state, and leave runtime
> region ownership outside the snapshot.
>=20
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D5

