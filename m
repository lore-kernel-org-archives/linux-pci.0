Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAF405C57;
	Thu, 11 Jun 2026 17:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197722; cv=none; b=E0hW4h8hL8ogAmHfZD5Akv7/CX8HT0yDcGih2p9wnPWmoK1knDBn0YXI9Ud6BDqP8zIDBqB9BLU9GY53Q/nhaLLqgQk2IQMlG4K854AwzFqOWZkpWYkLZvoRGcYD7NYxVFXKnfEiJmjRnQ5SgAcpg/Y87MbR6btYuvGUAOd7iow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197722; c=relaxed/simple;
	bh=egGjG/Z8RpGXuUkMcrmf1mJOAPq4qt7oZoc8fB0KWZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bdMS76Gsqq2OT1xd16BZoii1gju9Md+cJvNlnaqPKq5iolhpoVY6mS14DHghi5dfa0tQFyn12wTn9E2jLlLRqBwHKcE648wViBr1CS6F0vFQ001CdRSVQd0HkQ6WEq0C9kpvZsIN9hWG/MFzcq9Hdo4Pu2YPONJEpaxLiPi/trE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XJhuRuUj; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XJhuRuUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=OI7t1b36F4+UKnc6nJAr96ZUPjEMxmygm73wCkHRglo=;
	b=XJhuRuUjT+QN2DOVNarE4pC5ad8+yPjlUhyQsBdl9UZ0Um54bwxj+DWqIFwJgR
	IHrDlcvm+xPovj4ICxK6ErA/Oxyy87149WgeBdZuJMkSVCu5xYPCDaQIR4SY2EgR
	fRWWh0Ur/2zwmbAZMPunx1weEZT4EQm8nz/l1LQRw7f4Q=
Received: from [IPV6:240e:b8f:91b3:d000:5ea0:effd:ade2:b21d] (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCHfs1u6ypqCwM2Bw--.42788S2;
	Fri, 12 Jun 2026 01:07:59 +0800 (CST)
Message-ID: <b323db24-0e36-4c1a-a451-2dcbfec68cc3@163.com>
Date: Fri, 12 Jun 2026 01:07:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] PCI: Refactor PCIe speed validation and conversion
 functions
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 kwilczynski@kernel.org, mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 jingoohan1@gmail.com
Cc: robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260407130450.1489318-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260407130450.1489318-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PigvCgCHfs1u6ypqCwM2Bw--.42788S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw13CF48ur4xWryrGF13XFb_yoW8KrWrpa
	yYvw4fArWUGr9xCa97J3Wjqry5Wa93XrW0yry3Gas3Zw13AFn3JFWvgF1FvF9rXrWFvr42
	vr12vw1kCw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnF4iUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxA832oq63AZ5wAA3V

Hello Bjorn,

Gentle ping. Please take a look at this series.

Best regards,
Hans

On 4/7/26 21:04, Hans Zhang wrote:
> This series refactors PCIe speed validation and conversion logic to
> shared functions in the public header, eliminating code duplication
> and ensuring consistency across drivers.
> 
> ---
> Changes for v7:
> - patch 0002 add #include <asm/bug.h> (Ilpo)
> - s/u32 link_speed/enum pci_bus_speed link_speed/ (Ilpo)
> - The return value of pci_bus_speed2lnkctl2 uses the variable ctrl2_speed
>    to avoid the abuse of variable types. (Ilpo)
> 
> Changes for v6:
> https://patchwork.kernel.org/project/linux-pci/patch/20260406105613.1228673-1-18255117159@163.com/
> 
> - missing one line of code:
>    link_speed = pcie_get_link_speed(pci->max_link_speed);
> 
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20260406104708.1218648-1-18255117159@163.com/
> 
> - Rebase to v7.0-rc1. (pci/next tree)
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20251102143206.111347-1-18255117159@163.com/
> 
> - Maintain O(1) array-based lookup for speed conversion (addressing
>    performance concerns from v3 feedback)
> - Move pcie_valid_speed() and pci_bus_speed2lnkctl2() to pci.h
> - Update dwc driver to use the shared functions
> - Rebase to v6.18-rc3.
> 
> This addresses the feedback from Lukas Wunner and Manivannan Sadhasivam
> on the v3 submission, ensuring no runtime performance regression while
> achieving code reuse.
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816154633.338653-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - Gentle ping.
> 
> Changes for v2:
> - s/PCIE_SPEED2LNKCTL2_TLS_ENC/PCIE_SPEED2LNKCTL2_TLS
> - The patch commit message were modified.
> ---
> 
> Hans Zhang (3):
>    PCI: Add public pcie_valid_speed() for shared validation
>    PCI: Move pci_bus_speed2lnkctl2() to public header
>    PCI: dwc: Use common speed conversion function
> 
>   drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++-------------
>   drivers/pci/pci.h                            | 23 ++++++++++++++++
>   drivers/pci/pcie/bwctrl.c                    | 22 ---------------
>   3 files changed, 32 insertions(+), 41 deletions(-)
> 
> 
> base-commit: 525e91d84dc085492b36d4b87abb7c1cc93fcb44

