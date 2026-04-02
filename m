Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0F3C1418
	for <linux-pci@vger.kernel.org>; Thu,  2 Apr 2026 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775125604; cv=none; b=tagEWHwLr2LV+qJ0HtQlEy0FTtcbm65VlBJyltRK9hr5Z86VKV82KF5F7a4hViMR092+a/pYMCjDxjSfepEgYM+RBjW3SLdQSX5DVPpAiQemOpiMz7wS13gSzVy1zAy81miKHH0RKyDKfiTcer04O3ZPqBTjwbU90LHuiNtvSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775125604; c=relaxed/simple;
	bh=QocVP8RliyD57oYi8LKapgnuAL11EjWCrBQsYJjeP5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT9+/CwgUyukIBwPH7NJJoGHhnpW+h99HdWPh4bXW3MWJq/ZIVeJrBU0uZzzF+jBUAW3qbEclb8eyyQ31MZTlCmsHkMeJ/dYZtEYo0UGuDKjpG3zRnCGlBYnRtY3pY8g4I1tFCKT5YX9Yq9N8AeITZ/dOeTyhjuh+WgHSvhIxnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OWavSDX4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OWavSDX4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775125602;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tbiNW6fo2qH/eLsmPCaBwN/Htf3MbxA5LWFsoCSTCfM=;
	b=OWavSDX4TmZu7fTt8FWkKh5PX2jBGkPia+qz8X8rwYiVA8O8QDS1SCKPY4UJ72NV8O/NEB
	QeldXeuu/jWtdo59z4QxhFr0qjSlFjkP1dw8F0jJCadn5M9i9hulT+e8wpefDAIhAARsDP
	FhPhM9hqGE2U/8hD/2eeF/0AO3ZcPkM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-kUBRL3a7NfGvSW6G-M2Hug-1; Thu,
 02 Apr 2026 06:26:38 -0400
X-MC-Unique: kUBRL3a7NfGvSW6G-M2Hug-1
X-Mimecast-MFC-AGG-ID: kUBRL3a7NfGvSW6G-M2Hug_1775125594
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 850481956089;
	Thu,  2 Apr 2026 10:26:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.195])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECC091800351;
	Thu,  2 Apr 2026 10:26:20 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: anthony.l.nguyen@intel.com
Cc: andriy.shevchenko@intel.com,
	pmenzel@molgen.mpg.de,
	aleksandr.loktionov@intel.com,
	mika.westerberg@linux.intel.com,
	pabeni@redhat.com,
	mbloch@nvidia.com,
	saeedm@nvidia.com,
	piotr.kwapulinski@intel.com,
	sx.rinitha@intel.com,
	kuba@kernel.org,
	grzegorz.nitka@intel.com,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	arkadiusz.kubalewski@intel.com,
	tariqt@nvidia.com,
	davem@davemloft.net,
	dima.ruinskiy@intel.com,
	bhelgaas@google.com,
	andrew+netdev@lunn.ch,
	lukas@wunner.de,
	jacob.e.keller@intel.com,
	richardcochran@gmail.com,
	takkozu@amazon.com,
	enjuk@amazon.com,
	maximilianpezzullo@gmail.com,
	joe@dama.to,
	przemyslaw.korba@intel.com,
	leon@kernel.org,
	vgrinber@redhat.com,
	linux-pci@vger.kernel.org,
	sunithax.d.mekala@intel.com,
	corbet@lwn.net,
	vinicius.gomes@intel.com,
	ilpo.jarvinen@linux.intel.com,
	edumazet@google.com,
	linux-doc@vger.kernel.org,
	kohei.enju@gmail.com,
	kohei@enjuk.jp,
	horms@kernel.org,
	avigailx.dahan@intel.com
Subject: Re: [net-next,13/15] ice: add support for unmanaged DPLL on E830 NIC
Date: Thu,  2 Apr 2026 12:26:16 +0200
Message-ID: <20260402102616.177883-1-pabeni@redhat.com>
In-Reply-To: <20260330230248.646900-14-anthony.l.nguyen@intel.com>
References: <20260330230248.646900-14-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ice: add support for unmanaged DPLL on E830 NIC

