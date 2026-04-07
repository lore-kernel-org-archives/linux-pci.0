Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3629B38C2C3;
	Tue,  7 Apr 2026 06:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775544822; cv=none; b=HkmNX4t3S4K3L6+7XbJl2MztYD7qnDEBHyNoe6yay4ofp7X4qv6g0t3buv9cdGHsWdBT21dyDW3WWzIXddbqclG6iSpuoiMrhcv0v+oYJoOvh8v7EGJCyfHkbM19dyYqk4JomaMIPUR+/h6ilz9jnQSCg+CoxaDNNeu73NhD0iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775544822; c=relaxed/simple;
	bh=0ylP3qPddIE6iKieDpcRNjjkdOUWN7+gbfiTZw5y9BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaJHCvu6C+6eLHZLsLG1ASz27iLrBt7Ztatf7C7ymmrxZNxiJ5P4Qd7KDfID+fI815KSVR/FazSBxzpp0n3ZKC4x5Es5fy6XbyxehkCysOE4PimLCkg/qvU+E5CVHjthCdthY3hepsoTTkTe+hGDxvmENr4CAm0PZ2PL3VsqUl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f7bY7P9i; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f7bY7P9i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775544820; x=1807080820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ylP3qPddIE6iKieDpcRNjjkdOUWN7+gbfiTZw5y9BE=;
  b=f7bY7P9ivZqA0znFudJ0GMv2TtXinCRUbxdu9CVJXwsoN/ZKd3vV3wLw
   me6CpfASXGypZJ45nnKt8w6/53p8rVoTc25DogKj/UYmo5liI6gMf/YNX
   DKlyAZoNATFl+sYIWLnxzG93sXLL8ZirMc92eR2VrhQXkFX7XsAEJupzQ
   /1YYgQXZkNc5zPPd2xIGpilosd3rwH4qxZuUGmL0mYn6O0y45F/+vfLc/
   Mq0WNrYA/BS/Xk/C/xuqSDaRSMKg6ibam2beYlrcBPqjEPhPwGM3H45dX
   WhSIdgotFx6OXG43OyrAfDaRItvseYxb0oUfsCgz/OIN8PS4PDqbrPfPr
   A==;
X-CSE-ConnectionGUID: GCFJ7AUcTU2T5GvHj74EoA==
X-CSE-MsgGUID: OEGfofX8QO+088NffQIHVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="64046699"
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="64046699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 23:53:21 -0700
X-CSE-ConnectionGUID: iSNZMh5iTqqQpKQNzsq4cA==
X-CSE-MsgGUID: Onw+95tRTxCMlGBz5WScxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,165,1770624000"; 
   d="scan'208";a="251373004"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 06 Apr 2026 23:53:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 49A9095; Tue, 07 Apr 2026 08:53:15 +0200 (CEST)
Date: Tue, 7 Apr 2026 08:53:15 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
	netdev@vger.kernel.org, andriy.shevchenko@intel.com,
	ilpo.jarvinen@linux.intel.com, dima.ruinskiy@intel.com,
	mbloch@nvidia.com, leon@kernel.org, linux-pci@vger.kernel.org,
	saeedm@nvidia.com, tariqt@nvidia.com, lukas@wunner.de,
	bhelgaas@google.com, richardcochran@gmail.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: Re: [PATCH net-next 01/15] igc: Call netif_queue_set_napi() with
 rtnl locked
Message-ID: <20260407065315.GD3552@black.igk.intel.com>
References: <20260331173728.GA146742@bhelgaas>
 <9f169800-12f2-4f98-ab99-e4433b2b49a9@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9f169800-12f2-4f98-ab99-e4433b2b49a9@redhat.com>

Hi,

