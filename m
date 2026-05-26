Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B2E3B3BF7;
	Tue, 26 May 2026 14:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779806718; cv=none; b=UPyGjB07wbrcSWbz7hARd8dadDThCWGvgK/EdYfsEAsoV9ruNR2iWpdyDulM9MOD72p4Y4OKP9kgOsQJblKIKzl9nURT1wjFkw8e1xrl8EG/V9YOL8UYnnNL1U7VmuplUHgWPP3JZjb02BGDJ6ARoaeih5MVvg6CJjAfsKtUdEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779806718; c=relaxed/simple;
	bh=wvE4PKWW4wC5ScBLUT+4n4GbY3SgwvdjS6rpoqiE6s0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7BNaAKAHJvSuoCQNeyS4e4/yvpimPmZq0p3/U3486oWfUBhVqYv0wrRSwHHlrj6xzN9278vvlElgatEyiv8lxKbSmMdjqjszySUyFxQOUYT4mTQ/gdSm6j6rLWSjjZMMhHfSJ0MVfHZDPQASwRzhqN7QS2YfiRLGfyx0vyhKbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ui3QX9V9; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ui3QX9V9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779806715; x=1811342715;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wvE4PKWW4wC5ScBLUT+4n4GbY3SgwvdjS6rpoqiE6s0=;
  b=Ui3QX9V9exHhKgQRUTQnX0gCdBwqf8CytSVJAAU8E1igA1f11efnln5z
   gm9/+ee3HLfu8Av6U57j7HwsRLLt2ERfLQIjJvDns7TWrNgnw0aXIjI/z
   mWLCiZ3X9inflX08NFU9njwGIww0Ksia8AhHN0haA4gChymsZ4JFjmMWj
   aK4Rae1so+QiQAHhgapWivGCVMwUoYKmtlUkgmZsaDZM3ex6xAicxlrWT
   ScbFvuotO+z8ZvSlgYm/aDH8NWGxG4ACHmFHKPsX+4HViQTYKyeGvpqbq
   g7qcNNzZ2168A7AS+F//QIKFyrn8u2ugZGomLqSNEgd76XiPumwEMrULV
   A==;
X-CSE-ConnectionGUID: OrguXhBLRFC7TyabDdWx+A==
X-CSE-MsgGUID: WHP5kvEQRpyyzllFycORDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80679844"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80679844"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:45:13 -0700
X-CSE-ConnectionGUID: 9KCCFXyGTQGavp4oo43a3A==
X-CSE-MsgGUID: iLOqq9rVSiW/eJSwh8Vouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="265795759"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 07:45:12 -0700
Message-ID: <00a0beca-3213-4286-8e6d-72a310664792@intel.com>
Date: Tue, 26 May 2026 07:45:11 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] PCI: endpoint: pci-epf-vntb / NTB: epf: Enable
 per-doorbell bit handling
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Niklas Cassel
 <cassel@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, ntb@lists.linux.dev
References: <20260513024923.451765-1-den@valinux.co.jp>
 <923e522c-c288-4ab1-8206-9b7654ec9919@intel.com>
 <zgleppcjdym7hhoifhk3icze2ptualqwaalcyd45iwazmnwy4q@56dqc5uphi4w>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <zgleppcjdym7hhoifhk3icze2ptualqwaalcyd45iwazmnwy4q@56dqc5uphi4w>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/20/26 11:29 PM, Koichiro Den wrote:
