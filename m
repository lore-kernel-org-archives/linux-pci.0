Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491657;
	b=bLuUyPXO7o63eWYZdMkKHVpvFbFgxitxpF+ak0a/NYuf1L2ypx3I+f+XJ64G7PEuNXTk
	 3KGbdesZ+0fLXGsQA01dtSyQgmCVNdH1tyYzPoDTAymxh5Hd6o13GZ5v+1azc5OFzVaGu
	 pnCcpeXpQPeEuv//ZL2S1LHdMi30brFg+bVbE8ElWGiMO8CpmtVZCG26O15EafmgIopv5
	 HcBbqyECzudXlQYrU9vGJJ71BoKQk8x5KVRbBfVzaMdTXteTXpoyNkiLqLOIZVbwAgIng
	 hx0JVzTC9OTRWk+d2lJDzsZBTCx4zjrMrJ8SCotbeNmjE10bJjewNRZgXD054vVU0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491657;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=w1XnsOsou5Lm9XFSDJaZiQhVOAVD800RRoN8ibHoSdY=;
	b=KnXH8LtcSjk5AVVblo9M14+Q2xzxCMpbmkrs/3oYHDtOYS5XH4Xnglw3J2v79lf8YD9j
	 tDg3pcKqS7mbRzxtAyPZ2UxKz0sSBCPdaDgjRRutcYz7dRJJCIaVpQP3wlJvfmIvupTdH
	 lqol7mBCUChQw02NjZuDFGEGXQvOK3/J/Piwn2X/lKaphfIAAgJPm+Rhfe2NfWJfaKKDZ
	 ulAmsCUzXdl59HfO66Td+0P7zDgQS/UKLD2cfCqYrBPgrcrU3TMHxKcr/bS5ybkF3V7y7
	 Gwy0pFNAZspGw2c8Xco1X2x+34vxEkQmplCag8i7dXJc+mirFkAXzuZV8GqiigHnv3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cn9yz0ld;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B87D606A329;
	Tue, 20 Oct 2026 10:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B87D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Cn9yz0ld
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792491656; x=1824027656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=sA55Mtugr2IacCIUDeF9r4HIGlqEgLvh1hJILr5qX3E=;
  b=Cn9yz0ldwlOi55lqUnS6//OzZ5gbJ8MwS5YnSeZ9SkYXBvBFrqmQ+wO0
   EbmJHrK+GaS7q0Wt/qPHxo3wMWdqAy48yyAsmxcR2aH1SNPx1pDTdtSMl
   KdIKW1ed6hU4rA8M5yAWLEMdbzDdQYWu/SoObSTwq2T+EDX4aF6MrypVL
   cc/AycxR5w6D9bq3cnzQI07TzewgvPU3nGVqlJgbokE7TnCH3DVrvUxwJ
   6L2yLlM7nTtqP6F4xHPw2KqfLZ/7ItccJBnbI31oiQ6fMpARBaZg96oK3
   ZMk8unQbZp83HKJkQgMAb9ad2xJCDVOxTlyX7YVP+XZMWZx24TL8Z0BAi
   Q==;
X-CSE-ConnectionGUID: gON1VkVDRSWd2jIxtEA/cQ==
X-CSE-MsgGUID: QmW9ebCeSIKpMrK15OiYZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1218407"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1218407"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:20:56 -0700
X-CSE-ConnectionGUID: 0c8U+Dp/RdKWZYfMTaM47w==
X-CSE-MsgGUID: zrKcXHLRRNeJ6kLfP3bQFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2671910"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 20 Oct 2026 03:20:53 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id CB6CC9B; Tue, 20 Oct 2026 12:20:51 +0200 (CEST)
Date: Tue, 20 Oct 2026 12:20:51 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Francisco =?utf-8?B?QmVsdHLDoW4gTWlsbGFsw6lu?= <fbeltranmillalen@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>, Farhan Ali <alifm@linux.ibm.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, Darrell Gum <d@rrell.co>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI/PM: Keep the saved config space of an
 inaccessible device
Message-ID: <20261020102051.GC176164@black.igk.intel.com>
References: <20261019202445.38259-1-fbeltranmillalen@gmail.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261019202445.38259-1-fbeltranmillalen@gmail.com>

Hi,

