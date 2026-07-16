Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF2F28505E;
	Thu, 16 Jul 2026 14:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211773; cv=none; b=Mg/01JoiDjLItpRWdj3FcwoLXIBrMOw6/ftoe8OlrrRqzojspI0T8Rh+veYmO6mL7f+nWsf60h5aaAa/Voe9YuPnv+yEgTUhcta9EDsqMlCAl8bgHmEzh9ZiYlYs3tZeA5fg6ouIqJXCZBB1sBohcVoJznVlW+wnT5X4jPe31EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211773; c=relaxed/simple;
	bh=/rxFCHiIu4BymJ9k7FwUsZBizafix6bETAM21VjXyQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KpTJi+Bbh5DGuVfVqo79ON/kxlYSiw2fU4SYhLcnP/FU1zcXdLkvoOuXdVLmIdOyvd/lB/fmlXbUfq2fQHHzYLgyHlwFBAKtFgX8LHgni84smtrejROWsBwhRV9pypEsIXd/JH+rBh7qdJwU8aCt0obDEE5XwIaxl+uhmJR9xpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYguP7bL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYguP7bL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB871F00A3D;
	Thu, 16 Jul 2026 14:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784211771;
	bh=0i50oMqMo7EK4tKCQkAZLW1pM6qYZ5tZD+YzTRBl4vw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fYguP7bLjJbvVfprFBF/wlTNW5FU9py3NCBTOISr+ekP0fhWKDYl69Z5n4uHKR9SI
	 8I3YRlE0LlTE2nTyRBPKf37N6f1VqZm9Sc4XpL1+FK4GlzEERIhb9gWN2nrcyYbyID
	 XgJL1SiB9cjocFrP88+4Eh8tyokpiUaRpPynvYslcQBPYJSUBs/KbqWAbjfLGKAaeK
	 Gs6lqHtNrGKxaIvx4WVjGas5o8RiOv0057V+91cvQfcpr36PjvLMT9ztmfWf7Gkx1y
	 nqNuxMdV+nGiPD1IaV6ob+LbsJXYr0TYromMgQrk7oymdZuArCtBYmfGKC83FCuEt/
	 DD+10XYS8E4Tw==
Date: Thu, 16 Jul 2026 16:22:37 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, 
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 03/11] power: sequencing: Add
 pwrseq_power_is_controllable() API
Message-ID: <di2rdanp4hgmflhcrenjbohr3rzzmk6v7m3w7tjffe3it2mjla@46vkm2qat27c>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-3-46253587af64@oss.qualcomm.com>
 <CAMRc=MckiTUBCF+UvmFi-ceLpjWW71LXTTHDiY+s5Qn7NCbD6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MckiTUBCF+UvmFi-ceLpjWW71LXTTHDiY+s5Qn7NCbD6Q@mail.gmail.com>

