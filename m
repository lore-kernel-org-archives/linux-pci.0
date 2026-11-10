Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288858;
	b=NLabq8rd7PTmvASrv/pfw7DX7qSfZvQSeFxI2Ggv6Yi8JCsH2mcSKw+NmBZC7l/QIFfm
	 /nzkJkm0tDE/xGS7zNudWpvTMnky66AlJPgHQMujDfQgPt6oX8zC3HYLhZkB5giuhPQmz
	 XJgdWzyUuodow1Y1b9YunCeJr9d1X2og8q5dSM9HfCvkyN3HbQclPOVKZsbcWSRmyAXmL
	 BC8DM+/dza1CQrlBI9G1t6yGn6YRtGyVfdjWDklRuXtu1uw+c5Oc/q6tecXw76EuCuGYA
	 isCG68C4LhoqFCKO6lvtcF5QSk/Fdqrumx3GOZRuHCvU3O+dJbnDsczSIoQO4dz7yBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288858;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 X-Originating-IP:X-ClientProxiedBy:DKIM-Signature;
	bh=ZU+NpL8Z5ACfVAZOly86QMEpBSZGGgvzMjwetME/EfQ=;
	b=PScLKe7N62MHO7JT0ARrR8aFP+LH3tEerD+67DEWRVqpEZ/oAmdy9hb7cyYZqSjJRPGP
	 SUdE8gZ2V19uoLb0I8P7beBxPSOEjYU2Tg6lTqVqUxr796SDuKYEfPYoAxAKzuFR1eUhk
	 dyEgm36QOCLh1VHqAuYLArBb6tjAxDQU3qYcOKwpUOzqB6aKUsugj/QIqXabNQl1Sbe1f
	 luQ3E19R4PNgeDh1DNzT930UtO6vSMnRpXOusUIJ1rjAKa++eegCcD9yH7ACWUhvA4KvO
	 7jgWVuCFEESa97AfA17eB7wzW4JQ9EWD3B5vVW3lqdgKtvfpRF2pI3E0WK0e61eNndQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=h9AuSxU6;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 9D699606A337;
	Tue, 10 Nov 2026 05:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D699606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=h9AuSxU6
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Niklas Schnelle
	<schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Frank Li
	<Frank.Li@nxp.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: Save the Root Port state before a platform-specific reset
Date: Tue, 10 Nov 2026 13:33:48 +0800
Message-ID: <20261110053348.2419-2-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261110053348.2419-1-lirongqing@baidu.com>
References: <20261110053348.2419-1-lirongqing@baidu.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc6.internal.baidu.com (172.31.3.16) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1794288843;
	bh=ZU+NpL8Z5ACfVAZOly86QMEpBSZGGgvzMjwetME/EfQ=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=h9AuSxU6voB0W/QChGKQqVjEKe3j1RZfSmrEYYVA1bgg7WzbFqQdKPdujwavY+0s+
	 NddGtgjhOQ0lrwsJ7CgKTN3qAyT2Jud9Sqea1Hvb2LiX02zj6dp7N3AdFu1MUFdLbZ
	 IAtVq4uF0gPfyl90BU5B3A/R2uuxsKcAcG6d+appLKj7cjzZcX9gIbee1s+NoC1xhA
	 RKNit4lwXOy52mlFxBc0m7xRkcc1wzJukRv6sjPsRyIyZR3yuSlJ38kBuAIpQCiDtq
	 ux8GKXd+Qb5ZpOXOXZ+T1GquTO0fiwzcmO+6YVjb6nPuo8WFouHoAvfzTWQxjTXzpy
	 VpyL4N7Lldusg==

From: Li RongQing <lirongqing@baidu.com>

pcibios_reset_secondary_bus() restores the Root Port after
host->reset_root_port() without ever saving it. pci_bus_reset() only locks
the devices below the bridge, so the bridge itself is not in the saved set
either. Save the Root Port before the platform reset.

Fixes: 3fc686d550f6 ("PCI/ERR: Add support for resetting the Root Ports in a platform-specific way")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index ddb86dd..eaccd89 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4929,6 +4929,7 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
 	int ret;
 
 	if (pci_is_root_bus(dev->bus) && host->reset_root_port) {
+		pci_save_state(dev);
 		ret = host->reset_root_port(host, dev);
 		if (ret)
 			pci_err(dev, "Failed to reset Root Port: %d\n", ret);
-- 
2.9.4

