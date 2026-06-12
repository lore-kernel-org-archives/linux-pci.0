Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443E137416F
	for <linux-pci@vger.kernel.org>; Fri, 12 Jun 2026 18:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781288692; cv=none; b=ZyMQ/LxPKBRhXqdJAzWiUVptmiZcwq49smQTU1gJMqr5xkOVs+b5716rCuvo7+pkPhOXHB5GGdg1eW6PjISMRY2LlVVeLfB7gjugJ50IAcoH8KvDIRyQ9hfaqXSkYEF5tBl7D6EGP2tHDYBKfpPMiIsQRgSodHim24QU531sRR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781288692; c=relaxed/simple;
	bh=E/qdQJpSo/QQbTbpGmF93IYyIsgQ+q9BjyEIxHriTmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V82i38zI4hRFoG8D55S6sMUmHuHqA0wtq1S2Obd1hRSVG6bFvDMqMICLMwXz3bmMp9UJt0Q33y0UZqvMUj7GD84Puk79TMRMt7uIrvbl8TSroadw+SJBxJcPlaBonkTkKuwCiQFsKjTFz9pj3SAtjb/A6jl9v0BLCUy58WdtTHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfrqIwV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfrqIwV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37FAB1F000E9;
	Fri, 12 Jun 2026 18:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781288690;
	bh=di2ZX8fuY65VzdFceJHS+/J+z/IK+7up1axsLV96NJ4=;
	h=From:To:Cc:Subject:Date;
	b=DfrqIwV2HbEJRDDMpd31TVY8kFAhG2/mTCC/vPXqMz4D0K31fnR17xIosgaj0d+RK
	 hYSdDuPsK9eFBJYv2QkPXN+CYbTOO1F2MJKeo4C/FSEeIXdNWtMX15U6j1lOZ1qall
	 YSxq0DK0x/O84ihQt4usDK3lUAJbLJEHMPfwcbIwAwobcM2TA9Ojr1l3pF2icc99gj
	 WNq0YMmg2OpRODLMFoWnoaM7uxgnq+xFPmFqDWh97RLHO/a1l7krwJpd/vljLuMmiu
	 u7juiy4TaCGVhcbTg5DBNUdDqkFi17MAhxkF4fmdUPfr/MLx/fx8tFvmCXBMZbF0iY
	 rjLr1phStFFdA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/sysfs: Use kstrtobool() to parse the ROM attribute input
Date: Fri, 12 Jun 2026 18:24:48 +0000
Message-ID: <20260612182448.552406-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_write_rom() controls access to the ROM content through the
corresponding sysfs attribute, and treats the input as a request to
disable only when it matches the string "0\n" exactly:

  if ((off ==  0) && (*buf == '0') && (count == 2))

The count == 2 condition encodes the trailing newline that echo(1)
appends.  This was found when software in userspace wrote "0" without
a trailing newline aiming to disable access, which failed to match the
condition above and enabled access instead.  For example:

  $ echo 0 > rom     <- "0\n", count 2, access disabled
  $ echo -n 0 > rom  <- "0", count 1, access enabled
  $ echo > rom       <- "", count 1, access enabled (likely not be desirable)

Thus, parse the input with kstrtobool(), which handles common boolean
inputs such as "0", "1", "n", "y" or "off", "on", with or without a
trailing newline, so both of the above disable access, and update the
now stale comment.

As a side effect, input that does not parse as a boolean is rejected
with -EINVAL rather than enabling access.  The documented "0" and "1"
continue to work as before, and rejecting malformed input brings the
attribute in line with how sysfs attributes typically handle it.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1ddd6be25d95 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1309,18 +1309,19 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
  * @off: file offset
  * @count: number of byte in input
  *
- * writing anything except 0 enables it
+ * Writing a boolean value enables or disables the ROM display.
  */
 static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
 			     const struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	bool enable;
 
-	if ((off ==  0) && (*buf == '0') && (count == 2))
-		pdev->rom_attr_enabled = 0;
-	else
-		pdev->rom_attr_enabled = 1;
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	pdev->rom_attr_enabled = enable;
 
 	return count;
 }
-- 
2.54.0

