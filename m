Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613124;
	b=kJA/PvPJRHbM5wXYpnNFIFCgE1PCMnVpgNKnYyviNgwCBMTxdFamiN88MfsKh07q9Lzi
	 fSLzjb+AWBb6E3TDRmezl4EFMJAongIPMEs3u/j2+/p+/3OidUWLqLPJ4CqO3EMK69nT+
	 nVWAJvXcNSbzMvL1GaK+FrZubgoFQwiUNVjHejwbaBCCchd79BkI7cmd3KVv8ee6a9UBi
	 UphQxvnDOAzzNFkqSACqIlTMyxTB/O+Wi/6zYWR04LWAI9yfOnsBcRYkC1mtSEInwYmvf
	 BgJTee83amySe4DNeaJGHwP9DFwf14+8gWruw+IePebgls4heP+CXyB2MXIijLdbblQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613124;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=gJnNMMnwMUzcu7RpJAfAtm5ftRwCHKJNH4erz+wHv/0=;
	b=BKfrLXpdEir1a1Ot1PQFh8yuzbJHpdbsfp1heyLXUfDZ4moPbUOe1/bXGKxc9PBK+XFZ
	 zaGNeaJlPq+EFxNjJCMGLR79PtLP2NZpnMSAZye4Myv5+gN7dZPF/m9yIw7ZPSAKv8P2P
	 tUrY6+Sx1LPKE3FUAbBcaA/XYrJ6w2z+2ejX7rjJzJ3Mp1ILZIN2l87F8A/kvcIejMUdV
	 9Fnw7O3cwYB79e85dyudTi24U0ZSTED4A55/92JfFtRUev48IwnMIDE5ThOYwWhWJeNmR
	 asfuYgmFk56Tpv14HxNc4Dy+mxUwGrHMihcPqm6pp9V0rYdbmTZxvVywGE2IW1xuAGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B29606A326;
	Mon,  2 Nov 2026 09:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B29606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with UTF8SMTP id AQAAfwCHj58+XehqBjA_BQ--.426S2;
	Mon, 02 Nov 2026 17:51:58 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSHU3XehqVDv0AA--.22683S3;
	Mon, 02 Nov 2026 17:51:55 +0800 (CST)
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
Subject: [PATCH 1/2] dt-bindings: PCI: Add linux,pci-domain-reuse property
Date: Mon,  2 Nov 2026 17:51:49 +0800
Message-Id: <20261102095150.2370959-2-cuichao1753@phytium.com.cn>
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
X-CM-TRANSID:AQAAf8DwSHU3XehqVDv0AA--.22683S3
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGrnk0kE5QABsx
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7Zw18XFWfKw4rKF13Ww1xKrg_yoW8Ar43pa
	9a9ryUXF4kXF17A3yYv3WjvF15WrykJF48Gw42kwnrKFs5ta9Yqr9a9r1jgFyUCF48ZFW5
	AFZxGa4rGr48XFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

Add a new optional boolean property 'linux,pci-domain-reuse' for PCI
host bridges.

By default, the 'linux,pci-domain' property must be unique across all
host bridges. This property allows a host bridge to explicitly opt-out
of this uniqueness check, permitting multiple host bridges to reuse the
same software domain number.

Host bridges reusing the same domain number must have disjoint ECAM,
bus-range, memory, and IO windows so that (domain, bus) tuples remain
globally unique.

Co-developed-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Wang Yinfeng <wangyinfeng@phytium.com.cn>
Signed-off-by: Cui Chao <cuichao1753@phytium.com.cn>
---
 .../devicetree/bindings/pci/host-generic-pci.yaml      | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
index 420d551e9af9..1b439e2f38af 100644
--- a/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
+++ b/Documentation/devicetree/bindings/pci/host-generic-pci.yaml
@@ -114,6 +114,16 @@ properties:
       Requests with Address Type (AT).
     type: boolean
 
+  linux,pci-domain-reuse:
+    description:
+      Boolean indicating that this host bridge is allowed to reuse the same
+      "linux,pci-domain" value as another host bridge on the platform. Host
+      bridges reusing the same domain must have disjoint ECAM, bus-range,
+      memory, and IO windows so that (domain, bus) tuples remain globally
+      unique. A duplicate domain on a host bridge without this property
+      remains an error.
+    type: boolean
+
 required:
   - compatible
   - reg
-- 
2.33.0

