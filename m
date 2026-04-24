Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C081282F3F
	for <linux-pci@vger.kernel.org>; Fri, 24 Apr 2026 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043068; cv=none; b=UjMVZslpFTVTYqDPzUGyOZB0SVzQiJTzbfnKV52zCZafqURzt8SmZtijCS6RlME7+RAc+htn6KmZXI4aTcmKPgL6J2qBd5uu9rn6HQa8JaW7P1cYwMKDWGzgin3qK/r/sWsCTrDM+LTjmpUz6DZWotQK/3wl4TZugG6YA69XKwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043068; c=relaxed/simple;
	bh=1lbVp4nw/QPjFwcNSunCqFJAvHfz2Q2S4JYVL49zZBA=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cfcIOib55hVIeO6f7wusfEu6jG2lY0xAyg8Xazepv3FE/62vsu6J7RY6RWPpxB3g4ZDBZ0GiF+LoV1cVSc2JEerObyHLud7RQJ+qS15/ufZe+jOA0rFDHkmZO+WSA04ScoAW8EuU7qC/xX03AJCHGqbJcVI5q/qlEtuEvGFXOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dI3FTkiT; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dI3FTkiT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777043066; x=1808579066;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=1lbVp4nw/QPjFwcNSunCqFJAvHfz2Q2S4JYVL49zZBA=;
  b=dI3FTkiTEkhh2ZLmUAFA+vbgWVa0ZAU3ocwkG04m6QdhVTS+/tRc+pZP
   jiY1iXS5PC9m6S8jdrhzenzxYqyVarYYUBCS+TbD9VGUS03nqAzvtsIPh
   79gKg3EjkYNnVwKPV3zTBGG8EqCQAw5n5QwwdMzubtq1PpxLGhAVyn8iQ
   b9HyamtTlFo9fIUZvmu6zLkPjirVOQzId6iLhkQyetXaAhxf1oe86djOy
   BL7c3fkFkzIFg2VQAK5Qm7lGrGGEAuFuEpouOPzieP20QZglYCPJBx8W7
   Yra5r9cZr0+zZYz84bzwYUtPTyGDjAfI8Y+xdRbmS/8+SmDfx7F6KJPqv
   w==;
X-CSE-ConnectionGUID: LkSD6UjtSV+4Nh8yVs4hKw==
X-CSE-MsgGUID: AvxuHbrZSGKPSYs3BgApog==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="95437048"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="95437048"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:04:26 -0700
X-CSE-ConnectionGUID: dT6pl3rkS0y34TB9ihqQxQ==
X-CSE-MsgGUID: guOF/7lGTLSWqGrhKFPeNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="229775204"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.120])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:04:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 24 Apr 2026 18:04:19 +0300 (EEST)
To: Maarten Lankhorst <dev@lankhorst.se>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] PCI: Fix resizable bar fails due to bridge memory
 region
In-Reply-To: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se>
Message-ID: <ee594d2d-f5c8-271b-e883-9d43a47ad4ff@linux.intel.com>
References: <7f673ce8-fa00-47aa-a50f-812ae5073279@lankhorst.se>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Apr 2026, Maarten Lankhorst wrote:

> I encountered a problem that I have on my system, where I cannot resize
> the bar because one of the bridges has a 

You're missing words from here. But I can guess you've that extra BAR on 
in-card the bridge.

> If I take a look at the topology, the GPU shares the memory region with a bridge,
> 
> +-[0000:64]-+-00.0-[65-68]----00.0-[66-68]--+-01.0-[67]----00.0
> 
> The specific bridge likely causing a failure is:
> 
> 65:00.0 PCI bridge: Intel Corporation Device e2ff (rev 01) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 32, IOMMU group 1
>         Memory at 382400000000 (64-bit, prefetchable) [size=8M]
>         ....
> 
> Which causes upstream bridge 64:00.0 initially to allocate the region
> [38fe0000000-38ff0000000) for the GPU, and [382ff0000000..382ff07fffff]
> for the bridge device.
> 
> Bridge 64 is big enough for 1 BMG with a 32 GB bar and the second 8 MB allocation:
> pci_bus 0000:64: resource 9 [mem 0x382000000000-0x382fffffffff window] (64GB window)
> 
> The reason for failure is that bridge 65 has a 8 MB memory region assigned,

