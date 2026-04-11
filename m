Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397F12459E5;
	Sat, 11 Apr 2026 08:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775894531; cv=none; b=SoVHunGUo+TIXAoWPyH1FUARyG7cbc6KgkMUzcCPmzpr1dvdij18mbRqn3sYPGfxBN+/COwzOZgF/WHNgg4c4Z9bSVEJKpLB/QJbjM1VE6xA25awE+2ApfjwN7ZnK+7v3f1I9P3OpDFlrLlDbNIEkPtT2GLvs6VZgVz9YQel3o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775894531; c=relaxed/simple;
	bh=u/k9TMeqaPQPWgW7ILWQ8kth1orOPivoorazdGxMwic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omfF3MYEd3Oye6R/yVgAYj0S+Qjj4IadZLL/uVOV4xFfJ7rBTINrC7j9viYlFnaahBulp8HjGHULjZTiScuCXlPaEaAE+9NJALUuriDgPmMQIuZyNGFgJn9u/lysiTToOZSMIdvTUXOI4haRSI5AdlZ31YEFO4pCkmsx9HBnMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo4iDtD7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo4iDtD7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89CBC2BCAF;
	Sat, 11 Apr 2026 08:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775894531;
	bh=u/k9TMeqaPQPWgW7ILWQ8kth1orOPivoorazdGxMwic=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qo4iDtD7qxZkSIZx9BdJoDCYqrdHWObNJT+r06FDnhUtIVeSN58tp+J4UJePTgazh
	 gl6j2mp9lnQnt6G4D/JWQqQ6wP/rnsDW4HighjI0AWdzlA7hmu/WmnpuL/OuNWT04O
	 Sl0m2hcBnuTg8iLnRBIPAuEpOt7swOZARRTu7LLrWO0Wcpl/0VGvU3MADeoAyfEv51
	 hEVZ/4qhRsRvy3AIWoR+7DzVeoiI2ugVcARF6NHRrAgnEbh/b4v2aOKGYGaWo53VEp
	 e3eoWPOaRSa2r9VJZqHoqMo52bGYgXXZZb/0ilimN8CtTZHvpN4BQQDCYxBj2Xt4xJ
	 vPciWrP8y34pA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v4 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Sat, 11 Apr 2026 08:01:29 +0000
Message-ID: <20260411080148.471335-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411080148.471335-1-kwilczynski@kernel.org>
References: <20260411080148.471335-1-kwilczynski@kernel.org>
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

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 73a9ae9d289b..4f95b336cc34 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1619,6 +1619,9 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 	int ret;
 	u16 cmd;
 
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
-- 
2.53.0

