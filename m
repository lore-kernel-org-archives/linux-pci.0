Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305408;
	b=ZChXKNyJcYGK7wb+pUVZ0Dmf66nVNr7L4yRUKdMINcG+GvXqrJg59sa/zwio/Ntlcx3X
	 SjrvJR+RAUA7rSyRzy18/XJCE7FcbkYaKTKsUICvcO5ag/v7RhLuAEvFK6lHDJRodG2wn
	 IzwcSrWmrXX7N+BgoYhwaC5x6641+SjkIMI+JesipxkLkYaseU3tCibKHhhxQ7ziuP4zq
	 xWE+VCPgGFkvIuGQbP4FtAvrsSru/JO2GqBq/2S+J9t5IwgyTT5rsQTx0g3eI3z1oDcRj
	 ZSktNQjcNIhQZ+nPhuAI2XNjHJ7bz2OqIJc7Mtn44M5Lqyb5DaMap1zZO1i21pZzhrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305408;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xjtSKY+SmWPwxrp+IkseqPFtAqPIeZiD8ojI/qHqMgI=;
	b=aFBN0wYA96bDmXNYV5nQw2vOnjrh9IEnZKaF9W41NaG2wxSyRVzPBvbqFc8i5jR1hMoL
	 ilogXlMJ/0qpTXmdSs0SytREQUs3s9B5dECE+oHywz4LfXvLR9QIzRyo07QMhoAwTO4hf
	 gbpV1ViQsRoRXAWcE6CmSV0b+ENlFsF/boPiNQkXfFPapCUDb/NXVyq4zsFK+va3w3doT
	 FGhw0m1IMX7wwulQ6m5NW6D30XZUCHwiFPjK5V3C8KREuYlwuewalnPOs4oOcxpu9KzGg
	 OtFeAvTE0Dd3Lpw6d31IKphyI9ci6O7MypSraTluVRbntAWeDnlJ2sB+Y0RdPZQ6u3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=glRdxrF8;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BC2606A331;
	Tue, 10 Nov 2026 10:10:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78BC2606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=glRdxrF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=glRdxrF8fefh3i3zaQG1U+cLe7B2zAr8I4HsKFQr2GTY0MbOw4GfGGi2xeaguk5MD1nQ2bHIU6+XH
	 8tVvz0CZIuttp4EWfr5lMZIpuYU+/GImNViwp4HbUNevl4gfHofwNK0Rb88HAyMmCLaUD8rAjmM4xE
	 bopypUj84EcNrM+g=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af2ed73ee7-aa2e6;
	Tue, 10 Nov 2026 18:09:58 +0800 (CST)
X-RM-TRANSID:2ee16af2ed73ee7-aa2e6
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr04-12004 (RichMail) with SMTP id 2ee46af2ed74c04-b1a88;
	Tue, 10 Nov 2026 18:09:58 +0800 (CST)
X-RM-TRANSID:2ee46af2ed74c04-b1a88
From: zhaofeng2 <zhaofeng2@cmss.chinamobile.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	linux-pci@vger.kernel.org,
	Nishanth Menon <nm@ti.com>,
	Santosh Shilimkar <ssantosh@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PCI: keystone: Fix device node leaks in syscon phandle parsing
Date: Tue, 10 Nov 2026 18:09:51 +0800
Message-ID: <20261110100955.1046-1-zhaofeng2@cmss.chinamobile.com>
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

ks_pcie_init_id(), ks_pcie_set_mode() and ks_pcie_am654_set_mode()
resolve the "ti,syscon-pcie-id" / "ti,syscon-pcie-mode" phandles with
of_parse_phandle_with_fixed_args(), which takes a reference on the
syscon device node, but none of them drops that reference after the
register offset has been read from args.args[0], so the syscon node
is leaked on every probe.

All three call sites were introduced by the same commit, which
switched the driver from syscon_regmap_lookup_by_phandle() to
of_parse_phandle_with_fixed_args() in order to obtain the register
offset from the phandle argument.