> and previously it was ignored when reallocating.

What does this mean? I don't think it was ever ignored while 
reallocating??

Note that kernel has become much more verbose in explaining why things 
fail so perhaps the added message is confusing you (they won't appear in 
the old kernels).

> Failing case:
> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: was not released (still contains assigned resources)
> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
> pcieport 0000:65:00.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: can't assign; no space
> pcieport 0000:66:01.0: bridge window [mem size 0x400000000 64bit pref]: failed to assign
> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
> xe 0000:67:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> pcieport 0000:64:00.0:   bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]
> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> pcieport 0000:65:00.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]
> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> pcieport 0000:66:01.0:   bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]
> 
> Working with the patch below:
> xe 0000:67:00.0: [drm] Attempting to resize bar from 256MiB -> 16384MiB
> xe 0000:67:00.0: BAR 2 [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:66:01.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:65:00.0: bridge window [mem 0x382fe0000000-0x382fefffffff 64bit pref]: releasing
> pcieport 0000:65:00.0: BAR 0 [mem 0x382ff0000000-0x382ff07fffff 64bit pref]: releasing
> pcieport 0000:64:00.0: bridge window [mem 0x382fe0000000-0x382ff07fffff 64bit pref]: releasing
> pcieport 0000:64:00.0: bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]: assigned
> pcieport 0000:65:00.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
> pcieport 0000:65:00.0: BAR 0 [mem 0x382400000000-0x3824007fffff 64bit pref]: assigned
> pcieport 0000:66:01.0: bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
> xe 0000:67:00.0: BAR 2 [mem 0x382000000000-0x3823ffffffff 64bit pref]: assigned
> pcieport 0000:64:00.0: PCI bridge to [bus 65-68]
> pcieport 0000:64:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> pcieport 0000:64:00.0:   bridge window [mem 0x382000000000-0x3824007fffff 64bit pref]
> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
> pcieport 0000:65:00.0: PCI bridge to [bus 66-68]
> pcieport 0000:65:00.0:   bridge window [mem 0xd7000000-0xd83fffff]
> pcieport 0000:65:00.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
> pcieport 0000:66:01.0: PCI bridge to [bus 67]
> pcieport 0000:66:01.0:   bridge window [mem 0xd7000000-0xd81fffff]
> pcieport 0000:66:01.0:   bridge window [mem 0x382000000000-0x3823ffffffff 64bit pref]
> xe 0000:67:00.0: [drm] BAR2 resized to 16384MiB
> 
> 
> Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
> ---
> I'm not 100% this is the correct fix, I don't know why the bridge itself has
> a memory region, why the kernel allocates it and when it's supposed to
> be used. Not a PCI expert. :-)

I don't know why it is there either. Nothing in the portdrv really uses it 
for anything. There is patchset somewhere lying around which adds a quirk 
that releases the "extra" BAR.

> ---
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 61f769aaa2f6c..98692dccc4721 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -2258,6 +2258,7 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
>  	unsigned long type = res->flags;
>  	struct pci_dev_resource *dev_res;
>  	struct pci_dev *bridge = NULL;
> +	struct resource *r;
>  	LIST_HEAD(added);
>  	LIST_HEAD(failed);
>  	unsigned int i;
> @@ -2286,6 +2287,21 @@ static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *
>  				 res_name, res);
>  		}
>  
> +		pci_dev_for_each_resource(bridge, r, i) {
> +			if (!resource_assigned(r) || r->child)
> +				continue;
> +
> +			if ((r->flags & IORESOURCE_TYPE_BITS) !=
> +			    (type & IORESOURCE_TYPE_BITS))
> +				continue;

This should check if the bridge window is the same or not.

But it may not be wise to do this for any bridge without any 
discrimination.

> +			ret = pci_dev_res_add_to_list(saved, bridge, r, 0, 0);
> +			if (ret)
> +				return ret;
> +
> +			pci_release_resource(bridge, i);
> +		}
> +
>  		bus = bus->parent;
>  	}
>  
> 

-- 
 i.

