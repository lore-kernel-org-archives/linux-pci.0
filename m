Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BE1F91F6
	for <linux-pci@vger.kernel.org>; Sun, 17 May 2026 01:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778981487; cv=none; b=Lt1v3vy6vNTiG/LCQjreNdp/xtRn5BOvzPDTPHN62Yz2SUGYrATkilTr/uHGNA0ZzjumFmiWfPn5/hO9w+FcihxicWbbA1Iw00HwW0lwGoH59utGcvvarPbZmRNPYdd3K5ck6PT9ss6VbJsC0RA/TyZNty9F8XZX/fE+cMga4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778981487; c=relaxed/simple;
	bh=XbFBQD6v4NMrvGTk2XUMU3Ul6wCHY6mvwLftsc0GYn8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K4ATMmW0zp/xjiR5mqe4+BmZgGh617RY3sxyTNMv1mSt0YH5+2Mapdz3am6CxPkkQLAnXDMp7Mo82lRbxrtMmNXjGdHVFBlk2qrQy++6z9LiM6U/kdh5Anjkx6TOJLKe5Ks4J6ZVkm49NVSQJtJon923NSCmPlWuc6Cq3Y0ib4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aK5zkUhq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aK5zkUhq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD79C19425;
	Sun, 17 May 2026 01:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778981487;
	bh=XbFBQD6v4NMrvGTk2XUMU3Ul6wCHY6mvwLftsc0GYn8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aK5zkUhqk0RyObFnmf60Aimj6NVemP/5m9oglMMi4CETCZswXU1p8zEb3PjxIYrvr
	 RT2eDrdBxU5VWy686EP+16/7FXyK5hQsshpGQKCOAeoe4hZabfyhS0orRRauQNO1nd
	 TNdnOhgAcGlb9iKn/FWwGe3rftbzZMBxvi2ivLYDZZjXvnOjcVqN9m4MkiHYq7/hbg
	 bxjt4c1DOYUVsbZotMVl21zk1qv9AJ1GHjnVfvlheq/HtBgNzVs5y2tOYCbAHkpQ2E
	 bPj5nV68vFStqi4N1qpDl4w0o7dqiJKwZXiVtEf9cuaYzfByDvssCjOGWbaLZKsz33
	 tK10YoY4h146A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 20/27] rust: io: make IoMem and ExclusiveIoMem
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260517000149.3226762-21-dakr@kernel.org>
References: <20260517000149.3226762-21-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 01:31:26 +0000
Message-Id: <20260517013126.DDD79C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Missing `?` operator after `into_devres()` causes a compilation err=
or in `drivers/pwm/pwm_th1520.rs`.
--

commit a23bc481c58c23ac450d2b4d6632694158a96cc9
Author: Danilo Krummrich <dakr@kernel.org>

rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized

This commit adds a lifetime parameter to IoMem and ExclusiveIoMem to tie the
mapping to the device's lifetime. It updates the io requests to return the
mapping directly, while providing an into_devres() method for callers that
need device-managed revocation.

> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 1abf580653fa3..c84321a4d94e1 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
[ ... ]
> @@ -352,7 +352,7 @@ fn probe<'bound>(
>              dev,
>              TH1520_MAX_PWM_NUM,
>              try_pin_init!(Th1520PwmDriverData {
> -                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>(),
> +                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>()?.i=
nto_devres(),

Since into_devres() returns a Result type, does this need a trailing ?
operator to unwrap the value? It looks like omitting it will cause a type
mismatch and build failure because try_pin_init! expects the unwrapped
Devres value here.

>                  clk <- clk,
>              }),
>          )?;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517000149.3226=
762-1-dakr@kernel.org?part=3D20
