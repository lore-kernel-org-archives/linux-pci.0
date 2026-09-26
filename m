Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029131E7660;
	Sat, 26 Sep 2026 17:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790443023; cv=none; b=XRo8YGonjZPMZ2DFzJaPdCWV1u5liDvctl9ALVUqfA/aWQiNM1SGPR830wkNH03wueeQQGuV+zXuleydLJrmKdW8jY/sTghbpnhiCmGzjRbjVXr+0boJvKRzbIiF61V2F9b+86zABSXpJFivXfTvRy41nTPwN+xR96ht7g9oOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790443023; c=relaxed/simple;
	bh=zblWuerasN2tbRabMaEOOR+Ev41Ppxgbo3ximl6SGhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuaUyterMB79xzdr42K4iOD0jqeYsp3/kZSwFGr6c5/7CFha/J+AAKjuyl8DS7rf0SpqerU0OCdsOHew3cptzN7fA62LOx6q/OTSoM87VF6A95znUS/g7cjBhtPtqjv1dOK8LBL+Al+lguvxVPVZgfrk0HBroGo6RIHEL/DIvBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUN9e8R5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUN9e8R5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3C61F000FF;
	Sat, 26 Sep 2026 17:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790443021;
	bh=e63r+YGftV+8Wus6ConM4+eqXNzSJ84Llsl0KnQk8ic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GUN9e8R5XvGp+lwhJ9ZG8ahY1pmiY1qYOa5B0Rn7zf/93p/Z1/ezyPsJoXJNEJMyR
	 8amq/OWMLnKKwWXsaAouRW+hKUiuI4cgJ0riBzlSs0hr5UZghIbUW0jML4fktm1Tve
	 OePgYYOLgS3/WDn08PNO9pZbgFPZBerGkM/g3GwUy0P9Ye4C0HwG4y34kpf5PVYf8Q
	 cQFh1JCmIX0LFqAwb8DVG055S5qK2mvVBAba7Gj1L3a9LfdEl4Eb0+FP5vUpAZe2qg
	 wvMKIq0B3pEmu2izWNOom4iQdV0LhY8ZQJHec3i+2O5XVMApFBepi/hcFbXxa7N0sR
	 EKg3wfRDIKvig==
Date: Sat, 26 Sep 2026 19:16:55 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
	"open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" <linux-ide@vger.kernel.org>,
	Arthur Husband <artmoty@gmail.com>,
	Roland Waltersson <roland.waltersson@netinsight.net>,
	snoep <snoepke@live.nl>
Subject: Re: [PATCH v2 2/2] Revert "ata: ahci: force 32-bit DMA for JMicron
 JMB582/JMB585"
Message-ID: <arf-B_HVaKpJ2ATA@ryzen>
References: <arfea9Zk6mbaoRYr@ryzen>
 <20260926162625.GA2140496@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926162625.GA2140496@bhelgaas>

On Sat, Sep 26, 2026 at 11:26:25AM -0500, Bjorn Helgaas wrote:
> That all sounds good.  How about if I ask Linus to pull Mario's AMD
> SMN fix for v7.3, since that seems to be PCI-related, and then you can
> decide how/when to take the quirk revert, since that seems to be
> ATA-related?

Sounds good, I will queue it for for 7.4 sometime next week.


Kind regards,
Niklas