On Thu, Apr 02, 2026 at 12:29:06PM +0200, Paolo Abeni wrote:
> On 3/31/26 7:37 PM, Bjorn Helgaas wrote:
> > On Mon, Mar 30, 2026 at 04:02:30PM -0700, Tony Nguyen wrote:
> >> From: Mika Westerberg <mika.westerberg@linux.intel.com>
> >>
> >> When runtime resuming igc we get:
> >>
> >>   [  516.161666] RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> >>
> >> Happens because commit 310ae9eb2617 ("net: designate queue -> napi
> >> linking as "ops protected"") added check for this. For this reason drop
> >> the special case for runtime PM from __igc_resume(). This makes it take
> >> rtnl lock unconditionally.
> > 
> > Taking the rtnl lock unconditionally certainly makes the code nicer,
> > but the commit log only mentions the "avoid the warning" benefit, not
> > the actual reason this is safe to do.
> 
> Sashiko says it's not safe:
> 
> ---
> Can this regression cause a self-deadlock when a runtime resume is
> triggered from paths that already hold the rtnl lock?
> If the network interface is logically up but the link is disconnected,
> igc_runtime_idle() allows the device to enter runtime suspend. When a
> user queries the device using ethtool, the networking core acquires
> rtnl_lock() and then calls pm_runtime_get_sync() to ensure the hardware
> is awake.
> This synchronously executes the driver's runtime resume callback, which
> calls __igc_resume(). Because netif_running(netdev) is true, the
> modified __igc_resume() unconditionally attempts to acquire rtnl_lock().
> Since the executing thread already holds this non-recursive mutex, it
> appears the system would self-deadlock, hanging the network stack.
> ---

It's a good analysis. I just tried this flow:

1. Boot the system up, nothing connected to igc NIC.
2. Plug in cable to igc.
3. Configure the interface.
4. Enable runtime PM for igc.
5. Unplug the cable.
6. Verify igc is runtime suspended.
7. Run ethtool <interface>

This leads to deadlock as below.

igc maintainers, please drop this patch. I apologize I did not realize this
flow when I did it.

[ 1231.655924] INFO: task ethtool:3139 blocked for more than 122 seconds.
[ 1231.662515]       Tainted: G     U              7.0.0-rc6+ #1748
[ 1231.668551] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1231.676410] task:ethtool         state:D stack:0     pid:3139  tgid:3139  ppid:292    task_flags:0x480000 flags:0x00080800
[ 1231.687508] Call Trace:
[ 1231.689997]  <TASK>
[ 1231.692132]  __schedule+0x58a/0x1820
[ 1231.695747]  ? sysvec_apic_timer_interrupt+0x4c/0xa0
[ 1231.700742]  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
[ 1231.706090]  schedule+0x64/0xe0
[ 1231.709262]  schedule_preempt_disabled+0x15/0x30
[ 1231.713907]  __mutex_lock+0x377/0xa60
[ 1231.717606]  __mutex_lock_slowpath+0x13/0x20
[ 1231.721905]  mutex_lock+0x2c/0x40
[ 1231.725259]  rtnl_lock+0x15/0x20
[ 1231.728541]  __igc_resume+0x19a/0x2b0 [igc]
[ 1231.732798]  igc_runtime_resume+0xe/0x20 [igc]
[ 1231.737288]  pci_pm_runtime_resume+0xce/0x100
[ 1231.741678]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[ 1231.746681]  __rpm_callback+0xab/0x310
[ 1231.750458]  ? ktime_get_mono_fast_ns+0x3a/0x100
[ 1231.755107]  ? __pfx_pci_pm_runtime_resume+0x10/0x10
[ 1231.760096]  rpm_resume+0x4bb/0x670
[ 1231.763618]  __pm_runtime_resume+0x5c/0x80
[ 1231.767749]  dev_ethtool+0x19d/0xc90
[ 1231.771352]  dev_ioctl+0x23c/0x550
[ 1231.774791]  sock_do_ioctl+0x11f/0x1b0
[ 1231.778569]  sock_ioctl+0x27f/0x390
[ 1231.782091]  ? handle_mm_fault+0x11a5/0x1250
[ 1231.786388]  __se_sys_ioctl+0x75/0xd0
[ 1231.790077]  __x64_sys_ioctl+0x1d/0x30
[ 1231.793851]  x64_sys_call+0x14ed/0x2d30
[ 1231.797719]  do_syscall_64+0xfb/0x680
[ 1231.801404]  ? arch_exit_to_user_mode_prepare+0xd/0xb0
[ 1231.806559]  ? irqentry_exit+0x3b/0x510
[ 1231.810413]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
