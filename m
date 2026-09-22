Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C629F45628F;
	Tue, 22 Sep 2026 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790073844; cv=none; b=tZmCNokciQjuSP5ALz1ccLtoW4/TiJyaqC6ATCxnC7xxKSa5bQuseDvg4rAyBopiHcsaEfNRtC7JYvfcznJTs5Bd7OzCBAHRXXBFVA9HdX2N8yeoJQnAcXLpIFogrW2oXsdthf6FWdNotrO9OJU2WUi8W1AetrsZzwyeSLu/67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790073844; c=relaxed/simple;
	bh=zO9v5IXjxtrrCEOVW0nzZBkBHjM1Zd70v5k3mPhjdjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4tCra5ybeu6DpbNF+VsgZis1DPY7+ipyajuwLOJyX1ZxnmDq9bHHZV29/wh608muaHe7GWF+D105AXxlUMpR6aVaqFg+PIfcmNVZcfRYVKN9HYKL+M0xB4SpREJ6KzhpXbzs7L0xTKvHrmzcv6o11P961MaUDR8DXoYtxSmwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aYuSgpTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aYuSgpTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C501F000FF;
	Tue, 22 Sep 2026 10:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790073843;
	bh=bCtEmxZUbn8uytgHYG/+wf9dmr/nk4EU37G6Ft/R1Oo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aYuSgpTu23/DN1Lyb9KaeDsfr9JSuUmj6wLaZPBYbLgO0VHn59wA5XgakkXRtXFEg
	 NSXj1uIvhNmrlxiJtmLFZOv8Jkd37Qr2sgRGsULMtoxzd8hL+NcLESva3MNFvSvx1R
	 gUSMoG0Eem5ABCzEW4W8e+ZBimcD7PO7d3T1RQ5tQBe/sH8TL+64kdb2OT9MEXTnhA
	 hmPEUBPyITY1PxRLITVDA22snjC/o3DuRc4yPxODOAILXqIFKT2F48qDa5czCxF550
	 A4aBah+TKxYLlHTIjoUUZO68f/sqwIAxlexYm+vX+0wyoLHf7QHy/RzA9bdwJk348J
	 AL1xLNhQnEiJw==
Message-ID: <ced777dc-f813-456d-8296-6d3365c7a446@kernel.org>
Date: Tue, 22 Sep 2026 05:44:00 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit
 addressing
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Damien Le Moal <dlemoal@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
 "H . Peter Anvin" <hpa@zytor.com>,
 "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)"
 <linux-ide@vger.kernel.org>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org> <arJPQ2cEBgy3oxe2@ryzen>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <arJPQ2cEBgy3oxe2@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/22/26 04:49, Niklas Cassel wrote:
> On Sun, Sep 20, 2026 at 11:52:08PM -0500, Mario Limonciello wrote:
>> On 9/8/26 2:05 PM, Mario Limonciello wrote:
>>> An issue has been reported by a number of people that corruption
>>> was occurring on storage for desktop systems.  It's notably reported
>>> on SATA, but the same issue also appears on NVME.
>>>
>>> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
>>> the issue, but it's actually a problem that occurs specifically with any
>>> IOVA addressed >58 bits.
>>>
>>> This is because the BIOS on these systems is enabling a feature of the
>>> root port called 'enhanced atomics' which repurposes those upper 5 bits
>>> of address space.  That feature should only be enabled by the BIOS when
>>> the partner device supports it, but it's instead needlessly enabled on a
>>> number of root ports.
>>>
>>> As some of these systems probably won't receive BIOS updates and there is
>>> active reports of data corruption root caused to this add a quirk to
>>> disable it on affected models, and also remove the quirk that was
>>> introduced to work around this issue in drivers/ata.
>>>
>>> v2:
>>>    *  Added resume fixups for the affected AMD PCIe ports
>>>
>>> Mario Limonciello (2):
>>>     x86/PCI: Disable enhanced atomics on some AMD PCIe ports
>>>     Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
>>>
>>>    arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>>>    drivers/ata/ahci.c   | 18 --------
>>>    2 files changed, 99 insertions(+), 18 deletions(-)
>>>
>>
>> Gentle ping on this series.
> 
> I can pick up patch 2/2, but want to wait until patch 1/2 has been picked
> up either by Bjorn, or one of the x86 maintainers.
> 
> 
> Kind regards,
> Niklas

I think it would be better that this all goes through one tree so we 
don't end up with a situation that someone has the revert but not the fix.

So maybe better to leave an A-b tag on 2/2 and then let pci or tip pick 
up the series.
