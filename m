Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02283537D0;
	Fri, 10 Jul 2026 20:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783716413; cv=none; b=siKMkr9FMkLpwb7Heq2DRSZVjavjAk9C6pqmMBL/StuUYTJ8/eYZZuqqwzPam9RyESIMSQTTz7+HGLwxwhgHoawtFhuOR0PTlzdgZba4C9Ngghtd+/m9THtkYqNxoM6DH0YkkszcZSecxxVUboPFnwzg+2Lb+WKX+iYjjz3xaS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783716413; c=relaxed/simple;
	bh=O/nH8NFFtDf39iVENkiFt/8hgUDNcbuSKoU/4iTc8RM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G4g57IAFWWGV3qIMkDNm1ajbFIvLMac27iRbWvhlMQQSE1M5g+9bxfuV3ZiM6LPQOY5t0c+6pYOTCpJbreACFJwFno61F2z5dbOCreVlxknrJ77Ku6vdguj1JSvCbmuPRgWt5b0v8xoSXt0OJyZtOwXUBctLchbQTyqdR4RLZIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dd1oVQ5S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dd1oVQ5S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 036F31F000E9;
	Fri, 10 Jul 2026 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783716412;
	bh=4FXuD88xnQiyJIRdYMZFBXUOXQg1ApsCo+B8ICNsSeY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Dd1oVQ5SswVaWQAJ4Sh0rPhuwFNetoGiB/rMHf1oYG4qH5X0aRVbX2xisgA8ahbd2
	 oKKxKRE3UU/wcBzvSZcYwKRRU2x0z4tSrpz5+9fxHlkys/VnG7jXETm68pqnatOE0t
	 xfmoXqziVfLbhVDw5jZYTnvq60fFn4dg0zsuKmFFSKyyGlFp/bFQvl21D4uI1t/t74
	 /qo+GcJXuLRo9qF5wz619eh6Adx9yUoIJvM3D+sCU/tP+qHYhkhGHp98cfhjnO8juy
	 IVqGu1ZmRTc9KtlWm38twV2cf4hX5CWBIQEDq7BZTzIUoGRWO2zxavzCeFF67M7eMS
	 vtDEA8Z4QFgIg==
Date: Fri, 10 Jul 2026 15:46:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/8] x86/pci: consolidate x86-specific PCI quirks into
 arch/x86/pci/fixup.c
Message-ID: <20260710204650.GA998073@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707221800.920270-1-rosenp@gmail.com>

On Tue, Jul 07, 2026 at 03:17:52PM -0700, Rosen Penev wrote:
> This series moves all x86-specific PCI quirks from the generic
> drivers/pci/quirks.c into arch/x86/pci/fixup.c, where they
> architecturally belong. This reduces the ifdef burden in the generic
> quirk file and improves build granularity by gating the x86 fixups
> behind CONFIG_PCI_QUIRKS.
> 
> The series is organized as a preparatory commit followed by one
> commit per vendor/family, keeping each move reviewable.
> 
> Suggested by: https://lore.kernel.org/all/20161221142607.GA8594@infradead.org/
> 
> Rosen Penev (8):
>   x86/pci: gate arch fixups with CONFIG_PCI_QUIRKS
>   x86/pci: move Intel chipset quirks to arch/x86/pci/fixup.c
>   x86/pci: move VIA chipset quirks to arch/x86/pci/fixup.c
>   x86/pci: move SiS chipset quirks to arch/x86/pci/fixup.c
>   x86/pci: move ALi chipset quirks to arch/x86/pci/fixup.c
>   x86/pci: move AMD x86 chipset quirks to arch/x86/pci/fixup.c
>   x86/pci: move x86 ifdef-gated quirks to arch/x86/pci/fixup.c
>   x86/pci: move remaining x86-specific quirks to fixup.c
> 
>  arch/x86/pci/Makefile |    2 +-
>  arch/x86/pci/fixup.c  | 2284 ++++++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h     |    3 +
>  drivers/pci/quirks.c  | 2330 +----------------------------------------
>  4 files changed, 2316 insertions(+), 2303 deletions(-)

I don't object to any of this from a PCI perspective, so I guess it's
up to the x86 folks if they want them.

It looks like the typical subject line style in fixup.c is:

  x86/PCI: <Capitalized-first-word> ...
