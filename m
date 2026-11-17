Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914504;
	b=gm3qmfNJkrvbcoOwTNYG4P1A5/UvBD3jDZJkYA88m2NxGf6/v7nv45z4JYc9Kj3BszTi
	 OHpVGqo23q3veYJqbAVYBTHD/ebdZKD6yL/NGqFKhKv1AyONzU26NM2RMY020cGpNLle8
	 ds8F4YRqKGhLtfceoqa92UbQsQCrJJbptZT86jAt67EflCLrOOsqO1KvcTRensJAc+BMQ
	 Y64BeTAmNRdmbpK7yPZU6K/nJMi91JflRE7VrOC5QXykRhZIqpvvnVDaSW2SsJggRwTvX
	 mY3RCD4O4cebrYUn1TDJNIZY1erLrhf5+3Sm4dLjZa+ZUTrQyfoxZBq5gXIBocf0tgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914504;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x7FKUaCvfIYG+OL9lzY+LhaajL+qrQZmia0tnFbeArk=;
	b=tvA7QjNbIw87EgorRh9LUwv6tRo3jzqGx7RfmyCv6ujYn+mycC5w5MoiKl6iJWDeu9RB
	 QFTGihrND+4DW4lb84+J3QIz0cL1WZ02QEI9q7cxjppd5CPyMFLFX2LY85B0vtezokkNC
	 nF9Uh+pKFfbxOlZ9QymThRX1PWzEXiN0SxcYbFS2za5pDyn4zoGxhpn67aGeabowTrA+j
	 lgRODYAzV/hPyTUMDKE775QHiZJIeqZgzPaFRZV50AL5A50OXYo8EP4RVIufZpqpEHQ8a
	 DzKvPq/evT4A+V2m7xkcYAvrqtYvLEmIUCOEfRugu+ZNqBN43l2hXCPyG8qx9mOpZ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sQQSCwa5;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EEA606A323;
	Tue, 17 Nov 2026 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06EEA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=sQQSCwa5
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EA331CDD;
	Tue, 17 Nov 2026 03:21:40 -0800 (PST)
Received: from e135073.nice.Arm.com (e135073.arm.com [10.34.111.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D26F23F763;
	Tue, 17 Nov 2026 03:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794914503; bh=fqjc/m+GsrUpdUZSOPvYguj57JvvOU+w3OhEK+hZgDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQQSCwa5WOTLaq+RJBycgz64wJdPreJtjbw51rDWGDD6fmeiEwSwMPadHDo42x6CD
	 w0B6L9CpCqAVfP8J1GCJWQmaQr2RvZNsJtfGCigaf9sVen6xN1juZACoqSkOiiD1LX
	 jn94lVUpKMqQdf/y9VmIULmx4T8eGFAvw0+NGqfQ=
From: Pierre Gondois <pierre.gondois@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Ashok Raj <ashok.raj@oss.qualcomm.com>,
	James Morse <james.morse@arm.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Avadhut Naik <avadhut.naik@amd.com>,
	Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	acpica-devel@lists.linux.dev
Subject: [PATCH v1 19/19] PCI/ERR: Avoid NULL bridge pointer
Date: Tue, 17 Nov 2026 12:10:29 +0100
Message-ID: <20261117111444.4185512-20-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117111444.4185512-1-pierre.gondois@arm.com>
References: <20261117111444.4185512-1-pierre.gondois@arm.com>
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

Return PCI_ERS_RESULT_DISCONNECT when no upstream bridge is available,
avoiding a NULL pointer dereference in pci_walk_bridge().

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/pci/pcie/err.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 1a7fc71c79d8a..402dc74c7fe49 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -233,6 +233,11 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
+	if (!bridge) {
+		pci_warn(dev, "no upstream bridge\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+
 	pci_walk_bridge(bridge, pci_pm_runtime_get_sync, NULL);
 
 	pci_dbg(bridge, "broadcast error_detected message\n");
-- 
2.43.0

