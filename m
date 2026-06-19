Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D6A18FDBD;
	Fri, 19 Jun 2026 08:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859144; cv=none; b=NKpvWoOhO1FTrqlEsGM+VnYN7t0msdjW4i2V9y44GcpP2mj+JdbHzFr4y2C0lvOg0f6Gn2BS8pkyT+20FxnamvaOIeoRiDj8Xc1VgDokpZO4Tz3XyoF6zd7Mq7gXXT1r+m8v2j0+fjUDmNesiz4+kMkA/PS+S7q4sWbXV90GFUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859144; c=relaxed/simple;
	bh=9KXLrBNGT0ToNu4fHZqX/w3XLpky3ur23Tmkqe8TgNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a7f4P8hge1VQ1zVUW6x5N4Kx5w9Ti5yPrb4DrzTkGnp7/lwG+5I0KH935luB1WYL5Ji6q4mYepNLFbMZk2p9KWdg7520UST9FgseFBZV053yYvqmltq88gmzymdlrb6KNaiDlni8dGIoMNndKGd+2KxKXmiRvJq7w/136K1aOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvxGXdYR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvxGXdYR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9AA1F00A3E;
	Fri, 19 Jun 2026 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781859143;
	bh=5ptdizEpjuYqeg2f+U9wBoigKTE1I9tlh/xOEI1cGXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DvxGXdYRZjBwhtVt/XLBkqSTeCA0na6LMV/FEykjBxTTXIpdpGWpDMbt2Qr1JrFaI
	 9zcMQqINYRYbFYbOmCk6uxlrR59Z8oUF0zMZSjA0744Nf+0q7c1kRxUBd0+JfO5cD8
	 NrVGqhiifnFMswHAo/XCr9a7q3fquugELxBQPQ+G7Qkq1qOdKcWQjegvhtw3G3G8HT
	 zbzGY/4+qv7mltC2Fkjnw8lxtrPI5WDMg42QqMasw8hXkQPko5gmTa6n5PssupNK2I
	 NYl3sFq0q0Wvm+drBSR/10OAwxFsSLJOyB2aHRQICMf58Su3BVUDBklbC9A5qz48x7
	 vp6ayPc+xT4Rg==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Alex Williamson <alex@shazbot.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Dexuan Cui <decui@microsoft.com>,
	=?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
	Lukas Wunner <lukas@wunner.de>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Saurabh Singh Sengar <ssengar@microsoft.com>,
	Shuan He <heshuan@bytedance.com>,
	Srivatsa Bhat <srivatsabhat@microsoft.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v8 05/25] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri, 19 Jun 2026 08:51:40 +0000
Message-ID: <20260619085200.3729431-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619085200.3729431-1-kwilczynski@kernel.org>
References: <20260619085200.3729431-1-kwilczynski@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, the __resource_resize_store() allows writing to the
resourceN_resize sysfs attribute to change a BAR's size without
checking for capabilities, currently relying only on the file
access check.

Resizing a BAR modifies PCI device configuration and can disrupt
active drivers.  After the upcoming conversion to static attributes,
it will also trigger resource file updates via sysfs_update_groups().

Thus, add a CAP_SYS_ADMIN check to prevent unprivileged users from
performing BAR resize operations.

Tested-by: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 2280b7edb41f..dac780597727 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1596,6 +1596,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	int ret;
 	u16 cmd;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
-- 
2.54.0

