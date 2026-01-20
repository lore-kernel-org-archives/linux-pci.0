Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F642E01F;
	Tue, 20 Jan 2026 13:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768916646; cv=none; b=BPCMeaSLX8X/o+tScSpD1G4ImeSkQKIte0UO0/hL9CH0RgoqjFt6Y6ioIb8N7HfBBrUGwagByen7baQlcRZ5y1im+/jzUmFJCQjar2JIVfrK74Ckkni1vRPJ1p+LyzKTr7X1cQmYCdE4JpHnRSSSt81DaAJ79m5pddqn4rbvEwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768916646; c=relaxed/simple;
	bh=r/wgzgf0EkhTp6BMaxQZXx/C5WQztaEMFzHxhcyHpM4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lQduHgsDFddQ893cmVAgPt0/h/6ffBmolBDs4TyvIWAe1gtUGm1iMySrZUqBhXToN3M4tyDJ9nRV3MevqLWFOn/w12jP/bSrybvSUqIS+vj/a2s2ed+qu3oPc7IMrFDpxTjYCoQcWCrfR7Mt0648QaZWS875OnXwsobkozW6VQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlZoXePb; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlZoXePb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768916644; x=1800452644;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r/wgzgf0EkhTp6BMaxQZXx/C5WQztaEMFzHxhcyHpM4=;
  b=OlZoXePbltDlUV1uPgMHvshdY2EgfFXCiQd+E/11ryqyBOXZTGtn7CWo
   mk+3vTvu1+m9Ej/w7Uzb/0QywYdJ3sauUK7IzL6HEF9IqN+Rx2xwNialH
   yyIXWc7SZw4QLV1ssvwEfS6ioeAE0FfuRbIT946ZxFVPJl4B+Ez0RkgJO
   aD3hcHi5bxHBvi6VERlqBXZmo+j8oNjmNGt7mCra+2e2BHsAKUGa7Dbq5
   HIKjHJb0VMiXjptUfgOLY9ldhLF0JycpX/LFfktsGpTfqazsw8t2FjEiP
   60sci71ghQ4bw0MkhVAFs+0rLiSiy8A6LI4DWd3qA/9KM9lYfGJt419P8
   g==;
X-CSE-ConnectionGUID: qdaMXpY+Sb2jZ6P2ft1MPg==
X-CSE-MsgGUID: LG93UodES2SxRWFfN3OUKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73979168"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73979168"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:44:04 -0800
X-CSE-ConnectionGUID: kylcqk4sRI6/LbV6iNC9PA==
X-CSE-MsgGUID: h/Qob4EWRhO9dFdpqLY5pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="243712663"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.246.69])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 05:43:59 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: "Nilawar, Badal" <badal.nilawar@intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
 linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org,
 lenb@kernel.org, bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 varun.gupta@intel.com, ville.syrjala@linux.intel.com,
 uma.shankar@intel.com, karthik.poosa@intel.com, matthew.auld@intel.com,
 sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 06/12] drm/xe/vrsr: Enable VRSR on default VGA boot
 device
In-Reply-To: <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park,
 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-20-badal.nilawar@intel.com>
 <64894565d5eace99fd65f290ee807dabaa2de04f@intel.com>
 <aWkG5cEapt_attfS@intel.com>
 <431ce6be-b083-4002-8dc1-4be8e557d07c@intel.com>
Date: Tue, 20 Jan 2026 15:43:55 +0200
Message-ID: <e522e352351d52da15c8a9d7f9332e48092f06d4@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, 20 Jan 2026, "Nilawar, Badal" <badal.nilawar@intel.com> wrote:
> On 15-01-2026 20:55, Rodrigo Vivi wrote:
>> On Thu, Jan 15, 2026 at 04:25:06PM +0200, Jani Nikula wrote:
>>> On Tue, 13 Jan 2026, Badal Nilawar <badal.nilawar@intel.com> wrote:
>>>> The VRSR feature is to enhance the display screen refresh experience
>>>> when the device exits from the D3cold state. Therefore, apply the VRSR
>>>> feature to the default VGA boot device and when a display is connected.
>>> I don't understand how you get from the 1st sentence "therefore" the 2nd
>>> sentence. Please elaborate what you're trying to do here, and why.
>> On a scenario with multiple GPU, only one can use the aux power and the
>> feature itself was mainly designed for the display case - to bring up
>> display faster after the d3cold.
> This is to enhance screen refresh experience of primary display.

