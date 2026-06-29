Received: from va-2-53.ptr.blmpb.com (va-2-53.ptr.blmpb.com [209.127.231.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F443A7F47
	for <linux-pci@vger.kernel.org>; Mon, 29 Jun 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782725259; cv=none; b=m/lk+Wl3aomcrMC2WUFcMoP1/Hc+3EdIoV646Ha/MsOyPxV3iI6Uimg/kby9c6sN7MyFAw9lq4b2Jym/9c0d53nCEG1tdBh7iZAVlwCX2RIjztM+pu6TxxgvqcJ8hJ7ogbDrtN5JXoCbj0rjzcn54HaPkv6HB//NTAiPVYkvBHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782725259; c=relaxed/simple;
	bh=cDNjEtkbxPPAYSzPa85A/hIsh40mSao3Kd99KYUiaIs=;
	h=Cc:Subject:From:Date:Message-Id:Mime-Version:To:Content-Type; b=efwY1c0nD9jP3mxuhCbd1rw2kJBpeVLk4JfqvyO8K2wVQ1IM7XZAWLk9z/d6GhxN11dNl1ZRC1z3AlmuGHb21RxSIsZCq+MT6/3/cIN/bJmQp8wCUepiHA+JEOH9QPzOLZbd2xWPtiudumlTc30SEXOZQ/vq80gsBMHqCNSBXXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=K7OM8st1; arc=none smtp.client-ip=209.127.231.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="K7OM8st1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1782725243; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=EIRYVd2HO17Bih9m90fyaBD1V+fgyIuqmGqkWx0WfaI=;
 b=K7OM8st1G/aPW8ZTsv0aIg03lAi9sUX89ozMjdyC5V4woKwnQSigtnM+Noav1v+waLMf9w
 VdGzyn8fAruWx9cy1eFr/yHY4gGAYGIEjSWgOSQXb888qMGMkOkG5r1SOrX0HsbU0Cpl8W
 sBhcRPKpbDLF3zb7J5k8HzCv97mD0qwzjLDtEWFuH/eFNlZm8NDxWVHh81UlKYV94n2M55
 Ui1I8kjj3Sp1E4VMH/VBzQ615uFWGCUpNlTrNmIAJiJuFndmrhhpoZTteyH37v1TZA7d+g
 JNtJeVnDlWpfqnfUae3DHtLtFNhwEpMe5+ZkHesRGtusVSb4NHjnseMwoXumMw==
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
Subject: [PATCH v2 0/3] New vendor support and optimizations for DWC PCIe PMU
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.118]) by smtp.feishu.cn with ESMTPS; Mon, 29 Jun 2026 17:27:20 +0800
From: "Yicong Yang" <yang.yicong@picoheart.com>
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Date: Mon, 29 Jun 2026 17:27:14 +0800
Message-Id: <20260629092717.74946-1-yang.yicong@picoheart.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a423a79+7ccd61+vger.kernel.org+yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8

This patchset mainly enable the DWC PCIe PMU on our platform (Patch 1/3).
Besides do some optimization and refactor:
- Patch 2/3 extend the monitoring limit on platforms with narrowed counter width (< 64 bit)
- Patch 3/3 switch the driver to use the faux device interface

Change since v1:
- always enable hrtimer for updating narrowed counters on affected platform
- refine the commints and fix styles per Jonthan, thanks.
Link: https://lore.kernel.org/all/20260615063459.25361-1-yang.yicong@picoheart.com/

Yicong Yang (2):
  perf/dwc_pcie: Add support for Picoheart vendor devices
  perf/dwc_pcie: Convert to faux device interface

Yufan Dou (1):
  perf/dwc_pcie: Support narrowed time-based counter for long time
    monitoring

 drivers/perf/dwc_pcie_pmu.c | 170 ++++++++++++++++++++++++------------
 include/linux/pci_ids.h     |   2 +
 include/linux/pcie-dwc.h    |   2 +
 3 files changed, 117 insertions(+), 57 deletions(-)

-- 
2.50.1 (Apple Git-155)
