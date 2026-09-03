Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5E53911C7;
	Thu,  3 Sep 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422390; cv=none; b=ZAQWx4kHbwGiQFEMrDRemPvc3ywBmcdstY0aIfk72h0SnOzPKQwT6OG42mGUS+vlF61x1uGwLcTzrFj9GKY7G28zicxVtKm6jnFkpDBlK8eKTc/twEhR4/aXzFSWZJQW3uLNQ6gF0lGWU1IJtSoLldyqcWysgY8OuFMc31xpTDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422390; c=relaxed/simple;
	bh=liSx/l4e3jFApTv7vBn3G5LNXu5Qz9Y1FeZ2ZWZn9ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QmX8EAivsN3qUa8RLEcbhstbu8uftvP+Ds/9BsE1r5kLwzveNCacfsy4U33HQ9AxH0aLI3+aEeBEMTq1JxTM1gnEfi268NESiY0wQq4Y5EhPy7RNhWk4KhoADkzjDYtoxD97zDmTva7FoFFBlIW2SDNMr/PgSodbDbCh4yJkb78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onyxYBzL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onyxYBzL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21BD71F00A3A;
	Thu,  3 Sep 2026 07:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788422389;
	bh=liSx/l4e3jFApTv7vBn3G5LNXu5Qz9Y1FeZ2ZWZn9ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=onyxYBzL43U+hX3cEJSdCGAAi9CUIhYci4LD8kd1Cv6L5S31nCS5rZeDMTputvQOb
	 3kqlcPrIEaqcxb3qsXJFpo1ffg8628AenfRRhIb1C6DHM16Z+n7SpsdPsKE7KMeO78
	 QLXJUQveJw9SLmYUYWFdrGIzYAXeQoT6dAOgFnzdih0e0lSEwII5QmTXXr8AdGD1nW
	 EohxWgl4L/SPpXntUGMMkzNgfaKRs0v6LD4+N6f2Cr942z4DNj4fa+djeiP48dqFsF
	 63BxYSK7AyP9viVQfYYO6ebVWtax0s1Anvvup0TK2Qur3j5O3vIxTVAM3GlHggFCYW
	 jGvx61FScpe5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/8] perf hisi-ptt: Abstract trace data buf and
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sizhe Liu" <liusizhe5@huawei.com>
Cc: linux-perf-users@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260903075241.1445338-2-liusizhe5@huawei.com>
References: <20260903075241.1445338-1-liusizhe5@huawei.com>
 <20260903075241.1445338-2-liusizhe5@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 07:59:48 +0000
Message-Id: <20260903075949.21BD71F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Abstract the base address, current offset, length and packet type of
> analysing trace data into structure hisi_ptt_pkt_buf and move the step
> of current offset into the corresponding functions.
>=20
> Reviewed-by: Yushan Wang <wangyushan12@huawei.com>
> Signed-off-by: Sizhe Liu <liusizhe5@huawei.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260903075241.1445=
338-1-liusizhe5@huawei.com?part=3D1

