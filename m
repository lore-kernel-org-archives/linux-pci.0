Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B1140DFBC;
	Tue, 24 Mar 2026 01:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316883; cv=none; b=VJ7Rr7iui6m6h+S7KirLqmrkyM7aZPBbQrwBlp5o/+NmfWYvf88eTi94ZfvOSgUwfTPA9FIhCcb9AsnPAszgZ6mxllX80mWJeoM474svGBsxxtxWVqm93LWO73trfsZkLknuVayPaxymmiaqMFf2ohJQn4gI3mBkxZPgBa74tiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316883; c=relaxed/simple;
	bh=g7Wr3KgauRBD2RIrvkLuCFwRLL0SdbBGIuPA/D5fiwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OjP7zPxkNWxOXHpgrNN9h6uCUlxS6btykQF5BSFXT5s/nD3beHEXGyA5wm9nZM+LxG2wWh9NMjPqJclij2z7xmGHlMFagmex7LNG/ZweFASr/1b5guN/B5ZvnUe56jeFfZkeSEnVHVD7cdV90mG8wyJfZ3NEL63szX0btOyQmCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xxxElmcm; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xxxElmcm"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774316879; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P3+ErQTNYlSsCXT6mQTkj2lxwykATNza10EKPVnQTaE=;
	b=xxxElmcm/rXCPUQsaYjyZHzE5CgixbERbdYDuv0oRuk4UDljw2U1p1rchy1Ryyt8mwEKIQKPRN+tMwGQR0HUvyYjX/gPXheGbk0MjiVb/jTLBEGwNUKG935/R7Q9dqbQ+FHdhi23t9+EzhBV99sWV5JwijzamZBgGyQxXLVTJLw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R601e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0X.cmpgc_1774316874;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.cmpgc_1774316874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 09:47:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Nam Cao <namcao@linutronix.de>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Xunlei Pang <xlpang@linux.alibaba.com>,
	oliver.yang@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Update MSI-X irq domain hwsize
Date: Tue, 24 Mar 2026 09:47:52 +0800
Message-Id: <20260324014754.4973-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
  These two patches provide the ability to update hwsize during re-probe.
All comments are welcome.

Guixin Liu (2):
  genirq/msi: Introduce update hwsize helper
  PCI/MSI: Update MSI-X irq domain hwsize

 drivers/pci/msi/irqdomain.c |  5 ++++-
 include/linux/msi.h         |  3 +++
 kernel/irq/msi.c            | 22 ++++++++++++++++++++++
 3 files changed, 29 insertions(+), 1 deletion(-)

-- 
2.32.0.3.g01195cf9f

