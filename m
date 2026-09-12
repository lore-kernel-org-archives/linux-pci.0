Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65347A89B;
	Sat, 12 Sep 2026 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789219218; cv=none; b=K6jPe326a4Pp+B6RWG1SIHBTDfxAvy+DwuzZwCI3LymP1c68eZ/Deglq/HfyX23vaH2niARCiFvCMDOac6ktaf1lYwoIdxZjXt/oho+wiRCWc7c01Oa14Zs25jEYhntuEuKXaKbFIyED3vCoa8F9KB2UpIMfs8+QDoFY1sFpoYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789219218; c=relaxed/simple;
	bh=XTJsLnwrNhgezoO+tvyX6TMcd2mpHVISXBNLCjPPTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTKuQDVq/4EHJi9J480+qcnsPFtYLSfiW1MuNkh7NaLFcvrx1b5LEWe8MZYx3gSijBM0K5j00B9u8xjkluQf8kqV4+8t+OutMQH8txeY8lb4AWGn0ZoVaU1D9X3Ju43pm+nAwPCnAzjErD9r6rPVY3Ntm0Je9Kns+YdYP6Pxgwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c6iBN2+0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c6iBN2+0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789219216; x=1820755216;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XTJsLnwrNhgezoO+tvyX6TMcd2mpHVISXBNLCjPPTbA=;
  b=c6iBN2+0mPCVKmUm1PxPdWF0+xZ4ARftzsE0692gBvAiDZxUSpEVbqrZ
   DL9NPeoEMIY1kqJn6iTj8PYqajMGmrfWQ96M/U70RbBOx6jbiI5JnepMQ
   fXQGufELSfmR6GQ5wNbF0y9hafb8BgUXa3ZUEakbh4BksePiN4GUiiRLB
   2JPdJvaIXeCP/SHAA3qKqEnxaV0RW3nRzG0uUwuXUlkMYytcYoWR1Njd4
   JzQ76CEw382VBG3orltka1CZvh0+O00arSlcyLN98tiE1IFytUx1fndvp
   CgkbtFhLiacInuLDz8HlNR065g2t/aThAmSH9DO6OTDXN2eZJRSmmYgj5
   A==;
X-CSE-ConnectionGUID: Oev1BvNyQhaBH9VpqH5Njg==
X-CSE-MsgGUID: sHm+5w5XRKyhZgdgVDjEQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89785119"
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="89785119"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:20:15 -0700
X-CSE-ConnectionGUID: iK3U4KW7QYCRb8l6bA1k8A==
X-CSE-MsgGUID: C1nfPCSAR/uRW9c4hhsYwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,99,1787036400"; 
   d="scan'208";a="295674418"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.239])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2026 06:20:12 -0700
Date: Sat, 12 Sep 2026 16:20:10 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pavol Sakac <sakacpav@amazon.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org, Xu Yang <xu.yang_2@nxp.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	nh-open-source@amazon.com
Subject: Re: [RFC PATCH 6/8] driver core: Defer uevents for devices
 registered in a staged window
Message-ID: <aqVRirAqdynCpG13@ashevche-desk.local>
References: <20260911-vfopt-s5-v1-0-fa4cacdb6ca8@amazon.de>
 <20260911174414.97060-6-sakacpav@amazon.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911174414.97060-6-sakacpav@amazon.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 11, 2026 at 07:43:38PM +0200, Pavol Sakac wrote:
