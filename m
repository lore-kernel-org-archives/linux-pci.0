Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F687355F36;
	Fri,  3 Apr 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775243422; cv=none; b=MN4K5/Q6KQDh4LMB/907KCPxkgGf32wxFt+ViWQIn/vLMI3XctiLzD863LXx0XUSeWrNjgOIyUbUqjfyHyAFBG03DDGWAnfe6RchKUKH1pu56F19wakJ0VPA5rQJhEhUsybByPZTv2nrUcAp3DjvnGc8mbOt96cOPcxPStp/xFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775243422; c=relaxed/simple;
	bh=mBAG9+zsmylu3xKKEtOJVnSQpURUIHKDceVw7+LMHTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=T5e7d3xOtqX5kPmYcWABoxhh0kuZyyDcWcNBVUBV52+ElSwKigEo8QKEkG660tcQW00Zyh0fau/im0MDTpRYnB58ODviwfcadGy7IwP4L+OsKhLObm1Cv47uedaoYUReuP12XPhKau390M9V0JM4RdKA+59WuTBe+BEblXQhcks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uxyAHSC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uxyAHSC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FA0C4CEF7;
	Fri,  3 Apr 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775243422;
	bh=mBAG9+zsmylu3xKKEtOJVnSQpURUIHKDceVw7+LMHTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=uxyAHSC55KNWz3VVH9cCU1sSuKpxHmYZCoZkbjBuCguUnXI1lnWJCr7SEpYCfkVbx
	 l6OsMCnd/+Jdf0OatPtEugr+G4g+mOXLy1FOdPfkA4sHPabKLtoeMxsT2Hja4VpJpg
	 NnN1E3a9QYBos7wAs60kp7xHW58IwAx+5ml2xgU6ySCCgw4hTB1j6XvzrHkzhp1Stp
	 RUgD64PKyWInlKO6XmFvc9OJHvVerBT2kPl0BdKsSe49DgYnmmg1TodEcMBNMPttK3
	 O/iAeCOEwDnpR72dC0mSeHiXrmx3vB0wl5Lbxp5rAaaqzXPxkBHySGaZ7uYZCW0Z8l
	 HGkdmRanF4N6Q==
Date: Fri, 3 Apr 2026 14:10:20 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Joyful Lee <joy@joyfullee.me>, platform-driver-x86@vger.kernel.org,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts
 AMD 1022:150b root port, NVIDIA dGPU returns header type 7f
Message-ID: <20260403191020.GA348076@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a24fd871-2589-46eb-8117-ec8cfa5f720d@amd.com>

On Fri, Apr 03, 2026 at 01:41:04PM -0500, Mario Limonciello wrote:
> On 4/3/26 1:04 PM, Bjorn Helgaas wrote:
> ...

> > But as you point out, it doesn't close the issue.  Somebody else is
> > going to trip over the same issue.  Most likely they will not report
> > it and have no idea how to fix it.  Even if they do report it, we'll
> > have to go through this whole debug process again.
> > 
> > The kernel should work correctly (possibly with increased power
> > consumption or some other non-functional issue) regardless of whether
> > CONFIG_HOTPLUG_PCI_PCIE is enabled.
> 
> I do hope as part of this we can reconsider why CONFIG_HOTPLUG_PCI_PCIE
> isn't part of the defconfig in the first place.
> 
> defconfig doesn't work on any hardware of mine by default and it's too much
> work to figure out what to add to it.  So I always start at distro configs
> and peel back for my own use.
> 
> But, if we could actually make defconfig *usable* for general purpose kernel
> users maybe more people would use it.
> 
> > How can we make Linux smart enough that if we're lacking pciehp or
> > whatever is necessary, we automatically avoid s2idle or S0ix or
> > whatever causes this problem?
> 
> I suppose we /could/ have CONFIG_AMD_PMC depend on CONFIG_HOTPLUG_PCI_PCIE
> but it feels like using super glue on a wound until we know why this
> happens.

IMO making CONFIG_HOTPLUG_PCI_PCIE part of defconfig is definitely not
a solution.  It just makes it slightly less likely that people will
hit this.

Making CONFIG_AMD_PMC depend on CONFIG_HOTPLUG_PCI_PCIE might be a
little better, but I agree that it's pretty janky to do that without
understanding the mechanism.  Seems like we have a good chance to
understand this better, so I'm not ready to paper over it yet.
