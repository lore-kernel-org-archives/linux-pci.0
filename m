Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FA428820
	for <linux-pci@vger.kernel.org>; Wed, 29 Jul 2026 07:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785311952; cv=none; b=ZdeFD1QcaJ9VndHtX3rydPfcfsN/ROTjbDtVzEfamYd8gUffIBFME52BprfuqRNm8RTstzohfrGiV9z5mLI/K6gebNsTSQHtjcjD/WyW214GWK8DgLvzW6wl6STb5quBEs2tH9JXpxRCFjbkg7JVlBGVAT8O4T9aASZDa+BbcGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785311952; c=relaxed/simple;
	bh=WIh5o7xISrSFH33w+NqHaNQ3V48+Gj01Af3ZGhrnNf0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mdYrseqI2pwwJM8Y9cmK+glF7v9xlYcMQU8HzWhik7LeubaUIr/Gv7aFWCNZ8hBuVT7xPkiofsj5TwdzvxBmE9i6o11nGl6Xw7SpHzQBo8SGMxWBdoO4QVpG2euL/kRrlRSbEkR0JuZOVbH6/ngB4U4quKg82wOu7cJks9tKmcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TV4ogEz7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TV4ogEz7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2101F00A3A;
	Wed, 29 Jul 2026 07:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785311951;
	bh=FQmbpYQiwsfl9H+AZx0J03pUC7H7nO/Yl065kplxRs4=;
	h=From:To:Cc:Subject:Date;
	b=TV4ogEz7YcYs6DdErNLoEb9US4Dj12LhEWn2DkEgNDDsMSla178gc6dIQXeytXOck
	 G8pBDJ8g2fbG9qH9bbRTsQKb4Kx/nwvYUKjO7Yczg54h75K43iAldWwbbEyB5IgfXm
	 fi+AsAsEB5ltlH9AcR+S304uhIJXDIx46SOHgOG0AzZaTqBKv83rFO12GT70K+mwjR
	 +EZGXmb71cSBvPQLBVG+EW0yjW5dCdMv31GeMP9FEt1rWzb0xlA2k/nCGDUISFX4Kq
	 Qi7ZDBboRYl8QYV8xG88mJLyKr6n8qLrrQ5zIPg/IE8Zjp+07FGPSWpm4rcOtC49i6
	 fhW1n94Q02kGw==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Subject: [PATCH] PCI/proc: Avoid spurious runtime PM wakeup on config space accesses
Date: Wed, 29 Jul 2026 07:59:09 +0000
Message-ID: <20260729075909.1219906-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, proc_bus_pci_read() and proc_bus_pci_write() do not return
early for zero-length configuration space accesses at valid offsets.

Thus, such an access invokes pci_config_pm_runtime_get() and
pci_config_pm_runtime_put() around transfer blocks that do nothing.

This is a problem because pci_config_pm_runtime_get() synchronously
resumes the upstream bridge through pm_runtime_get_sync(), and resumes
the device itself through pm_runtime_resume() when it is in D3cold,
only for the handler to return zero immediately afterwards.  Such a
spurious wakeup wastes power and adds needless resume latency.

The sysfs core already returns early for in-range zero-length binary
attribute accesses before pci_read_config() or pci_write_config() is
invoked.  In contrast, the VFS forwards zero-length requests to the
procfs callbacks, where they continue into runtime PM handling.

Therefore, return early from proc_bus_pci_read() and proc_bus_pci_write()
when nbytes is zero, before any runtime PM involvement.

The value returned to userspace at these offsets remains zero,
so the change is not visible to userspace.

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/proc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 71ad289fcb8e..fcbd75d53ac5 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -46,6 +46,9 @@ static ssize_t proc_bus_pci_read(struct file *file, char __user *buf,
 	else
 		size = 64;
 
+	if (!nbytes)
+		return 0;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
@@ -122,6 +125,9 @@ static ssize_t proc_bus_pci_write(struct file *file, const char __user *buf,
 	if (ret)
 		return ret;
 
+	if (!nbytes)
+		return 0;
+
 	if (pos >= size)
 		return 0;
 	if (nbytes >= size)
-- 
2.55.0

