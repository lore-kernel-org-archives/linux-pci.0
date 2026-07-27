Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6A33E63A4
	for <linux-pci@vger.kernel.org>; Mon, 27 Jul 2026 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147009; cv=none; b=G+aQFcUvATzce9WB0XUrnLhsE+QiaKCmAGQFfd/oxPWi8bJkY44SFGwLXbiKAFNkUeixLdakRIgQjHDbQ27HF3YheGn4GZVRXDD/uNCByEGYuNyptRjouD8pAy4cNVUNvqZ+xS76US80igMDOPb7hGzn+5xfNYXF/ICqPimhr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147009; c=relaxed/simple;
	bh=SUqaAPhdPEZqGOKXqaQjqh5JFrqfFh12c07F2Y3z9RY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rjeD9weeCARQjWqNjAuKJIftgljGp5D463q1T9mIDFHTlbLfB3YMTDo49S2mErW9G+HjNBtVV8ypjncJM5MR5jXm+kesGpmnzEasWyxpECXmBFhMIZq8JN+6tqTmBn58glsyDCiwX5fqfNVDfuF4iBUqHgeXRtAItd+L7QfpoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvZPb/N+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvZPb/N+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627C21F000E9;
	Mon, 27 Jul 2026 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147007;
	bh=3+2ttRlj4tfjN1xH4v9aGtdZgb3+lqleLbR7FJIa2NQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EvZPb/N+R4thZ9mpCk22qHj6rl4kRk73jaVdoIh0e2qmJPGojoLOnTjjpSa50p5ci
	 Fnd3DoNFbBxdRIpdzKIL9j8NEyThvkosVPVKpHjIPugEphEg2tZpEEVuz8ChoLd+l+
	 tObKOd6iBYDnrVN2ogK05IniU8a1TzL2zlD8QwhFNCCzQWK11WnjMLdePkRcJRQfO/
	 3hqq5iK9mGaZc2QZDVSYJXjtexCpLO5E3y+zPoewOTAjsE5gUYHPVfBZyaN6t9ZzNe
	 HJ0V36L4J2ccxJa1mn26lCHi+zo+7xqwGdgD72qXgJM0VNDhSMNU711/bazABYlGYY
	 YCNyrxKOxZWYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() to
 pwrseq_vote_on/off()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
References: <20260727-pwrseq-vote-rename-v1-1-a2029aeeac65@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:10:06 +0000
Message-Id: <20260727101007.627C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unhandled error from `pwrseq_vote_on()` in `slot_pwrctrl_power_on(=
)` masks power-on failures.
- [High] Logic error in `pwrseq_vote_on()` executes `post_enable` and masks=
 errors when `pwrseq_unit_enable()` fails.
--

--- Patch [1]: [PATCH RFC] power: sequencing: rename pwrseq_power_on/off() =
to pwrseq_vote_on/off() ---
commit e51e94e0f35e884f6a8dab94fc8221cd0e96b231
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

power: sequencing: rename pwrseq_power_on/off() to pwrseq_vote_on/off()

This commit renames the power sequencing API functions pwrseq_power_on and
pwrseq_power_off to pwrseq_vote_on and pwrseq_vote_off respectively.

Link: https://lore.kernel.org/all/CAMRc=3DMefxn81d0VUwmQgwFtffkL1=3DEr_1VQZ=
CbC1Sa-Qph4t1w@mail.gmail.com/

> diff --git a/drivers/pci/pwrctrl/generic.c b/drivers/pci/pwrctrl/generic.c
> index a7e599d841e62..8872f6501352d 100644
> --- a/drivers/pci/pwrctrl/generic.c
> +++ b/drivers/pci/pwrctrl/generic.c
> @@ -29,7 +29,7 @@ static int slot_pwrctrl_power_on(struct pci_pwrctrl *pw=
rctrl)
>  	int ret;
> =20
>  	if (slot->pwrseq) {
> -		pwrseq_power_on(slot->pwrseq);
> +		pwrseq_vote_on(slot->pwrseq);

[Severity: High]
This isn't a bug introduced by this patch, but does this code ignore the
return value of pwrseq_vote_on()?

If the power sequence fails, the error is discarded and
slot_pwrctrl_power_on incorrectly returns 0. Could this lead to the PCI
subsystem attempting to probe unpowered hardware, causing fatal kernel
crashes when reading unpowered MMIO registers?

>  		return 0;
>  	}
> =20

[ ... ]

> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 02f42da915985..c630b14f6f2c4 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c

[ ... ]

> @@ -887,7 +887,7 @@ static int pwrseq_unit_disable(struct pwrseq_device *=
pwrseq,
>   * Returns:
>   * 0 on success, negative error number on failure.
>   */
> -int pwrseq_power_on(struct pwrseq_desc *desc)
> +int pwrseq_vote_on(struct pwrseq_desc *desc)
>  {
>  	struct pwrseq_device *pwrseq;
>  	struct pwrseq_target *target;

[Severity: High]
This is a pre-existing issue, but looking at the body of pwrseq_vote_on(),
is there a missing check for the return value of pwrseq_unit_enable()
before calling target->post_enable()?

	scoped_guard(mutex, &pwrseq->state_lock) {
		ret =3D pwrseq_unit_enable(pwrseq, unit);
		if (!ret)
			desc->powered_on =3D true;
	}

	if (target->post_enable) {
		ret =3D target->post_enable(pwrseq);
		...

If pwrseq_unit_enable() fails, we bypass any failure check and proceed to
call target->post_enable(). If post_enable() succeeds, it overwrites the
original error with 0, meaning we return success even though the hardware
is unpowered.

If post_enable() fails, its error rollback unconditionally executes
pwrseq_unit_disable(), which triggers a WARN for unmatched power-off and
a potential negative enable count.

Should there be a check on ret before executing the post_enable logic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727-pwrseq-vot=
e-rename-v1-1-a2029aeeac65@oss.qualcomm.com?part=3D1
