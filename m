Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799243E1CF4
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726156; cv=none; b=kh+3ZLuAi2BuszQYVoEIfF1TlJnuYdnnlMUKDjDhImp8wUZTUTB4Exe2lM5WGglqdxZ/4IEnxJz1Dz8p9YMhep3LGGgipik9jbM8ZmLMZXolTfPbzxoiYAR8fq6sprTngiDMFKUJPwdiOAhzrHnHn7HKyFDk/THS5BZaQ31IwYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726156; c=relaxed/simple;
	bh=SAlsP4oTaZ6igvRvb74YFJefhWtlzcLIp9Fln9Kb9l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cINsLuhvXFvvn6z0MaidmMrj6scbMaTQsunCKws1WE31d6aFOM0btmsZ1LqluEonpmIoc9brXb+Dg1fxsupB746Xiy63eTsVR9771N8im4IUu3dokSaw0IOXTTPWJGxf51gJ8cbBi2iDhKfjCfwIY2ey719pRG6LT6hZ1FXlSxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mCAm43ke; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCAm43ke"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25E71F000E9;
	Mon, 29 Jun 2026 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782726155;
	bh=6T/MVjDltHEst+cdCKbdfYrd9hF755vpXVqOA7CiWfg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mCAm43kef/yqA7wuO7Ia8Xs0/f7GkupH0N0iLJgiig4s92427JVruIxOQ9YrIfW02
	 fhTZNnVXXTuUNCWwa2JoDSaEVD9M82iNC/lSewuJMMylYbRdx/TLh8hoMM4oRkptec
	 t3YYjekAfSJ+3hX3kqfq/tGyYkg9XnAsuh/p0eFrLZKTIDHmXHdbwOIz7Z+ErkacdO
	 zGw2JzA/ZXlphTP8LB/GcJP2yj70hQF5wkK5EUCk3kulxnqBanPVJQAABRJt2e118Q
	 SFqHBLdCRoiMPukXt8mZYu4Tn94O7CfOQa1PExV7eY+rfFhiBkI1qa/gfcdd0ZdVu/
	 XpIJCmKHBBKXw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] perf/dwc_pcie: Support narrowed time-based
 counter for long time monitoring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yicong Yang" <yang.yicong@picoheart.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260629092717.74946-3-yang.yicong@picoheart.com>
References: <20260629092717.74946-1-yang.yicong@picoheart.com>
 <20260629092717.74946-3-yang.yicong@picoheart.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 09:42:34 +0000
Message-Id: <20260629094234.F25E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing PM runtime reference during asynchronous hrtimer lifecycle
--

commit 2e4285bc1c7667cda860c906d0df29f1548de698
Author: Yufan Dou <douyufan@picoheart.com>

perf/dwc_pcie: Support narrowed time-based counter for long time monitoring

This commit adds an optional hrtimer that fires every 2 seconds to read,
update, and reset the time-based counter. This works around hardware
implementations that do not implement the full 64-bit width of the counter
and limits short time monitoring usage.

> diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
> index 5385401fa9cf6..7ec8302d4090b 100644
> --- a/drivers/perf/dwc_pcie_pmu.c
> +++ b/drivers/perf/dwc_pcie_pmu.c

[ ... ]

> @@ -429,6 +453,26 @@ static int dwc_pcie_pmu_validate_group(struct perf_e=
vent *event)
>  	return 0;
>  }
> =20
> +static enum hrtimer_restart dwc_pcie_pmu_hrtimer_callback(struct hrtimer=
 *hrtimer)
> +{
> +	struct dwc_pcie_pmu *pcie_pmu =3D container_of(hrtimer, struct dwc_pcie=
_pmu, hrtimer);
> +	struct perf_event *event =3D pcie_pmu->time_based_event;
> +	struct hw_perf_event *hwc;
> +
> +	if (!event)
> +		return HRTIMER_NORESTART;
> +
> +	hwc =3D &event->hw;
> +	if (hwc->state & PERF_HES_STOPPED)
> +		return HRTIMER_NORESTART;
> +
> +	dwc_pcie_pmu_event_update(event);
> +	dwc_pcie_pmu_reset_time_based_counter(event);
> +	hrtimer_forward_now(hrtimer, ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS));

[Severity: High]
If the PCIe Root Port enters runtime suspend (such as D3hot or D3cold) while
this timer is active, will the hardware accesses in
dwc_pcie_pmu_event_update() cause problems?

Accessing the configuration space of a suspended device could return
corrupted data or trigger system errors like synchronous external aborts.

> +
> +	return HRTIMER_RESTART;
> +}

[ ... ]

> @@ -478,10 +522,15 @@ static void dwc_pcie_pmu_event_start(struct perf_ev=
ent *event, int flags)
>  	hwc->state =3D 0;
>  	local64_set(&hwc->prev_count, 0);
> =20
> -	if (type =3D=3D DWC_PCIE_LANE_EVENT)
> +	if (type =3D=3D DWC_PCIE_LANE_EVENT) {
>  		dwc_pcie_pmu_lane_event_enable(pcie_pmu, event, true);
> -	else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT)
> +	} else if (type =3D=3D DWC_PCIE_TIME_BASE_EVENT) {
>  		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
> +		if (pcie_pmu->timer_enable)
> +			hrtimer_start(&pcie_pmu->hrtimer,
> +				      ns_to_ktime(DWC_PCIE_PMU_TIMER_PERIOD_NS),
> +				      HRTIMER_MODE_REL_PINNED_HARD);

[Severity: High]
Should we be taking a PM runtime reference on the PCIe Root Port device when
starting this background hrtimer?

Since the hrtimer fires asynchronously every 2 seconds, ensuring the device
remains awake while the event is active would prevent the hardware accesses
in the timer callback from hitting a powered-down device.

> +	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629092717.7494=
6-1-yang.yicong@picoheart.com?part=3D2