The way it's being added, it's just really oddly specific.

>>
>> But yes, the right explanation for the why needs to be here.
> I will rephrase the explanation.
>>
>> Also, although unlikely, we never know what users can do out there, and
>> perhaps we will have someone with multiple cards and display plugged in
>> more than one?! We probably also need a global counter/flag to avoid
>> a second one to quick in.
>>
>> But we definitely need to prioritize the first one with display connected.
> At present there is no way to know which one is primary display that's 
> why check is against default_vga_device.
>>
>>> So we have xe_pci_probe() -> xe_pm_init() -> xe_pm_vrsr_init() ->
>>> xe_display_connected() -> intel_display_connected(), and that's the only
>>> path and point in time to check whether displays are connected. If not,
>>> the decision is "not VRSR capable", which is just a weird concusion to
>>> make. The *capability* does not depend on displays, does it?
>>>
>>> If you boot a device without a display, and then plug in a display, no
>>> VRSR for you?
>> yeap, it looks like the check is in the wrong place. It needs to be
>> checked when going to d3cold...
>
> Yes, VRSR will not be enabled if display is not connected at boot.

Why? And this needs to be properly explained in the commit message. The
current one isn't enough.

> *capability* does not depend on display but VRSR use case is.

Please at least don't conflate the two. Don't determine capability based
on whether the conditions on the use case exist.

Contrast with, I don't know, FBC. The platform will still have FBC
capability even if the conditions for enabling it aren't met.

BR,
Jani.


