Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C75360EC0
	for <linux-pci@vger.kernel.org>; Sun,  5 Jul 2026 22:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783289313; cv=none; b=q/DJJOwhfUgdd1MrDRARrlXFqpOCLVm3uiesOW8lJeYF2RfF00oIVo7tffIJUYvk79XbimnSjrOEF5tAzeYcZC9XZrmFbMfXUexRIE5FggmniDCBn3ueJfBgZrGUBr2fOs/TeGxA5f10vxebetsGbOQoFDA2PaRKdhYT3lamqPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783289313; c=relaxed/simple;
	bh=PF1Ihza93WpOrvAq3pHsaM6w4cza/bisA5tm8+GK5YE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LLfDaHnasmT5uJeto8x2MiyGhZz0mHvtJP5vFuB62cyinGLG0JOE4j7BcYHUXeR8wNJRg7ASWv0pXNKkQfH/hGSAU7kHmgL61nFEtwu6aBLKSbQr34m5MZ/LnIMfT2ZXzlWr1tT+PDvkjtx+lgbGSsnbp3MDg18boo+TE+N2dlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtxbFF1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtxbFF1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B181F000E9;
	Sun,  5 Jul 2026 22:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783289312;
	bh=0qfonW8VYNwplGYVwRq4NMvzNH4D4FSvq6cGZ3w262A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TtxbFF1oJra04Y1XdE7SRbR+Lf/gswk5YjgahfgDkTi2Vcehxue6a8ypxOTsixP0g
	 VAInO/rCdj9Y8SlMeZ1cJxJsq9emHzomzPgGqQ10SzVXW6FdO5tzn0x9fbpdIqCdMG
	 0QokZvg+FLAtxgkC/IiI+6kkcTehcZVEVD9p2QR4Slvxk60rqwK/sSzFa05DzmZjHI
	 3o4Fb0gVlCBAhsosKaP0Fs7kjg+zBZQ+GYzMfmRd1gp9GTw9hpISWOy+Ar7aHp6n6i
	 Ym7t/oxlrai5bN8JRgptG/vlIz672945zlatSlcITZ4bgxdrQtn3t6NNflLN+MhKis
	 JGPaypc2C/WWA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 319B3F40068;
	Sun,  5 Jul 2026 18:08:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 05 Jul 2026 18:08:31 -0400
X-ME-Sender: <xms:39VKajFEl11uhWS--dHAvQ4YsAJoMz4VzicD1VtlOM_PshC3sooAAg>
    <xme:39VKaqZuJW4In2VXoWlrMm7AMTtRYi9hezesiUepXwBFUYtmGcIX2rk5AgslFbQLk
    lQWV9cS33DcZM0EHF8whH1z7eR8zuAfu13JrrJnbOLbOR3QMP_nEVS9>
X-ME-Received: <xmr:39VKalCcO_C7tAXlW4KSLZlRmMoMbdd0fEnWbswiOxF32rHEnex0-iTaLKnjNRjsX8Mi_Kxm5stFpqo9nS5YF4bWlF6sQuoFRFM>
X-ME-Proxy-Cause: dmFkZTGoHsnyv3ousxBbqGvLQCFFp+v0BisJSUTjcc6vW+mq8tln0+GfG+hYf812UNJnXR
    XOBq3Ysuh5l98s+bMBBW5fLYh+Obq0VX5oRPxooNPAmG5We2f6yVcZ2TsIK7l9fSw6buFt
    L2eZi+t4gBmBD0NAAiqfkLYYcPqqs19/H2/FNDPyg3qPoH/kdkdMFm2TdXQtChKRcbbnYV
    YIJ0JMGB6r9N1D6kjAsLqs35kmAPMaGdHtdXLsnIy47uV2vqoMMTMleX7SM0BFMYafZ6yM
    pN4K7jWFX5/8AiflvBCHBip3YaT54asN8y1bl+q855yCfOPeBDW9VuxjY09sO1OezGhiDZ
    QTQR0B/1OWkUI1lBYvGFJ8xlYXtspqdSDbepRUzfDo7TWOmBQ89YERZseVdv4+xRc1T69p
    1Q+SqNwqrdH3lcGztgtsDwN/AnBfrXgYpXi67x5UElRaQFsltGTs1RMaq8DyR61ws9reu+
    1XigMDDvXdR9PXUmw3E5cYsMc1pcnPJKcC3BEgJZiZh7PObmARf0pEx2eyZKOj0u9M7EAu
    RljkjBqxM9ljPT8f/GnXDcBb+lkxv+7O6z9x29zYxP5WJrPkY8qRpOsMOGTgdbygPpqS7+
    MtY61BFafTpLWm3Ky+CE4msR74AEF8R0phBexmpZjjNsXVhtBQIx3FBG3X4g
X-ME-Proxy: <xmx:39VKailp-t-JLeSv8dLA2LpOpR3wr2vxKJDLTl_zkJkppWR0gQRdfA>
    <xmx:39VKamxacms6jm3mnfiubZqJgy-Qn1QP_21FvLyAPaT2rUXxKl0NBQ>
    <xmx:39VKasSlZvWkB1DSM5Tb800uF4GqikFTwFXHCLXz9VdPWcW4tZ1GKw>
    <xmx:39VKau86kabylYv4PmxcUkUtAlZMxMsdDh9J4nkv-p7qtQMOWy2Hpg>
    <xmx:39VKaqvP1N2dZG8GX_zp7aghS1viJH3gmgeb6q9n8RnI3PesFqRvmQNG>
Feedback-ID: i67ae4b3e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:08:30 -0400 (EDT)
From: Dan Williams <djbw@kernel.org>
To: linux-coco@lists.linux.dev
Cc: linux-pci@vger.kernel.org,
	driver-core@lists.linux.dev,
	ankita@nvidia.com,
	Saravana Kannan <saravanak@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 07/15] modules: Document the global async_probe parameter
Date: Sun,  5 Jul 2026 15:08:11 -0700
Message-ID: <20260705220819.2472765-8-djbw@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705220819.2472765-1-djbw@kernel.org>
References: <20260705220819.2472765-1-djbw@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for adding another /sys/module/module/parameters entry,
document the existing async_probe parameter.

Cc: Saravana Kannan <saravanak@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Dan Williams <djbw@kernel.org>
---
 Documentation/ABI/stable/sysfs-module | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/stable/sysfs-module b/Documentation/ABI/stable/sysfs-module
index 41b1f16e8795..397c5c850894 100644
--- a/Documentation/ABI/stable/sysfs-module
+++ b/Documentation/ABI/stable/sysfs-module
@@ -45,3 +45,13 @@ Date:		Jun 2005
 Description:
 		If the module source has MODULE_VERSION, this file will contain
 		the version of the source code.
+
+What:		/sys/module/module/parameters/async_probe
+Description:
+		(RW) Emits "1" if drivers from loadable modules attempt async
+		probing by default. Emits "0" if drivers from loadable modules
+		attempt synchronous probing by default. This value is overridden
+		(in priority order) by: the module's built-in "PROBE_FORCE_*"
+		requests, the "driver_async_probe=..." kernel command line, the
+		"async_probe" module option, then this default. Write a valid
+		boolean value to toggle this policy.
-- 
2.54.0

