Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4BE328B62
	for <linux-pci@vger.kernel.org>; Wed, 19 Aug 2026 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144304; cv=none; b=dhKPH0TdPu7iMtCMFxdl2AvWQmIVoJfyGLzT2Pq0HM1r+FI1bhQO9S609ENFA89LH85AenSrack9D8D/+3ZVqqzhCE+4uKJs/iNmwQIc/1wYxOWY1fVtJKCMpGLgly1TUAYK4Oa6jVQuY5DVsMAEkRbOc2QB4zdVew1zNBreKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144304; c=relaxed/simple;
	bh=+It7h51+50ibkC3PMimBVVFaMujRe0/WTa2pkJO8kSU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pKPSDrYZIF5HLp1dR2Karz80NQPrBhar+NKZL3irFvyk15IORPaQmEnUxhmJinXKbFyyLhOZ+Ea9OxI7/e1L+sf5wWv4vtU3ioX+CizAFMmzVb6zoOBw8WWWAJzxLrtAUG3QIDYLJJHdGrVJRoci21sv7Dn5HiwTskIuGr9kqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba0qo+cV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba0qo+cV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B141F000E9;
	Wed, 19 Aug 2026 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787144303;
	bh=pKdZjuge/BNsOoH5jrwhG57gbbQEyZGvE7FwTBWyekc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ba0qo+cViPKLzPzuiQNjGEzH4gIUSzxyo6jZbhaBZwBBCL+Gyx0rIb5yXyhj3Xl15
	 UiIK4bRcic6ZwSXFx1YVpFgvBUC47zwVyj9ElBTPYErjHET1dLoVcArrhCnZm7nNh2
	 jt/1CVLW9Q8oPz0IrFHf8/+vC3Hbt6QLa6WSUsQ9hs3C3sJiwHsySf5FLOL935iu4N
	 Ej/7D8iWTdFo9H3Fb9uiU03PcxT1X+c+1/udJ6Nnx+grMDiGgHab1denkhIr16+3v6
	 vO5SLUQXbeXcqLZuQtcwbdRvqQnMAOeIExxZGTN/VEZfeSfDZDv02SXypc2yGEo0JS
	 bWVCBvRhBx9Kg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] genirq: Integrate GSIM into interrupt flow
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luigi Rizzo" <lrizzo@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260819124341.4185621-5-lrizzo@google.com>
References: <20260819124341.4185621-1-lrizzo@google.com>
 <20260819124341.4185621-5-lrizzo@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 12:58:22 +0000
Message-Id: <20260819125822.E0B141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Overloading IRQD_IRQ_INPROGRESS for GSIM breaks __synchronize_hard=
irq() by introducing prolonged busy-waiting and potential deadlocks.
--

--- Patch [4]: [PATCH v5 4/7] genirq: Integrate GSIM into interrupt flow ---
commit 8749b57516c52ba231f3249d6f52173005693e96
Author: Luigi Rizzo <lrizzo@google.com>
Subject: genirq: Integrate GSIM into interrupt flow

This commit integrates Generic Software Interrupt Moderation (GSIM) into
the handle_edge_irq() and handle_fasteoi_irq() flows. It introduces
irq_moderation_allow() to validate IRQ eligibility, defaults moderation to
disabled during setup, and ensures the state is cleared during IRQ teardown.

> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index de754db414d1d..04a30ba04e78b 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
[ ... ]
> @@ -500,6 +501,10 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
>  		return false;
>  	}
> =20
> +	/* Moderated interrupts have IRQD_IRQ_INPROGRESS and need early return.=
 */
> +	if (irqd_is_moderated(irqd))
> +		return false;
> +

[Severity: High]
The comment mentions that moderated interrupts have IRQD_IRQ_INPROGRESS
set. Could this cause a prolonged busy-wait or deadlock in
__synchronize_hardirq() when a driver calls disable_irq() or free_irq()
while the moderation timer is active?

__synchronize_hardirq() uses a tight loop to wait for this flag to clear:

kernel/irq/manage.c:__synchronize_hardirq() {
    ...
    while (irqd_irq_inprogress(&desc->irq_data))
        cpu_relax();
    ...
}

If the flag remains active for the entire duration of the moderation
hrtimer, any teardown or suspend/resume operation would busy-spin
for that entire duration.

Additionally, if synchronize_irq() is called with local interrupts disabled
on the CPU where the moderation timer is pinned, would this hard-deadlock
the system since the hrtimer can never fire to clear the flag?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819124341.4185=
621-1-lrizzo@google.com?part=3D4
