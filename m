Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9497541F35A
	for <linux-pci@vger.kernel.org>; Sun, 27 Sep 2026 17:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790528420; cv=none; b=mPd8LfiCQKrHtKqe0amYgpmUNTTP/Ew95oitfTBZ7XfixmI5WLYzK9V/IbSOIkOzfQFMJxfvTbDfbNIgQuFM0qdiOCP3vKDz0LBt9ITrpqZoYbD9FoDa67rD2pRYLXdVLfu1ox2X7FnVXA43n2epPfAI62oPVbGdTXg11O4f9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790528420; c=relaxed/simple;
	bh=dL3zK8dBE5WoQTWjMcIOBCwqPV4iaEevL2z1m9LJR1M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DzgyZcvCDdhu2F+sBKm7leEAKccrUDwp6qwcH1AnUcVmTf0Hmo3U18XBqPhK/+kF7qMVlyzi+WszKz5kfe6RHIVFnnzAM28h/q2Ja+FpV8YAHU5xjwI6RUrDsBBUnqc3WsFm7SXonvKZ+YaCwhxsOk91DcjxQ3JqBL5GYm63aWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASpwAk3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASpwAk3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A0E1F0089A;
	Sun, 27 Sep 2026 17:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790528418;
	bh=0vm6TOPwTTj2Yu5YDTJR8uk82ib7s8UAgJ3ckMTy/mI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ASpwAk3BujgMl6wTeMKdScG68gqQR4jDR5Sv/YE+Sh9qPq8aiHLJ64X5dGNYdPv5B
	 sooxZNiHzqz/gfV/H1XD23seHNs1UpZ2NRRr8K4Oo7rLd+Xvx1XBf84xg7j/Smq3Co
	 k1cuzlAfRDe984Ye/w4J9avRadjjKwdpJoqaNPSuI3iS/hKBfEtpNc8h1jz+z9YjUk
	 jB5SKnSuotzewMCX3uvN2QJGl9H4xEi9RLN65n7s/Xa/luNOYJhCddY+qEC8ZJntCo
	 JUVHE5hQnrlYuMkbFtGjDtmThAyYA3fakOHwvhY423bCSEG4YT27WyNPYNwZQ3tVtg
	 a2aFtnauEaJbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 5/5] misc: Add edu_srpoc surprise removal POC
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Abhin Parekadan Jose" <abhinjoses@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260927165459.829900-6-abhinjoses@gmail.com>
References: <20260927165459.829900-1-abhinjoses@gmail.com>
 <20260927165459.829900-6-abhinjoses@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 27 Sep 2026 17:00:17 +0000
Message-Id: <20260927170017.D5A0E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> A test driver for the QEMU edu device that reproduces the surprise
> removal hang described in MST's RFC v5 thread.
>=20
> - hacked in a reg to the edu device on qemu to raise a delayed irq
> - This driver writes to that reg in remove and waits for the irq to be
>   handled. This simulates del_gendisk() blocked in
>   blk_mq_freeze_queue_wait()
>=20
> remove() blocks until the delayed interrupt arrives, 600 seconds after
> it is requested, or until the device is surprise removed and its
> disconnect work runs.  That is the purpose of the driver, so a normal
> unbind takes 600 seconds, and on a QEMU without the delayed interrupt
> register it never returns.  It is only built with CONFIG_EDU_SRPOC.
>=20
> Assisted-by: LLM
> Signed-off-by: Abhin Parekadan Jose <abhinjoses@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260927165459.8299=
00-1-abhinjoses@gmail.com?part=3D5

