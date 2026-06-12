Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247663396EE;
	Fri, 12 Jun 2026 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781306645; cv=none; b=cGRSNH1yo2HzZ5b/VNEhq44RplqCRnRGYmWm3E4oJi4VVFuazbFNpe2nkB0rith/ivNBKXkPs3kLk0Ucqf7raCzjIoVtkANvQqK/OdAfpZIl491PoRuhiRSmgHbwouupPL8iibLETNxf+uMIXylMAM2K1vczXMd7YPJaNd2QoxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781306645; c=relaxed/simple;
	bh=q66Q/IT6j2syih5xvnzoFJ5QQu7ZtCEqp02WsrLvOFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J/P37/+FICN4XFT65siEspYFeZtf+VtaCxAWaGm4TxmWVVh+11Q9HwRKF+2U3l/G9qMvFtd7vS4oY3wQ/bGhkm/pZPYc7Dpm5e+UMMpFW4OeEu3Kpg6DpCLmXk5434AZ5Nx/GutWApZuDqc2GysYEKAR5DJMvn988d4cQQe6upo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6Ghg/3i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6Ghg/3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCCC1F000E9;
	Fri, 12 Jun 2026 23:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781306643;
	bh=KYdYu+X0f0vJdas42PYuu/STKPDbGG0DXiHJtnelvHg=;
	h=From:To:Cc:Subject:Date;
	b=N6Ghg/3iE2/6sLipkW33bNq0LBLJ5yjWvrcRbmooKAKFST83vphbO3T2n8wMrEjLp
	 wwN6NOJ8w9aEdpIKy9sHNnJcpoaYr0y9dzk3Uv80d3HokOj58Sol1Q5LqLaYY8fiT+
	 33sBJzRQPpqkoISfNhYOS7VX29vbFEuNXGFMh5XVAx64V2LnRAvHgIsrI7NO6t9CEO
	 7s2ZsPvit2SIz+PN+Ysh7+CJbFnaLJ2xzxNKYpoH4rncuFXUATP73kYzQe7uMli1YY
	 t0DV3x+AjifD1xB3SdvBWPVH/XYHPH5rjB5bRQZeye+QwP34qFcvSuKnU/wGBQjb+5
	 hABrODFehrOJA==
From: =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] alpha/PCI: Fix I/O port accessor argument order in pci_legacy_write()
Date: Fri, 12 Jun 2026 23:24:00 +0000
Message-ID: <20260612232400.585195-1-kwilczynski@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_legacy_write() in arch/alpha/kernel/pci-sysfs.c passes its arguments
to outb(), outw() and outl() in the wrong order:

  outb(port, val);

The Alpha I/O accessors in arch/alpha/include/asm/io.h take the value
first and the port second:

  extern void outb(u8 b, unsigned long port);

So the port number is written as data to the I/O address taken from the
user-supplied value, and the intended write to the requested port never
happens.

The arguments have been reversed since the file was added, and the
function returns the access size regardless, so the caller sees success
while the requested port is left untouched.

Fixes: 10a0ef39fbd1 ("PCI/alpha: pci sysfs resources")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
---
 arch/alpha/kernel/pci-sysfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/alpha/kernel/pci-sysfs.c b/arch/alpha/kernel/pci-sysfs.c
index 3048758304b5..354ec5f10ad0 100644
--- a/arch/alpha/kernel/pci-sysfs.c
+++ b/arch/alpha/kernel/pci-sysfs.c
@@ -355,17 +355,17 @@ int pci_legacy_write(struct pci_bus *bus, loff_t port, u32 val, size_t size)
 
 	switch(size) {
 	case 1:
-		outb(port, val);
+		outb(val, port);
 		return 1;
 	case 2:
 		if (port & 1)
 			return -EINVAL;
-		outw(port, val);
+		outw(val, port);
 		return 2;
 	case 4:
 		if (port & 3)
 			return -EINVAL;
-		outl(port, val);
+		outl(val, port);
 		return 4;
 	}
 	return -EINVAL;
-- 
2.54.0

