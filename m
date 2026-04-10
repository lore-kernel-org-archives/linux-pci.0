Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5B230BF5C;
	Fri, 10 Apr 2026 05:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800259; cv=none; b=XeZZ4uEKjnhngw5FDnwzqne9ubyv70UUC+9vbuDWxoVDDbiKOs/konKu3Cb/9gD3eAH3zeZ3+HxtUHLYE4Yuk+jSMs3yaKqPnAGWHqUSLPomqM4+jAQ8fla7gA74KHswaFqsLcjP4aIDx5e1AXUpVxufsfvJModdUrTTDwXHxKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800259; c=relaxed/simple;
	bh=SoGJBLsBAedU3UkQnFKz0LBvzv23roF9wHFr+0WZ14I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehPQpaoDe7l0xuOG9AkQwoLApJIpbAyAvtwCg9R4Faxum2OSkv969fn142+4czwnRiFh2+gc30anilMu9+weaWU9wp1UlB460Uee4fxEAvRNPqu8X6aedHGAdtllYYlaVV78SKriiQ5RQvX/bZjsBGzdsENEspaPRAfbdBkIsSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFgo48Kh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFgo48Kh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB7FC2BC9E;
	Fri, 10 Apr 2026 05:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775800259;
	bh=SoGJBLsBAedU3UkQnFKz0LBvzv23roF9wHFr+0WZ14I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFgo48KhP2UwDP+v7nBAAQpFvOcYKzZLYUpNrDbkMijA1CB/EOL/wf0hnZlc+76nA
	 QsgNEHBftINlrHeVEVCM5cfdhpaa2UA20qtkNr3ImV/HC/36UrrDrZu1vqo3Q8KvHH
	 8igsFPxntEMEia0YELY/E2uyNxICaOnxIC5jIi1ROZv8KDzNFgIncJy6+XVY/KlGVt
	 hBUfxONpEMROdiKXuWSdcPvqOrOEmz5Tlvi5RZ7lP8ZW+WbtPwfj6HZ7o+ZSkR2k5I
	 lKraDdD1mdbrwxowYEuiId6ylp90u/2drCdw7XYpIg3MuyfilzxfGOPlCH6FY0sPJl
	 GaMDcCMe1ufsA==
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
Subject: [PATCH 04/20] PCI/sysfs: Add CAP_SYS_ADMIN check to __resource_resize_store()
Date: Fri, 10 Apr 2026 05:50:24 +0000
Message-ID: <20260410055040.39233-5-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410055040.39233-1-kwilczynski@kernel.org>
References: <20260410055040.39233-1-kwilczynski@kernel.org>
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

Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 drivers/pci/pci-sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ac4e7c516e78..6b8c8e62f68a 100644
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

