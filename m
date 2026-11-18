Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.76.78.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999448;
	b=FP06v+h3UE1gR+SpYE/tZzRGtjcGdUtr4I430w7pz17nmwntaZcKg+SYBVoYXeZPOmAx
	 Q6YCWFkQqajqZZFpK8MpGqAdAbUGi41DSr9kHJKlmkRWvnq+md11Ev+W5d44Z7dgKMoCJ
	 T32YsdaVyanygevRZFOmE85v4CzpBjZSnacZ1fJc//sTE6sxu5G/IeWjnsBxmUq816Zuu
	 62xxGY3Y9t5+/an4JnpTXl8/pq0OmayWYD5IlS020318lN1plzFAVHRI43vM2qhu0wXR8
	 JrgauDie1AQ5TK/J8KDOscxQ4N3N4Es0k9MZ4aZ2+pkFVdmSRz/ImAdtQTtH4AduzBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999448;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=5vccRsej6U4a/ZHe+hzTCUcNdodK+DAuno/TNDFubxo=;
	b=AvP3me1wWi0RpIEPbx2DAOS7HWSMiUslfxiK64Ce1jK/1Qfa8PdYgmL0OkiJMNbiafZR
	 7Pib2/s+BXkVGXubekegfpfUPhtqx7dBFS1YIpHxrCoaA6k6R8vTB1dnCNn2203wSxNqt
	 3Hj/Zhx1eNcKO5z45+I+u6r4BzySg77DyG3Rb6TINzrkymvfwdu6xQdasOlmMfnGPtJer
	 6fMtbpj83FQYzLcv2qkuz7MRvD2CfB902dMLpMxbzCDLbyj4A37FfAyDyX7/jWU0UD/oT
	 UtWP+dfmb71NZyZwgJX615V/bQOQsPY0iScA/Qfjxfw5+T8jHzGGrfjqUfkyR9YelXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=eswincomputing.com;
	spf=pass smtp.mailfrom=eswincomputing.com;
	dkim=pass header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=TLujzcJr;
	arc=none smtp.remote-ip=13.76.78.106
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD5C606A320;
	Wed, 18 Nov 2026 10:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD5C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=eswincomputing.com header.i=@eswincomputing.com header.a=rsa-sha256 header.s=dkim header.b=TLujzcJr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=eswincomputing.com; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=5vccRsej6U
	4a/ZHe+hzTCUcNdodK+DAuno/TNDFubxo=; b=TLujzcJr94kTWqv3zompplZjyp
	JJifaWWpcbjg1yZPbHKP47SsjUEIBRtLvXYNLwnu33crjK+ckxIZAWP7TVauSj1u
	+yfdqlZITz8TY7Js3aFcc9gl7ilPEr9IC1tMcdmRKU3ocpQrpaolURQPXflxH6Gr
	9xFCGTJ22d+3kUv9k=
Received: from E0007865LT.eswin.cn (unknown [10.64.112.9])
	by app1 (Coremail) with SMTP id TAJkCgDn1eSOhP1qLCEAAA--.181S2;
	Wed, 18 Nov 2026 18:57:20 +0800 (CST)
From: Donghui Zhao <zhaodonghui@eswincomputing.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhengyu@eswincomputing.com
Subject: [RFC] PCI: dwc: eswin: proposal for a separate EGC-series driver
Date: Wed, 18 Nov 2026 18:57:17 +0800
Message-ID: <20261118105717.1364-1-zhaodonghui@eswincomputing.com>
X-Mailer: git-send-email 2.55.0.windows.4
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
X-CM-TRANSID:TAJkCgDn1eSOhP1qLCEAAA--.181S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr1rGFW7ZFWDJr15uw1xXwb_yoW8Gr1rpF
	W5Way8AFn7JF43u3WkZF4vyFyIvwn3CFyUKws5Gw10v3WfCa4UXr4aqF1FqF1DGF1qgw4j
	qryYva4UZr4YyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUva14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjfUonmRUUUUU
X-CM-SenderInfo: p2kd0vxrqjx33l6h245lqf0zpsxwx03jof0z/

Hello PCI maintainers,

ESWIN Computing is preparing support for a new EGC series of SoCs.  The
PCIe controllers in these SoCs are still based on the Synopsys DesignWare
core, but the SoC integration around the core differs considerably from
the EIC7700 controller supported by
drivers/pci/controller/dwc/pcie-eswin.c.  Reusing the existing driver
would require a large amount of per-SoC conditional code, so we would
prefer to keep the new support in a separate driver.

Before posting the full series, could you confirm the preferred upstream
structure?

  a) Add a new host-only driver in
     drivers/pci/controller/dwc/pcie-eswin-egc.c, with a separate
     CONFIG_PCIE_ESWIN_EGC Kconfig symbol and Makefile entry, while
     reusing the common DesignWare host code.

  b) Extend pcie-eswin.c with additional of_device_id data and per-SoC
     operations, so that a single ESWIN driver covers both controller
     generations.

If (a) is acceptable, is pcie-eswin-egc.c the preferred file name?  The
differences from EIC7700 are at the SoC-integration level rather than in
the DesignWare core programming; a detailed list will be included in the
cover letter of the full series.

We will follow up with the driver, the DT binding and the MAINTAINERS
update as a complete series once the direction is agreed.

Thanks,
Donghui Zhao

