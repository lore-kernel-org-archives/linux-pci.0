Received: from va-2-29.ptr.blmpb.com (va-2-29.ptr.blmpb.com [209.127.231.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924554048A7
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783500321; cv=none; b=p72xKZW8SwypkVVwx0Fq1ASoOfy/dazZ1kUDMlGGMNc1GurxZPW1xTEjHYuaU/TFZpEVsUlSQnijNe4meSOrfhCIht7iSD7rjwl/H424V6m+j0adtMMIw1rdbmMNn/pyXJGjjIGnEvA6UxF5v45dBcH5rI7llJnGK3bHUiVTgJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783500321; c=relaxed/simple;
	bh=qqxjBDyOee/HHo1a1rnMVWzu13eXWL17EZYlBCnN7sQ=;
	h=To:From:Date:Mime-Version:Cc:Subject:Message-Id:Content-Type; b=mpmpJ4gzJld8o3MA46OOPbEDjlNsN3FjUTM/qUJJEZMZeex4su92qqofRNaAo0NBs8o2umEJDqMvShsinrt4KeMkXnYIPQhpbQGnEv82pBB6We2s2thrHHAty7BZ/nmqsyiFyaaGdXNdhtEYOpM7p+On/rEnm6piaX3Q6M7FFEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com; spf=pass smtp.mailfrom=picoheart.com; dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b=FhyCnU5m; arc=none smtp.client-ip=209.127.231.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=picoheart.com header.i=@picoheart.com header.b="FhyCnU5m"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1783500312; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kUnD/FmbiEHATMxH4UM6OStMfnlD8a8PP8hjbRyglEs=;
 b=FhyCnU5mkE9b7n7uKbGbMPFjcENjH8WpSWfJOqH+aEwx0e4Rg5WsuDpaxhenzGzQhPJ2dc
 hY9gIlYxx9HNZ4R8Xf7361K4bUijoZwLVhAc3xkfCp4llwDiemACIOAQ5djxEGMGxC+Lga
 rrt6VB40XVolPkfjsTfUEp311VJ73nRZ21PSzfJvaGzt3g7QKB2KoxcmoTzFvW8RLeKE1m
 ZZTYJEMY8QaFZMotnp3O51GxNi/FP4igCPQHb2Shwk8ULJBuKUtFdt21EDj3LKC5MYVGYY
 idSo/8iJOspXn+pQao+J4hAsxFM1HGA0qddRKOzAvUa2+HZ5xpABiNQ6th50Iw==
To: <xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>, 
	<will@kernel.org>, <mark.rutland@arm.com>, <jic23@kernel.org>, 
	<bhelgaas@google.com>, <linux-pci@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>
From: "Yicong Yang" <yang.yicong@picoheart.com>
Date: Wed,  8 Jul 2026 16:45:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Cc: <jingoohan1@gmail.com>, <mani@kernel.org>, <juwenlong@picoheart.com>, 
	<geshijian@picoheart.com>, <yang.yicong@picoheart.com>, 
	<douyufan@picoheart.com>
Subject: [PATCH v3 0/4] New vendor support and optimizations for DWC PCIe PMU
X-Lms-Return-Path: <lba+26a4e0e16+f61429+vger.kernel.org+yang.yicong@picoheart.com>
X-Mailer: git-send-email 2.50.1
Message-Id: <20260708084507.98242-1-yang.yicong@picoheart.com>
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>
Received: from G9WYR9K0VW.bytedance.net ([61.141.241.112]) by smtp.feishu.cn with ESMTPS; Wed, 08 Jul 2026 16:45:09 +0800
Content-Type: text/plain; charset=UTF-8

This patchset mainly enable the DWC PCIe PMU on our platform (Patch 1/4).
Besides do some optimization and refactor:
- Patch 2/4 extend the monitoring limit on platforms with narrowed counter width (< 64 bit)
- Patch 3/4 switch the driver to use the faux device interface
- Patch 4/4 fix an old issue that PMU may counting when corresponding root port
  is runtime suspended.

Change since v2:
- Fix the sytle and ID orders per the comments.
- Fix one runtime pm issue
Link: https://lore.kernel.org/lkml/20260629092717.74946-1-yang.yicong@picoheart.com/

Change since v1:
- always enable hrtimer for updating narrowed counters on affected platform
- refine the commints and fix styles per Jonthan, thanks.
Link: https://lore.kernel.org/all/20260615063459.25361-1-yang.yicong@picoheart.com/


Yicong Yang (3):
  perf/dwc_pcie: Add support for Picoheart vendor devices
  perf/dwc_pcie: Convert to faux device interface
  drivers/perf: Fix the condition where the root port is runtime
    suspended

Yufan Dou (1):
  perf/dwc_pcie: Support narrowed time-based counter for long time
    monitoring

 drivers/perf/dwc_pcie_pmu.c | 195 +++++++++++++++++++++++++-----------
 include/linux/pci_ids.h     |   2 +
 include/linux/pcie-dwc.h    |   2 +
 3 files changed, 141 insertions(+), 58 deletions(-)

-- 
2.50.1 (Apple Git-155)
