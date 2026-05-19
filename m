Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEC3ED3D8;
	Tue, 19 May 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779207038; cv=none; b=EIjHx0pR98BodWEWhOKr0zjc/u48YVm45C8awsJgXUWIG/EZqZUZE9tss0unBPJi4oQ9JcEJGFaW5gd4ClwhmB2Oz0keHh4Tz8Pvj2/P8GVES4IoWiPFgZ1dZNYUkHpnkmsvR/asXGD6QKB2H2S80g/ofICZlaSrS5cigqCWZac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779207038; c=relaxed/simple;
	bh=8okWtQH8joVAmxJvNHgYveZTTMjAxL5udncqkOLy9Qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oY0vtJDQV0wZogOoSzpPCNlKw0khmtWdbBqkDPZJtHk7gpDp/PfqalX8LJpimtKT0hzuSCWM1zKdRUMjnRerQYeV+X0+54dEwk7Fq1YElwIjDnElXTxpJtACZNYda69WhmCzq+YxkOY8xFHxoMPHBPQH5g9q38Bnbq0iNFshnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JUyt0G87; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JUyt0G87"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=JLeG6x1Y3dfOvgAW0mg1VnFVfEP9lZkOIYEiUHHIyoA=;
	b=JUyt0G87rt7PYlK4QmM8e4B8RwvbyXFoil0YpiApMe3XoreMYWYuEqJf5cPfwf
	qlBIVDUaQLyHq0JgoD73DUE643nlzgebsfiYDyj3SJ0JmWnZ7d0U+bjJkV9ql9SY
	HGrtIli4iTrWBVdI6Ps9vODOFptHtzla5d5m36vbO5yK4=
Received: from [IPV6:240e:b8f:91b3:d000:9130:b3d8:6241:39fd] (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wBXXrU4iwxqGKJPCQ--.44368S2;
	Wed, 20 May 2026 00:09:29 +0800 (CST)
Message-ID: <5cc6fbcc-98eb-4da5-b123-2c04c4d39326@163.com>
Date: Wed, 20 May 2026 00:09:28 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] PCI: dwc: Cache PCIe capability offset and simplify
 drivers
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 jingoohan1@gmail.com, mx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260509135152.2241235-1-18255117159@163.com>
 <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <beqy5ykxgo4ianya6r4mahkkyujs6lly475u26vqaemgqsdnhp@2pn5ipczwc34>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXXrU4iwxqGKJPCQ--.44368S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryfKrW8tFykKr18tF1fJFb_yoW5ArWkpa
	y5tF4IyF18tF4S9a12v3WDuF13t3Z7AFyDJ39xW34SvFya9F17Wr10yrWftF97JrW2qr1a
	kF45ta47uFs5JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRiiSJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7BqOMmoMizpQVQAA3Y



On 5/19/26 21:57, Manivannan Sadhasivam wrote:
> On Sat, May 09, 2026 at 09:51:49PM +0800, Hans Zhang wrote:
>> The DWC PCIe core and its many platform drivers repeatedly call
>> dw_pcie_find_capability(pci, PCI_CAP_ID_EXP) to obtain the offset of the
>> PCI Express Capability structure. This is wasteful and makes the code
>> verbose. And some even search for the PCI_CAP_ID_EXP offset value within
>> the suspend/resume functions.
>>
> 
> Sashiko has flagged some real issues with this series in accessing DBI space
> very early and 'pci->pcie_cap' being 0.


Hi Mani,

We have discussed this issue in the Cadence driver. I think it won't 
cause any problems. Specifically as follows:

https://lore.kernel.org/linux-pci/5823faec-d972-4c77-90ec-a215c686e0a8@163.com/
"""
As per PCIe r7.0, sec 7.5.1.1.11, Since all PCI Express Functions are 
required to implement the PCI Express Capability structure, which
must be included somewhere in this linked list.
"""



Bjorn also responded as follows:
https://lore.kernel.org/linux-pci/20260505212306.GA744158@bhelgaas/
"""
It's true that all Root Ports must have a PCIe Capability.
"""



Mani, should I continue to make the judgment that 'pci->pcie_cap' might 
be 0 as per your instructions?



Best regards,
Hans


> 
> Those needs to be fixed.
> 
> - Mani
> 
>> Add a cached pcie_cap field in struct dw_pcie and a helper
>> dw_pcie_get_pcie_cap() to initialize it once at probe time. Then replace
>> all explicit capability searches with the cached value across the
>> entire dwc subtree.
>>
>> Hans Zhang (3):
>>    PCI: dwc: Add pcie_cap field and helper in designware header
>>    PCI: dwc: Use cached PCIe capability offset in core
>>    PCI: dwc: Simplify platform drivers using cached capability offset
>>
>>   drivers/pci/controller/dwc/pci-imx6.c         |  6 +--
>>   .../pci/controller/dwc/pci-layerscape-ep.c    |  4 +-
>>   drivers/pci/controller/dwc/pci-meson.c        |  4 +-
>>   .../pci/controller/dwc/pcie-designware-ep.c   |  4 +-
>>   .../pci/controller/dwc/pcie-designware-host.c |  4 +-
>>   drivers/pci/controller/dwc/pcie-designware.c  | 16 +++---
>>   drivers/pci/controller/dwc/pcie-designware.h  | 17 +++++++
>>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 +++---
>>   drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>>   drivers/pci/controller/dwc/pcie-fu740.c       |  2 +-
>>   drivers/pci/controller/dwc/pcie-intel-gw.c    |  2 +-
>>   drivers/pci/controller/dwc/pcie-qcom-ep.c     | 11 ++--
>>   drivers/pci/controller/dwc/pcie-qcom.c        | 24 ++++-----
>>   drivers/pci/controller/dwc/pcie-sophgo.c      |  8 ++-
>>   drivers/pci/controller/dwc/pcie-spacemit-k1.c |  5 +-
>>   drivers/pci/controller/dwc/pcie-spear13xx.c   |  6 +--
>>   drivers/pci/controller/dwc/pcie-tegra194.c    | 51 +++++++------------
>>   17 files changed, 85 insertions(+), 97 deletions(-)
>>
>>
>> base-commit: 70390501d1944d4e5b8f7352be180fceb3a44132
>> -- 
>> 2.34.1
>>
> 

