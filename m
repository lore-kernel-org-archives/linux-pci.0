Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E82C235E;
	Sat, 11 Apr 2026 00:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775867993; cv=none; b=NTILhv5H2mRbjmtFdxsrfh+Az+wpF+fVFZxeonfZjaOc4fHgleSmp3ePDi8ouP62Ypb/rhN/QiHcxbp99FLDTkzRSSNojTIYwbHqEPHhQbi2Xj0EwdYxbOjgvJrUW4gif3s+yb1CkAEXZezWuVW4oySgUwsSj6AsJ3s6hnUzIZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775867993; c=relaxed/simple;
	bh=bf9rDhhDLQYlfFaN1vUUcDJylrZVM5QUZxazTmomJjk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AwkV+2jFyeQMcQpUKE0ePh3lTwoZdzdCblhMpWJsHsu78txt+YvApW7zy8JMXp2RGfVnkg6o1XIEznCHWZyjVo3da5j8Ojrfwu4VFtDdxWJ06YRg2uPabOEsl30DJh+LKbkZ/CVn8cbYua1BjoTdJE3k6SwtBu64CfXoYVz5iOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibWeOg6j; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibWeOg6j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775867991; x=1807403991;
  h=from:to:cc:subject:date:message-id;
  bh=bf9rDhhDLQYlfFaN1vUUcDJylrZVM5QUZxazTmomJjk=;
  b=ibWeOg6jfS20eq2abjON0wPFKGLEYTtrKVwmc0T1W6yt4QDjbccmUG/u
   sLV73yCj55C5piBmme6nWiLSeuMOf8s7RuNj0wUkbxtB89mzmPkbQQgIX
   BtLyZIVEZIBHvh9NdpMR8OwHUrmNQ5VOc6muiHPI7gG7H7tANAChA2q/v
   OVBGQ9An4mi2reF3rBkgWi7KSYKR+TKhYBx7Q/+pAvfiivESysWFbI0xe
   mV5NLDWlmh8irk5DoMZoLURcyJ5/YK+iL+ReRTFql6fGc6536Ci8ezMZ/
   cIrjT7NRcMCSAxNEvqUfBX8vZING0SzUKqOex2LaVCezA3tvYJ3G7I1zs
   Q==;
X-CSE-ConnectionGUID: ASF6wV8RRLCBtk/yTaE1xw==
X-CSE-MsgGUID: cV5oz8JrQFucRzShy6wiEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="64423717"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="64423717"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 17:39:51 -0700
X-CSE-ConnectionGUID: x13t4GsSRpywFZyyfr8xKg==
X-CSE-MsgGUID: hbH5JdM/S0qunHamrYpX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; 
   d="scan'208";a="228392487"
Received: from estantil-desk.jf.intel.com ([10.166.241.24])
  by orviesa010.jf.intel.com with ESMTP; 10 Apr 2026 17:39:50 -0700
From: Emil Tantilov <emil.s.tantilov@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	jay.bhat@intel.com,
	ivan.d.barrera@intel.com,
	aleksandr.loktionov@intel.com,
	larysa.zaremba@intel.com,
	anthony.l.nguyen@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	aleksander.lobakin@intel.com,
	linux-pci@vger.kernel.org,
	madhu.chittim@intel.com,
	decot@google.com,
	willemb@google.com,
	sheenamo@google.com
Subject: [PATCH iwl-next 0/2] Introduce IDPF PCI callbacks
Date: Fri, 10 Apr 2026 17:39:57 -0700
Message-Id: <20260411003959.30959-1-emil.s.tantilov@intel.com>
X-Mailer: git-send-email 2.17.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This series implements PCI callbacks for the purpose of handling FLR and
PCI errors in the IDPF driver.

The first patch removes the conditional deinitialization of the mailbox in
the idpf_vc_core_deinit() function. Aside from being redundant, due to the
shutdown of the mailbox after a reset is detected, the check was also
preventing the driver from sending messages to stop and disable the vports
and queues on FW side, which is needed for the prepare phase of the FLR
handling.

The second patch implements the PCI callbacks. The logic here follows
the reset handling done in idpf_init_hard_reset(), but is split in
prepare and resume phases, where idpf_reset_prepare() stops all driver
operations and the resume callback attempt to recover following the
reset or the PCI error event.

Testing hints:
1. FLR via sysfs:
echo 1 > /sys/class/net/<ifname>/device/reset

Previously this would have been handled by idpf_init_hard_reset() as the
driver detects the reset. Now it will be done by the PCI err callbacks,
so this is the easiest way to test the reset_prepare/resume path.

2. PCI errors can be tested with aer-inject:
./aer-inject -s 83:00.0 examples/<error_type>

3. Stress testing can be done by combining various callbacks with the
reset from step 1:
echo 1 > /sys/class/net/<if>/device/reset& ethtool -L <if> combined 8
ethtool -L <if> combined 16& echo 1 > /sys/class/net/<if>/device/reset

Emil Tantilov (2):
  idpf: remove conditonal MBX deinit from idpf_vc_core_deinit()
  idpf: implement pci error handlers

 drivers/net/ethernet/intel/idpf/idpf.h        |   3 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  13 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   | 114 ++++++++++++++++++
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  11 +-
 4 files changed, 129 insertions(+), 12 deletions(-)

-- 
2.37.3

