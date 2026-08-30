Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8BBA3D;
	Sun, 30 Aug 2026 07:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074529; cv=none; b=n/ZmH62WN9WH8d4ytq1iByoyko/4Mm6krihOqk9g0WO6sljT0HNY9jp5D4iFq4wjkPbBiMYGBCx5IdbL3QFlMrHnqZdjHoQu/H9HMO3yBVSBdM0kedpVr9hxPxx70ER28c89ykre7joElmZ7wp649fB/gMgYXpYM9En8terLyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074529; c=relaxed/simple;
	bh=0IRzBSt4eT9lZudaOi0rawYsLP13G2f+Dg+z1fvfCy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TMhr7KwOSsooUVKwIFtHnOjvsZZMuCAX+POHZWWZmwbZ1Jpd1Fyes7jk1f/CAB9EsvUfciq0upjoByYrHpdQ6awLsqbdZTfE4YQKz+xTJ8rj51QU7y1rzZGJHKhbsCetDYVRNpO1tkvWGI3ggVaM1KAD/bbfUFe9bCq9T7XH5mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=anDiVqEH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="anDiVqEH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074528; x=1819610528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0IRzBSt4eT9lZudaOi0rawYsLP13G2f+Dg+z1fvfCy0=;
  b=anDiVqEHWTaOa6sDVipNHgvF2Mn/qrsjcE4w4sUl+CZkbHJjH3bbwHiS
   UD/9ZQjmusLorTx3Ek05vuYb7tb4elYV7DSbCtbZ5RhuFvgUjSlHzRANY
   Zv6NZ3abmSWEpcFlE8RIjFcxEgy+w1yDk5pk/arkvsW+sQzBdzfqgnjWm
   qRXw7rvY84F5kxh03jotmCLtiHWo0Krprr36dpgX3I3Y3rS3VkfPKflVe
   +owW72cG1myfqrshUcKoOz940X9FiK6gi0S1U/u6snZ58Eh3gL+roPe5V
   1z/nC1acHEnO+vC6cymZAhHfj+B/s060u7vKC/trsG5R5ZGjEaB+tUbEY
   A==;
X-CSE-ConnectionGUID: FUWvhyFMTpGE0+QxiT1wKw==
X-CSE-MsgGUID: 8+6r7EDmS7e8N2Sa7fpzYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="87648935"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="87648935"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:22:07 -0700
X-CSE-ConnectionGUID: woQLyEEFQLauLj2+pTY8lg==
X-CSE-MsgGUID: azVJ2Ex6QNmQrox5/86hyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="266710378"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:22:04 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: jic23@kernel.org,
	fan.ni@samsung.com,
	mst@redhat.com,
	marcel.apfelbaum@gmail.com,
	dave@stgolabs.net,
	arun.george@samsung.com,
	dongjoo.seo1@samsung.com,
	s.neeraj@samsung.com,
	vikash.k5@samsung.com,
	cpgs@samsung.com,
	gost.dev@samsung.com,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC V2 06/10] hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability.
Date: Sun, 30 Aug 2026 15:21:44 +0800
Message-ID: <20260830072144.399508-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
References: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:06 +0530, Shrihari E S wrote:
> +            /*
> +             * SVC3 is only meant for UIO TLPs and The non-UIO protocol 0000
> +             * should be for VC0 only. Also checking the TC-VC mapping.
> +             */
> +            if ((i == 3) || (res_ctrl & PCI_SVC_VC0_PROTOCOL) ||
> +                 !(res_ctrl & BIT(i))) {
> +                valid = false;
> +            }

PCI_SVC_VC0_PROTOCOL is (0x0 << 8), so "res_ctrl & PCI_SVC_VC0_PROTOCOL"
is always 0 and the protocol-0000 rejection this comment describes can
never fire.  I tested it: wrote 0x80000010 (VC Enable | TC/VC map bit 4,
protocol select = 0000) to the VC4 Resource Control register of a
cxl-rp; the readback keeps VC Enable set (and, going by the code,
pcie_svc_update_map() then marks uio_opt_svc), where per the comment
the write should have been rejected.  Protocol == 0000 needs the
whole field tested, e.g. !(res_ctrl & PCI_SVC_VC_PROTOCOL_SELECTED).

The UIO branch has the same pattern:

> +        if (res_ctrl & SVC_UIO_PROTOCOL_SELECTED) {

Matches any protocol value with bit 9 set -- including the
vendor-defined 1111b -- not just 0010b.  Comparing the extracted 4-bit
field against the expected value in both branches would close that.

Same run: Port Cap1 reads back EVCC=7, but the init loop only populates
sets 0, 3 and 4 -- the rest read VC ID 000b, the same as VC0, which
7.9.29.6 wants unique.  Was EVCC=2 with sets 1/2 carrying 3/4 the shape
you were after?  (Quoting 6.2 throughout -- newest spec I have.)

> +void pcie_svc_cap_reset(PCIDevice *dev)
> +{
[...]
> +    pci_set_long(dev->config + offset + PCI_SVC_CTL_OFFSET, 0);
> +    pci_set_long(dev->config + offset + PCI_SVC_STA_OFFSET, 0);
> +}

The init function sets USE_VC_MFVC and this clears it again, before
a cold-plugged guest ever runs -- SVC status reads 0 on all four port
types at first boot.  0 is the conformant value anyway (7.9.29.5, and
the comment above the set says as much), so I'd drop the set at init
rather than restore the bit here.

The asymmetry does bite for the rest of the state: a guest-set VC
Enable in RES_CTRL(3)/(4) survives a system reset while CTL/STA are
cleared, and the dev->exp.svc shadow flags set by
pcie_svc_update_map() aren't cleared either.

On the register defines: v1 ended with routing these through
pci_regs.h plus a note on when the kernel header picks them up; they
went into QEMU's pcie_regs.h instead.  Still the plan for a later
spin, or intentional?

Many thanks,
Junjie
