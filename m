Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBC8545D99;
	Tue, 22 Sep 2026 12:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081582; cv=none; b=J2b5WXRTuFTLaZlxR4tnlo3eDrp/cRJjJkue4Q1QdNBkyong08Dptd6QAM5eMg31rStdSZcMgsDu1cTs6LkHwQozQE+yqM8GT7GmKmZQLfn4Q0ooGDF/lqORLn9l45tbLEd+DS8YbAkIk0h0b0s6Q0cgEPCL3kflbR+A432fFPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081582; c=relaxed/simple;
	bh=2mEgvee7JoMc3RTTR7pEYg1kvL/S+eRA/kxAFo1wj0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYxc+Wn7wW3CT+gbBVKa9lbL6MCX+bnlkqSKmwFjKurkR/4Ux5Oahtmk2f6eL1uYqeIzVsa/S4yb9VCSEXl2xqle5BGmadZhpJb526YqXmyd0BISuCmJrmWBDaGqiZC8IpZjHbpAM7996rlTcLnVbpnEGhUueoyYEGkHRJ5h8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3fJDGQz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3fJDGQz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565641F0089A;
	Tue, 22 Sep 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790081581;
	bh=Lok7HdvpHst/GgeNo+XZ6OBJYwvBn1PJr3FfTs75GVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F3fJDGQzc0aBwNS0B2Ni9bd98ABOE9vbolPdAz42hYGjQ1pbzcIs2R5wCVFl+6Cqc
	 wJJwxk3jpKrg8Wlg8NI+Sz7k+fbJ9CDe5rvjhXD9LvVqmMZqm9ztrXuben0BoyKKti
	 yY/fEhSXmNdObOFPPC4BfCypEybTCWEFlNI9MbZfbtjVs05sOKu53tYxOYKyAs6XDP
	 11dlvAtnjX2u9AdC3ldL4usdGOGcd83Q5rx7pN0lJ+w8BbKIqBhIqeyfL0dZV5bkqQ
	 xozKZrTUYT8g6bZMV2a+vk07fHVHSPrcmsxmNU45YXm8ORjMJO6TUfqG9UFf5p68rk
	 hW1q+q4v/2VLA==
Date: Tue, 22 Sep 2026 14:52:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>,
	"open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	Arthur Husband <artmoty@gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Message-ID: <arJ6J5e8l94ia-9a@ryzen>
References: <20260908190600.226485-1-mario.limonciello@amd.com>
 <20260908190600.226485-3-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908190600.226485-3-mario.limonciello@amd.com>

On Tue, Sep 08, 2026 at 02:06:00PM -0500, Mario Limonciello wrote:
> This reverts commit 105c42566a550e2d05fc14f763216a8765ee5d0e.
> 
> The issue is actually a problem with BIOS configuaration of PCIe
> root ports, enabling a feature that causes problems with 64-bit
> DMA.  It is fixed by adjusting the kernel adjusting the
> configuration of those root ports.
> 
> Cc: Arthur Husband <artmoty@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Acked-by: Niklas Cassel <cassel@kernel.org>
