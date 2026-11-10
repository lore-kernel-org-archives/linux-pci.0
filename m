Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=180.76.5.236
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794288861;
	b=AKCTXcyNkj7cxSWwcrXawHAXZYe+S64AgpdYsY4oCoqr2VLo/dx0tCzgvUi7riq/0Dnr
	 SYipUGccVW8k3cZAFa4oYp1ifS1p8bCMMnYM1BjI5zFzN+REulfwdA2LiH8g4mE8dJBex
	 PhMSe+42y8yq9FdBmrojrq1ZqcPwpYuNKS72TdYIP0nPW1ASgpojv7XoII9i/Dbaiap7l
	 J4EFVhAK/8UNODHX1rWeBw8Wx0gb3JLgwDvaAXcqrjB8o7417ou0UNDod7gdTA4OpO0+T
	 iHZMa9NEp9skkGEpiB9yjk1/+OiLWgMfKqHwAlw5RR0IrEZaYOZ3ti92Nk8f6FUyAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794288861;
	h=DMARC-Filter:X-MD-Sfrom:X-MD-SrcIP:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:DKIM-Signature;
	bh=jm0xTK3bL4vKhMSB7eI2wu0qqQoBZSMsEg35f0cjP0s=;
	b=swgKO2bB+V48oiOqTLN8phH0qaowA0tqGUlqpBCJeiSuYefT7oRXAJmxct6h4NUy7AUD
	 ujMCBnWgW1SEln0aHHGgte6iWgcqZWYcmxpGE6LOTmjydcSFrgV2zFb88omWLvufvFQUK
	 n3v7Jxk04j7/j7gfm/DmVJrVbKRSQFf48CzPLI5wlV+Jh889GpiVKOEe0QQdgWZhhbug4
	 LU8bdNak3+iziWXwxGSUA6bRccvb5E7yblkGZoxpHHdSvHrtPyXHmt6PbIXwxKiU0lPun
	 Uc0AKPTVYVlq+lnNeqRvRMpBpbFVWjpIDF5bj0EfGye73bA8zURNsQHhB3q4vbiBtuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=baidu.com;
	spf=pass smtp.mailfrom=baidu.com;
	dkim=pass header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=bLhwTbLf;
	arc=none smtp.remote-ip=180.76.5.236
Received: from outbound.baidu.com (outbound.baidu.com [180.76.5.236])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 261A460A2601;
	Tue, 10 Nov 2026 05:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 261A460A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baidu.com header.i=@baidu.com header.a=rsa-sha256 header.s=selector1 header.b=bLhwTbLf
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] PCI: Clear the bridge's subordinate pointer when child bus registration fails
Date: Tue, 10 Nov 2026 13:34:10 +0800
Message-ID: <20261110053410.2469-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
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
	s=selector1; t=1794288859;
	bh=jm0xTK3bL4vKhMSB7eI2wu0qqQoBZSMsEg35f0cjP0s=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=bLhwTbLfRzaPJuesz8xJIPq2mPfixfs6arBFjEei6DWzYEeTNf3QY//5LxVYZCXUC
	 3rkERDZm0IImVFML+HJEYv0shUzUMMPsig7kv3EO89EJVWURqEc59ODuhAPspjDgNQ
	 S1Pn3F4Tvrg6zDBApBEeZBJFDac/YERl24/XiVI07HxprmnMuN/k7H18JBQiHJ+Ng9
	 jGsFiEusHm9fxozlht1nLsp5Gpz37At/WPyPnZEW2p0LCR6aC9YpT9cujSg2XOxkaY
	 oTJL//w+eGsLo9rk2ChsQVY2XVUAbrQnuoTnM9E9zIyOZYWZr+vez0Ui+nxKOzmlJP
	 Q+MrFhW/OegDQ==

From: Li RongQing <lirongqing@baidu.com>

pci_alloc_child_bus() stores the new bus in bridge->subordinate before
device_register(&child->dev). If registration fails,
put_device(&child->dev) runs release_pcibus_dev() and frees the bus, but
bridge->subordinate still points at it.

The caller returns without scanning the new bus, yet the rest of the rescan
or removal path still follows dev->subordinate:
pci_assign_unassigned_bridge_resources() and pci_stop_bus_device() walk
bus->devices of the freed bus.

Clear the pointer before dropping the reference.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/pci/probe.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 86dbfd4..e07e189 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1269,6 +1269,8 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
 	if (WARN_ON(ret < 0)) {
+		if (bridge)
+			bridge->subordinate = NULL;
 		put_device(&child->dev);
 		return NULL;
 	}
-- 
2.9.4

