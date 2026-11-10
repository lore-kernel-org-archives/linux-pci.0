Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309773;
	b=r7kokIDxJ5TYzcE1HZt+rAKtj2l2nT68IHiSWbnUn/6N3i9FPolVCgR/Lzg5KuvL66s8
	 fHWfwdc1nGd50YVuzy4/Bb8sMLR9Emu8XEHfbhbO9NTPAqmqdC3lvGw244emljXEFWq0Y
	 1nBXX9Iiau9BQHTmK+hUsTab82GJ+zL2FD9irzMgu3S/eZyltU/nDNJ8/3wBqhyDVqsyU
	 kLZtEHjg/dkuyFRP8+VY9m3qtmsU0QJJEAQZJr4P6yRRUT5zdK4OwtKxwoyBbZB7ku0aC
	 ++yFu5OJT8xH+hCTmb0omCsleQsDwiOwie0gTI4mt3/Rucn9zIo0bWKNc3D6RCYdyuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309773;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=r5BObBbZgUS5+tPHOoP4WnX3Q1F+kMLyB8Eo871CKgM=;
	b=wAjxw8nAotPF6GHai0oW7cC+UC/bm0yeTpo23BpNnv+KzAndZqm7LL+n9RSMOtW5iQL2
	 Fs3AhulN+WvUjprRUAjJn3A20x+0jmdp3PE+nV5trUoQwFtHt6TVmOf2s8egTzZrKkLSu
	 pIO0EUTyFIHBpc9FmEZs7mF/k5w0eRyR2po68DcBbvX5jO9jlgZtYw3lT/aD1Id8D285l
	 BcHd6pKmA6JJQD7O+st/YANAEzaucW0Ly/bWwYEZeANKN00GU3xc+UNHe2Yk0Cl5nB+hU
	 bYJflKBcTkj1UkDmg8F/Xw6gxIC353turgGtRDebyB4x44LmhGkhOrgsq9q6/sJyVqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XmQ0Cx0W;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CBC606A32A;
	Tue, 10 Nov 2026 11:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7CBC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XmQ0Cx0W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794309773; x=1825845773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=zUxil3M4apIBoPLoUunAgoPPqe4wYpmHDM6G4Iocbn4=;
  b=XmQ0Cx0W3o+4ZDTsTbu7clndXaHBqN2kD5qGq800gnD8ldHmDQZbXLO2
   lOSKhla5g9uK4dzf+nxBiK18mHieTrUEGWXmfkTLnguLJOWQK5XznGzTZ
   9zDsTFGK4bwxmhUcEuiYgmpcJ4TZw+A9E+MzYXdQTel7aAp/qkugF2Q4R
   zySS489dBgVAvVbDkairmmkbXasecXHWc1QBTV2squvc47oWFZkDyiuGR
   /Yf+zLnVRmDV5I/eTJ/ODIChfDK3I5xVQqilXgvpKx9TU8H9fxcL0dveG
   UtZgp8vz6lloJxGZ5tUOQAq9sL/PJsMFL44l2cN7ASM1CwCiNRy8D6HvZ
   g==;
X-CSE-ConnectionGUID: x+lvQnRlTdSP6jT2oshg9Q==
X-CSE-MsgGUID: K5tCfXnZRk23kCdzF1BdMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3041816"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3041816"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:22:51 -0800
X-CSE-ConnectionGUID: lo2+23a8T+elsMMG2QX3dQ==
X-CSE-MsgGUID: HONsXu23Tf2Cvc1+NLVxuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="8453251"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 03:22:48 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 10 Nov 2026 13:22:44 +0200 (EET)
To: kameron.markham@gmail.com
cc: Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    linux-pci@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [PATCH] PCI: Don't add failed disabled ROM BARs to fail_head
In-Reply-To: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com>
Message-ID: <7b7f0266-693d-7a9e-88f6-e3c60ec5c3fa@linux.intel.com>
References: <20261109-r730-disabled-rom-fail-head-v1-1-88ef813d125e@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 9 Nov 2026, Kameron Markham via B4 Relay wrote:

