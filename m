Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794264691;
	b=W9Iyfk8h4Z59v8Skflt8xQZlxp2T2aWVRnzc/+Rii2PD+q/y15NhLi4ny8LdroyYRbIF
	 YNeZe7NSQx678dn5IVvSOBOIwNgaON8nyR1eWXXRK5lviXXsKqrie6mXPrry7Eitxhn8i
	 H2F/ADGaCNjNz5elV/YYQ6ZAca7970tE/mSGCwPZegOL/O05bH8fN8Ls2CVbkIF46jPyW
	 zWbQyTjdQQg5vkMZUbIZ4E7ZxnU6RtiN8GLo/0V0sGZGnwRkifb2LFc+3tjY7hDlpK41n
	 HQsbD+BgxinuC4VtocQ86acwdgUXfxBFwWmAWS4e73M7gGUCdMoE5jOcFYJgFeLqJuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794264691;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=OLJ67V8X7KC85E5hy4wyiU8tc9lVp4VzA68SRJcP5ck=;
	b=3UDjHr5BlZx/RGEcqjIoFH+cFfsIln67YN5SnlF36LBNhEtm/ff0pPzQZY9TcOhkoZxD
	 velD9Wb83cYlCqO825ewRcJS0tmsv6bO7wliCoR1E5G+4+S3gkftSi3rQuXp3OVvZndHP
	 rexvVvNyItay23uq102JKcIDcxPw3VdyWvtlifjFM0jPpjp9uWgfQ7wQQhyXlvyxab3XV
	 ngXgBdbvuaHSKO1aF22su6dhVeR8uB+r8fo8/Bofx/nNvqWWy5JYDyk3/XT95yH/cg2Fp
	 H3LsV/pI8zABj9TjaSdkoMVFppZbrZ0ZGdVLpgLUNJ5vjh9MLeR9DLIwdbyjBaEmWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrAW11MW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90AC606A321;
	Mon,  9 Nov 2026 22:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VrAW11MW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1271F008A3;
	Mon,  9 Nov 2026 22:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794264690;
	bh=OLJ67V8X7KC85E5hy4wyiU8tc9lVp4VzA68SRJcP5ck=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=VrAW11MWqmE8FHeSQc8ncdp1WQph7/ZKqQKoG5d04gFFAh/KiyOeMyhbs9tgUPVEH
	 yu0Sw/LVrEnq1l0/D1Ogtek0IwM86wjZL3ojvdP6jRRRvgmhv+3Yt1Qlzl2Ay3tSfi
	 CGCdK0drexkQf8k6w5Z73HDDhrQ0OlxihxA9oNkzZhHXoFCMq+7x9TlJyew0p1V8ix
	 dAfTAyuGDAb2n7DcSnbSgQBxeYdtPNk1xfWrFJ5zmfRW9HQ5lVc+fCuBDBWH3eY7mp
	 qXuHsRYFc7+UJBGV9tH7o+jCuK7GtShutCPiQGcOj8hWCcvxwDoO5/MJYxga8YJXp+
	 rFWDHRUqWDABw==
Date: Mon, 9 Nov 2026 16:51:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: Re: [PATCH 0/3] PCI: remove redundant resource assignments done
 after BAR resize
Message-ID: <20261109225129.GA334675@bhelgaas>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>

On Mon, Nov 09, 2026 at 03:10:07PM +0200, Ilpo Järvinen wrote:
> The BAR resize rework removed the resource assignment call that
> followed the BAR resize in amdgpu. The xe and i915 drivers and the
> PCI sysfs resize interface still make the same call.
>  
> The current BAR resize code should properly assign all resources and
> handle fallback gracefully so a driver-side call to assign resource
> right after BAR resize is just duplicate work (no-op). If that isn't
> the case somewhere, the fix belongs either the BAR resize code or the
> code that left the resource unassigned (e.g. a hotplug race or whatever
> left an resource unassigned prior to resize).
> 
> If drm wants to take their patches out of these, it's fine with me
> (either drm+pci or through pci tree only works for me).
> 
> 
> Ilpo Järvinen (3):
>   PCI/sysfs: Remove resource assignment after BAR resize
>   drm/xe: Remove driver side resource assignment after BAR resize
>   drm/i915: Remove driver side resource assignment after BAR resize
> 
>  drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
>  drivers/gpu/drm/xe/xe_pci_rebar.c           | 2 --
>  drivers/pci/pci-sysfs.c                     | 3 ---
>  3 files changed, 6 deletions(-)

All applied to pci/resource for v7.5, thank you!
