Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8264D3033CC;
	Wed,  1 Apr 2026 21:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775079461; cv=none; b=XXHz20OUKPwvGJbJcau5AJ0Es/sfXMd3RtTz7JhE3sFNbSlJ1VzfQRdXKs5gazDS+051lc2hBbMFXqA3ZM8zhuKYCvwJIAlAIxj5b4699hRtO1uG+78BHr8dXilvGl+FCPkNl/+pIhJDHpUw1mHI4wtaHYJVft0dDL2MlNBFUFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775079461; c=relaxed/simple;
	bh=GRHB1ChFXIwHXmODkukj0axN/JDNhc3RkWyL4u6TFyU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ntAcu9kntPkIH3xG6xtl6t1GTGV0AlFwiKD0O1s2ulZNhiDjzUZudJ3cs1MTmXcG6Z4Mv6V8lvG35Ua34wN5OijjjIWCa8MmkjuN1gIKGu5dsDvN5uP6rJNjxUi2CxkrMbe9QkxcCiSSdB4a878sSyj1Gk162nGQut25NUAPcGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDr8vvMh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDr8vvMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B30C4CEF7;
	Wed,  1 Apr 2026 21:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775079461;
	bh=GRHB1ChFXIwHXmODkukj0axN/JDNhc3RkWyL4u6TFyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fDr8vvMhw060FqzypDUPl3cT3RTYC1RLQGZlNpY7hW2MLKGJRB47Hlga6VmpMh4eJ
	 +APuMV/nJBpVfrLbbRe2coy73au693PpzME65gbghGRuqIa5Uoc5eKae+B/30kYpaO
	 uQD80Ug7FuLvUojTS7VsA3bJvFZb36S7nYE/4jQ/KeXSA0XCeLULMqO9Pp9YjHX0oo
	 kREGJsbPh0imj/oAytVR+ObKreOZtS8xRaC7iAzSRQAVlht2ii7bI3Q3DiELLRK3vZ
	 kET14AyQLtftRu5XBRJBNOUjEMoK6n0dIX3MJ7zbk0KmeC7irK70ag0Msy1/GhBEPB
	 SMzg69hOo8VyQ==
Date: Wed, 1 Apr 2026 16:37:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Devilliv Kelly <kelly.devilliv@outlook.com>
Cc: linux-pci <linux-pci@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"myron.stowe" <myron.stowe@redhat.com>,
	"keith.busch" <keith.busch@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Handle MPS mismatch for Switch Downstream Ports
Message-ID: <20260401213739.GA235798@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SEZPR01MB538982EC382C61697D0986E08453A@SEZPR01MB5389.apcprd01.prod.exchangelabs.com>

Thanks for the report, and sorry we missed your original email; I
couldn't find it in the lore archives, so maybe it got lost in
transit.

On Tue, Mar 31, 2026 at 04:10:56AM +0000, Devilliv Kelly wrote:
> Background
> ===========
> Commit 9f0e89359775 ("PCI: Match Root Port's MPS to endpoint's MPSS as
> necessary") added logic to reduce a Root Port's MPS when an endpoint's
> MPSS is smaller than the Root Port's current MPS setting. This ensures
> hot-added devices can work correctly.
> 
> However, this logic only applies to ROOT_PORT type bridges:
> 
>     mpss = 128 << dev->pcie_mpss;
>     if (mpss < p_mps && pci_pcie_type(bridge) == PCI_EXP_TYPE_ROOT_PORT) {
>         pcie_set_mps(bridge, mpss);
>         ...
>     }
> 
> This leaves Switch Downstream Ports unhandled, which can cause issues
> when the Switch reports an incorrect or unexpected MPS value after
> secondary bus reset.
> 
> Problem Description
> ===================
> We encountered a scenario where a PCIe Switch Downstream Port reports
> an MPS value larger than what the endpoint can support:
> 
>   Topology:
>   16:00.0 - Switch Upstream Port (MPS = 512 bytes, correct)
>     └── 17:00.0 - Switch Downstream Port (MPS = 2048 bytes after secondary bus reset)
>             └── 18:00.0 - Endpoint device (DevCap MaxPayload = 512 bytes)
> 
> After a secondary bus reset, the Switch Downstream Port's MPS unexpectedly
> became 2048 bytes. When the kernel enumerates the endpoint device (18:00.0),
> it attempts to set the endpoint's MPS to 2048 to match the upstream bridge,
> but this fails because the endpoint only supports a maximum of 512 bytes.
> 
> Kernel log shows:
>   pci 0000:18:00.0: can't set Max Payload Size to 2048; if necessary,
>   use "pci=pcie_bus_safe" and report a bug

Can you please collect the complete dmesg log when booted with
the 'dyndbg="file drivers/pci/* +p"' kernel parameter?  (The double
quotes are a necessary part of the parameter)

How do you initiate the reset and which device is being reset?  What
caused the subsequent enumeration?

My guess is you used setpci to set the Secondary Bus Reset bit in the
16:00.0 Bridge Control register?  And maybe you used a sysfs "rescan"
file to enumerate the endpoint?

If you used a sysfs reset interface or a driver called
pci_reset_function(), the kernel should have saved and restored config
space so the 17:00.0 MPS shouldn't change unexpectedly.  Also, the
kernel would only let you set SBR in 16:00.0 if there was a single
device on bus 17, and switches typically have multiple downstream
ports.

> This results in NMI errors when the endpoint attempts DMA transactions:
>   Uhhuh. NMI received for unknown reason 2c on CPU 0.
>   Dazed and confused, but trying to continue
> 
> Root Cause
> ==========
> The pci_configure_mps() function only adjusts the upstream bridge's MPS
> when the bridge is a ROOT_PORT. For DOWNSTREAM_PORT types (Switch ports),
> the kernel attempts to set the endpoint's MPS to the bridge's value
> without checking if the endpoint can support it.
> 
> While the Switch firmware should ideally configure correct MPS values,
> the kernel should be robust enough to handle such cases and ensure
> proper MPS configuration for reliable operation.

Agreed.  I think the SBR *should* reset MPS to the default value of
000b (128 bytes), but maybe this switch doesn't work that way.
Regardless, I agree that Linux should handle this better.

> Current Behavior
> ================
> 1. Endpoint's MPSS < Bridge's MPS
> 2. Bridge is DOWNSTREAM_PORT (not ROOT_PORT)
> 3. Kernel skips bridge MPS adjustment
> 4. pcie_set_mps(dev, p_mps) fails because p_mps > dev's capability
> 5. Device may not function correctly
> 
> Workaround
> ==========
> The issue can be worked around by using the kernel parameter:
>   pci=pcie_bus_safe
> 
> However, this affects the entire system and may reduce performance
> for other devices.
> 
> Questions for Discussion
> ========================
> 1. Was there a specific reason for restricting this logic to ROOT_PORT
>    only? The commit message mentions avoiding impact on "other unrelated
>    sub-topologies," but Switch Downstream Ports typically only have one
>    endpoint below them.
> 
> 2. Should we also consider propagating MPS changes up through multiple
>    Switch levels in the hierarchy?
> 
> References
> ==========
> - Commit 9f0e89359775: PCI: Match Root Port's MPS to endpoint's MPSS as necessary
> - Commit 27d868b5e6cf: PCI: Set MPS to match upstream bridge
> - https://bugzilla.kernel.org/show_bug.cgi?id=200527 (original ROOT_PORT fix)
> 
> Kelly Devilliv
