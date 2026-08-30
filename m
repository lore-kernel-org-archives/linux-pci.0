Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2557A35C68E;
	Sun, 30 Aug 2026 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788074423; cv=none; b=TECHAapLpNSibpXKwLq/1uewKnN/jediP8nR2CucubrARe8nSWKBqiIvUTyeRGVChucS/tkE4pDEbkVpa7B5pC9VDzKs7vk6VsyhmGYfNGpWYr65yxZTQdl3hLUAb5Ra9RFXzf/AwBHhHvtOcw8VNgSlhnc+AY5VqJgQgfSEK10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788074423; c=relaxed/simple;
	bh=3NN2t9r2Azkmq9exQ6+3pR2tk3buhw2The2KdTb3xFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXao9ZXPY8SOA0A25pbW+ZZkOaain9HSMSg6nnrPECKv03PVDxl7BIjvUOfWk9ucOnUcJV+msYabiLfLRmNCzVVwl8fSFpn0byxqaUjENkW4aAZLNla88h4R9zDHkH8RbCdxuIHPVI52XjbLBhlo4LF/7ueDBnKexcvpVlTJHAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q+f7HNuq; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q+f7HNuq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788074420; x=1819610420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NN2t9r2Azkmq9exQ6+3pR2tk3buhw2The2KdTb3xFA=;
  b=Q+f7HNuqQrqGi5bfqFw+pjX+XF9TLaz+ssvFxI59XN6rdn/ZQ30eu80r
   Bb5aA7Sr49m1AaksWJCsTrLOoY1Yy+mU2XYfESBrwXCaLks4kLXxEAddJ
   E8eJhL+vAiNmi3ay9rTtbX3l2S1IGGUI96OFdSN6/Oq52GnP5TsMvvOYY
   W6QL60/oRYA+HJZD1WYwMYaF/NvJxTqwGutfClNE3TRR4M4XKBAMGDeXq
   Fo5tyYhPQi1yXLkolNtp43s6oh92Rwpo/vO/AQNXtDYrmNp1XGBzeB8Gw
   dRUhAiG5m7oaRPCvX4SAh3elmlU+VIPvhqS7udztcG99VeDNXKnO+Pcfi
   w==;
X-CSE-ConnectionGUID: C3enmAaKSOSv7IBSslewcQ==
X-CSE-MsgGUID: PagSibCgQIOawKQ9GADXGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11890"; a="92380927"
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="92380927"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:20:18 -0700
X-CSE-ConnectionGUID: 92CMuN+MSoaG1EOQ7gBxtA==
X-CSE-MsgGUID: LpRICQnqSkCkPUG41hNkIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,251,1779174000"; 
   d="scan'208";a="298441716"
Received: from junjie-desk-dev.bj.intel.com (HELO junjie-desk-dev.tail2c02c1.ts.net) ([10.238.152.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2026 00:20:15 -0700
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
Subject: Re: [RFC V2 0/9] hw/pci: hw/cxl: Add UIO support in CXL and PCIe stack.
Date: Sun, 30 Aug 2026 15:19:53 +0800
Message-ID: <20260830071953.399414-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
References: <20260826053410.1322176-1-shrihari.s@samsung.com> <1212772528.01787732102473.JavaMail.epsvc@epcpadp1new>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Wed, 26 Aug 2026 11:04:00 +0530, Shrihari E S wrote:
> This series is written on top of:
>
> Base commit: 3c99db7705c1a885c795b7c14f751c7a3ba29ed8
> Repository: https://gitlab.com/jic23/qemu
> Branch: cxl-2026-01-09-draft

Applies clean there and builds; x86_64 cxl-test still passes.  I
booted the patch-10 example topology and walked the extended
capability chains and the HDM decoder registers: the v1 SVC/AER
collision is fixed.  Two things are broken, both on 7/10: the
switch USP never advertises HDM UIO -- its uio gate reads a flitmode
field that nothing sets -- so the example topology can't advertise UIO
end to end, and "-device ioh3420,x-svc=on" aborts QEMU.  Per-patch
comments on 2, 3 and 5 through 10.

Testing point 3 looks at whether existing configurations still work;
the compat question is whether they still look the same to a guest.
2/10 moves x-256b-flit onto pcie-root-port with the default left on,
so every pcie-root-port on q35 comes up in flit mode with no compat
entry -- an inbound migration already fails at that patch, I tried
it -- and 7/10 shifts the CXL DVSEC offsets whether or not x-svc is set.

Worth adding the PCI maintainers on v3 -- eight of the ten patches
touch files under their entry, and both new capabilities land in
hw/pci.

I'll re-run the topology once the USP gate is settled.

Many thanks,
Junjie
