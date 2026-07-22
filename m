Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F3C3F3263;
	Wed, 22 Jul 2026 15:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784735777; cv=none; b=S3TCOYsh4FheaPSrNvWViAc6QQbYYjlRq8jCekGuUudZT9GplKLd+EQl53R7EuQEFd46dEpGG4qZgPaGr9tRAdWZcSuqWA7BwkEAU3WuvHDUX+q79AbNjij/pDMRJ+89b8SbBLbRq2Hcl9ggs50xz33ESiU8T5XwC8MXi1QDIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784735777; c=relaxed/simple;
	bh=479t9wq5IMLoEe6LdnFCXLa4RGb56vh3sGFRDc2GXog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VOokb2UA8a6pGAUuJDsCcJFWNnIVABM4VSL9qD3gd0qQLFNNrsYPBpxYkRDQxY+LUeuZKsnRyIuC/8U05SnVxOj030keBK1ETuvkOJfi/7ShrH6nmDCxhJUddYOpvINb/JCXco5YBGCrhy9oOJFFgqsgI6tvmRGk6NEPvW5RAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luqgxHZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luqgxHZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D547F1F000E9;
	Wed, 22 Jul 2026 15:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784735774;
	bh=uuu1Tu0mavyGTKCTNlz/UMSHBAzx4FGHXBKIVOkO5m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=luqgxHZgCLrxH35q8K0hoG5fURY3wUyTXsoWg0QnmpHM71Q4GfoEZnLFZ7E43AtXW
	 R2csB6RpmM2d4Ky3zgHFJdkvuXaPl8zBu2PYmh5dA5DWe3lVLe8X13dG7V2JPIgUjI
	 dCvvi8VdDxSA+cR943rwpFJT6PLWwnU7WTs6TEl9/r0J7RI2hA6T4cZywp+Oz77ijd
	 6oX7iQyTXPEffMEIHWUpX/eNRbCJyRi757LlQJ0IgviZhqW6deQYHK61SS0xhOwwpp
	 yDaypsknrwAz6NFmfQgRJgy6QQ9c7/q5RdiZH4Ea/ir9U307CP3EvbEkHDX6xHJm6h
	 hZFLlsjKjNFYA==
Date: Wed, 22 Jul 2026 18:56:07 +0300
From: Mike Rapoport <rppt@kernel.org>
To: kexec@lists.infradead.org
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>,
	David Matlack <dmatlack@google.com>,
	Alexander Graf <graf@amazon.com>,
	Steven Rostedt <rostedt@goodmis.org>, kvm@vger.kernel.org,
	linux-mm@kvack.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE/CFP] LPC 2026 Live Update Microconference
Message-ID: <amDoFzbQVdxjgqzH@kernel.org>
References: <ahcc3Qyuy7Oy03Iq@plex>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahcc3Qyuy7Oy03Iq@plex>

Hi,

This is a reminder that the CFP for Live Update microconference at Linux
Plumbers Conference is still open and even extended until August 7th.

On Wed, May 27, 2026 at 05:05:23PM +0000, Pasha Tatashin wrote:
> Hi,
> 
> The Call for Proposals is now open for the Live Update Microconference 
> [1], taking place at the Linux Plumbers Conference this October 5-7 in 
> Prague [2].
> 
> As infrastructure scales, minimizing workload disruption during host 
> updates has become a critical operational requirement. This 
> microconference focuses on the evolving engineering challenges behind 
> seamless software handovers, state preservation, and warm reboots that 
> bypass traditional hardware reset cycles.
> 
> We are seeking technical presentations, and problem statements spanning 
> the entire stack—including kexec optimizations, hypervisor integration, 
> user-space checkpoint/restore, firmware coordination, and device state 
> handovers.
> 
> ---
> A few focus areas we hope to cover during this year's sessions include:
> ---
>  * Orphaned Virtual Machine for zer-downtime upgrades.
>  * Live Update Orchestrator (LUO) enhancements and architecture
>  * Kexec HandOver (KHO) framework advancements
>  * Kexec reboot latencies to minimize guest/workload downtime
>  * Preserving guest states across live updates (guest_memfd, hugetlb)
>  * In-flight DMA, IOMMU tracking, and preservation
>  * VFIO device state preservation and live update migration mechanics
>  * PCI/PCIe device handovers, reset avoidance, and state restoration
>  * Live Update in Confidential Computing (TDX/SEV-SNP)
>  * Building robust testing, fuzzing, and validation frameworks for 
>    upgrade paths
> 
> ---
> Submission Details & Deadlines:
> ---
>  * CFP Portal: https://lpc.events/event/20/abstracts/
>  * Track Selection: "Live Update MC"
>  * Deadline: July 24th, 2026
> 
> Session Format Reminder:
> LPC sessions are highly interactive working groups, not static lecture 
> slots. Proposals should be designed to introduce a concrete technical 
> challenge quickly and leave substantial time open for real-time debate, 
> consensus-building, and problem-solving with the room. Keep slides 
> focused on architecture and open issues rather than heavy text blocks.
> 
> We hope to see you in Prague to help push the live update ecosystem 
> forward.
> 
> (Note: LPC attendance caps fill up exceptionally fast. We strongly 
> advise booking your passes early, as track organizers cannot always 
> guarantee speaker registration overrides once the event sells out.)
> 
> [1] https://lpc.events/event/20/contributions/2321/
> [2] https://lpc.events/
> 
> Best regards,
> Pasha

-- 
Sincerely yours,
Mike.
