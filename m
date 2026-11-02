Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601676;
	b=eFPouQ2R/9Yy4/CJ9yNxGyqwtyeY+awHjs9PpXbhUu468bDkNxBRw7Mo5zvyaZniQldg
	 gQq0SSwFA4WSWp8hVrubnasvpUZVaVggjDc03eMGu2HF6hGseVoCrZf9UMQmIp4xBf9u7
	 4NC55aok1zOOZBlNxvca3N6o0D5oqzje8U52FOjEJUbBXsSsD4w7iQfwKjwHN8Fv+JUTF
	 sMHOv6ygSoBFQJ8ajimewFIfLLShYk+S/Yr0yQm4V0cZN+/s8G+PlaEWjO2mypyBA95Be
	 o+Y4ryGRRHCCj0QO+pJP1yUDlVJ6uGHNsj2YiKasM7K2BQ6s+kXGGz6cu92DaB3ZLfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601676;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=DOpqM1C0HSsP+/x8lk0qRSuGC14OfVRy0/BKZIpySdg=;
	b=E17HQSgqkAauIy5isneE+u2hjkVSb5bdzYuw9GGc/df98fadw3HYCfrZ7L9mQX/ZIPWy
	 ytHMIlYcYVwcIhACHrQJlf6GETTY1q8yHRmZFvIU4+cBLPisrqGQRvYCUFMkhksrIYxDE
	 Fbg8p1mz1yIcKihkc1VFT0ajIrEdFaJqw8JQLsVokyEK+Sb/FCmgUPrwoqW79EPdW1Ete
	 ZXkaN6s1XxT4AUHERo8AFG1RYJDfi1v8bPnbjgSizzIhOvy7A+MCAsB4/gm1v6T5OMqqt
	 WyfjD/RwP/ysXt+c9Cf0ebxOaOkTfLhFehp7EZF4zD44NOr/RidjDaPpum0m3fliB/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ge3QtI8P;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD86B606A324;
	Mon,  2 Nov 2026 06:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD86B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ge3QtI8P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=DO
	pqM1C0HSsP+/x8lk0qRSuGC14OfVRy0/BKZIpySdg=; b=ge3QtI8Prki249+VQh
	Iirw2wybvR/0kZmEmHYtqQru9BAk/SiWRZPF9NRCYo8RoJIpKTeQD1cj4s8sK06B
	C/QKYKcQmMst0JjUwd8uxhdV9P6qZa174LtmGEC7Vo1rY54/c5CESCxdN9eEGIgE
	AHHU94OB8olj4bKjJdoX3ykns=
Received: from Precision-7960.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDnL4hvMOhqVx58DA--.12846S2;
	Mon, 02 Nov 2026 14:40:48 +0800 (CST)
From: Hans Zhang <18255117159@163.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hans Zhang <18255117159@163.com>,
	syzbot+ea7278bdcb20a491495b@syzkaller.appspotmail.com
Subject: [PATCH] PCI: Fix pci_alloc_child_bus() error path
Date: Mon,  2 Nov 2026 14:40:35 +0800
Message-ID: <20261102064035.3833574-1-18255117159@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgDnL4hvMOhqVx58DA--.12846S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF1xAw4DAF45uF1xGr43GFg_yoW8Kry7pF
	WfG3y3trW0qw12kw4ayr1UZFykCFsFyFWF9r4rJw1Sya9F9ry7trW0yFy5ur4DCrs7tF45
	tF45A3WjgF48JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRJPExUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BH8oGroMHE0YQAA33

If device_register() fails in pci_alloc_child_bus(), put_device()
frees the child bus, but bridge->subordinate and the bridge resource
names still point into the freed child.  Subsequent rescans can then
dereference dangling pointers.

Also, WARN_ON(ret < 0) reports device_register() failures as a kernel
bug even when they are caused by normal runtime resource exhaustion,
such as fault-injected -ENOMEM.

Defer assigning bridge->subordinate and the bridge resource names until
after device_register() succeeds, and handle the error without WARN_ON().

Reported-by: syzbot+ea7278bdcb20a491495b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ea7278bdcb20a491495b
Fixes: 4f535093cf8f6 ("PCI: Put pci_dev in device tree as early as possible")
Assisted-by: Codex:deepseek-v4-flash
Signed-off-by: Hans Zhang <18255117159@163.com>
---
 drivers/pci/probe.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 9a178e0e5f7f..0f317d25a32b 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1259,21 +1259,29 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 		pci_info(child, "extended config space not accessible\n");
 	}
 
-	/* Set up default resource pointers and names */
-	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
+	/*
+	 * Set up default resource pointers now, but defer pointing the bridge
+	 * resources at child->name until device_register() succeeds.  On
+	 * failure put_device() frees child, so any references to child would
+	 * otherwise dangle.
+	 */
+	for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
 		child->resource[i] = &bridge->resource[PCI_BRIDGE_RESOURCES+i];
-		child->resource[i]->name = child->name;
-	}
-	bridge->subordinate = child;
 
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	if (WARN_ON(ret < 0)) {
+	if (ret < 0) {
 		put_device(&child->dev);
 		return NULL;
 	}
 
+	if (bridge) {
+		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
+			child->resource[i]->name = child->name;
+		bridge->subordinate = child;
+	}
+
 	pcibios_add_bus(child);
 
 	if (child->ops->add_bus) {

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0

