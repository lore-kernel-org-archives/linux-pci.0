Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794294588;
	b=w/ScnMg4L23YS0bvDMXbtif5iUzVyMipxtRZL8r8wSXLRBb4rmuw/uL4kCYhjcs+ZS06
	 vm+0Dm/m1kwrjfOqLZ/rWZA3bItOXphDWlOi0sZ8zYq8keusZB8ztVAOQVJR2mO2ST38/
	 eJ2SWXKPvViZudrk0fotzvJ221+IUR+vD/FxnS+fTTO1Q2Khy2RMr3mz8uBmIxseV5uWF
	 O2PVwufQ5hkheylwnLo1nx7zgr2xN/Ga4eBiu+0Sp4wmeX52idT4YAnjUO4vL7QvMbmIE
	 EJJdWcCdSZuPTw4RymnS7HpccQFjZVFIvaWnXgldIshVoRF1CzCrqd7nH3PFgJQfRSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794294588;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tewiO/fcU0kVXHUFtT/bhkFJMYsz1DEUUMUqBRKDrXY=;
	b=SrvH68pP4y6QQqFZDt3tpujd7/jkGcfTUAc4wKzEpceKbwba4clNtK1tD1mzTYcVP0s8
	 +ssDlXvZgmhuYFxGgFfomG/UExRHRJCig6EvMRaJixiNX1FybPoqfkcZcNA17NYAdl4P/
	 Sk3btGFAoxmXiuP9RQ+SDpwVyaEiBVwSKxRBrPCpl2oRK5hJyAi4f+qSiy2HYYMuK1IGc
	 yfRYbIAGaU/3+G5ERJp0u6kIPE0ZuQ4Om7p1d0SRr+71msrqAfic43QpLx0fqEMd5quEN
	 ftotZMrX7rlQLQ2UciY9Vgj7COeTj77rECQsUFg0czflz2NTnJ0zqoZH39/X9F6n92g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b="B/yk8fLK";
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFCC606A31C;
	Tue, 10 Nov 2026 07:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AFCC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=B/yk8fLK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=B/yk8fLKa8u8YzWQaAhx5Htj4Cxgod8Tgg2yorYVBYbIBBejh6dxHaf2+c2wvB5rbib4JLRFFaQXw
	 a2PZDoUMUpG/zW9jmEIigOxtpLerJddbfX2NXYt6mFQ7ZqC7y+x0oJ480UwIzXhWFCo1kgchtzXB28
	 5u0Yb8q2idRAhZus=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af2c33615d-07f2f;
	Tue, 10 Nov 2026 15:09:46 +0800 (CST)
X-RM-TRANSID:2ee26af2c33615d-07f2f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96af2c3377a6-ab659;
	Tue, 10 Nov 2026 15:09:46 +0800 (CST)
X-RM-TRANSID:2ee96af2c3377a6-ab659
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	linux-omap@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 0/2] PCI: j721e: fix OF node reference leaks
Date: Tue, 10 Nov 2026 15:09:41 +0800
Message-ID: <20261110070944.996-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

j721e_pcie_ctrl_init() and j721e_enable_acspcie_refclk() resolve
syscon phandles with of_parse_phandle_with_fixed_args(), which takes
a reference on the resolved device node.  Neither of them drops it,
so the referenced device node is leaked at probe; and since
j721e_pcie_resume_noirq() re-invokes j721e_pcie_ctrl_init() on every
resume, the leaks repeat on each suspend/resume cycle.

Drop the references once the phandle argument has been consumed.