On Fri, Jul 10, 2026 at 06:13:55AM -0700, Bartosz Golaszewski wrote:
> On Fri, 10 Jul 2026 11:57:29 +0200, Loic Poulain
> <loic.poulain@oss.qualcomm.com> said:
> > On some boards a power sequencing target has no host-controllable enable
> > for its function, for instance when the enable line is not wired up to a
> > GPIO and is hardwired to an always-on level. The pcie-m2 "uart" target is
> > one such example: when the M.2 connector does not route the W_DISABLE2#
> > signal to a host GPIO, its enable/disable are no-ops and the host cannot
> > gate the Bluetooth function at all or exclusively.
> >
> > Add a generic pwrseq_power_is_controllable() helper. It reports whether the
> > target's final unit provides a host-controllable dedicated power actuator.
> > The unit can implement a new optional per-unit is_controllable() callback,
> > reporting whether that actuator is effective on this instance (for example
> > depending on GPIO presence). If the unit does not provide the callback, it
> > is assumed to be controllable.
> >
> > Note this only describes the target's own enable actuator. It does not
> > imply that a power-off reaches an electrical OFF state as a target may
> > have multiple consumers. Also, this does not restrict consumers from
> > calling pwrseq_power_off() either, which remains valid to drop a vote
> > on shared unit resources/dependencies.
> >
> 
> Thanks. In general it looks good, though I would extend the last paragraph by
> mentioning that the fact that the target's final unit doesn't guarantee power
> control for the host, doesn't mean that the power is not controlled for its
> dependencies. This is what you basically said but it may not be clear to
> someone new to this API what a "vote on shared unit resources" exactly means.
> 
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/power/sequencing/core.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  include/linux/pwrseq/consumer.h |  7 +++++++
> >  include/linux/pwrseq/provider.h |  9 +++++++++
> >  3 files changed, 55 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
> > index 02f42da915985339d3de507fc36dd158b0035a99..35df55312a71e9dfd3f24a8199b539746466af36 100644
> > --- a/drivers/power/sequencing/core.c
> > +++ b/drivers/power/sequencing/core.c
> > @@ -72,6 +72,8 @@ static DECLARE_RWSEM(pwrseq_sem);
> >   *          this unit.
> >   * @disable: Callback running the part of the power-off sequence provided
> >   *           by this unit.
> > + * @is_controllable: Optional callback reporting whether this unit's
> > + *                   enable/disable actually control power.
> >   * @enable_count: Current number of users that enabled this unit. May be the
> >   *                consumer of the power sequencer or other units that depend
> >   *                on this one.
> > @@ -83,6 +85,7 @@ struct pwrseq_unit {
> >  	struct list_head deps;
> >  	pwrseq_power_state_func enable;
> >  	pwrseq_power_state_func disable;
> > +	pwrseq_is_controllable_func is_controllable;
> 
> Is there any reason not to put it in struct pwrseq_target? That would avoid
> needless duplication of NULL pointers across all units, right?
> 
> >  	unsigned int enable_count;
> >  };
> >
> > @@ -104,6 +107,7 @@ static struct pwrseq_unit *pwrseq_unit_new(const struct pwrseq_unit_data *data)
> >  	INIT_LIST_HEAD(&unit->deps);
> >  	unit->enable = data->enable;
> >  	unit->disable = data->disable;
> > +	unit->is_controllable = data->is_controllable;
> >
> >  	return unit;
> >  }
> > @@ -991,6 +995,41 @@ struct device *pwrseq_to_device(struct pwrseq_desc *desc)
> >  }
> >  EXPORT_SYMBOL_GPL(pwrseq_to_device);
> >
> > +/**
> > + * pwrseq_power_is_controllable() - Check whether the target provides a
> > + *                                  host-controllable power actuator.
> > + * @desc: Descriptor referencing the power sequencer.
> > + *
> > + * Some power sequencing targets provide no host-controllable enable for their
> > + * function on a given board, for instance when the enable line is not wired up
> > + * and is instead hardwired to an always-on level. For such targets a call to
> > + * pwrseq_power_off() is still allowed, so that the consumer can drop its vote
> > + * on the (possibly shared) resources, but the host cannot gate the function
> > + * on its own.
> > + *
> > + * Returns:
> > + * True if the target provides a host-controllable power actuator, false
> > + * otherwise. Also returns false if @desc is NULL.
> > + */
> > +bool pwrseq_power_is_controllable(struct pwrseq_desc *desc)
> 
> I think, we should call it simply pwrseq_is_controllable(). I was thinking
> about pwrseq_target_is_controllable() but it's redundant: a pwrseq handle is
> already associated with a concrete target. When you say "power" it suggests
> a concrete thing that's "controllable" but it may be a ragulator, it may be
> a GPIO or reset. I'd just go with pwrseq_is_controllable().
> 

But what does pwrseq_is_controllable() mean to the clients? What is
controllable? pwrseq itself is controllable? If so, then what does
pwrseq_power_{on/off} provide?

pwrseq_power_is_controllable() also suffers from the same ambiguity. The goal
of this API is to tell the clients whether a specific GPIO or some signal is
available that enables/disables the radio on the device. But that is not same as
controlling power to the sequencer, which is controlled by the regulator.

But TBH, I don't have any suggestion for the generic API name :/

- Mani

-- 
மணிவண்ணன் சதாசிவம்
