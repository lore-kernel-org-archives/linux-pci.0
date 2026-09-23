Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0EF5275BB;
	Wed, 23 Sep 2026 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188621; cv=none; b=QO/E+CNNOmm4ORHqy6R1KmtVT3Ehhc/xcvs5EwC4WXCJKDagV8rawLBcUOy1xCd7VGSq7IHmufedwkq8fl6gHGxvErdqi4ubw1L+hL7Um/raJ7OIawKBrIkLa6csxvQEIpts2fL6qkCkQDXtkPMLgUYoLQtd0+PMNmN8TEaXWMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188621; c=relaxed/simple;
	bh=iqqLVc9blGv1Qq3c57RR93+vIn4LD801SVFpUDmD6QU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RSVV3A43hunxNY8Xs5npkuQzOGxvDf0tFT7TFmSJRSMJacQWsswLeGTJQ6scNN+6gttCi8zqk4XJZk3FB4ZtrCyv5s+QO6oUC2uiFlBZj4F/0kZUbgG97oH2A+X/qe43ytuv2notKjLdhmaa2NwKXyhgVv4yxxEK8D0tJes6qCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7kNo577; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7kNo577"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05071F000FF;
	Wed, 23 Sep 2026 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188618;
	bh=nXGrpCjWB3LH4rhmz7QwyZ/fzqWae+WkDnbz0XMOTTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=S7kNo577neF9p2zEZBd5fLjopB7AZg1Mq3PNHghIAP3pPmw/UYh7jrxTJI6LFSZJH
	 2WJsXeS/qpm/sY5Mig8vlVF4Z2CHP6F5GZ1e3sliD4bfq55DXAtvhjndZQyOlAQt/q
	 MMCysBtN0l3mJ1EYI1OnBvIgctEWGAwozt23cJvBMZZpAnKN6eapIMO7mX02z96EZH
	 gN2QE7Za2XzLUWe3I7oOK3gPvV0hoBTkeBVhNKz4hacIuJRv2rmC32UCDa5EkU9bAz
	 7Ygpn5kJXlKGadUIxMTWyNJ0Uk48RVDvZkQkql/ZHhKs6kpGLi4lASIxwTQNegTmcN
	 F1s2k0obTFAdg==
Date: Wed, 23 Sep 2026 13:36:57 -0500
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
Message-ID: <20260923183657.GA1900695@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908190600.226485-1-mario.limonciello@amd.com>

On Tue, Sep 08, 2026 at 02:05:58PM -0500, Mario Limonciello wrote:
> An issue has been reported by a number of people that corruption
> was occurring on storage for desktop systems.  It's notably reported
> on SATA, but the same issue also appears on NVME.
> 
> At a glance it looks like an IOMMU issue as turning off the IOMMU helps
> the issue, but it's actually a problem that occurs specifically with any
> IOVA addressed >58 bits.
> 
> This is because the BIOS on these systems is enabling a feature of the
> root port called 'enhanced atomics' which repurposes those upper 5 bits
> of address space.  That feature should only be enabled by the BIOS when
> the partner device supports it, but it's instead needlessly enabled on a
> number of root ports.
> 
> As some of these systems probably won't receive BIOS updates and there is
> active reports of data corruption root caused to this add a quirk to
> disable it on affected models, and also remove the quirk that was
> introduced to work around this issue in drivers/ata.
> 
> v2:
>  *  Added resume fixups for the affected AMD PCIe ports
> 
> Mario Limonciello (2):
>   x86/PCI: Disable enhanced atomics on some AMD PCIe ports
>   Revert "ata: ahci: force 32-bit DMA for JMicron JMB582/JMB585"
> 
>  arch/x86/pci/fixup.c | 99 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ata/ahci.c   | 18 --------
>  2 files changed, 99 insertions(+), 18 deletions(-)

Applied to pci/for-linus for v7.3, thanks!
