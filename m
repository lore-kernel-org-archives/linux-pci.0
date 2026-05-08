Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586D51EE01A;
	Fri,  8 May 2026 04:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778214967; cv=none; b=flj26AU58BSP73d8s+FIs36mAikCbbMajOZHUCi8f4R7xguxysGoqdmxD8IwxMGxp7bA7J518Zbt4xwVzSKryMBTFlRqbe0dsv+5C7992eSqJ4LCQr3eCnXKSPUEOVqd3Qm359l6297MaZggpGqdM6BBGWKYiJeqi/7yLmPvPOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778214967; c=relaxed/simple;
	bh=9KXLrBNGT0ToNu4fHZqX/w3XLpky3ur23Tmkqe8TgNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2UfSnpn59iJpr9oIeR+4U4viVMoKsCWwukRuNHpLzNRuj/l9iLNdQNlTR37iP5KS3tz0G1Dpedotjlj4Z1gqi69CkQJUnNnyKzcMh7R7DSABSOQWmuaPQtE2bnjObWPYdn6oJqn5GXfA5R9qf32RnKg4WDg6YTVYD9LqspwemA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c6YrOJEL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c6YrOJEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B03F2C2BCB4;
	Fri,  8 May 2026 04:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778214967;
	bh=9KXLrBNGT0ToNu4fHZqX/w3XLpky3ur23Tmkqe8TgNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c6YrOJELe42YPhzYmdxA2+pDGLb/lIIe88nH1uFnMhkVo6O/4Hmt77NyiEHQiaOz/
	 3lW3I9GpoGve5tNp1zxXkM7MW2Kuxd1dHEpoDZ41L0vuQk1iqISSLe3A8us/fJtd7d
	 o0Bx1t5t02a6uc6MTVhdP7hlvzstCojKjCNiMYJD2QuET9VC2eHdq7NswApXbkusrk
	 Kr1zOzU+p7Y+pLwWxcrDqxahePyzuZJ59CaQPJXVyW3sDqGFLaCRDaEPUB3/qJ1svY
	 rGbmmWFcH7osNf2BlaJa+N0ZAj3Rh7vG5kKKDreZfWwhWdE8mx5dlKTDGf2ScSJIN+
	 Ur8pxP9rFDk4A==
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
Subject: [PATCH v7 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri,  8 May 2026 04:35:24 +0000
Message-ID: <20260508043543.217179-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508043543.217179-1-kwilczynski@kernel.org>
References: <20260508043543.217179-1-kwilczynski@kernel.org>
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

