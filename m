Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22730437455;
	Sat,  5 Sep 2026 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788613189; cv=none; b=jGQcQ1hMdoVz5H+UQuvN8wFls3MBsK4/QcBzjqogGmS0uQiUC9EBpKdvY+tYJ6+2Juin1M0YVTUqtcmbFF6RG7NsTP3wIxcJvJ+hm3xDN1E4hvSz/2pfpGxo20Z64pmIm0DBKcCxBsvieA9FGTBn3d/wRYCSot3Hh/E0UOBzh6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788613189; c=relaxed/simple;
	bh=bBry9fZts1yq1CSc4GeI6QD5rxla071/BBCucqdhqgs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f0AlDXEUBPnGPU6I4d8dMPzCi28a3ViJI0tPTp7NgZS63aXVBpX+rNaLpjIuSIDipRdDhUTILVG4FkCtYdgCpjoQyJeHlTpj6PvnCTSIW8xEGYQKMdgHQeDBLqbKRFjn/KAbyn0YDcE1K+gldlwp+85B1M7m6kIfV+C2hxf6aZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv/xmwK4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv/xmwK4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740391F00A3D;
	Sat,  5 Sep 2026 12:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788613187;
	bh=bBry9fZts1yq1CSc4GeI6QD5rxla071/BBCucqdhqgs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Xv/xmwK45SBkJDbEtRUIMKlh3TnZ6ypM6dqfv8n8mNboQY97EXbBwsbq4GAt1LibR
	 jVOw9c+tSRqqwRb7tIBHMD400oE0fktyorvpmZTsg31O8GScGO4/Fep/c3sCxaTkDt
	 t2FL/PE+L5pw0/mirtCi+mYoimxgofITbj3GpkDBaHZoy4q3iX7RixbnY4aRK/dUqb
	 MMNve1EpNJl9XsEiblYPWyNQC9sJQ0WlLa8TCpA23hcqwyLAEA5ofqzsCxUs7jNR9v
	 VvPmBo8pr3csoQPPa/JlovBftCA+YytflSBHjd/8wPV73ehHT9q/CinvyikYJRTPpA
	 10InX0T2GAQ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/3] regulator: mtk-spmi: fix Makefile typo for
 mt6316
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Rodrigues Alves" <breno3011alves@gmail.com>
Cc: linux-input@vger.kernel.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org, linux-clk@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20260905125706.6550-2-breno3011alves@gmail.com>
References: <20260905125706.6550-1-breno3011alves@gmail.com>
 <20260905125706.6550-2-breno3011alves@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 12:59:47 +0000
Message-Id: <20260905125947.740391F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905125706.6550=
-1-breno3011alves@gmail.com?part=3D2

