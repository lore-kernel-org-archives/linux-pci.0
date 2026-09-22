Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E854F4CFF;
	Tue, 22 Sep 2026 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070602; cv=none; b=pjF1/uznSoo6I/HFNjzEKwVv8J09kG7kULkDvju8wUgYJv1Vby6FWnijJUuYR88p14qoi9dttnH0iHMoEbb/pqibOhXHpaIF5da7ZsEG/+/c6FBeBRHAMx8/fr6szswxmfNtcPJU9LxHFru9oWVX1ShGHv8/NBCIE2/3clhk/Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070602; c=relaxed/simple;
	bh=gFLlgGUoiR/yRG0FuwEyYVgBERHSu9xqYe4l5v06J/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nxFS4xtpFxs43/DgTVLD0boclFKVA72tLOQ21Tju6fn2blodTlyYmtjOgFGHPLvhrzZa1By48B4dHqMP6dZpXs6J1fXbceV5BoDPk0iKTWbsOPa9UPcZnrYt+vkjRWijjMgZACOkG7x3YtwPFkHT8hee2n85oTxVvo5L6wg1DcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P2m/3sOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P2m/3sOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E754A1F000FF;
	Tue, 22 Sep 2026 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790070600;
	bh=w8aonqomSCKE60lBhbk8C45Hcy5KfE9qY91v6P9GIpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=P2m/3sOM1/A/FYaweZIW35cm095c//Jdn++No4GJox6WBSXSvCJtlleSSqmMXS7f2
	 n7esCusffA7JxXwAORRjf9taYrVMxNhj2uXLfmQzfXwIrmwbiutfu17NuC7A7zeVCG
	 LsrR8aF2XWLibrF3RlXDLKbL3yB5jCtP1+JzCPuD/vuxW5BbhAktK04ylOfM5FzMdw
	 iDnr10d4SrZnM5l6oM+/x8e0fCMLZqjmFdKp/nSQxMubjyIhTdP5aorp3xNsd9rwXo
	 TMBKPUyW/BkE+P4g7KTnurhnsHt5UXx3n4wPdSDF0idhUOfv5c4HSsdorhRHZVvCx/
	 0QbbhQ4sfdlhA==
Date: Tue, 22 Sep 2026 11:49:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Fix for storage corruption w/ AMD IOMMU on 64-bit
 addressing
Message-ID: <arJPQ2cEBgy3oxe2@ryzen>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15cebf13-1e28-40e1-9113-19205ee8d604@kernel.org>

On Sun, Sep 20, 2026 at 11:52:08PM -0500, Mario Limonciello wrote:
> On 9/8/26 2:05 PM, Mario Limonciello wrote:
> > An issue has been reported by a number of people that corruption
> > was occurring on storage for desktop systems.  It's notably reported
> > on SATA, but the same issue also appears on NVME.
> > 
> > At a glance it looks like an IOMMU issue as turning off the IOMMU helps
> > the issue, but it's actually a problem that occurs specifically with any
> > IOVA addressed >58 bits.
> > 
> > This is because the BIOS on these systems is enabling a feature of the
> > root port called 'enhanced atomics' which repurposes those upper 5 bits
> > of address space.  That feature should only be enabled by the BIOS when
> > the partner device supports it, but it's instead needlessly enabled on a
> > number of root ports.
> > 
> > As some of these systems probably won't receive BIOS updates and there is
> > active reports of data corruption root caused to this add a quirk to
> > disable it on affected models, and also remove the quirk that was
> > introduced to work around this issue in drivers/ata.
> > 
> > v2:
> >   *  Added resume fixups for the affected AMD PCIe ports
> > 
> > Mario Limonciello (2):
> >    x86/PCI: Disable enhanced atomics on some AMD PCIe ports
> >    Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
> > 
> >   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/ata/ahci.c   | 18 --------
> >   2 files changed, 99 insertions(+), 18 deletions(-)
> > 
> 
> Gentle ping on this series.

I can pick up patch 2/2, but want to wait until patch 1/2 has been picked
up either by Bjorn, or one of the x86 maintainers.


Kind regards,
Niklas