> Staged registration publishes a device's subtree in one step, so nothing
> observes the device before it is complete. That does not hold for a
> device registered from inside the window: device_add() calls hooks that
> can register a child of the device being added, and such a child takes
> the eager path and announces itself with KOBJ_ADD while its own path
> resolves to nothing. Nothing replays that event, so a consumer that
> cannot open the DEVPATH never learns of the child. Neither opt-in in
> this series reaches that case: nothing attaches a wakeup source to a
> PCI VF or to the VFIO class devices, and pci_acpi_setup() enables
> wakeup only for a bridge that can do D3. It is reachable by code the
> opt-in caller does not control: dpm_sysfs_add() registers a
> wakeup-source device whenever power.wakeup is already attached, and
> wakeup_source_register() registers one directly for a device that is
> already registered, which a staged device is. The driver core
> therefore handles the case rather than forbidding it in the opt-in
> contract.
> 
> Defer such a registration, composing the idiom block/genhd.c already uses
> for a disk's partition tree: suppress the uevents, complete the tree,
> then unsuppress and replay KOBJ_ADD. A device whose directory kernfs
> marked staged is enqueued suppressed on the window of the nearest
> ancestor that opted in, and the window is drained as the ancestor's
> device_add() returns, just after its own KOBJ_ADD, each member's ADD
> delivered in registration order followed by BIND where a driver bound
> in the window. An ancestor whose owner suppresses its uevent and
> replays it after registration will see members announced before its
> replayed ADD. The window lives in a global hashtable keyed by the
> opted-in device, so no struct grows.
> 
> Members are expected to be registered synchronously by the opted-in
> device_add() that owns the window, the only shape the driver core can
> reason about here. Raw uevent_suppress is not reused as the detection
> marker, precisely because a subsystem may already own it; a device found
> already suppressed is left out of the window entirely. An in-window
> KOBJ_CHANGE is dropped rather than replayed, as in the genhd case, since
> only the addition can be reconstructed afterwards. A failed opted-in
> registration closes its window without replaying anything and leaves
> suppression set, so a member's KOBJ_REMOVE is dropped too and userspace
> never sees a removal for an addition it never saw.
> 
> The staged_device suite gains five cases for the window: the replay of a
> member's addition once the owner's device_add() returns, the aborted
> window that replays nothing and leaves suppression set, a member behind
> a class glue directory, the reconstructed KOBJ_BIND of a driver bound in
> the window, and a member found already suppressed being left out of the
> window.
> 
> If you would rather not carry this until a caller needs it, it can be
> dropped and the restriction stated as an opt-in condition instead.

...

> +	member->dev = get_device(dev);
> +
> +	spin_lock(&staged_windows_lock);
> +	hash_for_each_possible(staged_windows, win, node, (unsigned long)top) {
> +		if (win->top != top)
> +			continue;
> +		dev_set_uevent_suppress(dev, 1);
> +		list_add_tail(&member->node, &win->members);
> +		member = NULL;
> +		break;
> +	}
> +	spin_unlock(&staged_windows_lock);
> +
> +	if (member) {
> +		put_device(dev);

With this condition it makes sense to use the same argument, id est
member->dev.

> +		kfree(member);
> +	}

...

> +/*
> + * Records the child's replayed uevents as they are dispatched through the
> + * bus uevent callback -- which runs upstream of netlink broadcast, so this
> + * observes action-specific kernel dispatch and ordering, not reception by
> + * any consumer.  Scoped to the active context's child: the same static bus
> + * serves another case, and teardown emits further events.
> + */
> +static int staged_test_bus_uevent(const struct device *dev,
> +				  struct kobj_uevent_env *env)
> +{
> +	struct staged_window_ctx *c = staged_window_ctx;
> +	int i;

Why signed?

> +	if (!c || dev != c->child)
> +		return 0;
> +
> +	for (i = 0; i < env->envp_idx; i++) {


	for (int i = 0; i < env->envp_idx; i++) {

> +		if (!strcmp(env->envp[i], "ACTION=add")) {
> +			c->add_uevents++;
> +			c->add_seq = ++c->uevent_seq;
> +		} else if (!strcmp(env->envp[i], "ACTION=bind")) {
> +			c->bind_uevents++;
> +			c->bind_seq = ++c->uevent_seq;

Why preincrements?

> +		}
> +	}

Missing blank line.

> +	return 0;
> +}

...

> +static struct attribute in_window_attr = {
> +	.name = "in_window_attr", .mode = 0644,
> +};

I believe you haven't read the generated code. Do you understand what it does
(I mean the whole your patch and patch series)?

...

> +static const struct attribute_group *in_window_grps[] = {
> +	&in_window_grp, NULL,
> +};

Same style issue.

Also we have __ATRIBUTE_GROUPS() macro.

-- 
With Best Regards,
Andy Shevchenko


