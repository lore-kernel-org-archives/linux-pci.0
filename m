Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72BC37E5E5;
	Thu, 20 Aug 2026 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239090; cv=none; b=kZkMxsM8oTACSQ0e9qyvXiSIozQx+spI/0rye/eZ1bf1Jw5a3vh3eSjuczDJcYPwn3SFFxQ0wvaF0Dj7sd/LODsjXsA8XAeBI0gVVWWr5GX41v+a+7mDbDuSeAFU7GKlV+dTv9gdE5vAYNeJyPwP0VylwCc6+rSN7gnbl5ij39M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239090; c=relaxed/simple;
	bh=cWpIAtyTCdPlakiXlW38UncZwFCKnczScJWBpx1E6I4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKpJyYY9rSha8en/GhZvFPlkjOF4sVZUNNRC8tqY+y0OTYJdk1p2E8Czxmp4zm0WKRAkM2n4mqFVqczdsaZKYjV+SJrDl6t+FgZu4RZnxbxo19hs9srgvlKSdRW6Hqp7edWLScn1y/UmQ8A2qq8ZC5TS76lMbVzWBranZw+/LQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jz7Yb4NV; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jz7Yb4NV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=hCBCfkhuylDswajnEAey0yhp/w2gaAIUfLfZkrqLJZI=;
	b=jz7Yb4NV2f4ape26Kp1GE/Cg4BTdXVJCyxo9NcOQCjfIZGGbmJazQ27Qg+bQ8E
	K9iqAp0NKgajM4aFMscqoafCMxBrzSFXaGCX0qxzW+EEXJDVnZ6q9s4aaPkyr85P
	DVveMqpuEMuJ7rSa8XEECERFA43Wfvq3V2lj4f80cLFVM=
Received: from [IPV6:240e:b8f:91b3:d000:fc9b:5f4:477a:dca5] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCHTa9jGodqjxLpQQ--.14990S2;
	Thu, 20 Aug 2026 23:16:52 +0800 (CST)
Message-ID: <a2f0c2d6-750e-4076-aae2-6efaba1009a1@163.com>
Date: Thu, 20 Aug 2026 23:16:50 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/16] PCI: dwc: Use cached PCIe capability offset in
 core
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 jingoohan1@gmail.com, imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, sophgo@lists.linux.dev,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260720150619.24733-1-18255117159@163.com>
 <20260720150619.24733-3-18255117159@163.com>
 <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <ps2qzgcb5lixkoqz2xbofdurkgmsiojg7e5ueqfdhyissqvzf2@tuderrjgzg6b>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCHTa9jGodqjxLpQQ--.14990S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF15GFy5tryfZw17uFy8Zrb_yoW8ur18p3
	yaqr4ayr4kZrW2vFWxJa1YqF10gF98trW3J3s3Kr15ZwsxCFWxJrW2yryYvF9rGrWqyr1F
	kF4UXryDur98AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRi2-OUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AQcv2qHGmR67gAA3M



On 8/13/26 14:06, Manivannan Sadhasivam wrote:
> On Mon, Jul 20, 2026 at 11:06:05PM +0800, Hans Zhang wrote:
>> Modify the DWC core functions to use the cached pcie_cap offset instead
>> of calling dw_pcie_find_capability() each time.
>>
>> In the DWC core, dw_pcie_find_capability() is called at several locations:
>> - dw_pcie_ep_init_non_sticky_registers()
>> - dw_pcie_wait_for_link()
>> - dw_pcie_link_set_max_speed()
>> - dw_pcie_link_get_max_link_width()
>> - dw_pcie_link_set_max_link_width()
>>
>> The cached offset is initialized after hardware is ready:
>> - In host mode: dw_pcie_host_init() calls pp->ops->host_init() (enables
>>    clocks/resets), then dw_pcie_get_pcie_cap() caches the offset.
>> - In endpoint mode: the core no longer caches automatically. Instead,
>>    drivers must call dw_pcie_get_pcie_cap() after hardware is enabled
>>    (e.g., after PERST# deassert).
> 
> But you didn't modify all DWC EP drivers to call dw_pcie_get_pcie_cap(). This
> can lead to pcie_cap being 0.
> 
>> dw_pcie_ep_init_non_sticky_registers()
>>    is called after that point, so it can safely use pci->pcie_cap.
>>
>> dw_pcie_ep_init_non_sticky_registers() now assumes pci->pcie_cap is
>> valid. if not, it prints a warning and skips the operation.
> 
> Where is this warning printed?
> 
> These are already pointed out by Sashiko. You should go really go through all of
> them (not the pre-existing issues) and comment whether the issues are valid or
> false positive. For a series touching many controller drivers, this is necessary
> to avoid introducing regressions.
> 
> I'm not going to merge this series until you fix the real issues Sashiko
> reported or mark them as false positive if not valid.

Hello Mani,

I'm truly sorry. Recently, due to work commitments, I haven't had any 
spare time. I plan to handle this series after v7.3-rc1 is released. 
Thank you very much for your reply. I will carefully consider the 
subsequent review comments regarding Sashiko. Thank you again.


Best regards,
Hans

> 
> - Mani
> 