Hardware variants of E830 may support an unmanaged DPLL where the
configuration is hardcoded within the hardware and firmware, meaning
users cannot modify settings. However, users are able to check the DPLL
lock status and obtain configuration information through the Linux DPLL
and devlink health subsystem.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
> index 62f75701d652..2a9eb233dbf4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c

[ ... ]

> @@ -3148,12 +3176,15 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
>  	int ret;
>
>  	ret = ice_dpll_get_pins(pf, pins, start_idx, count, pf->dplls.clock_id);
> -	if (ret)
> +	if (!cgu || ret)
>  		return ret;
> -	if (cgu) {
> +
> +	if (first) {
>  		ret = ice_dpll_register_pins(first, pins, ops, count);
>  		if (ret)
>  			goto release_pins;
> +	}
> +	if (second) {
>  		ret = ice_dpll_register_pins(second, pins, ops, count);
>  		if (ret)
>  			goto unregister_first;
> @@ -3162,7 +3193,8 @@ ice_dpll_init_direct_pins(struct ice_pf *pf, bool cgu,
>  	return 0;
>
>  unregister_first:
> -	ice_dpll_unregister_pins(first, pins, ops, count);
> +	if (first)
> +		ice_dpll_unregister_pins(first, pins, ops, count);
>  release_pins:
>  	ice_dpll_release_pins(pins, count);
>  	return ret;

NULL checks were added to ice_dpll_init_direct_pins for handling unmanaged
DPLL initialization where only one DPLL device is active. However, is the
corresponding cleanup function ice_dpll_deinit_direct_pins missing the same
NULL checks?

In unmanaged mode, only pf->dplls.pps.dpll is initialized while
pf->dplls.eec.dpll remains NULL. When ice_dpll_init_pins calls
ice_dpll_init_direct_pins(pf, true, outputs, count, num_outputs,
output_ops, eec.dpll, pps.dpll), if this second call (for output pins)
fails, the error path calls ice_dpll_deinit_direct_pins(pf, true, ...,
pps.dpll, eec.dpll).

Looking at ice_dpll_deinit_direct_pins:

static void ice_dpll_deinit_direct_pins(struct ice_pf *pf, bool cgu,
					struct ice_dpll_pin *pins, int count,
					const struct dpll_pin_ops *ops,
					struct dpll_device *first,
					struct dpll_device *second)
{
	if (cgu) {
		ice_dpll_unregister_pins(first, pins, ops, count);
		ice_dpll_unregister_pins(second, pins, ops, count);
	}
	ice_dpll_release_pins(pins, count);
}

When cgu=true and second=NULL, ice_dpll_unregister_pins is called with
dpll=NULL. Then dpll_pin_unregister(dpll, pin) dereferences dpll with
xa_empty(&dpll->pin_refs), causing a NULL pointer dereference.

Shouldn't ice_dpll_deinit_direct_pins add NULL checks for first and second,
matching the guards you added in ice_dpll_init_direct_pins?

> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.h b/drivers/net/ethernet/intel/ice/ice_dpll.h
> index ae42cdea0ee1..2c98b6c6deb0 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dpll.h
> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.h

[ ... ]

> @@ -173,3 +181,5 @@ static inline void ice_dpll_deinit(struct ice_pf *pf) { }
>  #define ICE_CGU_R11_SYNCE_S_BYP_CLK		GENMASK(6, 1)
>
>  #define ICE_CGU_BYPASS_MUX_OFFSET_E825C		3
> +#define ICE_DPLL_UNMANAGED_PIN_NUM		4
> +#define ICE_DPLL_IN_ESYNC_ENABLED	ICE_AQC_GET_CGU_IN_CFG_FLG2_ESYNC_EN

This isn't a bug, but ICE_DPLL_UNMANAGED_PIN_NUM is defined but never
used. Looking at the unmanaged pin descriptors, ice_e830_unmanaged_inputs
has 1 entry and ice_e830_unmanaged_outputs has 2 entries (totaling 3 pins,
not 4).

