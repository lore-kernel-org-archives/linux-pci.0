Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5244E040;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526997; cv=none; b=SXeuga9LjVsM6zlRKivgZ4Ku+m/C4PDTXYM6ZWGzFIAetFz3zhmZcggIcuLvn47fLiDBkCljy71jTSf60XsbQ+T6gBLYxNWxRvST6tzC2Dd60h5+RIUh+1bAKbuPpHFp9kfRs8H/4IZms/azi18q/St88PnlF58DfPDtyyHRrvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526997; c=relaxed/simple;
	bh=qPK6UugunlFMoeP+8P0TP368mHmANW2O2gkSeilG6ro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iHYCaFuonEIYH3Auk/IBL10Mwu+UYeNVAdtAkMsiWE7/SHudxYsom1+IT6SvkEkJLDbOkXXQEpg20ZDVsS6MVt3gOXJy1hJ0wRy4l8pQT/9i7+S2WP932jwORC1+rJTvKzeP2Im4TLW/b+uDdvlGmp+kkWbuWj6RQrhtIV4xUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfDQf+F9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfDQf+F9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 491BAC2BCF6;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778526997;
	bh=qPK6UugunlFMoeP+8P0TP368mHmANW2O2gkSeilG6ro=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=GfDQf+F9j5Jgu7MvQ8LLLGsREGlI3KFyJR/SrUuMFZJpZ6dKUxclR59bcspMPSWnV
	 1roZl2/STNjLF4xrQ36/LPV4jBk0sauzRGVWPEKYmw85tia8fin9xTS14Zs7NotX17
	 7nDZs5c/pkN5v2rDM5KQdDnSk6VgmGOva1n4WV4sX8HlfnP3bJMAWHC3ELV3o/yeB3
	 DdV0R0pRXHdMXNEgIl/ldPYbkWmHB4FShHhXJxUG3FtK/uLiA5/gmqKUsHlN02KHyv
	 F+zSkmPeyZiyigqeHqOfB/KvqEUUG/GFppblDZ2gHTa+CmjEkpRKSh66i4p+334P7j
	 f55RFk9hfjttA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C0C8CD484D;
	Mon, 11 May 2026 19:16:37 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Mon, 11 May 2026 14:16:14 -0500
Subject: [PATCH v2 02/23] MAINTAINERS: Add entry for SDXI driver
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sdxi-base-v2-2-889cfed17e3f@amd.com>
References: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
In-Reply-To: <20260511-sdxi-base-v2-0-889cfed17e3f@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Wei Huang <wei.huang2@amd.com>, 
 Wei Xu <weixugc@google.com>, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778526994; l=957;
 i=nathan.lynch@amd.com; s=20260410; h=from:subject:message-id;
 bh=J7ULZm7Owlmcwbz490UgcmZhmtYpI8wOv94ro2VxLk4=;
 b=LAQoINyNUEZxRg5ZG8ZvS2JMKjtR6eRhLp8cZCKgFFc4pd0dcAvCdAIRP9VG9PSGEzBtYanm+
 jB88aSHAMURDd+Qshe6y6Q3hdFJPegxwRe5U1j9b5wFoCoFZb5FR0gS
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
index 2fb1c75afd16..5c6d175a3f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24036,6 +24036,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
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
2.54.0


