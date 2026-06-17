Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190EC3BFAD1;
	Wed, 17 Jun 2026 07:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682238; cv=none; b=Fp76llqkqKeqwmHoS8Zx0XP/Ikqmi5GuAtss7s4ZVwHorJflkNJ9mr6SjGq2ZooqOkEA70BykuHPZDKR77N2Q8L13jkIt3HUS4PWmwzFLbshdx0Pzgl3qrPPCid7tXO3bkHd3/qZF0SvhhRH/f2ZYqjkNFBp7BJSCJwUBtU+Q3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682238; c=relaxed/simple;
	bh=JrQdhu8yn6tpuL6obR8nEfCZia2seXFUvByj6d+tDxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E14P6nTlrrR+oBlt36vgmCGFa/I+WIRfmbF4o7XbdcPL6YHIQ57pKqlKTGSXJp0mxUNSM6hao00dpQ4kwaxGam8AosI1ijHIiMJQA3quhA0xkmT9EYS8/OptzBoVTJMnaucep5C+mWMEk2IRdhc+/ZdgxrdyIqIzkhRnjUUplNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iKK6Bxb5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iKK6Bxb5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781682237; x=1813218237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JrQdhu8yn6tpuL6obR8nEfCZia2seXFUvByj6d+tDxg=;
  b=iKK6Bxb5XmKBEI944QdX9nsdULC1zft72Nc5iMqhU8iZeDufTipyyzoX
   MvC+ULCmna3S/I6ewxwEPh58oAZcZnC4V5PmfqBKyk0f5hMlu4QI3twSk
   Ktp7FjtoRNKVWWoAkNMd0ceh6VumRqYvVA8UQVzTGS94kRCakXh7JHejR
   oVwchiKFpXYZT0/Rb2gIm7HC/zbkbRwKlv6WCk0DTGnLtaI9xb32IydIM
   3u5eT33PVjeDrQED+4Te//Qi9MVzFLbtT5sP56YB+CofJLS9fe/D3s5ME
   rUN3WjTZ8p1JhbVtKVYFLVTzArJTZb3ye02kMIPruwakADHzGNQtBY4bg
   A==;
X-CSE-ConnectionGUID: zgQxUmh7QL+iolH/7GsMgQ==
X-CSE-MsgGUID: g1oaVf79TM2sKHZ2uDLOTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="93133619"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="93133619"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:57 -0700
X-CSE-ConnectionGUID: r3fPfwH1SKCwalYELaq4LA==
X-CSE-MsgGUID: Q2aD1LAcSAucpuWXhWqVEQ==
X-ExtLoop1: 1
Received: from junjie-optiplex-micro-plus-7010.bj.intel.com ([10.238.152.98])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 00:43:54 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Shrihari E S <shrihari.s@samsung.com>
Cc: Junjie Cao <junjie.cao@intel.com>,
	jic23@kernel.org,
	linux-cxl@vger.kernel.org,
	linux-pci@vger.kernel.org,
	qemu-devel@nongnu.org,
	cpgs@samsung.com,
	arun.george@samsung.com,
	vikash.k5@samsung.com,
	s.neeraj@samsung.com,
	dongjoo.seo1@samsung.com,
	dave@stgolabs.net,
	gost.dev@samsung.com
Subject: Re: [RFC 6/8] hw/pci: Add PCIe Streamlined Virtual Channel (SVC) capability.
Date: Wed, 17 Jun 2026 23:45:18 +0800
Message-ID: <20260617154521.520191-2-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609105836.3702787-7-shrihari.s@samsung.com>
References: <20260609105836.3702787-1-shrihari.s@samsung.com> <20260609105836.3702787-7-shrihari.s@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Shrihari,

On Tue,  9 Jun 2026 16:28:34 +0530, Shrihari E S wrote:
>      if (flitmode) {
> -        pci_long_test_and_set_mask(exp_cap + PCI_EXP_LNKSTA2,
> +        uint32_t pos = dev->exp.exp_cap;
> +
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
>                                     PCI_EXP_LNKSTA2_FLIT);
> +        pci_word_test_and_set_mask(exp_cap + PCI_EXP_FLAGS,
> +                                   PCI_EXP_FLAGS_FLIT);

Following up on Jonathan's observation here -- I'd also noticed a
bogus Interrupt Message Number on a plain flit-mode root port, so I
checked what the stray write actually does to the Flags register.
The impact is wider than just UIO:

The first set_mask writes PCI_EXP_LNKSTA2_FLIT (0x0400) into
PCI_EXP_FLAGS (cap offset 0x02) instead of PCI_EXP_LNKSTA2 (0x32).
0x0400 falls in the Interrupt Message Number field (bits 13:9) of the
Flags register, so a flit-mode port ends up reporting a nonzero
Interrupt Message Number (it reads back as 2).

pcie_cap_fill_lnk() runs for every flit-mode port, and x-256b-flit
defaults to on for pcie-root-port, so even a plain
"-device pcie-root-port" comes up with the corrupted field.

The second line (PCI_EXP_FLAGS_FLIT into Flags) looks correct and
should stay.  The first one looks like a typo in the destination
register -- it was PCI_EXP_LNKSTA2 before this series (visible in the
hunk above), so I'd restore it there rather than drop it.
pcie_cap_flit_write_config() does maintain the LNKSTA2 flit bit, but
only on guest LNKCTL writes; it doesn't run at realize/reset, so
dropping the line would leave LNKSTA2 flit status reading 0 at reset
instead of its pre-series value.

Many thanks,
Junjie
