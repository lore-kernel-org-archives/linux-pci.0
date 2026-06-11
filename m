Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91130DEA6;
	Thu, 11 Jun 2026 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171857; cv=none; b=QqKD+vU7dSHoLAfqe9hIN7SB6eb/OgbdtVULPjXD32w0VwqEG14OQUa5zYzpJDVVJeOZX6xKdVPbe/GjmN63uuIJC2fPhWooomBiw6EHRD/sifhAGt9FNqTZA6ifT6Xsq5mUx3Tkvhy1vJCFQNJJ3o9ZbB7XdULMskWs9qZ3nGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171857; c=relaxed/simple;
	bh=yWJjbFWP40GQ6mBlWIN/vS9n955pAAcL7GLSYEsj4HY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qaudqhlAEl/QC6rh6jcsYEGfp7BpcvnGAERxZvf/bIPePcCmDBpYKqUIlf22TxklxFT5Zt3yceTiyJZmrecmR/gwk0QKKr8uegPZh0Wif4Ot8KOgBFDXQ6Cd93cQJIzxyUauLYe7aWHyp44+pYi9Y67U1Pojxxi23z1nNrPZph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OBTTQExz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OBTTQExz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781171857; x=1812707857;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=yWJjbFWP40GQ6mBlWIN/vS9n955pAAcL7GLSYEsj4HY=;
  b=OBTTQExz475P2M9aWF0XlvRisa9/aFb5oZW/jsZpbhBU4RqFvx2CQ+Jn
   ga1z/Vt7/JJjNhCpRbCBioCpZeyo34Kd2rJmvAN4RENFbzSygd4T0bfrb
   YtHnY0GwN91VpOVMZLe1n7PiJPWjHJaOZu7KuYFB0CcRZyBUmF4LbhrVb
   Lg1Zrtu5sTlqKwmpTvi+gvDPysJc3sddDBEdct3EmmNUuH/ngamOSHmGY
   irNahPyyHh81NsoPrCPMUrF7ISgV0C9A/NCJnPDJIhSJJkU2pBcHYt7dO
   BTXR5TDONRAP51PcDU82GN1xLfYYm5ieRZPAjOfFLiWw3ZfeNMmIfhbAe
   A==;
X-CSE-ConnectionGUID: JxdTu95TT7WO5ysRteZKIg==
X-CSE-MsgGUID: 0HTt3UaLTWWhpsPiSfBFVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81960659"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="81960659"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:57:36 -0700
X-CSE-ConnectionGUID: x0Bc822/ToWPO/USHQ7R+Q==
X-CSE-MsgGUID: /Wwg94r3T2yEBx6ELbbw3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="246458770"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 02:57:32 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 11 Jun 2026 12:57:28 +0300 (EEST)
To: Yuguo Li <cs.hugolee@gmail.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Jesse Barnes <jbarnes@virtuousgeek.org>, 
    Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, 
    Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
    Yinghai Lu <yinghai@kernel.org>, Yuguo Li <hugoolli@tencent.com>
Subject: Re: [PATCH 2/2] PCI: setup-res: Guard against bus->self == NULL in
 _pci_assign_resource()
In-Reply-To: <20260610135709.1630627-3-hugoolli@tencent.com>
Message-ID: <ef439f87-46dc-8c29-ecb4-10813eff98d0@linux.intel.com>
References: <20260610135709.1630627-1-hugoolli@tencent.com> <20260610135709.1630627-3-hugoolli@tencent.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 10 Jun 2026, Yuguo Li wrote:

> _pci_assign_resource() walks up the parent buses looking for a
> transparent bridge to retry resource allocation against.  The
> termination check dereferences bus->self->transparent without first
> testing bus->self.
> 
> For SR-IOV virtual buses created by virtfn_add_bus() via
> pci_add_new_bus(parent, NULL, busnr) -- which happens when a VF lands
> on a bus number different from its PF -- bus->self is NULL.  When
> __pci_assign_resource() is invoked on such a VF (e.g. via
> pci_assign_resource() from userspace-triggered LTP coverage) and the
> allocation fails on the first iteration, the !bus->parent test passes
> because the virtual bus does have a parent, and the next term then
> NULL-derefs bus->self.
> 
> Add an explicit !bus->self check, mirroring the established pattern
> elsewhere in drivers/pci/ (e.g. pci.c, probe.c, pciehp_hpc.c).
> 
> Reproduced on mainline 7.1.0-rc7+ on x86_64 with an SR-IOV PF whose
> VFs span multiple bus numbers, by triggering pci_assign_resource() on
> a VF that lives on a virtual bus:
> 
>     BUG: kernel NULL pointer dereference, address: 0000000000000860
>     RIP: 0010:_pci_assign_resource+0x63/0x130
>     Call Trace:
>      pci_assign_resource+0xe9/0x370
>      ... (LTP tpci test-case 12 driving pci_assign_resource via sysfs)

Hi,

And who called _*pci_assign_resource(), etc.? I actually wanted to check 
the code... :-( Please don't strip PCI core related parts of the 
callchain.

>      do_syscall_64+0xab/0x500
> 
> This is the same SR-IOV-virtual-bus / self == NULL pattern fixed for
> pci_read_bridge_bases() in commit ("PCI: Bail out of
> pci_read_bridge_bases() for SR-IOV virtual buses").
> 
> Fixes: d09ee9687e02 ("PCI: improve resource allocation under transparent bridges")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuguo Li <hugoolli@tencent.com>
> ---
>  drivers/pci/setup-res.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index 991d3ed543f5..e8bd3d4ff923 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -353,7 +353,7 @@ static int _pci_assign_resource(struct pci_dev *dev, int resno,
>  
>  	bus = dev->bus;
>  	while ((ret = __pci_assign_resource(bus, dev, resno, size, min_align))) {
> -		if (!bus->parent || !bus->self->transparent)
> +		if (!bus->parent || !bus->self || !bus->self->transparent)

I'd like to know if this should not break in case of !bus->self because
I couldn't immediately find the code which would add window resources to 
the VF virtual bus so I'm not convinced this check is right.

__pci_assign_resource() obviously must have failed to assign the resource 
if you can trigger NULL deref here so that hints VF bus does not have the 
resource that could parent dev's resource present (another explanation 
could be that it just doesn't fit there but I cannot say it based on the 
limited information).

Did the resource fail to assign? What is the resulting resource tree with 
this change?

The more approriate check might be this one:

		if (!bus->parent || (bus->self && !bus->self->transparent))

-- 
 i.

