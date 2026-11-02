Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613134;
	b=P2L5vownRLwZ7Ks6139JDECG+fRJJTguiLMjM58aDTaIijC9E2wizG6nxNkKmFnb0QY4
	 AtdcXZW38yFyWPcwXEDvfcfMUCzykr3CRNhfW7s8D8l2mrt7siky8aOJ+i0noREeXdtLg
	 HYX09291EgQuJheoRLFYe7cnW/q1wtWurKt2ZZzrJ4x/d/hECi9KMnA+giue5N7LQWIUW
	 07xf3SRNWKLQr3uB6DYbYtyNKcnE2rRiz1bbuPAaBwvGJsEu3fiXjY6fuTp5tcbjMLnOi
	 PCBA+XyFSdDApGhrOEZYzu09ZDljFLTIJqdnLVOogtbJhmzlIDT6BbVFppd0/sW1WCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613134;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=hZd39NkOwt0spQ0Fc/i0H3+nue4pIN5LVhWFLWxW1TM=;
	b=tSOCuk4NZzwc9+3b0+b6xImtf1xuyJpiTaqfg2okJhT+XE8KoU7ZzRi79dKyqjJtJPUv
	 mW+Ueg7+OYfILTEi4Gktb/UGnHwsPnbsBnJL0kfZS6dWwN/iVt1E2+c9EEFLW+h3ER2I2
	 Q59mh0lhbmYcV3hLhj24HJ23whYgyqOuRKp5JKjI9e5P+OGCYV4X6xhIx3PZXfCIGgE23
	 1zFOeXiGcG2YaYBq04sna0MghuHdDmYsyrD09afyn1mnYF3yuk2z8ruA9EcZTorb8CVCC
	 Kg+qkTcMcfGGPtCVCyyfjjpqKrOxZdgCI1Sg3ueE/6fHAzOymq9NQxmnRR0VH51GXCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9B8606A332;
	Mon,  2 Nov 2026 09:52:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E9B8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBHZd5KXehqbkXYAQ--.19645S2;
	Mon, 02 Nov 2026 17:52:10 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSHU3XehqVDv0AA--.22683S4;
	Mon, 02 Nov 2026 17:51:57 +0800 (CST)
From: Cui Chao <cuichao1753@phytium.com.cn>
To: Will Deacon <will@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI: Allow reusing PCI domain numbers in DT
Date: Mon,  2 Nov 2026 17:51:50 +0800
Message-Id: <20261102095150.2370959-3-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
References: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
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
X-CM-TRANSID:AQAAf8DwSHU3XehqVDv0AA--.22683S4
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGrnk0kE5QACsy
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxurWruFyrAF17urW5KFWkXrb_yoW5tFyUpF
	W7trW5ur4kXF1UXwn8Jr1UWFyYkFZYkFWkJw13Kw1kuFn8tFyqgr18try0gFyUArWUJFyj
	yFnrJw1Dtr18JaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

In the existing DT path, a uniqueness constraint is imposed on the PCI
domains of multiple PCIe nodes, which prevents devices under different
PCIe RCs from reusing the same software domain number.

Add support for the 'linux,pci-domain-reuse' DT property. For a PCI
node that declares this property, it is allowed to reuse the same
'linux,pci-domain' number with other nodes. For a PCI node that does
not declare this property, the original uniqueness check remains in
place.

Reasonable resource partitioning does not affect the global uniqueness
of devices. When domains are the same, as long as the physical
resources of two PCIe nodes (RCs), such as ECAM, bus ranges, mem32,
mem64, and IO, do not overlap, (domain, bus) remains globally unique,
and the BDFs of all devices are also globally unique.

Device tree example:
Each RC node participating in reuse declares 'linux,pci-domain-reuse';
whether the same number is actually reused is determined by the
'linux,pci-domain' value. In the example, the ECAM, bus-range, and
ranges of the two RCs do not overlap.

 pcie0: pcie@10000000 {
        ...
        linux,pci-domain = <0>;
        linux,pci-domain-reuse;
        bus-range = <0x00 0x7f>;
        ranges = <0x01000000 0x00000000 0x00100000 0x00000000
                  0x10000000 0x00000000 0x00100000
                  0x02000000 0x00000000 0x20000000 0x00000000
                  0x20000000 0x00000000 0x10000000
                  0x43000000 0x00000200 0x00000000 0x00000200
                  0x00000000 0x00000100 0x00000000>;
        ...
 };

 pcie1: pcie@20000000 {
        ...
        linux,pci-domain = <0>;
        linux,pci-domain-reuse;
        bus-range = <0x80 0xff>;
        ranges = <0x01000000 0x00000000 0x00200000 0x00000000
                  0x10100000 0x00000000 0x00100000
                  0x02000000 0x00000000 0x30000000 0x00000000
                  0x30000000 0x00000000 0x10000000
                  0x43000000 0x00000300 0x00000000 0x00000300
                  0x00000000 0x00000100 0x00000000>;
        ...
 };

Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
---
 drivers/pci/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 7c6f2aba8144..245ffb9d2f74 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6801,13 +6801,19 @@ static int of_pci_bus_find_domain_nr(struct device *parent)
 		/*
 		 * If domain is in DT, allocate it in static IDA.  This
 		 * prevents duplicate static allocations in case of errors
-		 * in DT.
+		 * in DT. Platform that legitimately reuse a domain number
+		 * across host bridges (disjoint ECAM/bus/memory/IO) opt out
+		 * of this check with "linux,pci-domain-reuse".
 		 */
 		domain_nr = of_get_pci_domain_nr(parent->of_node);
-		if (domain_nr >= 0)
+		if (domain_nr >= 0) {
+			if (of_property_read_bool(parent->of_node,
+							"linux,pci-domain-reuse"))
+				return domain_nr;
 			return ida_alloc_range(&pci_domain_nr_static_ida,
 					       domain_nr, domain_nr,
 					       GFP_KERNEL);
+		}
 	}
 
 	/*
@@ -6824,6 +6830,10 @@ static void of_pci_bus_release_domain_nr(struct device *parent, int domain_nr)
 	if (domain_nr < 0)
 		return;
 
+	/* Reusers never acquire the static slot, so never release it */
+	if (of_property_read_bool(parent->of_node, "linux,pci-domain-reuse"))
+		return;
+
 	/* Release domain from IDA where it was allocated. */
 	if (parent && of_get_pci_domain_nr(parent->of_node) == domain_nr)
 		ida_free(&pci_domain_nr_static_ida, domain_nr);
-- 
2.33.0