>
>>> More comments inline.
>>>
>>>> v2: Move generic display logic to i915/display (Jani)
>>>>
>>>> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
>>>> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
>>>> ---
>>>>   drivers/gpu/drm/i915/display/intel_display.c | 22 ++++++++++++++++++++
>>>>   drivers/gpu/drm/i915/display/intel_display.h |  1 +
>>>>   drivers/gpu/drm/xe/display/xe_display.c      |  5 +++++
>>>>   drivers/gpu/drm/xe/display/xe_display.h      |  2 ++
>>>>   drivers/gpu/drm/xe/xe_pm.c                   |  5 +++++
>>>>   5 files changed, 35 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.c b/drivers/gpu/drm/i915/display/intel_display.c
>>>> index 81b3a6692ca2..97c74272fb19 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_display.c
>>>> +++ b/drivers/gpu/drm/i915/display/intel_display.c
>>>> @@ -8426,3 +8426,25 @@ bool intel_scanout_needs_vtd_wa(struct intel_display *display)
>>>>   {
>>>>   	return IS_DISPLAY_VER(display, 6, 11) && intel_display_vtd_active(display);
>>>>   }
>>>> +
>>>> +bool intel_display_connected(struct intel_display *display)
>>>> +{
>>>> +	struct drm_connector *list_connector;
>>>> +	struct drm_connector_list_iter iter;
>>>> +	bool ret = false;
>>>> +
>>>> +	mutex_lock(&display->drm->mode_config.mutex);
>>>> +	drm_connector_list_iter_begin(display->drm, &iter);
>>>> +
>>>> +	drm_for_each_connector_iter(list_connector, &iter) {
>>>> +		if (list_connector->status == connector_status_connected) {
>>>> +			ret = true;
>>>> +			break;
>>>> +		}
>>>> +	}
>>>> +
>>>> +	drm_connector_list_iter_end(&iter);
>>>> +	mutex_unlock(&display->drm->mode_config.mutex);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> diff --git a/drivers/gpu/drm/i915/display/intel_display.h b/drivers/gpu/drm/i915/display/intel_display.h
>>>> index f8e6e4e82722..20690aa59324 100644
>>>> --- a/drivers/gpu/drm/i915/display/intel_display.h
>>>> +++ b/drivers/gpu/drm/i915/display/intel_display.h
>>>> @@ -560,5 +560,6 @@ bool assert_port_valid(struct intel_display *display, enum port port);
>>>>   
>>>>   bool intel_scanout_needs_vtd_wa(struct intel_display *display);
>>>>   int intel_crtc_num_joined_pipes(const struct intel_crtc_state *crtc_state);
>>>> +bool intel_display_connected(struct intel_display *display);
>>>>   
>>>>   #endif
>>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
>>>> index f8a831b5dc7d..54ed39b257ad 100644
>>>> --- a/drivers/gpu/drm/xe/display/xe_display.c
>>>> +++ b/drivers/gpu/drm/xe/display/xe_display.c
>>>> @@ -64,6 +64,11 @@ bool xe_display_driver_probe_defer(struct pci_dev *pdev)
>>>>   	return intel_display_driver_probe_defer(pdev);
>>>>   }
>>>>   
>>>> +bool xe_display_connected(struct xe_device *xe)
>>>> +{
>>>> +	return intel_display_connected(xe->display);
>>>> +}
>>>> +
>>>>   /**
>>>>    * xe_display_driver_set_hooks - Add driver flags and hooks for display
>>>>    * @driver: DRM device driver
>>>> diff --git a/drivers/gpu/drm/xe/display/xe_display.h b/drivers/gpu/drm/xe/display/xe_display.h
>>>> index 76db95c25f7e..11d4b09808e5 100644
>>>> --- a/drivers/gpu/drm/xe/display/xe_display.h
>>>> +++ b/drivers/gpu/drm/xe/display/xe_display.h
>>>> @@ -37,6 +37,7 @@ void xe_display_pm_resume(struct xe_device *xe);
>>>>   void xe_display_pm_runtime_suspend(struct xe_device *xe);
>>>>   void xe_display_pm_runtime_suspend_late(struct xe_device *xe);
>>>>   void xe_display_pm_runtime_resume(struct xe_device *xe);
>>>> +bool xe_display_connected(struct xe_device *xe);
>>>>   
>>>>   #else
>>>>   
>>>> @@ -67,5 +68,6 @@ static inline void xe_display_pm_runtime_suspend(struct xe_device *xe) {}
>>>>   static inline void xe_display_pm_runtime_suspend_late(struct xe_device *xe) {}
>>>>   static inline void xe_display_pm_runtime_resume(struct xe_device *xe) {}
>>>>   
>>>> +static inline bool xe_display_connected(struct xe_device *xe) { return false; }
>>> There was a blank line before #endif. Please keep it. Ditto throughout
>>> the series.
>>>
>>>>   #endif /* CONFIG_DRM_XE_DISPLAY */
>>>>   #endif /* _XE_DISPLAY_H_ */
>>>> diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
>>>> index 3fe673f0f87d..e7aa876ce9e0 100644
>>>> --- a/drivers/gpu/drm/xe/xe_pm.c
>>>> +++ b/drivers/gpu/drm/xe/xe_pm.c
>>>> @@ -9,6 +9,7 @@
>>>>   #include <linux/fault-inject.h>
>>>>   #include <linux/pm_runtime.h>
>>>>   #include <linux/suspend.h>
>>>> +#include <linux/vgaarb.h>
>>>>   
>>>>   #include <drm/drm_managed.h>
>>>>   #include <drm/ttm/ttm_placement.h>
>>>> @@ -387,6 +388,7 @@ static int pci_acpi_aux_power_setup(struct xe_device *xe)
>>>>   
>>>>   static void xe_pm_vrsr_init(struct xe_device *xe)
>>>>   {
>>>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>>>>   	int ret;
>>>>   
>>>>   	if (!xe->info.has_vrsr)
>>>> @@ -395,6 +397,9 @@ static void xe_pm_vrsr_init(struct xe_device *xe)
>>>>   	if (!xe_pm_vrsr_capable(xe))
>>>>   		return;
>>>>   
>>>> +	if (pdev != vga_default_device() || !xe_display_connected(xe))
>>> Simply considering the places in the kernel that call
>>> vga_default_device(), this just doesn't feel right.
>> I also don't understand why to check this vga default device...
>
> As previously mentioned, a check for the default VGA device was added to 
> determine if this is the primary display.
>
> Thanks,
> Badal
>
>>
>>>
>>> BR,
>>> Jani.
>>>
>>>
>>>> +		return;
>>>> +
>>>>   	/*
>>>>   	 * If the VRSR initialization fails, the device will proceed with the regular
>>>>   	 * D3cold flow
>>> -- 
>>> Jani Nikula, Intel

-- 
Jani Nikula, Intel
