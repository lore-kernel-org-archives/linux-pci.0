Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410341DED4
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311661; cv=none; b=dqAyIrE5XaBGDZWcSNNuc4tiCRX0gaIYQexq0BkMGgRJ1Xh5uaXVpR23SivHwqwEW8VGzvG1Cuy4E/KLvX2CRDNVk8klj2TNigLNjhA8RzqQk3FCHGItod7HALUyK3TGG7Ds+c321yqLj3Cbigu7vEnxHUJY989eZw2P7qNwcPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311661; c=relaxed/simple;
	bh=VCVA2PidKO0ADO09XqBQEx9Ld/BHny/owjsuV9okZu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rzxxANNGnnbLKYMSFyMMmvwGt3YsnbDg1Xt06Oy96n9X1imD6sckx1CxUrlt4zSWU8GwbHYHaFNnPnRR7wdFSueVDCpPB+tInC9YyaJTIncKgGO115JrhVZROkItkaCLHKTftxwtN5726ngexrsQxQgvYfFRlPNc/ADcmY+R+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ymyo2Kns; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ymyo2Kns"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EAB1F000E9;
	Wed, 29 Jul 2026 07:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785311656;
	bh=GxZ7QVVH5311f113ShfekrCsgA2DAihos3qOEtFj4RE=;
	h=From:To:Cc:Subject:Date;
	b=Ymyo2Kns3N4AdGmjypWe7ey9gP7WsaBcqmm37V2wVrrsJEGwMl+7uJUUQP6sQYqjm
	 c0scQaQouUQos+g8DibUOK93wtPRU2lFbqZJenQAg45c1leGfloRQRPMidX5/fE+ZK
	 JZ1XzIRQ88quy5H2os+e+F7X1Mqv877rpCTRH3aaUH8N9VJ2NhApc8yTis3SstOoIA
	 K5Zo/ZHFztlCSPYbUcCVQJ+EzLsNs4qMNq9GLtbntvPQosDOe//8XWG5bJufRnrZIr
	 LwwJQ1AfS9yse5pzPe8rxpVyZZyfgXQRM7v4UGJu89y0kqiaMwVQp+xbD7wvkdTuoH
	 rfp6V2jIFh77Q==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/proc: Warn on writes to kernel-exclusive config space regions
Date: Wed, 29 Jul 2026 07:54:13 +0000
Message-ID: <20260729075413.1215821-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, a driver can claim a region of a device's config space as
exclusive using pci_request_config_region_exclusive(), after which a
write to that region originating from user space is expected to emit a
warning and taint the kernel.  The check is advisory only, as the write
itself is still allowed to proceed.

Since commit 278294798ac9 ("PCI: Allow drivers to request exclusive
config regions"), the sysfs config space attribute performs this check
in pci_write_config(), but the procfs interface was never updated.  A
write performed through /proc/bus/pci/BB/DD.F therefore bypasses the
detection entirely, even though both interfaces offer the same level
of access.

Thus, add the same resource_is_exclusive() check to proc_bus_pci_write().

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/proc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 71ad289fcb8e..12200979d3a8 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -14,6 +14,8 @@
 #include <linux/capability.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/panic.h>
+#include <linux/sched.h>
 #include <asm/byteorder.h>
 #include "pci.h"
 
@@ -122,6 +124,12 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
+	if (resource_is_exclusive(&dev->driver_exclusive_resource, pos, nbytes)) {
+		pci_warn_once(dev, "%s: Unexpected write to kernel-exclusive config offset %x",
+			      current->comm, pos);
+		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
+	}
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
-- 
2.55.0