On Mon, Oct 19, 2026 at 05:24:43PM -0300, Francisco Beltrán Millalén wrote:
> When a PCI device stops responding while the system is suspending,
> pci_save_state() stores all ones over its saved config space, and
> pci_restore_state() writes that back on resume once the device responds
> again.  For a bridge, that means bus numbers ff/ff/ff and Secondary Bus
> Reset asserted, which cuts off everything below it.  Resume can also
> wait about 65 seconds for a device behind a dead bridge, because an
> all-ones Link Status reads as an active link.  I ran into both on a
> MacBookPro14,3.
> 
> Patch 1 makes pci_save_state() keep the previous snapshot of a device
> that is not accessible, instead of overwriting it with all ones.  Patch
> 2 stops the link wait code from taking an all-ones Link Status for an
> active link.
> 
> Patch 2 does not depend on patch 1 and is unchanged from v2, so it can
> be applied on its own, as you offered on v2.
> 
> Why patch 1 changed
> -------------------
> On v2 I described [1] what returning -EIO from pci_save_state() does to
> some drivers: stmmac_pci_plat_suspend(), intel_eth_pci_suspend(),
> atl1e, atl2 and amd_mp2 abort system suspend, and libata and others
> trigger the "State of device not saved" warning.  I asked how you would
> like those drivers handled, and said I would hold v3 until then.
> 
> The Thunderbolt work exposed the same PCI problem in another path.  I
> have sent a Thunderbolt patch [2] that calls the SXFP ACPI method on
> Apple systems with Alpine Ridge before system sleep.  SXFP also powers
> down the xHCI on the side of the controller with nothing connected.
> The automated review of that patch pointed out that if this happens
> before the xHCI saves its state, pci_save_state() stores all ones and
> resume writes them back.  I found the same by reading the code; I have
> not run that case without this series.
> 
> On v2 you wrote that skipping pci_save_state() when the device is not
> accessible seemed worthwhile.  That preserves a usable saved state, but
> does not make the Thunderbolt controller resume.  The Thunderbolt part
> now has its own patch in drivers/thunderbolt [2].  This version only
> does the skipping: pci_save_state() keeps the previous snapshot, marks
> the state as saved and returns 0, as it does today.  Callers see no
> change, and there is nothing for the PM core to warn about.  The device
> gets the config space it had when it was last accessible back on
> resume.  This makes v2 patch 1 (usb: hcd-pci) unnecessary, so it is
> dropped.  The values written back can be older than the last ones the
> device had; patch 1 describes that.
> 
> If you would still rather have pci_save_state() report the failure, I'd
> like to know how you want the drivers above handled.
> 
> [1] https://lore.kernel.org/all/20261011210451.12129-1-fbeltranmillalen@gmail.com/
> [2] https://lore.kernel.org/all/20261019134851.7496-1-fbeltranmillalen@gmail.com/
> 
> Changes since v2:
> - 1/2 (was 2/3): keep the previous snapshot and return 0 instead of
>   returning -EIO, with the check once at the start of pci_save_state()
>   as you suggested.  On v2 I said I would make pci_dev_save_and_disable()
>   use the return value of pci_save_state(); with this version that no
>   longer works, so it keeps its own check (see the notes in patch 1).
> - Dropped v2 1/3 (usb: hcd-pci).
> - 2/2 (was 3/3): no code change.  Added Darrell's Tested-by from v2.
> - Based on pci/next as of 2026-10-15 (732c4f7d2c04).
> 
> v2: https://lore.kernel.org/all/20260930141914.6678-1-fbeltranmillalen@gmail.com/
> v1: https://lore.kernel.org/all/20260924124221.12374-1-fbeltranmillalen@gmail.com/
> 
> Testing:
> I built patch 1 into a v6.18.49 kernel with patch 2, a backport of
> e18d1abc3bff and other local changes for the MacBookPro14,3, including
> the next version of the Thunderbolt patch above, with the changes Mika
> asked for in his review.  The USB HCD patch was not included.  I tested
> it on that machine with 30 second suspend/resume cycles and a USB 3
> disk on the Type-C ports, which sit behind the two Thunderbolt
> controllers:
> 
> - Five cycles: three with the disk on one side or the other, one
>   removing the disk while the system was suspended, and one with
>   nothing connected.  All resumed, and both Thunderbolt controllers
>   came back.  The disk was read after each cycle in which it stayed
>   connected, and after the other two it worked when plugged in again
>   (on both sides after the first, on one after the second).  In these
>   cycles the xHCI saved its state before SXFP powered it down, so the
>   new check in pci_save_state() did not trigger.  The order of the two
>   is not fixed, as both suspend asynchronously.
> - To hit the case above, I also called SXFP earlier, in the PCI suspend
>   phase, through a test-only PCI quirk that is otherwise disabled.  In 3
>   of 3 cycles the xHCI on the empty side (each side at least once) was
>   reported as "Device config space inaccessible; unable to save state",
>   the snapshot from before was written back on resume instead of all
>   ones, and the xHCI came back.  A disk plugged into that xHCI
>   afterwards worked at USB 3 speed, on both sides.  In all of them the
>   snapshot was one taken earlier while the xHCI was accessible.
> 
> There was no kernel WARNING and no "State of device not saved" during
> the whole boot.  The series itself was built on pci/next with W=1.  I
> have no SR-IOV hardware, so the VF case is untested, and the machine
> never reaches the pcie_wait_for_link_status() change.
> 
> Thanks to Bjorn for the review and the simpler check, to Farhan for the
> pointer to the 2025 discussion, and to Darrell Gum for testing v2 on a
> second MacBookPro14,3.
> 
> Francisco Beltrán Millalén (2):
>   PCI/PM: Keep the saved config space of an inaccessible device
>   PCI: Do not mistake an absent device for an active link

Both patches look good to me and they improve PCI config space handling in
general too,

Reviewed-by: Mika Westerberg (Intel) <westeri@kernel.org>
