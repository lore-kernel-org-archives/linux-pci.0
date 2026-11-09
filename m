Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794229823;
	b=4wqMwjqQeRt1DQSSN53DHIzcXw52Bh2AOR6s4y3hVlWOQ58u9sjkQJRzmnNNSwhWw/PP
	 SrKTyyaH1phYwqs9MmQ+2eq8yx6W2TqnthdIU8rozGWPIeQKdaBhXu2+DonlyyO5x2qmC
	 TjSDBE68RsGxPLx62tSV2iN+c5KYLP/y6GHsFZ7be1V2LTkwCQ3M0GXCYS6tZt+T4OMdv
	 adLxiUdt3nF1xdaNGj/Gk9Nx794b9AWS2K7+F4bBcjW06y6S3tBbw1clE7vADO/mY9yQw
	 qLuRPaSkA0QDP4ki0v2p4Ck5MeqGPSpFB2GSj0TEc+oHjoYfPkGOzfXGQ+SuQc7yLIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794229823;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=FZZMx5Ep2WBP3yRYbUwpo8CiLtMhiMWGEYjzNV7FYJw=;
	b=3BnYMk+8kPs9sDZMSBajrPWNHn5Mq0jJf79U//XUhPddRrikutSoo5FvRDmBlO+evjvi
	 gGkMtmDRcQlQ8GvNYcJn5VLQg7FoPsZ//X+k/GNlhOYZXtjb2Ipd6beLKp/htvlf8GrFt
	 gF6I9OFrjVF4JgPkO03tXtC/6TXa3RkSwEsgVFqnNi6OTpynp0nMCjjVeJzL2OHh4OFka
	 ym9CWWK33S+qZExJyGEUWk8k7XN42SKOFVEaL/PbpFZ4bEDXhih14BYrv4A9ciz2dwT/v
	 /7xI0021XLE11+hTJTUnN9hDtMyvneCcyoGYI6U3bwzhzMdIfIxuj2e30xFD921sRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a0YKVZJO;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A66606A321;
	Mon,  9 Nov 2026 13:10:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8A66606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a0YKVZJO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794229823; x=1825765823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MIxBSmzDBepqTU2DTXW7tfzJLCR9DCC+4Y6znsrqrMY=;
  b=a0YKVZJO2wz+OZaamVF98vntkPik2sQ8pw7wstL/FyW6MqkfzfDpD8QZ
   5FVsD+hcD9SVgWcsBTQCbhkBRRmN0wJFxntWCFNYXBDwdPnTUTeeVaI8x
   B/9OWJRmn+V7KKjEQ3HtpNC7Z1X07YKDLC/+QlhzLkA3QnFmxsCRo1mnV
   ePDwtdYVy6/nNdXD/tHi8Ho5qu3UbHI1iAbWTozi3eiz3a9OG3lNED1aA
   99WaWXiZJ/OiWvvOAEzakbdys8ZGgRfOtqbQx+UwbSzXfm2LckTF8pjgc
   xQf/fxHCcN/wKI/rBgZnxlVC4bVRYY9QrcFkswCU8TYpWm5CNbvlf60vN
   Q==;
X-CSE-ConnectionGUID: qjZE+a5kS6eZL69OKTWCVQ==
X-CSE-MsgGUID: 881HzFDpSFeYbUveTbOCjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3052214"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="3052214"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:23 -0800
X-CSE-ConnectionGUID: lyKUtdNAR0SkpkMCqLgrRw==
X-CSE-MsgGUID: rDXvF2QkR0aXbw7i3v3x2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8002741"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 05:10:19 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/3] PCI: remove redundant resource assignments done after BAR resize
Date: Mon,  9 Nov 2026 15:10:07 +0200
Message-ID: <20261109131011.1815-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The BAR resize rework removed the resource assignment call that
followed the BAR resize in amdgpu. The xe and i915 drivers and the
PCI sysfs resize interface still make the same call.
 
The current BAR resize code should properly assign all resources and
handle fallback gracefully so a driver-side call to assign resource
right after BAR resize is just duplicate work (no-op). If that isn't
the case somewhere, the fix belongs either the BAR resize code or the
code that left the resource unassigned (e.g. a hotplug race or whatever
left an resource unassigned prior to resize).

If drm wants to take their patches out of these, it's fine with me
(either drm+pci or through pci tree only works for me).


Ilpo Järvinen (3):
  PCI/sysfs: Remove resource assignment after BAR resize
  drm/xe: Remove driver side resource assignment after BAR resize
  drm/i915: Remove driver side resource assignment after BAR resize

 drivers/gpu/drm/i915/gt/intel_region_lmem.c | 1 -
 drivers/gpu/drm/xe/xe_pci_rebar.c           | 2 --
 drivers/pci/pci-sysfs.c                     | 3 ---
 3 files changed, 6 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.47.3

