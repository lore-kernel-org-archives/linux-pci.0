Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C172364028;
	Tue,  1 Sep 2026 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788255945; cv=none; b=gl36UFQx8abIQtlYRSr+6aRhfvY+o/FqsIaJ4H473nI5oLuU6mF6Ly1TeG6K6NvnWj+iQPaORYAcPWKAHOrdFQ4LS5yFG65byYTEknBJpM/wJ9VWyvpKWova1Wf/HctsuQgY2JM6CF0Yw516xgVFR1nnXFqwtTM59xIr2e+8ZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788255945; c=relaxed/simple;
	bh=QfNOxArFGd2IdGN+F/LQmhw+oBsp+HNvYtY0qYF/lT8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jy0Dl3RWOwZh3eTTVaDFrxAljXurbSNKfYv7V2Easf5f4h56e2QR+OU6NXhle8iL2PM2wo2Br8iVsPDzp7jETEvgCZBpMvGaRysf7zghhviFivvKwd8r0XE1WfZKvYiMLd1o16LRqzsq9/tRMD/ZoO/Yrt3Zjh/OD157W2SvgnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef7Gqj43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef7Gqj43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B851F000E9;
	Tue,  1 Sep 2026 09:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788255944;
	bh=QfNOxArFGd2IdGN+F/LQmhw+oBsp+HNvYtY0qYF/lT8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ef7Gqj43jSY7aZ1B5oi1mc4fHkHUEmOuO4fc/zUfUh1g1gge/7Db5TUtzcNSsv1w4
	 Ei9OhS7SG2r5biUDDMmz/NWL6RsdueG1h7xnw22Kn2No5AY7UC0VyxiafNTzQ1RCi1
	 B7AcRPy00BwlCGAB3j7lvw2z0BLRQNOJ4csSmcDeMIItcwHvGyrwmCae0id7y/3lUA
	 MarK4NNPDZnCffNxLKUNlPMhFnqysITolBzXYV5Bb2wccdGuEHl7/3F2CAzSYI6Tmw
	 vHb3z2BxHmxXONBQ1D0zZHgk7uyLaRPyZMg/AGJTsciEXn4jJp9HkRQe0ZJc0p3RKW
	 RLCQ1YRCaX49Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 01/19] vfio/pci: Add PCI error recovery support
 state
Reply-To: sashiko-reviews@lists.linux.dev
To: "Shameer Kolothum" <skolothumtho@nvidia.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260901093217.8539-2-skolothumtho@nvidia.com>
References: <20260901093217.8539-1-skolothumtho@nvidia.com>
 <20260901093217.8539-2-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 09:45:43 +0000
Message-Id: <20260901094543.E9B851F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add the state, the lock and the wait queue that the rest of the series
> needs. Nothing uses any of it yet. The lifecycle and the access guards
> come next, the recovery callbacks later.
>=20
> The flags word records what happened in one event. IN_PROGRESS while
> recovery is running, FROZEN if the channel was frozen, RESET if the host
> reset the device, and FAILED if it did not recover. These are internal.
> A later patch reports the same set to userspace along with a sequence
> number, so an event can be told from the one before it.
>=20
> Where both locks are held, recovery_lock goes outside memory_lock.
> Recovery has to shut out new device access and wait for whatever is
> already running before it can take memory_lock and revoke the BAR
> mappings. The other way round deadlocks. An access path sits on
> memory_lock waiting for recovery_lock, while recovery sits on
> recovery_lock waiting for memory_lock. So nothing may take recovery_lock
> when it already holds memory_lock.
>=20
> Only the generic vfio-pci driver advertises support, so variant drivers
> carry on as they do now. Userspace activation is a separate switch, so
> even on generic vfio-pci nothing changes until userspace asks for it.
>=20
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901093217.8539=
-1-skolothumtho@nvidia.com?part=3D1

