Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732273515D4;
	Mon,  3 Aug 2026 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796251; cv=none; b=elRBGyOCrLoZwu060P+QlH/g0vh1GCOcFd/2oX+4Kdv7girFZnKcODp6vPL5/a1iYw2VKhwMrOEidIJpMnxM/Rfzu1wlcu5azl/Ubv8rCXg8UFmRHdUMIW0F9IjnKtXSMbnSgbd2VpJMae1slOpGmqN+FVGnBM0rg/4HMl+VmNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796251; c=relaxed/simple;
	bh=4nxb5QHAje4H3F5wFZdm5J4kPWDiANgU0HGDnzyi/kE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KyD3oWsD4LMA9/9JjBJJLqHPAdapIVLyqo582ldRVDJpb0ale4uPDeki4VPIaU3uhANWcXmGAUEE4r/GMokDt3Bqt6zkUsYavvHqPGocxDbRLucKPwJ182pO6+R3QeoyxR9o2qJUdh8X4S4E44qGc9wOC7JG4XpNxi6R8nw1rE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DL4Lvn5A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DL4Lvn5A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6191F000E9;
	Mon,  3 Aug 2026 22:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785796249;
	bh=4nxb5QHAje4H3F5wFZdm5J4kPWDiANgU0HGDnzyi/kE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DL4Lvn5AVkF7vdLJZQtQkONbs2KU3eLcuKnmsGa7v4mYPQyFPmwq5z6TXvrZbc2si
	 r593cQ3OIkC3wxJuaVbQDwNwxdBa0wBXMJy1OnO9kP6jJYjs9ZlytKqe100PxwxZOr
	 K7z6bNKcULtgaAI15uiV/29+rKTAy4URhTeL354lJjFAZtY0jJ9Es6+lFxONPhwu5U
	 XPV+8kjwChx2HO6Z+HrVIb7E5YnrbLwqM4l0aeWguP+SbqK3Ly8dMubx/nJFSt+veT
	 sNWZZmelHuJQ7woYlgA4cvglecOZUa3PHtkqMzJWS25Lesz7uuzI1pKXC9glstJlbn
	 WcdI1r5cKtmsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 04/14] cxl: Tighten CPER kfifo registration API and
 symbol visibility
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-5-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:30:48 +0000
Message-Id: <20260803223048.DD6191F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Dan Williams <djbw@kernel.org>
>=20
> Tighten the CPER protocol error kfifo registration API and symbol
> visibility.
>=20
> Use EXPORT_SYMBOL_FOR_MODULES() instead of EXPORT_SYMBOL_NS_GPL() for
> the CPER kfifo registration symbols. This names the consuming module
> explicitly and gives compile-time enforcement.
>=20
> Drop the work_struct argument from the unregister path. Change the
> WARN_ONCE condition to a NULL check since there is no caller pointer
> to compare against anymore.
>=20
> Return void from the registration helpers whose result callers ignore.
> cxl_cper_register_work() keeps its int return as the only one consumed by
> a caller. Flag double registration with WARN_ONCE() inside the lock
> instead of returning an error.
>=20
> Change cxl_ras_init() to void because there is one consumer and one
> producer so the error return was unnecessary. Remove the now-dead error
> check in cxl_core_init().
>=20
> Co-developed-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D4

