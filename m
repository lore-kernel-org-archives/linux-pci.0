Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37BD3CA4A3
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 20:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784580240; cv=none; b=ko4udS6UbYiruYc9BxQuG976XK0ilfQXfl/JrrTQqCJYLHYwpjk+W/JXtK/p7W+IX0q3uBUKe/yGBchF/Llk1lDtXAjGg1gmqq2wUqaCyr2RUowpidoq0IUwG9x3giLjkrDrdrX62bMt0jwqG1606jV2XaZxHaVY4Pc/E0kd42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784580240; c=relaxed/simple;
	bh=kbZYlQc4YVuO+2f5SGVcqx1bBghapqgik648bJ0R8l4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ofJn/KG9Iqwsjhd9c+/vqXnXF8t1IcbVwDgBBh+Bi70YLP6djA6U+hq9Phfo71gFM6TzCVaaciaEivHKHQwRmGqnd5dxVzS1QyhVXK4HhLXhSg/2Az0BIs2MxXHi5l0xqiiG16O3rnXZVUp2Lyg1gb9yLOpCN85TqFae62S8IPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ih4rP1yD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ih4rP1yD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 634361F000E9;
	Mon, 20 Jul 2026 20:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784580238;
	bh=L/qUDsTR741JJICwMNxL2awC0J7gppQPSDZEvPwB9b4=;
	h=From:To:Cc:Subject:Date;
	b=ih4rP1yDL50kMlC0nNk+fp/tfffMgEUXWfxXnT9zTW9LZ5jU2mV+bLBY/ev2yLqWm
	 aduLDYuhrkHgTPIOa9CTg/Qo+dqvXYbm/Gy/yPq2Vn9i/jeomSZ7ZyO+Cx6aujsZFT
	 Hvt021dyU3GWDqrd7hI4tL0r2CT8EnhDJmXLRA10fie+CI55RcPdSWMgVPxt1xGa3H
	 XhICZCs23TxPWgfa/3gVkLiAfsXgXBvZ92xNbBGPhuMFBJz/LtghMEu+iGIJP9L8BP
	 s1Im8YzJJ1DVnex/2t8L2dZfrPsYC+7glQPnAUtmrXgQxYUm1Nm93UmZWFZol4a1jE
	 CafQ7EdzQhslA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/sysfs: Avoid spurious runtime PM wakeup on config space accesses
Date: Mon, 20 Jul 2026 20:43:56 +0000
Message-ID: <20260720204356.1501749-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the boundary checks in pci_read_config() and
pci_write_config() reject only offsets beyond the effective
configuration space size.

Thus, an access at an offset exactly equal to that size passes
the check, has its length clamped to zero, and then invokes
pci_config_pm_runtime_get() and pci_config_pm_runtime_put()
around transfer blocks that do nothing.

This is a problem because pci_config_pm_runtime_get() synchronously
resumes the upstream bridge through pm_runtime_get_sync(), and resumes
the device itself through pm_runtime_resume() when it is in D3cold,
only for the handler to return zero immediately afterwards.  Such a
spurious wakeup wastes power and adds needless resume latency.

The sysfs core already clamps accesses against the attribute size set
through the bin_size() callback, which reports either 256 or 4096
bytes.  As such, the affected accesses are reads at offset 64 (or 128
for CardBus devices) through files opened without CAP_SYS_ADMIN, and
reads and writes at the exact configuration space size on devices
where a quirk sets a non-standard size.

Therefore, reject accesses at the boundary offset as well, so that
they return early before any runtime PM involvement, matching the
procfs implementations in proc_bus_pci_read() and proc_bus_pci_write().

The value returned to userspace at these offsets remains zero,
so the change is not visible to userspace.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5ec0b245a69b..a4f6559c619c 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -718,7 +718,7 @@ static ssize_t pci_read_config(struct file *filp, struct kobject *kobj,
 	else if (dev->hdr_type == PCI_HEADER_TYPE_CARDBUS)
 		size = 128;
 
-	if (off > size)
+	if (off >= size)
 		return 0;
 	if (off + count > size) {
 		size -= off;
@@ -799,7 +799,7 @@ static ssize_t pci_write_config(struct file *filp, struct kobject *kobj,
 		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
 	}
 
-	if (off > dev->cfg_size)
+	if (off >= dev->cfg_size)
 		return 0;
 	if (off + count > dev->cfg_size) {
 		size = dev->cfg_size - off;
-- 
2.55.0