> On Tue, May 19, 2026 at 02:29:51PM -0700, Dave Jiang wrote:
>>
>>
>> On 5/12/26 7:49 PM, Koichiro Den wrote:
>>> This series fixes doorbell bit/vector handling for the EPF-based NTB
>>> pair (ntb_hw_epf <-> pci-epf-*ntb). Its primary goal is to enable safe
>>> per-db-vector handling in the NTB core and clients (e.g. ntb_transport),
>>> without changing the on-the-wire doorbell mapping.
>>>
>>>
>>> Background / problem
>>> ====================
>>>
>>> ntb_hw_epf historically applies an extra offset when ringing peer
>>> doorbells: the link event uses the first interrupt slot, and doorbells
>>> start from the third slot (i.e. a second slot is effectively unused).
>>> pci-epf-vntb carries the matching offset on the EP side as well.
>>>
>>> As long as db_vector_count()/db_vector_mask() are not implemented, this
>>> mismatch is mostly masked. Doorbell events are effectively treated as
>>> "can hit any QP" and the off-by-one vector numbering does not surface
>>> clearly.
>>>
>>> However, once per-vector handling is enabled, the current state becomes
>>> problematic:
>>>
>>>   - db_valid_mask exposes bits that do not correspond to real doorbells
>>>     (link/unused slots leak into the mask).
>>>   - ntb_db_event() is fed with 1-based/shifted vectors, while NTB core
>>>     expects a 0-based db_vector for doorbells.
>>>   - On pci-epf-vntb, .peer_db_set() may be called in atomic context, but
>>>     it directly calls pci_epc_raise_irq(), which can sleep.
>>>
>>>
>>> Why NOT fix the root offset?
>>> ============================
>>>
>>> The natural "root" fix would be to remove the historical extra offset in
>>> the peer_db_set() doorbell paths for ntb_hw_epf and pci-epf-vntb.
>>> Unfortunately this would lead to interoperability issues when mixing old
>>> and new kernel versions (old/new peers). A new side would ring a
>>> different interrupt slot than what an old peer expects, leading to
>>> missed or misrouted doorbells, once db_vector_count()/db_vector_mask()
>>> are implemented.
>>>
>>> Therefore this series intentionally keeps the legacy offset, and instead
>>> fixes the surrounding pieces so the mapping is documented and handled
>>> consistently in masks, vector numbering, and per-vector reporting.
>>>
>>>
>>> Dependencies
>>> ============
>>>
>>> This v4 is prepared on top of the current pci/endpoint:
>>> commit f5aa97125491 ("misc: pci_endpoint_test: remove dead BAR read before
>>>                       doorbell trigger")
>>
>> I can't seem to apply the patch set via 'b4 shazam' on top of f5aa97125491. Trying to set it up for review.
> 
> Hi Dave,
> 
>>
>> DJ
>>
>>>
>>> plus these patches as contextual prerequisites:
>>>
>>>   - [PATCH 0/2] NTB: epf: Fix ntb_hw_epf ISR issues
>>>     https://lore.kernel.org/ntb/20260304083028.1391068-1-den@valinux.co.jp/
>>>
>>>   - [PATCH 0/2] PCI: endpoint: pci-epf-{v}ntb: A couple of fixes
>>>     https://lore.kernel.org/linux-pci/20260407124421.282766-1-mani@kernel.org/
>>>
>>> (These touch the same code part as this series and would otherwise conflict
>>> with it. They should land upstream first in my opinion.)
> 
> This series depends on the two prerequisite series listed above.

They don't apply cleanly either. Do you have a public repo somewhere that has everything applied? That may be the easiest way to do things if a series has complicated dependencies.

DJ

> 
> Best regards,
> Koichiro
> 
>>>
>>>
>>> Practical benefit
>>> =================
>>>
>>> This also enables ntb_netdev's multi-queue performance scale:
>>>
>>>   [PATCH v3 0/4] net: ntb_netdev: Add Multi-queue support
>>>   https://lore.kernel.org/netdev/20260305155639.1885517-1-den@valinux.co.jp/
>>>
>>> Each netdev queue maps to an ntb_transport queue pair. With correct
>>> db_vector_count() and db_vector_mask() callbacks, ntb_transport can wake
>>> only the queue pairs covered by the doorbell vector it received. Without
>>> those callbacks, the NTB core falls back to the full valid doorbell mask,
>>> so each doorbell interrupt can still wake all queue pairs. See "Testing /
>>> Results" section in the above link.
>>>
>>>
>>> What this series does
>>> =====================
>>>
>>> - pci-epf-vntb:
>>>
>>>   - Document the legacy offset.
>>>   - Defer MSI doorbell raises to process context to avoid sleeping in
>>>     atomic context. This becomes relevant once multiple doorbells are
>>>     raised concurrently at a high rate.
>>>   - Report doorbell vectors as 0-based to ntb_db_event().
>>>   - Reject unusable doorbell counts and guard configfs writes after EPC
>>>     attach with -EOPNOTSUPP.
>>>   - Fix db_valid_mask and implement db_vector_count()/db_vector_mask().
>>>
>>> - ntb_hw_epf:
>>>
>>>   - Document the legacy offset in ntb_epf_peer_db_set().
>>>   - Fix db_valid_mask to cover only real doorbell bits.
>>>   - Report 0-based db_vector to ntb_db_event() (accounting for the
>>>     unused slot).
>>>   - Pass per-vector context as request_irq() dev_id instead of deriving the
>>>     device vector from Linux IRQ numbers.
>>>   - Keep db_val as a bitmask and fix db_read/db_clear semantics
>>>     accordingly.
>>>   - Implement db_vector_count()/db_vector_mask().
>>>
>>>
>>> Compatibility
>>> =============
>>>
>>> By keeping the legacy offset intact, this series aims to remain
>>> compatible across mixed kernel versions. The observable changes are
>>> limited to correct mask/vector reporting and safer execution context
>>> handling.
>>>
>>> Patches 1-7 (PCI Endpoint) and 8-12 (NTB) are independent and can be
>>> applied separately through the respective trees. They are sent together so
>>> the two sides of the same legacy layout do not drift apart, and the
>>> resulting code stays easier to follow.
>>>
>>> The plan is still to take the whole series through the PCI EP tree once the
>>> remaining NTB acks are collected. See:
>>> https://lore.kernel.org/linux-pci/rnzsnp5de4qf5w7smebkmqekpuaqckltx73rj6ha3q2nrby5yp@7hsgvdzvjkp6/
>>>
>>>
>>> Note
>>> ====
>>>
>>> Most v3->v4 changes are responses to Sashiko feedback:
>>> https://sashiko.dev/#/patchset/20260323031544.2598111-1-den%40valinux.co.jp
>>>
>>> Sashiko also flagged a broader driver-unbind lifetime concern around the
>>> vNTB PCI driver. That is real, but it predates this series and needs a
>>> proper .remove() path, including NTB unregistration and work cancellation.
>>> I am keeping it as follow-up lifecycle work:
>>>
>>> https://lore.kernel.org/linux-pci/20260226084142.2226875-1-den@valinux.co.jp/
>>>
>>> This v4 only clears the deferred doorbell state added by this series around
>>> EPC init/cleanup.
>>>
>>>
>>> ---
>>> Changelog
>>> =========
>>>
>>> Changes since v3:
>>>   - Rebased on the dependencies listed above.
>>>   - For Sashiko feedback on state added by this series: clear
>>>     peer_db_pending around work enable/disable, mask peer_db_set() with
>>>     db_valid_mask, and use __ffs64().
>>>   - For pre-existing issues made more relevant by per-vector semantics:
>>>     stop deriving ntb_hw_epf vectors from Linux IRQ numbers, pass
>>>     per-vector request_irq() context, ignore the reserved slot, and
>>>     validate vectors before BIT_ULL()/ntb_db_event().
>>>   - Added adjacent hardening: pci-epf-vntb db_count range/configfs guards,
>>>     bounded db_vector masks, ntb_hw_epf mw_count precheck, and helper guard
>>>     cleanups.
>>>   - Dropped Reviewed-by tags from patches that changed to non-trivial extent.
>>>
>>> Changes since v2:
>>>   - No functional changes.
>>>   - Rebased onto current pci/endpoint
>>>     e022f0c72c7f ("selftests: pci_endpoint: Skip reserved BARs").
>>>     * Patch 2 needed a trivial context-only adjustment while rebasing, due
>>>       to commit d799984233a5 ("PCI: endpoint: pci-epf-vntb: Stop
>>>       cmd_handler work in epf_ntb_epc_cleanup").
>>>   - Picked up additional Reviewed-by tags from Frank.
>>>   - Fixed the incorrect v2 series title.
>>>
>>> Changes since v1:
>>>   - Addressed feedback from Dave (add a source code comment, introduce
>>>     enum to eliminate magic numbers)
>>>   - Updated source code comment in Patch 2.
>>>   - No functional changes, so retained Reviewed-by tags by Frank and Dave.
>>>     Thank you both for the review.
>>>
>>> v3: https://lore.kernel.org/linux-pci/20260323031544.2598111-1-den@valinux.co.jp/
>>> v2: https://lore.kernel.org/linux-pci/20260227084955.3184017-1-den@valinux.co.jp/
>>> v1: https://lore.kernel.org/linux-pci/20260224133459.1741537-1-den@valinux.co.jp/
>>>
>>>
>>> Best regards,
>>> Koichiro
>>>
>>>
>>> Koichiro Den (12):
>>>   PCI: endpoint: pci-epf-vntb: Document legacy MSI doorbell offset
>>>   PCI: endpoint: pci-epf-vntb: Defer pci_epc_raise_irq() out of atomic
>>>     context
>>>   PCI: endpoint: pci-epf-vntb: Report 0-based doorbell vector via
>>>     ntb_db_event()
>>>   PCI: endpoint: pci-epf-vntb: Reject unusable doorbell counts
>>>   PCI: endpoint: pci-epf-vntb: Guard configfs writes after EPC attach
>>>   PCI: endpoint: pci-epf-vntb: Exclude reserved slots from db_valid_mask
>>>   PCI: endpoint: pci-epf-vntb: Implement db_vector_count/mask for
>>>     doorbells
>>>   NTB: epf: Document legacy doorbell slot offset in
>>>     ntb_epf_peer_db_set()
>>>   NTB: epf: Make db_valid_mask cover only real doorbell bits
>>>   NTB: epf: Report 0-based doorbell vector via ntb_db_event()
>>>   NTB: epf: Fix doorbell bitmask and IRQ vector handling
>>>   NTB: epf: Implement db_vector_count/mask for doorbells
>>>
>>>  drivers/ntb/hw/epf/ntb_hw_epf.c               | 133 ++++++++---
>>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 210 ++++++++++++++++--
>>>  2 files changed, 296 insertions(+), 47 deletions(-)
>>>
>>
> 

