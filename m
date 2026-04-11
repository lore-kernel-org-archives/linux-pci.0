Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CF540DFA1;
	Sat, 11 Apr 2026 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775870527; cv=none; b=o8QsHJ1LvJe0yt0pEDIXomzZ7hU0ytOvZe+jnJ2Bw9QQE6eY7chmL8byyOJhAJdsh+jODc2FtejmPoUqfDwEBfdKhc+lbq789vldy67TE0S9KT7YLH2zTuVFyHF8zW7Dd+J6f9wlHKEMADQnXC6XoFwmWEOZLpDdXk3ksDRwhRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775870527; c=relaxed/simple;
	bh=/PwF8G2z6l/Sklihb/YvZ936SeSPy4Fa3jTst40qrDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t9tddvuP8RZD9ZK93Vp1ojsVmIR40G1bM5RXiVKiuYggH6Y7XM4AksYpcDI+UpR5rd03wduaX73LfB6IlGIPhI7pTeKYzwchsC0J1z2XlMvcnhf0m146dWk9m/zie/IOtE+wGWUreb36z7rn5uwGknBzjryETVmR6mrtUwHE6fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=gIY5fPrA; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="gIY5fPrA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=gsFOLbG7V80dZwqsFNZhbuEJATi7InTrokWZZf8tcJA=;
	b=gIY5fPrAqLlrv2E5KIG7g3KAB4Nyup2e78ZyMCDWrXIhQAX7stnzCs85kccrX0
	e06nAHGihLp3w5htgSq831Dc4SrAWNtaO569Tn2JHk0LXwlTFPDV1yAdSg5l63CH
	P7kq+iLrv7tVGXnNgWVkt2ZNJn9qa/Q6AnnIR0w6xOB/U=
Received: from [192.168.50.71] (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnFXIZotlplTr6Vw--.8824S2;
	Sat, 11 Apr 2026 09:21:31 +0800 (CST)
Message-ID: <df1d4fa0-13b3-4635-85c5-c1c2512c38ba@163.com>
Date: Sat, 11 Apr 2026 09:21:28 +0800
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
X-CM-TRANSID:QCgvCgAnFXIZotlplTr6Vw--.8824S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KrWkZFy8Wr4UCF1UXF1fJFb_yoW8KF1Dpa
	yY9w4fArW7Gr9xCa97J3Wjqry5Wan3XrW0yry3Gas3Zw13AFn3JF4vgF1FvF9F9rWFvr42
	vry3Zw1kCw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U0ZXwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwxyAJGnZohzAMAAA3F

Hi Bjorn,

May I ask if there's any chance for this series to be included in v7.1?

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

