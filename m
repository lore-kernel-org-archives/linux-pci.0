Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20561A9F82;
	Fri,  6 Feb 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770420038; cv=none; b=MMw2MTnQ+j7k0v53aYLjoi2wIIvjgmtkBCFYQSe098q7SmQQF5QQ6bUH4XvDTVLSemHSZfhs5OIv0A1c2Wtsthm2qYwDx8Uojn6YBKkrZ2E+VPpi0M67QF+9h0lXcb2VUXfBVyVD8miuM4JBUns8tRj/3SKrWYlcWhrG72Woq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770420038; c=relaxed/simple;
	bh=daLtigT/CXjlneHopW+7e3vb4w73BJ77Jk7hiG+lTQs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RsaRdMY3akrh0hHKqJlnDElzM/lQdMJX/9k4w5VmrsX7vxQH7MAZ8JiIVA81fhTAMJ0TNCLKLKNaqs67c17YE0Zoim4C3bXD1mlavGR2lHLIgW67V6Hfol1PNb8/GQcfYwJZ9ZU4+1BQwmMIzKIZPpBtRcRmxRcPFpaTXREbcPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e8OP7LwX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8OP7LwX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F0A0C116C6;
	Fri,  6 Feb 2026 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770420038;
	bh=daLtigT/CXjlneHopW+7e3vb4w73BJ77Jk7hiG+lTQs=;
	h=Date:From:To:Subject:From;
	b=e8OP7LwXtdZ5ZWPAqUdkske620cSIIBWegeD8UMC0w3fDwHkGsOZDCA/vJzAM0ATR
	 RrAkdjpqqgDa62MkhLK2rCZPw48DFSlr025f05nQFL9pnGpHbuBTCGUFmIYnaxKqXC
	 rrh53vd/hc/MMmvWzSxm1LHod8Sc9aGHdEDfigDvh9McsZtrs2VX6EIDd7U/4fxzzL
	 u5Vg18Kf/JKOpAxmT4NuAYMwuJLtKHTmcjZb8YQGB8XtKXkE6HNWZq0k4W+d8IFWZ6
	 AZGmZMa5iR6R8v1JNY1ToUe7fmnZhVIB8pLtZ7y5KKQOmo4AtTIkFSzyBnc20gNAXG
	 SrG7aYYAttoig==
Date: Sat, 7 Feb 2026 00:20:34 +0100
From: Helge Deller <deller@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pci: Show PCI bus number with hex prefix
Message-ID: <aYZ3QtGtUdsNVu4X@p100>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The PCI bus number is printed as hex number (base = 16) but without the "0x"
prefix in the syslog, as can be seen here:
  pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
  pci_bus 0000:00: root bus resource [mem 0xfffffffff8000000-0xfffffffff87fffff]
  pci_bus 0000:00: root bus resource [bus 00-07]

Add the SPECIAL flag to the printk format to add the 0x prefix.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index a3790c43a0ab..f52fc95981b5 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1088,7 +1088,7 @@ char *resource_string(char *buf, char *end, struct resource *res,
 		.base = 16,
 		.field_width = 2,
 		.precision = -1,
-		.flags = SMALL | ZEROPAD,
+		.flags = SPECIAL | SMALL | ZEROPAD,
 	};
 	static const struct printf_spec str_spec = {
 		.field_width = -1,
