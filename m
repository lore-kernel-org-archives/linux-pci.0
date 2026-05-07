Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564863C6A43;
	Thu,  7 May 2026 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778165330; cv=none; b=IuWaKgUDoABO4tjSemzFU05S0VDsNYeUaZwoo8gVEhOvHE8XwzWe4KKp31+vdEwqZnTAH60caAJU7dYgZy0sV3B1vSotLUvpd3YaCvS4++5C67Y/78SgbUGv2mwKc4CuiDdJO+/Sw5/uOpnXRiFfRfRabwwEc5CCJ/pEPXNQpkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778165330; c=relaxed/simple;
	bh=mAnZeudFZDCOP3cJqoGPtLyUBm7fmF2BfW+v9MBNZoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzaN02niuZwC040MlRasC4Yi0omzZJZQQ5O7ZS2uZN8PAxmLYN8zlj7c3DrQL90b3dN7J27wRNlIG37D4o1OkbgN8BOdjeVZJnHbWjg5Thgem+yDxfyC1PeYo4tZYdsCDejpaG22BQVVBSxPye6zcXXlx7DvNNjCoBNjeyTVgu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QIEELKKv; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QIEELKKv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=KjhKx2J06APKtxFuNWiKeBEj4SQNQ/II0at4VGGiHnA=;
	b=QIEELKKvbLVVsk0ss3zOat2V6Yd92mlMmIEYH3TQjj4XqJX03NkbgBzGeaeV9N
	VlJVCegy9NOZQPki9TOKdAC5Q24IqT8gyq0ydKV4JZYSHfc3YV0yhYC/b7urQmDn
	gE6AjSwYonrc7idotl7JmQTWSaU1wJEfhD1bsbr8gZ55I=
Received: from [192.168.71.11] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCHOqEbpvxpmYUECw--.3259S2;
	Thu, 07 May 2026 22:47:55 +0800 (CST)
Message-ID: <265a2718-053c-46c2-994c-706b9437b48f@163.com>
Date: Thu, 7 May 2026 22:47:54 +0800
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
X-CM-TRANSID:PCgvCgCHOqEbpvxpmYUECw--.3259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF43ur15CFWxZFWDWryUZFb_yoW8Kr15pa
	yYvw4fArW7G3sxCa97G3Wjqry5Wan3XrW0yry3Gas3Zw13AFn3JF4vgF1FvF9rArWFvr42
	vry7Zw1kCw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UkEfOUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwx1K7Wn8ph00MAAA3T

Hi Bjorn,

Gentle ping.

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

