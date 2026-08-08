Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2ED4330D2A;
	Sat,  8 Aug 2026 17:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786209805; cv=none; b=AR/yfthWg6jqQAEWaU/rWu2T+kq+WX22VcAkRVXlypCWzyZnsxKQcS1DkMHEGT2Ifly0BvGH4dFEAqyKygN+oGTLFFKLGsXz1QwvLaye+ELrMaQKpkm7xJtr8O9cKScR7/EZQvIMxlst9ZMAJwEILGCoJF2zKu0AvOoxjyJgzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786209805; c=relaxed/simple;
	bh=XqzKeOrl0HbsjgV3fBPtFE9vlyiQB/LtkqCJuJErEH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p4gHOpUc6oQobYQktDbEhSkcxoyJO6lm2CFyuBP/3zVEE3kTHB22QW5WrOjN/ZvcHJZEL5ZDvDSP0+I+1WLrt8ENtbWB3Bn4b1o/pyGHuBssFOaWti7hZAUf2CBgKUdCkwYta5tW/zXv7dlt62VRaA3AQbWcnofyHkV/yyW0gwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/JT25Zg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/JT25Zg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF751F000E9;
	Sat,  8 Aug 2026 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786209804;
	bh=aaGZwfZ5AlcimCI6EowKiTNgtwZB/06u9D4Ve2MvzqQ=;
	h=From:To:Cc:Subject:Date;
	b=J/JT25Zg7yxNR/lHmXXjq/hQcFrHV+JtPDY5Y1sozTMEysXKbQFOk/vGqeXuVGfqf
	 PRwOQEVjUf8EOL6Wt2LyOFK8R84tUjf/B88qwETqbDiv/GL8MzvoDWS5g/N9qkfk4U
	 SZoowjjlyV48VjURu0bml/exyHPK6dS5CAIuytKWFGR/XUVchMEX1ZfbGPTqYK++Ef
	 gos3kv30GnYtkmN6+MnoQ4f6kPYhQZqB8YPgioG6J1ggbcgPRaMNpSCAwR9TCKgkmT
	 Ps0mVZUtiqzuXF5d/tuVDPAFCe5wRYX/UepVguljJBOPFnHnMlYYmcqvLUrLcdVnfu
	 dqlxSKJ1IYvUw==
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1 0/2] PCI: Include human-readable BAR and window sizes
Date: Sat,  8 Aug 2026 12:23:06 -0500
Message-ID: <20260808172308.282591-1-bhelgaas@google.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PCI and other subsystems often use %pR to decode and print memory ranges.
The size of the range is useful to know but hard to read off at a glance,
e.g., 

  BAR 0 [mem 0xfea80000-0xfea9ffff]

Add more user-friendly size information to the %pR format, e.g.,

  BAR 0 [mem 0xfea80000-0xfea9ffff (128 KiB)]

%pR is also used to print I/O port, bus number, and DMA resources, where
the size is not as relevant, so this only applies to IORESOURCE_MEM
resources.

Bjorn Helgaas (2):
  vsprintf: Add %pR human-readable size
  PCI: Include human-readable sizes in resource assignment messages


vfio_pci_info_atomic_cap
 drivers/pci/setup-bus.c | 46 +++++++++++++++++++++++++++++------------
 drivers/pci/setup-res.c | 11 ++++++----
 lib/vsprintf.c          | 18 ++++++++++++----
 3 files changed, 54 insertions(+), 21 deletions(-)

-- 
2.53.0

