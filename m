Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29C3043DB;
	Tue, 14 Apr 2026 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776133352; cv=none; b=IBPHL9MoeHqA/uZViHE+4NbA1GnHf+M9rWfnr4xzvk5m753qLLM2D51AFdzF+76Udgcf7F0k0swGtbLFLyNi76Y1xBNpLdut1fzuj/ydfwEp5aFMUbd0ESqblxgKlI0OiORlKA1tT+J9ct/TYugWVTggeuhZqgkw3niUWOBnJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776133352; c=relaxed/simple;
	bh=v4hRLWdKZl1td+XsFhOO+B7/Z0GyFge0IIAVpEt8kRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AO8OtqUx4W98Z7NIdEpevF0Iscvm/ecHyfVKp8CqPp+0HGL8+VNQtfTqS3QgRDU+jpmH/eXTCLguMp1br/pGTZQ4KVEs4m1gEUKZACmvg/k+02OtpDvReTT8pkwjWeJBHFuhKXpOYV7E35A97PC+GpY0UqAgvZqwmpKQASMJEQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=fy8BxZwC; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="fy8BxZwC"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=y8QgHZ6mFh3FP1pNCkiLHez+31Z3pNxghWY6u95D59Y=;
	b=fy8BxZwCRbi6O3LyWV/Ae86h3hwBXm77qIbhFKNocxib34SJrxKd5+3sX7xWoJzkVEodsw/Pj
	KSwQiTUCIO1MOcAS6AGxhgwYnT4sC/uPVM/MHbHWicEEElNbxiVyfDnatyq5XDz9yKaQsS/7tSR
	YLBVbXDJOmWYB0a2grSMYdQ=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fvnvB18WVzKm5G;
	Tue, 14 Apr 2026 10:16:06 +0800 (CST)
Received: from kwepemr500012.china.huawei.com (unknown [7.202.195.23])
	by mail.maildlp.com (Postfix) with ESMTPS id 8CF8A40563;
	Tue, 14 Apr 2026 10:22:25 +0800 (CST)
Received: from localhost.localdomain (10.50.85.180) by
 kwepemr500012.china.huawei.com (7.202.195.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 14 Apr 2026 10:22:25 +0800
From: Ziming Du <duziming2@huawei.com>
To: <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liuyongqiang13@huawei.com>, <duziming2@huawei.com>
Subject: [PATCH 0/4] PCI: Fix procfs PCI config access issues
Date: Tue, 14 Apr 2026 10:45:40 +0800
Message-ID: <20260414024544.2975605-1-duziming2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr500012.china.huawei.com (7.202.195.23)

Hi,

As suggested by Bjorn, this series aligns the implementation of procfs with
the sysfs counterpart and fixes procfs PCI configuration access issues.

The first two patches refactor proc_bus_pci_{write,read}() to align
with pci_write_config() and pci_read_config() respectively:
  - Rename variables (pos->off, cnt->count/size) for consistency
  - Remove rebundant bounds check

The last two patches fix potential overflow issues:
  - Prevent overflow when offset exceeds reasonable range
  - Fix implicit 64-bit to 32-bit truncation in read path

Link: https://lore.kernel.org/all/20260303193253.GA3817951@bhelgaas/

Ziming Du (4):
  PCI: Align proc_bus_pci_write() with pci_write_config()
  PCI: Align proc_bus_pci_read() with pci_read_config()
  PCI: Prevent overflow in proc_bus_pci_write()
  PCI: Prevent overflow in proc_bus_pci_read()

 drivers/pci/proc.c | 115 ++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 58 deletions(-)

-- 
2.43.0

