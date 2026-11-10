Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294589;
	b=lzeTHLRqqdlVdcHNBhIIVm7Vjjq385xrDuEKZBq3mENQxYkjZCJ0bTmVhsmICvQUCUKn
	 2aUCHn9QiLbOYAhzcKSre7W5BlSiy1n86hwU83DIYQ5X9ErhByvq2L0HpYJvCBBgmd9wL
	 et3cBO+l/iO9PKf7DMyf8hPmOuxiSLvudgwXVmjFEOqrLWWEKIJs49cXyEh0qLnGkXvAR
	 SyrhMEWGJFhFwjT4uPYRQm6VGudQvPBfNxTfIUbIFcGKPWIcg9MjS1lNPex02JBSmTs3G
	 j2BfWJHTz/IaGDvRZq1n4cX39ktplQhic1pGAEFtiZ/vDHlcFzI5X1w/uR0fO+psfPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294589;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vNcdGNMR9h25+07+FbJJL+KnzsQKob8YFMXFVv6Av4k=;
	b=0VG9n1wCuiJpEDg7jZPngmB0WuxE6BDAyHAhAw+7FQld+8i++C8jTUxCo7vX4DRutuyY
	 kOEyHcN2i4tCFEFR4ZvW0aSNEq8/890w5tuSZ1cJTUoBIVmysOugfWVv4tENZSZe+bmKm
	 5R/vJfdWV8eLekvAJ5tIAZo2tS5U0bCmOcvYF+GfJZt5ZXgLmQycg08cT34rFB6d/LrZ7
	 T/qlqLX0xPcDNWn6gQOmEiTQg5Lj6LQp4EYd+eUb76C0eb41wPWLiBlS5u2bTabZ4jpLW
	 ENL+iqihxOhiO+HbSaejCpvHf6RS/CvW+nGtMbaV/sDOk2J95O/O1GbRfGvPqABkquw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HA9dhkoB;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D22606A326;
	Tue, 10 Nov 2026 07:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D22606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=HA9dhkoB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=HA9dhkoBJKbS0iKzQznDKoSyLDHDueiXA7XxNyxzWR8esJtud3hzxOUMrIWES27eudWtDcDIm3vYS
	 JP0/v44LmCajab5PrVWF7MvQ9IlVGN9DK5wY3eR3Jg90A1ZD8ECV4Cwmv3MEqo6dsR4bF68RroTPEV
	 9C0WfYNfNu2orUqo=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af2c33a261-c97d1;
	Tue, 10 Nov 2026 15:09:47 +0800 (CST)
X-RM-TRANSID:2ee56af2c33a261-c97d1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af2c3377a6-ab663;
	Tue, 10 Nov 2026 15:09:47 +0800 (CST)
X-RM-TRANSID:2ee96af2c3377a6-ab663
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/2] PCI: j721e: Fix OF node reference leak in j721e_enable_acspcie_refclk()
Date: Tue, 10 Nov 2026 15:09:43 +0800
Message-ID: <20261110070944.996-3-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
References: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>

j721e_enable_acspcie_refclk() resolves the "ti,syscon-acspcie-proxy-ctrl"
phandle with of_parse_phandle_with_fixed_args(), which takes a
reference on the resolved device node, but the reference is never
dropped, so the device node is leaked.  This is called from
j721e_pcie_ctrl_init(), which j721e_pcie_resume_noirq() re-invokes
on every resume, so the leak repeats on every suspend/resume cycle
as well.

Drop the reference with of_node_put() once the mask argument has been
consumed.

Fixes: 82c4be4168e2 ("PCI: j721e: Enable ACSPCIE Refclk if "ti,syscon-acspcie-proxy-ctrl" exists")
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -247,6 +247,7 @@
 
 	/* Clear PAD IO disable bits to enable refclk output */
 	val = ~(args.args[0]);
+	of_node_put(args.np);
 	ret = regmap_update_bits(syscon, 0, mask, val);
 	if (ret) {
 		dev_err(dev, "failed to enable ACSPCIE refclk: %d\n", ret);


