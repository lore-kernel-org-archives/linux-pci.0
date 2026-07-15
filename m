Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81392DCC1C;
	Wed, 15 Jul 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103088; cv=none; b=aIQQbq9JEEeBsgHI28XqHGadEE6U1Wr0o/zrJ3HOeoHW7KYNjrzCSXWElXHkbP17HZEWwW5pQrhGq6/3ROOJ1z1o++fsaUq6REQaxWhqSQZFIp3XDP/wMWz2KkVn/5fPPi2Ns3bZzqg9X/52Aw51c8iM1XyPFCuGzX6Xb8+W97E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103088; c=relaxed/simple;
	bh=8SCqIOp2hr70g8ZwIId6xqoAZ2aVhuLyqfRax0IeQl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y1zD0VhnUYjw4jHKyhQJvCg7fKLU0JZsB8dyS3O4P77V4p7u8CPjcvIK9io4Wqjbd9UT3TRt/7yDurb2q91LlITBFbGqXZBNpbShUql5uLBnpank3AVs81QOkFO1u0y6mh9PSkf6+Exwz8vBnBol/D/SwHUwKDfbQluoAYG6Bvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dTBseB29; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dTBseB29"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GMxvlrOzCdf7y6WpgV6PFNpYV/54zVVeCEqxmrSnghU=;
	b=dTBseB29/4m5doo48llOQHmcXl9wSK903QUBSfTjMPCMwEZlThMeC0BsMTtRN1
	Fd7Xv82NrHsD5H/Httu03J2BTOFOLP8GsD/StJsAOsuQ3t0RfUl0P0F8g9PtifyI
	7wmnfUt57trgsNC7NwwVFv/HXo2HzAzx7g+RRjoEmnpIQ=
Received: from [10.111.8.51] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wBXXRd8QFdqThepJg--.3253S2;
	Wed, 15 Jul 2026 16:10:37 +0800 (CST)
Message-ID: <4416a93b-82e6-43a2-94e7-919f8b150d40@163.com>
Date: Wed, 15 Jul 2026 16:10:32 +0800
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
X-CM-TRANSID:_____wBXXRd8QFdqThepJg--.3253S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWUGr1fAFWUArWDCw47CFg_yoW5GryDpa
	yY9w4fArW3Gr9xCa97W3WjqryUWa93XrWjyry3G3s3Zr1ayFn3JFs2gF1FvF9xurWFvr42
	vr13Zw1kCw1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8PEhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC6x+fQ2pXQH+SvgAA3G

Hello Mani,

Gentle ping on this series. Bjorn has asked you to review and apply this 
series.

https://lore.kernel.org/linux-pci/20260611172301.GA490724@bhelgaas/

Bjorn, Ilpo, and you have added the "Acked-by" and "Reviewed-by" labels. 
I'm not sure if this allows us to proceed to v7.3?

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

