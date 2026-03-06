Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E31281503;
	Fri,  6 Mar 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812321; cv=none; b=dRVAZE3NK0Is7z30mLxab+ACIXttTcI5X3jRGgZX1m/NZ2RByC3mxzLcL4f7g3XvBVuErUtOPlXrq0A/+ZT7yx5M1wwJbAhm/Ex3e+4o8BTNu2BkjTyhwrPrFjgio5sAa2K/nElM3Z7qSUSpFhTjY4esptOnJm3UWQxad2DGV0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812321; c=relaxed/simple;
	bh=QVAtJU32fI3hijyKBLjoH3GMdFQjjw5d7difJLTShhI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdBx/2MvPtTX2R/q2cAa220kXfL4dtk6fCoosnae5meDi0v9jWeEwLYxrelkdCHEPpzKWzdHt3ojHnGtUyfvit1CeA6Crze7fvMJszGZCgRceWRWT2gZV43dk10U84G0A6aUHKd19rFB4tdSnlyAEU3Ttv5fErwsdz4Qj8vNQQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HA6DQXeb; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HA6DQXeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=z1piXpiFHso3GGftRgQQooHaij0dQTWZjfWoc2FOYuc=;
	b=HA6DQXebmX82AC26V79kzT/UzLhiHVpv6hhXf/0TSWZCZJ2+y2Pm/AxFJqex8V
	1hKPWb7Xp931ZhM9K+8K0XGQesgS0bVet7fUyZGXTqkXonSJWpnfEoTx33fUCc2t
	KP5/MhnOrsm3ntlOXGRM/23buw0s2bS9TP121wvjnTTIE=
Received: from [IPV6:240e:b8f:927e:1000:3542:2c51:dbe0:7121] (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgAXltTi96ppp8cyQg--.6084S2;
	Fri, 06 Mar 2026 23:50:59 +0800 (CST)
Message-ID: <142343c7-2be5-4deb-8d47-42876a6df7f4@163.com>
Date: Fri, 6 Mar 2026 23:50:58 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v4 0/2] PCI: Introduce pci_clear/set_config_dword()
To: mahesh@linux.ibm.com, bhelgaas@google.com
Cc: oohall@gmail.com, mani@kernel.org, lukas@wunner.de,
 linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251101162219.12016-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251101162219.12016-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PCgvCgAXltTi96ppp8cyQg--.6084S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF4UJr45XryxJr1ftr1DJrb_yoW8Wry5pr
	Z3Ary3JrW7GFya9FW7GFy2ya45Wa1kJFWrJr17Kwn5Zw13Zry8ZF9agry5AF9rJrWrXw42
	grs2gFy8uw1qkFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRDrckUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCwwQ832mq9+QQ7gAA3K

Hi,

Gentle ping.

Best regards,
Hans

On 2025/11/2 00:22, Hans Zhang wrote:
> This series introduces auxiliary functions for the PCI configuration space
> and simplifies the read and write operations of the AER driver, reducing a
> lot of repetitive code.
> 
> Patch 1 adds pci_clear_config_dword() and pci_set_config_dword() helpers
> to reduce repetitive read-modify-write sequences when modifying PCI config
> space. These helpers improve code readability and maintainability.
> 
> Patch 2 refactors the PCIe AER driver to use these new helpers,
> eliminating manual read-modify-write patterns and intermediate variable
> in several functions. This results in cleaner and more concise code.
> 
> ---
> Changes for v4:
> - Introduce pci_clear/set_config_dword()
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20250816161743.340684-1-18255117159@163.com/
> 
> - Rebase to v6.17-rc1.
> - The patch commit message were modified.
> - Add Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> Changes for v2:
> - The patch commit message were modified.
> - New optimizations for the functions disable_ecrc_checking, aer_enable_irq, and aer_disable_irq have been added.
> ---
> 
> Hans Zhang (2):
>    PCI: Introduce pci_clear/set_config_dword()
>    PCI/AER: Use pci_clear/set_config_dword to simplify code
> 
>   drivers/pci/pcie/aer.c | 29 ++++++++++-------------------
>   include/linux/pci.h    | 12 ++++++++++++
>   2 files changed, 22 insertions(+), 19 deletions(-)
> 
> 
> base-commit: 8742b2d8935f476449ef37e263bc4da3295c7b58

