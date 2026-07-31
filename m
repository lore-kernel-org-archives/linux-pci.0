Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574FC35C698
	for <linux-pci@vger.kernel.org>; Fri, 31 Jul 2026 08:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487027; cv=none; b=Iti0OFyTI5E+YKAu8E2I9nLUKgUdp5nzjs2Vz8m810Cvc7mHic8pJ3gBeidK8knUsGSl7+LYYm85g7fFKxh+6il+p3ADil5v7/mxcp/h0k60ia5ONK9FtrdIoNzQUPV7VNix18buhAFxdy5Cw5jh7uTSuEjCgt9bNwF3D5XXxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487027; c=relaxed/simple;
	bh=MTjo1lSM8HUAkt8e5tdXAzGNYivibm/uvSCvmizDQ7I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ps/k2Zyd3x3bd43/7vRxhgDFpc/zjJ1PWm/4lqNjAmfYMRhSpoYWec5DsqXD72PJKKOHUr0x6w5IBozdis7DwWBEe+6SYRQXDE33TnPjtiBi3SuAMs44yivQF8LMFW0brWoJQkZzSZumbRSJoKy6EEAsOw+hpPG5bm71+ztYaZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgA3w0cm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgA3w0cm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE53D1F000E9;
	Fri, 31 Jul 2026 08:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785487025;
	bh=CpesTmYpSKIoM1B1QrRNaidoPDjYfR2VXC4UNfQijYs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AgA3w0cmdtI2/aP3kDEi+L1urR3mvlpmTa8/lClJVSM+94ue5i4rfQZB8Zbtalay+
	 vB4kZJtWOog29TzEHgf5Zcmwuy6vk8wZtYzXsB5qIADpWZT5MrkppxmbO0GDTlX7uC
	 mEcF4Wl7g2hBI3hDAFGH6mTsZeqbfa6Awt6ar648SFKO1pdo0vVVTb85aiY0hswEID
	 V4NzHHGG59pnRoxeSxAgwmwsPWnZ022Fke/GDNYW2DuutmxOjIGmsAWTtE1RBHi9Zk
	 KCQRRpF46kqYiQCdafICtBvB33Hy/qu/oMXST6MAurGEYB/fvbKTeQIE6rVrPX9u/t
	 qnbhCapVmpGUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_enable/disable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v2-1-480357946e00@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 08:37:05 +0000
Message-Id: <20260731083705.AE53D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Low] The function `pwrseq_power_off()` was incorrectly renamed to `pwrse=
q_disble()` instead of `pwrseq_disable()`.

Pre-existing issues:
- [High] Unchecked failure in the rollback path of `pwrseq_enable()` leads =
to a leaked power sequence enable count and an inconsistent descriptor stat=
e.
- [High] TOCTOU race on `desc->powered_on` in `pwrseq_enable()` and `pwrseq=
_disble()` leads to leaked power sequencer votes or unbalanced enable count=
s.
--

--- Patch [1]: [PATCH v2] power: sequencing: rename pwrseq_power_on/off() t=
o pwrseq_enable/disable() ---
commit adf6e02fc844795e2717b0bb913d426b91714a03
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/d=
isable()

This commit renames pwrseq_power_on() and pwrseq_power_off() to=20
pwrseq_enable() and pwrseq_disable(). The new names better reflect the
semantics of voting for power states rather than direct power control.

Link: https://lore.kernel.org/all/CAMRc=3DMefxn81d0VUwmQgwFtffkL1=3DEr_1VQZ=
CbC1Sa-Qph4t1w@mail.gmail.com/
Link: https://patch.msgid.link/20260727-pwrseq-vote-rename-v1-1-a2029aeeac6=
5@oss.qualcomm.com

