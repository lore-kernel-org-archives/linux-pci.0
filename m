Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50EC330D54;
	Thu, 30 Apr 2026 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777566157; cv=none; b=exQbuK+d/nEdjWhsBPv4LSJ39BYg3KqOweBKL/v1Qv2BU/xJakb1oDtQLIS+6AIjCU7Pma4bJF4cJe8kgwYHMceUWfWxrk6sCzrSbJxDCxiZxAkCsao7uSpm5DqplAu9hvjMAgm21ioSfPenIZWg8sM40f/iIrGuBmL5FEZM0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777566157; c=relaxed/simple;
	bh=Mez5As1RneO/MRM6s7tojfS69kWEmTjgPYktdsfn50o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GtWYcvWjHDW7AW4u5pqOhL5KpV3gyiqjVuN+Y6WYNYLpzP6/YDfsUy69qHpJ8aRMxmkoDOY4cIgylGGviCSTmahIo+vVAZb7xmxGrf+mjoYMFQ7m8pGSmb5l0Rt3jJcve8KrHBcBV12q5rhGknE5abtbf8A7OM4OOQAlZErDQLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=TQnBJm6d; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="TQnBJm6d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=lgOkgt64wlf+glnOOYyNKpnMDGONDz3qxMKki9FrYto=;
	b=TQnBJm6dcoi9EGh/g27w0+KwriZg2FqXJtbHYeSwoID6p78L26SmG6jnZ1q5BF
	VV9xWfYDJGKQDQDa5PxwEteQvNbNYr+POy1KGLG37XRA1AQY6rSr5g4xE5mQBjbm
	RmyAIM+OaJBv5X2Tdz8vBjl0cWKsPn0spt3yuPuGTeX64=
Received: from [IPV6:240e:b8f:927e:5900:c497:d540:b00d:97f4] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgDn1_ivgfNpPCjLBw--.9605S2;
	Fri, 01 May 2026 00:22:09 +0800 (CST)
Message-ID: <336f827e-71da-49af-be9b-6f555cd3cbb1@163.com>
Date: Fri, 1 May 2026 00:22:07 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/16] PCI: Use FIELD_MODIFY() to simplify bitfield
 operations
To: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, jingoohan1@gmail.com
Cc: robh@kernel.org, s32@nxp.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260430161254.40278-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260430161254.40278-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgDn1_ivgfNpPCjLBw--.9605S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar4DJw1rtrWfCw1xKr1fXrb_yoW8KF1rpa
	4UKFyxZFy8tr45ZF43Ca1jkFyYvFnak34UtayqgwnrW3ZI9ryUWrWUtFyrJ39xJF4UWFy5
	Kw1Uta45uFs3JFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U5R67UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxHjh2nzgbE61QAA3z


Sorry for the noise.Due to my current system issues, the remaining 
patches were not sent out. I will resend them now.

Hans

On 5/1/26 00:12, Hans Zhang wrote:
> Replace open-coded bitmask clear + FIELD_PREP() sequences with the
> dedicated FIELD_MODIFY() macro.  FIELD_MODIFY() performs the same
> operation but is shorter, less error-prone, and includes compile-time
> checks to prevent field overflow.
> 
> This series touches the PCI core, PCIe extended capabilities (PTM, IDE,
> TPH, MSI, REBAR, IOV, CardBus), and several DesignWare-based and
> other PCI host controllers.  No functional change is intended.
> 
> The patches are split per subsystem or per driver to ease review:
> ---
> Hi, If the Maintainers think it's not necessary, please ignore it.
> ---
> 
> Hans Zhang (16):
>    PCI: Use FIELD_MODIFY()
>    PCI/PTM: Use FIELD_MODIFY()
>    PCI/IDE: Use FIELD_MODIFY()
>    PCI/IOV: Use FIELD_MODIFY()
>    PCI/TPH: Use FIELD_MODIFY()
>    PCI/MSI: Use FIELD_MODIFY()
>    PCI/REBAR: Use FIELD_MODIFY()
>    PCI/CARDBUS: Use FIELD_MODIFY()
>    PCI: al: Use FIELD_MODIFY()
>    PCI: eswin: Use FIELD_MODIFY()
>    PCI: s32g: Use FIELD_MODIFY()
>    PCI: tegra194: Use FIELD_MODIFY()
>    PCI: qcom: Use FIELD_MODIFY()
>    PCI: dwc: Use FIELD_MODIFY()
>    PCI: mvebu: Use FIELD_MODIFY()
>    PCI: mediatek-gen3: Use FIELD_MODIFY()
> 
>   drivers/pci/controller/dwc/pcie-al.c          | 12 ++----
>   .../controller/dwc/pcie-designware-debugfs.c  | 23 ++++-------
>   .../pci/controller/dwc/pcie-designware-ep.c   |  3 +-
>   drivers/pci/controller/dwc/pcie-designware.c  |  3 +-
>   drivers/pci/controller/dwc/pcie-eswin.c       |  3 +-
>   drivers/pci/controller/dwc/pcie-nxp-s32g.c    |  3 +-
>   drivers/pci/controller/dwc/pcie-qcom-common.c | 40 +++++++------------
>   drivers/pci/controller/dwc/pcie-qcom-ep.c     |  6 +--
>   drivers/pci/controller/dwc/pcie-tegra194.c    |  8 ++--
>   drivers/pci/controller/pci-mvebu.c            |  3 +-
>   drivers/pci/controller/pcie-mediatek-gen3.c   |  3 +-
>   drivers/pci/ide.c                             |  6 +--
>   drivers/pci/iov.c                             |  3 +-
>   drivers/pci/msi/msi.c                         | 11 ++---
>   drivers/pci/pci.c                             |  3 +-
>   drivers/pci/pcie/ptm.c                        |  3 +-
>   drivers/pci/rebar.c                           |  6 +--
>   drivers/pci/setup-cardbus.c                   |  3 +-
>   drivers/pci/tph.c                             | 10 ++---
>   19 files changed, 51 insertions(+), 101 deletions(-)
> 
> 
> base-commit: 3b3bea6d4b9c162f9e555905d96b8c1da67ecd5b

