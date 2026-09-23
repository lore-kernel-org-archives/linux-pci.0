Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465640DB4C;
	Wed, 23 Sep 2026 18:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189180; cv=none; b=bYhjvdsEOEUFqnbh/qLYXFqLlQBY0nwBoZ1v5OU0456XLrJTdHJVcbOA659ff3JvMfyAJYWiAHmDr7M4NVw8PPxILJDs3d7TUbx5jp9D8EILOzHD87a4vqcGo2DS4XTGXJ6DDteFUOpnvz6yySRskek8RLi8vv4Rp9TpgvA7x5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189180; c=relaxed/simple;
	bh=DowexvyP0YfpvTFm7h2/IfJBq3gtaAKsPxlji8S+eu0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Tb12WxDESf7fKZaGZQ0EPzrpNxP6zQJ9mKb+/yDBHdhNd5nyRu/RbWMefSpgvvoyVp9V+8pVB9P5OHu82D3WYm1tf0E+eIb//9nPoESaQiVRSADWvw5YOtKIQOR5CNAV3dFOHFj+2oGcChpQwyTBxEzvokRfSGVPXCTodP8Xms8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2/o0TPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2/o0TPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0035A1F000FF;
	Wed, 23 Sep 2026 18:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189171;
	bh=TEOLXTXSoVwAXu15O4+IO+TBS5mtYVlDWzz8+W1qRQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=K2/o0TPrLywf41wD67dGRl0zZXx7NNo9HOagwKQ7fu+FwNCBor+B9MS9U1ayBMBc9
	 my/6HpKLC0a50+VaMGm12JsDiBXDnZZsuSQKeDIRB9lD1eLrjCwFqNEo5sb7I3vqKz
	 rF6eopwISC/eB5OcS+AwDkuu10nJx2JqmBresZvywGtQGm+Z4NGctLYu+WQvCxrFUP
	 Hd4/wYsrhYgcoAazH/9sZC8qkSa+iStdFx8Jmu2E3s87RsNfUlUlBXcYG7DFdrVN3c
	 Bjcj82uXacPQ76j8qcK52joCrJHuYRi+EqPDTUReJrcK2DiYm5DHsZzH5C3dNXPLff
	 jrAIItdon6ycA==
Date: Wed, 23 Sep 2026 13:46:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
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
Message-ID: <20260923184609.GA1906456@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52e6bb87-1a64-405b-a11a-3b9f9bf95410@amd.com>

On Wed, Sep 23, 2026 at 01:39:46PM -0500, Mario Limonciello wrote:
> On 9/23/26 13:36, Bjorn Helgaas wrote:
> > On Tue, Sep 08, 2026 at 02:05:58PM -0500, Mario Limonciello wrote:
> > > An issue has been reported by a number of people that corruption
> > > was occurring on storage for desktop systems.  It's notably reported
> > > on SATA, but the same issue also appears on NVME.
> > > 
> > > At a glance it looks like an IOMMU issue as turning off the IOMMU helps
> > > the issue, but it's actually a problem that occurs specifically with any
> > > IOVA addressed >58 bits.
> > > 
> > > This is because the BIOS on these systems is enabling a feature of the
> > > root port called 'enhanced atomics' which repurposes those upper 5 bits
> > > of address space.  That feature should only be enabled by the BIOS when
> > > the partner device supports it, but it's instead needlessly enabled on a
> > > number of root ports.
> > > 
> > > As some of these systems probably won't receive BIOS updates and there is
> > > active reports of data corruption root caused to this add a quirk to
> > > disable it on affected models, and also remove the quirk that was
> > > introduced to work around this issue in drivers/ata.
> > > 
> > > v2:
> > >   *  Added resume fixups for the affected AMD PCIe ports
> > > 
> > > Mario Limonciello (2):
> > >    x86/PCI: Disable enhanced atomics on some AMD PCIe ports
> > >    Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
> > > 
> > >   arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
> > >   drivers/ata/ahci.c   | 18 --------
> > >   2 files changed, 99 insertions(+), 18 deletions(-)
> > 
> > Applied to pci/for-linus for v7.3, thanks!
> 
> Thanks!  Could you add to the commits:
> 
> Cc: stable@vger.kernel.org
> 
> We should take this back to any non EoL kernel as well.

Done :)
