Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613129;
	b=jtHRH5itGuzfi6DFK3/Ssktznvbk8TTI4wGFrh8kLONmH0IdVZdk6F9g+qQV7iwwxnOT
	 2MKZM4WklowWQe9JMcno0Y92rnddw4/tTFnJokhYy8K2EfD1ofXSxObSL6uEy/atqwacH
	 l9qzD/U5Ems8/ZOE1Njculb4tRuT0Q5nQSCkBrS53pPliITJ/ntRof7A6hZ5KpTqfhUbG
	 D9qtvZ9P/34POh9ETZvp26t5ghqsgSNI793GfrrblG/f7w/HB4kNNDiwqpFkQ/XQamb6O
	 iVLLqCZXS420gINCiHeyi/ynbI8jULgxN84VPNz0cn1x74Sf7TZwXkYXX/PTRffCevA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613129;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=piXRLkxe/MMr3aw8+5GCp8kCJ3Al4TCZfqVsOYAL3vM=;
	b=Zil7Jnd9t+k4/1AaT2fIMEhTOeeqsIMu8ulfQW8K/Eq59HcHHLmgkaaQr4JqW8M2VnXN
	 2TgiSIa+Wg1npTSAepMIvx1ugPcUjzwe9xLw96VkIuNkaS4WdslrGcBsvBAXgUbU9/UDj
	 j7cnoSMxjd/16XFLhVoOQOpGSegkJhGu7VCpoCJSyHPfm8YMj/yJ342UAJFwlUQAOfHdX
	 5xiKa6EkS9dQ1xgKnjjKuG2kuVnPjESwZ6ZROS2+KSxVUUdf5URuXMFL/hRYSWYlKJfff
	 Fv1ISK4v7cACR/h+XUG4mc14Kkk2/uI2+J7dQCAVMKeiCH4wE9u/725xgVFD/XBAYsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=phytium.com.cn;
	spf=pass smtp.mailfrom=phytium.com.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70853606A32C;
	Mon,  2 Nov 2026 09:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70853606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with UTF8SMTP id AQAAfwBHT1tBXehqO0XYAQ--.19815S2;
	Mon, 02 Nov 2026 17:52:01 +0800 (CST)
Received: from localhost.localdomain (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAf8DwSHU3XehqVDv0AA--.22683S2;
	Mon, 02 Nov 2026 17:51:51 +0800 (CST)
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
Subject: [RFC PATCH 0/2] Allow reusing PCI domain numbers in DT
Date: Mon,  2 Nov 2026 17:51:48 +0800
Message-Id: <20261102095150.2370959-1-cuichao1753@phytium.com.cn>
X-Mailer: git-send-email 2.33.0
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
X-CM-TRANSID:AQAAf8DwSHU3XehqVDv0AA--.22683S2
X-CM-SenderInfo: pfxlux1drrlkut6sx5pwlxzhxfrphubq/1tbiAQAHAGrnk0kE5QAAsw
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=cuichao175
	3@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoWrtrW8Zw17Wr1DCFW3ZFyrJFb_yoWDtFc_uF
	97ZryDWayUAF1Fqa4fJr1SqFy8uw4DJr1jyFZ0qF1qg345ur1ay395WrnxZ3WxJr47Zry3
	Cr93Cwn7u3ya9jkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=

This series allows multiple PCIe host bridges to reuse the same software
domain number in Device Tree (DT), provided their resources are disjoint.

In mainstream GPU P2P functionality, whether the GPUs participating in
P2P belong to the same PCIe domain is one of the decision criteria. In
the existing DT path, a uniqueness constraint is imposed on the PCI
domains of multiple PCIe nodes, which prevents devices under different
PCIe RCs from reusing the same software domain number.

It should be noted that equality of PCI domains at the software level
is not equivalent to the final P2P decision. The ACPI path directly
returns '_SEG' and does not perform a similar uniqueness check, as
'_SEG' is a purely software concept and allows multiple RCs to use the
same value.

Cui Chao (2):
  dt-bindings: PCI: Add linux,pci-domain-reuse property
  PCI: Allow reusing PCI domain numbers in DT

 .../devicetree/bindings/pci/host-generic-pci.yaml  | 10 ++++++++++
 drivers/pci/pci.c                                  | 14 ++++++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

-- 
2.33.0