> From: Kameron Markham <kameron.markham@gmail.com>
> 
> On Dell PowerEdge R730 servers with "SR-IOV Global Enable" disabled in
> the BIOS setup, kernels since v6.15 hard-reset while igb probes the
> on-board Intel I350 NIC. The iDRAC logs PWR2262 ("The Intel Management
> Engine has reported an internal system error"), CPU0000 (IERR) and a
> CPU machine check, and the BIOS sometimes halts in POST afterwards
> (PST0208). v6.14 boots fine on the same machine.
> 
> With SR-IOV Global Enable disabled, the firmware does not assign the VF
> BARs of the on-board 82599 NIC, so pci_realloc_detect() enables
> resource reallocation automatically. On the first assignment pass the
> disabled Expansion ROM BARs of three devices cannot be assigned:
> 
>   pci 0000:02:00.0: ROM [mem size 0x00100000 pref]: can't assign; no space
>   pci 0000:01:00.1: ROM [mem size 0x00080000 pref]: can't assign; no space
>   pci 0000:07:00.1: ROM [mem size 0x00080000 pref]: can't assign; no space
>
> Before commit 96336ec70264 ("PCI: Perform reset_resource() and build
> fail list in sync"), __assign_resources_sorted() did not put a failed
> disabled ROM BAR on fail_head ("If the failed resource is a ROM BAR and
> it will be enabled later, don't add it to the list."). That commit moved
> the check into the new loop at the end of the function, but passes an
> idx that is not computed for the resource being checked, so the check
> no longer recognizes ROM BARs. Commit 2499f5348431 ("PCI: Rewor  
> optional resource handling") then removed the check.

As you can see, it was very much an intentional change.

Please don't justify changes with what is required for keeping things 
bisectable through a series (which I apparently failed to do by not 
recalculating the idx variable properly but that code is gone by now, so 
that omission is largely irrelevant at this point).

> The failed disabled ROM BARs therefore end up on fail_head, and
> pci_assign_unassigned_root_bus_resources() starts another round that
> releases and reassigns bridge windows the firmware set up, including

This is the intended behavior!

> the window of the PCH root port 00:1c.4 and the I350 behind it:
> 
>   PCI: No. 2 try to assign unassigned res
>   pci 0000:00:1c.4: resource 14 [mem 0x91a00000-0x91bfffff] released
>   pci 0000:00:1c.4: bridge window [mem 0x92200000-0x924fffff]: assigned
>   pci 0000:07:00.0: BAR 0 [mem 0x92200000-0x9227ffff]: assigned
> 
> The machine resets when igb then accesses the I350 at the new address.
> Why the platform does not tolerate the move is not known.

So all resources that were assigned prior to starting were assigned 
succesfully? Which would mean there was nothing wrong with the fail_list & 
ROM resource handling.

So far, all looks to be working as intended so the changelog surely needs 
a major revision to actually explain what the real problem here is if it 
comes down to the resource assignment algorithm having a problem. You only 
describe intermediate state related errors, and those are very much 
expected even when the algorithm works as intended.


This might be more a quirk territory if the resources were assigned just 
fine but some device fails / crashes when given a valid address for its 
BAR(s).

> Restore the old behavior: add pci_resource_is_disabled_rom(), the
> helper the first of these commits already called, and don't put a
> failed disabled ROM BAR on fail_head. Such a BAR is still reset as before.
> Other failed resources, including optional SR-IOV BARs, are still added
> to fail_head, so reallocation can still make room for them.
> 
> Tested on a Dell PowerEdge R730 (BIOS 2.19.0, SR-IOV Global Enable
> disabled): v6.17 and v7.4-rc2 hard-reset on every boot without this
> patch and boot normally with it; no second assignment round happens and
> the I350 keeps its firmware-assigned window. Enabling SR-IOV Global
> Enable in the BIOS, or booting with pci=realloc=off, also avoids the
> problem.
> 
> The bisection, the analysis, this patch and this changelog were done
> with the help of an AI coding assistant (Claude, by Anthropic). All
> testing was done on the hardware described above.

This kind of paragraph belongs below --- line.

> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222253
> Cc: stable@vger.kernel.org
> Signed-off-by: Kameron Markham <kameron.markham@gmail.com>
> ---
> Notes for reviewers (not part of the changelog):
> 
> - Bisected between v6.14 (good) and v6.17 (bad) on the affected machine
>   with test kernels booted from RAM over PXE. 96336ec70264 does not
>   build on its own (pci_resource_is_disabled_rom() is not defined by any
>   commit), so for the bisect it was built with a one-line definition
>   identical to the open-coded check it replaced. Its parent e89df6d2beae
>   boots; 96336ec70264 resets.
> 
> - Only the SR-IOV Global Enable BIOS switch matters: stock v6.17 boots
>   with only that switch enabled, and still resets with X2APIC and I/OAT
>   enabled but SR-IOV disabled. (User reports often recommend all three.)
> 
> - Alternative considered: make pci_assign_unassigned_root_bus_resources()
>   retry only when a required resource failed. That would also change how
>   failed optional SR-IOV BARs drive reallocation, so this patch restores
>   the pre-v6.15 behavior for disabled ROM BARs only.

...So the LLM says but I don't take it for granted. ;-)

There's also another level which actual does categorize the failures 
below pci_assign_unassigned_root_bus_resources().

If you think there's something wrong with SR-IOV behavior, fix that also 
but don't justify wrong level change with it.

But you need to explain what is wrong with the end state of the resource 
assignment algorithm, not the intermediate problems it shows while it's 
still running because those are expected and are there to help issue 
diagnosis (we could print just the end result but then who would be able 
to debug that?).

> - Serial console logs of good and bad boots, the bisect log, the BIOS
>   switch matrix and the test scripts are attached to the bugzilla entry
>   in the Closes: tag.

Sadly bugzilla is not working at the moment so I cannot check these but 
I'll get back to them later.

> - Tool use, per Documentation/process/generated-content.rst: Claude
>   (Anthropic) running in Claude Code, driven by the submitter, ran the
>   automated bisection on the hardware, read the PCI resource assignment
>   code, proposed this change and drafted this message. The submitter
>   reviewed the change and the analysis.
> ---
>  drivers/pci/setup-bus.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index ed16ef7c26..6506e44866 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -377,6 +377,17 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  	}
>  }
>  
> +/*
> + * A disabled Expansion ROM BAR is only enabled later if it is needed, so
> + * failing to assign it does not leave the device unusable.
> + */
> +static bool pci_resource_is_disabled_rom(const struct pci_dev *dev,
> +					 const struct resource *res)
> +{
> +	return pci_resource_num(dev, res) == PCI_ROM_RESOURCE &&
> +	       !(res->flags & IORESOURCE_ROM_ENABLE);
> +}
> +
>  bool pci_resource_is_optional(const struct pci_dev *dev, int resno)
>  {
>  	const struct resource *res = pci_resource_n(dev, resno);
> @@ -743,7 +754,12 @@ static void __assign_resources_sorted(struct list_head *head,
>  		if (resource_assigned(res))
>  			continue;
>  
> -		if (fail_head) {
> +		/*
> +		 * Don't put a disabled ROM BAR on fail_head: failing to
> +		 * assign it must not trigger the release and reassignment
> +		 * of bridge windows that are already in use.
> +		 */
> +		if (fail_head && !pci_resource_is_disabled_rom(dev, res)) {

This isn't the right place for this. All failed resources should be 
returned for the algorithm retry / window resizing to work properly. 
Period.

This has been proposed earlier and it hasn't turned correct approach 
since then:

https://lore.kernel.org/linux-pci/20260717180029.1829888-1-anthony.pighin@nokia.com/

-- 
 i.

