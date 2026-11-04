Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793760604;
	b=2NkLnJEIzeNNA9Vpe83ja6O0PZoHiQkdOeATqn1R0xwIu07OEhgQ9komoe3Rn0T+UXMb
	 mwjYQf38WAsHsPC246pM+NXBYrNP7EhpAcLGA11FytlA2sI6Ie7VmxxzrpqdKMccOg0PV
	 3mxhOGpj0Zh4XQOetIhOksDurELODmMIS3Hd3M6Ce1A+rfpFOGUaG2jlHfoMQGo/oP1Vb
	 vkJcI9/96li+ACZ75cM2T//DlN3W3AbZlrtbZkf9gQX9Ih82CfIxBc1wGJvyZ8xW2WOkC
	 /1VED9JTMmmqZb0Ee/Xk3m0kCaNuNJntNEoyl2skLZiwvukzdbeQ1N1EwXeDYqeBCzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760604;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=abDkj90NJiD8l8l0zAUvwFxe1kTltejS2SG5NFKFw0M=;
	b=D5bqOGVpnsyNTAjpVcW59A5Va/KiAaNSmduu9r7J3e/Akc1IxgHfmLegya6EOXr2ytEV
	 1cYvnJkgLfVa92qjwa+AhqouUFLyRo1r+nhHuKOnRoYq99rUnkSwdM26wwtbgHUWGikxu
	 DHJpJyLq15wtfetBdvHDg1WA58YT+rtO4qqoZ3aoKb7gf/Fserg47/l5LEYHwnUro0OsU
	 DYgOz9BYKl6JnR04RZpDNIyIHaG6AsnH19PX0ltRMDBLL+m1IJZJMs80WBJ4EpVbcZfU8
	 4Cj6k21Sb4BGsljQjCwyDZKFBguPgVbDN+yMNTJoNVA+eud1H9FXohA+UYlPEAIP4yw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScdDhyL6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B0606A326;
	Wed,  4 Nov 2026 02:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ScdDhyL6
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793760603;
	b=tkr5BtCL5hyTQYIjvee3GBMeh0bzADo+A5jr1kof2zX3+mx8nsTEOTvbEsMQiWPDSzNz
	 FLvOgD68Tg6ALuyi1qkRKxLCioGkS6F82RXZ7XJ/f2MOcJsqVXadVfKPWMIBb96xDnlUY
	 AVfOVlG0djnYQaATxZZP4uV2tU1Jrz//cgf3Gkp3FTNL/JpEIPSIrAhgeF/oxEAjq+xUL
	 7yO3BvncLNV8TCskhskXCJbvuojAaCqN/ND/AcdLB/EEUPMc87gp+/NDaUEfdDMDMefRY
	 Xzw1Dms6+EFQcJLio1LKiaZ19toYqwxZ2FjE+wwyyvHC0+gVWA0xQVtJekr4TAoT02w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793760603;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=abDkj90NJiD8l8l0zAUvwFxe1kTltejS2SG5NFKFw0M=;
	b=zLVAwFa+EQUHTP/32tnU6rJM78H3c9DHkPUIN2VEVlrmcLN5XxwZ/r+TmSwtrw1YWX2T
	 X2i/cvDeiWqX+8wz+WYU0pREs+YpZIjbYF7AUt9MK9u/VtEtUfftOcehYegtxjwC9pkEM
	 w6bUkeVg1oSbLT8VLHXuKlD9ByYc/tdwyazk2dP5yZ3zJmZg2wrKE1w81AQ58oEnyq60M
	 qYEnxEIa0Z/M5fxStyIKsFJPTBK3l0uhCQb3eWTUSj+xr8ptXWwdCWc8gcW5Qb8iLU+By
	 meNouSOOXXU3wxL3QOAbRfBU5gfG6sYf4FvSC6BiJkiO+WKBrOKeTk5iEHuJZ3PkC5A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id D57151F0093A;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760603;
	bh=abDkj90NJiD8l8l0zAUvwFxe1kTltejS2SG5NFKFw0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ScdDhyL61GkX4nSv8WNp927gmGegANO0uI6zlVZ2Q2Xp3A/Dni19MvFpdKKUN4Bj5
	 VLkooMwh1sFKuyvunDE3KDfeFb9JXCgYG4B0BhtWX208EQivnqCbdqDGbI/Z53ASzC
	 rtk9Ejv+6LlHKILZXy7kC8RYF5/58oNUSCwdM0xaP8mBsmdmXV5iFD0kXrqEUWpyVS
	 iiNQTXWRgKuwA+bS6UzjJbuKzmeXDp3dG8jbvWs5Ck2p53hhni7GS7t0MnMe2B/yZ/
	 +kOp80QDNc31TiHrOoeDvpsxOq0MpuXauq5dd6LZh7D7Sc82uqFHtUj/ITVUKqXKgs
	 uTh2bXPYg4hcw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4CB6446BFB;
	Wed,  4 Nov 2026 02:50:02 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Tue, 03 Nov 2026 20:49:43 -0600
Subject: [PATCH v4 02/25] MAINTAINERS: Add entry for SDXI driver
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261103-sdxi-base-v4-2-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
In-Reply-To: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
 David Rientjes <rientjes@google.com>, John.Kariuki@amd.com, 
 Jonathan Cameron <jic23@kernel.org>, Kinsey Ho <kinseyho@google.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 PradeepVineshReddy.Kodamati@amd.com, Shivank Garg <shivankg@amd.com>, 
 Stephen Bates <Stephen.Bates@amd.com>, Tycho Andersen <tycho@kernel.org>, 
 Wei Huang <wei.huang2@amd.com>, Wei Xu <weixugc@google.com>, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793760600; l=957;
 i=nathan.lynch@amd.com; s=20260722; h=from:subject:message-id;
 bh=QzMadJVmuUJo4TNmWXrHY24R0Uh6rkcQVfp+/UUrz6I=;
 b=elxBEGJUVTadQeEHCPFE3sgcwAMkwFMb49z1+xPlPBjDeY2rns5t3mOv8GxN3cZE7CbKddfMF
 1liLmfVafgPC70viPc/0oVlHVGNzXJBHTYYiSvy7JRr7p31G8EeZoPN
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=pO5+BCw/TENGLvwX5NYZOZmZihcxjkxeFSMuk47erps=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20260722 with
 auth_id=891
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com
Content-Transfer-Encoding: 7bit

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
index 93abbb315065..721f06446435 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25281,6 +25281,13 @@ L:	sdricohcs-devel@lists.sourceforge.net (subscribers-only)
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
2.56.0


