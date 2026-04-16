Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C028460;
	Thu, 16 Apr 2026 09:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332545; cv=none; b=pySobz2oTTQVnpYR6DURXOyfsVbh3FMJoKLsfA9Me7qP2gqRkKcT6Gt8Z08vs7uwwDwSLYm0sQXoki1TlBv4zbwvuKGov72xyNeoSeAbeUWQKmD85FzvvAD1UV4RGOr7dzUiYRfGQeXgIo2UtLnVE3M4aEsePJFyNdCkEHoPNuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332545; c=relaxed/simple;
	bh=Do3bjOX5Yz3nHlgztkmB+3XNsyylbY6ZDSvacrh0dwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A1UGgK7qhQiFNYU8JvhyJe2HVDCZZgT4eV87YMBkX0LmZfHe02brQGQ7qqD/pPbS+yyiNcx6/Qkl+Yl+o/mlfYrFeBQXWXwPsWae1DZDd7Xj7VD3VYpTfSWcCeFMbTTGamsyyAy2zyzMD88l3F5mOaV2bp3cbTqDOobeSu640mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fxChq1kQBzHnGd9;
	Thu, 16 Apr 2026 17:42:03 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D1E640584;
	Thu, 16 Apr 2026 17:42:21 +0800 (CST)
Received: from SecurePC-101-06.huawei.com (10.123.51.176) by
 dubpeml500005.china.huawei.com (7.214.145.207) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 16 Apr 2026 10:42:20 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Sizhe Liu <liusizhe5@huawei.com>, Jie Zhan <zhanjie9@hisilicon.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <linux-pci@vger.kernel.org>, <jic23@kernel.org>
Subject: [PATCH] MAINTAINERS: Update HiSilicon PCI Trace and Tune maintainer
Date: Thu, 16 Apr 2026 10:42:19 +0100
Message-ID: <20260416094219.25258-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)

Yicong left Huawei a while back so drop both of our entries and add one for
Sizhe Liu who will be looking after this code going forwards.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d1cc0e12fe1f..79efa7b94c9e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11572,8 +11572,7 @@ F:	drivers/perf/hisilicon
 F:	tools/perf/pmu-events/arch/arm64/hisilicon/
 
 HISILICON PTT DRIVER
-M:	Yicong Yang <yangyicong@hisilicon.com>
-M:	Jonathan Cameron <jonathan.cameron@huawei.com>
+M:	Sizhe Liu <liusizhe5@huawei.com>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-event_source-devices-hisi_ptt
-- 
2.51.0

