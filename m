Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DCE325495;
	Wed, 22 Apr 2026 16:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776874469; cv=none; b=DJAFIAE7yQrry9+XejT/zdjjzSzCQjDMl2jP1t+S9BMPWjmn5CD0AfLKwkYKH1r7IJFtAv5wpkUmsORqRZmpCxGoIE9bVcJ4Cyvl3NBLg+IoxWG9E9Fum8wMUgIUAM6J1A42WNuOjdTriWetPhq6I1dXYZAihbSYy1xQBFcO1jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776874469; c=relaxed/simple;
	bh=vxvZ/JB/94PIgSzvTadnmUwd1Mvfl/S43tmZJ955zdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hv/G2qURu2315BSfZWrd6Lq1ElHlEmluo3dP3yPgoKsoq3wVmiZg0pcUr31s6LhlXMqQLaeOP1LzSAR2ciLGogkD6RqDTi4jBXtxYLlv4NM9QMeQpUWlCbJOstN0Q3bN9wDG+F0MLoORNCXbe/B29eDcjnpRVJt8GLddJBrJjDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rJSKsA75; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJSKsA75"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4894CC2BCB4;
	Wed, 22 Apr 2026 16:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776874469;
	bh=vxvZ/JB/94PIgSzvTadnmUwd1Mvfl/S43tmZJ955zdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rJSKsA75DyyNHGFajpmAKfspkDX7UL9PaNh58TVV/uGGfjHiltihkeVxgJymRpO8W
	 thmgSvS7XPmEmwu9/jFctCf/jblS0GTWX4hK5XfPQgyUUPUM2r8XfxoMZty10+0+Z5
	 f5izG16JVHMImHyIz+sYv9+9neuvaK6QsME4auMoVw4dJYw0iCak6Zu63VJ59iZcW0
	 gOoBOBxK5wd+cvbUMgWmcuO9t8tE5hV/bZ8JI81wjsO95J5bfec18sgTaUu0bROq83
	 QfKRfeWDy98NXkyKvNZ4JEcaiXpMqGLypTMe2PmN7JYY1M0LaqaVtsFoteLBL7cqho
	 6/f8ghz7xTq3g==
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
Subject: [PATCH v6 05/24] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Wed, 22 Apr 2026 16:13:48 +0000
Message-ID: <20260422161407.118748-6-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260422161407.118748-1-kwilczynski@kernel.org>
References: <20260422161407.118748-1-kwilczynski@kernel.org>
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
2.54.0

