Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3086314A6B;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775826469; cv=none; b=unubXIwJJBQx7x9KhSErvgY+KY45LxfPHcPKx3vnTY9HSA2UCScDf6Sshad/1ux683OXR0dgYNXGTfS+xdGJSoVE4Vx9+looqmnFuzWbMLm9szAnmqYasx8h0cj7VNuvT97l0m0qT/PZah2Tt87+g+qiTclNfOf8jvn4MOi48yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775826469; c=relaxed/simple;
	bh=cBt3HgmADgxJCCYnsq9WSrqUQpWAdP7TlJDds9AdyvI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kaEzT6m8fdeRRE2bPUHU69zvwgzPjDbnpjle1Mq+WyN/Pxr53KhTLPe9tlVarXO96StXquTgOrDGw0U9iDyi0Ql7F8r5kPuVIvlJF+kjaOZtOU5DYJwRVyPUVkBMO5hN8j4u6k2pgYYY97NRD29TblHXhjFBNJ2Ou2GRjPy/AzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0BQJBzl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0BQJBzl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 980C6C2BCAF;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775826469;
	bh=cBt3HgmADgxJCCYnsq9WSrqUQpWAdP7TlJDds9AdyvI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=I0BQJBzlxrZ15ygJ0IbcI3nHGyyCGchzmtG76F4kjMSc/TqRQqLM1a+/T1gyyJZBJ
	 fhQEPYZjvVxTJW9Ixs/3fM9nDcM2/MhFs1HankST4WpoDeCGm9p3nd6jNYCIzbeBTq
	 TxsW1WvR2loL4b9e7nklortj5YgvVYeUy+tP94T3ycGkljQJlZgREefii5jOvQftq/
	 elRngDyT4JjNd5aUUjYSP+75Hrj1IbhC2oCumuwBiuTm6reqpJp3TlObSrPiFwyNxG
	 Gxq+M1E3CT6tS982mFpjc1ziHEeNWHo6DV80zfVEId8FTmDV6kC+KCmGoSvBOVVcpW
	 jZWLhlL75yvVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF1AF44855;
	Fri, 10 Apr 2026 13:07:49 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Fri, 10 Apr 2026 08:07:12 -0500
Subject: [PATCH 02/23] MAINTAINERS: Add entry for SDXI driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-sdxi-base-v1-2-1d184cb5c60a@amd.com>
References: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
In-Reply-To: <20260410-sdxi-base-v1-0-1d184cb5c60a@amd.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Wei Huang <wei.huang2@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, PradeepVineshReddy.Kodamati@amd.com, 
 John.Kariuki@amd.com, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
 Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775826467; l=957;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=tqnIKUQ/EyLmPhjhcEIOb2dPPBxNHEJNAOATM/Xpro4=;
 b=CWe5mwrd2PJa7wLdnOmVyBrciLI3IiIUPOqT+6YgXzYTQ16BNNSjKI6Cd5+CS/WT5F3XAtFMG
 i5fq/eAIO7ADCuz0sq3F5fv+igtAwI9pup/ECs94DNbPDvVVVwOfZVl
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=PK4ozhq+/z9/2Jl5rgDmvHa9raVomv79qM8p1RAFpEw=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260410 with
 auth_id=728
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

Add an entry for the SDXI driver to MAINTAINERS. Wei and I will
maintain the driver.

The SDXI specification and other materials may be found at:

  https://www.snia.org/sdxi

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b38452804a2d..5aa7b6cd93f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23831,6 +23831,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
 S:	Maintained
 F:	drivers/mmc/host/sdricoh_cs.c
 
+SDXI (Smart Data Accelerator Interface) DRIVER
+M:	Nathan Lynch <nathan.lynch@amd.com>
+M:	Wei Huang <wei.huang2@amd.com>
+L:	dmaengine@vger.kernel.org
+S:	Supported
+F:	drivers/dma/sdxi/
+
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
 S:	Maintained

-- 
2.53.0


