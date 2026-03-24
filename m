Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AE237BE8D;
	Tue, 24 Mar 2026 01:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774316844; cv=none; b=HAsPzixKaaRN2cAAOippQ8Z0b8jk/3JwJ9E0k3PtXzr43Sf75zhIzCZ8D1eSYakifyxXHiRuda2YEd/8/3g/JcagGq8pZ4WOOcO9fAJ5NT3/1iOPAQ405t7CIQTkDOMToOOK+ZAAMoV5XrMT1anSF2/Db5+oNYxLU7TUorpoVsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774316844; c=relaxed/simple;
	bh=g7Wr3KgauRBD2RIrvkLuCFwRLL0SdbBGIuPA/D5fiwM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QazpjfgL9cL7jv8EnBvdH4xUw6V6OmW9DL+EEcG3/hsaTRb5Szt85WNQ6Y1EhkaL1Y2CeKn7beWqBJsRmMgjVU0ov+bgGLOFd+91v2d6peVzUs+RkXO3zHQr0tJM/EGEm8+LXYVozmIHvOmFacRmZPH3Ts8Y+ni/vPC7aj+ywyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=t2soDX54; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="t2soDX54"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1774316837; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=P3+ErQTNYlSsCXT6mQTkj2lxwykATNza10EKPVnQTaE=;
	b=t2soDX542TM/zT0yYTSyWe0HsgKmjQilSn3UaAA2ZmPsZFJdzqPQ8RKQwfWQxdj3eOfE2egBkm4ZH+TOyPJS/E08F/oEbdKwB0cakhJNrQbr1/juw/plrGDF97ICCR8bfdYHtI0Dllm8YRvu+GLEIv4ghVtDn2a2/mKYPbCH69M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X.cpS1O_1774316827;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X.cpS1O_1774316827 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Mar 2026 09:47:16 +0800
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
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Update MSI-X irq domain hwsize
Date: Tue, 24 Mar 2026 09:47:05 +0800
Message-Id: <20260324014707.4236-1-kanie@linux.alibaba.com>
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