> diff --git a/Documentation/driver-api/pwrseq.rst b/Documentation/driver-a=
pi/pwrseq.rst
> index ad18b2326b689..0c315ab1138b0 100644
> --- a/Documentation/driver-api/pwrseq.rst
> +++ b/Documentation/driver-api/pwrseq.rst
> @@ -50,9 +50,9 @@ Consumer interface
>  The consumer API is aimed to be as simple as possible. The driver intere=
sted in
>  getting a descriptor from the power sequencer should call pwrseq_get() a=
nd
>  specify the name of the target it wants to reach in the sequence after c=
alling
> -pwrseq_power_up(). The descriptor can be released by calling pwrseq_put(=
) and
> +pwrseq_enable(). The descriptor can be released by calling pwrseq_put() =
and
>  the consumer can request the powering down of its target with
> -pwrseq_power_off(). Note that there is no guarantee that pwrseq_power_of=
f()
> +pwrseq_disble(). Note that there is no guarantee that pwrseq_disble()

[Severity: Low]
Is this function name a typo? Should it be pwrseq_disable() instead of
pwrseq_disble()?

[ ... ]
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 02f42da915985..34d5c0af6f37b 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
[ ... ]
> @@ -887,7 +887,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *=
pwrseq,
>   * Returns:
>   * 0 on success, negative error number on failure.
>   */
> -int pwrseq_power_on(struct pwrseq_desc *desc)
> +int pwrseq_enable(struct pwrseq_desc *desc)
>  {

[Severity: High]
This is a pre-existing issue, but does this function leak the power sequenc=
er
enable count if the rollback fails?

Looking at pwrseq_enable(), if target->post_enable() fails, it attempts to
roll back by calling pwrseq_unit_disable():

	if (target->post_enable) {
		ret =3D target->post_enable(pwrseq);
		if (ret) {
			scoped_guard(mutex, &pwrseq->state_lock) {
				pwrseq_unit_disable(pwrseq, unit);
				desc->powered_on =3D false;
			}
		}
	}

If pwrseq_unit_disable() returns an error (for example, due to a hardware
failure), the unit's enable_count won't be decremented, but desc->powered_on
is unconditionally set to false.

Later, when the consumer calls pwrseq_put() or pwrseq_disable(), it will sk=
ip
calling pwrseq_unit_disable() because desc->powered_on is false, permanently
leaving the hardware enabled. Should the code check the return value of
pwrseq_unit_disable() before clearing desc->powered_on?

[Severity: High]
This is a pre-existing issue, but is there a TOCTOU race condition when
checking desc->powered_on?

In pwrseq_enable(), the desc->powered_on flag is checked outside the state
lock, but modified inside it:

	if (!desc || desc->powered_on)
		return 0;
    ...
	scoped_guard(mutex, &pwrseq->state_lock) {
		ret =3D pwrseq_unit_enable(pwrseq, unit);
		if (!ret)
			desc->powered_on =3D true;
	}

If multiple threads call pwrseq_enable() concurrently on the same descripto=
r,
both could see desc->powered_on as false. They would then serialize on the
state_lock and both increment the unit's enable_count. A subsequent call to
pwrseq_disable() would only decrement it once, leaking the second vote.

>  	struct pwrseq_device *pwrseq;
>  	struct pwrseq_target *target;
[ ... ]
> @@ -940,7 +940,7 @@ EXPORT_SYMBOL_GPL(pwrseq_power_on);
>   * Returns:
>   * 0 on success, negative error number on failure.
>   */
> -int pwrseq_power_off(struct pwrseq_desc *desc)
> +int pwrseq_disble(struct pwrseq_desc *desc)
>  {

[Severity: High]
This is a pre-existing issue, but does pwrseq_disble() have the same TOCTOU
race on desc->powered_on as pwrseq_enable()?

	if (!desc || !desc->powered_on)
		return 0;
    ...
	guard(mutex)(&pwrseq->state_lock);

	ret =3D pwrseq_unit_disable(pwrseq, unit);
	if (!ret)
		desc->powered_on =3D false;

Concurrent calls could result in both seeing desc->powered_on as true,
leading to unbalanced decrements of the enable_count.

>  	struct pwrseq_device *pwrseq;
>  	struct pwrseq_unit *unit;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-pwrseq-vot=
e-rename-v2-1-480357946e00@oss.qualcomm.com?part=3D1
