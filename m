Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4699372EC0;
	Sun, 29 Mar 2026 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774795734; cv=none; b=hzg3WxQb3wDw3WoWmDzkZZy2pruo6RvpdnMk3EzApZc9JO5vsN5W5HddiQ3l4FoSJZTt2n8iZNO5fJ7oC+bRz8AskfQoE/ibSK2WMpS19WR8jufMXaueCK/fnPZ6J/eGfY+fV8Z6cq58lEdCAveP6RimR3qKCRtEnQ8XFDwD324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774795734; c=relaxed/simple;
	bh=WpuLa+iR+7dPc/R2n3OibyMBDZqIk4vAA9bHtGje/bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/X+E0ssuz4UD2yNwOkGAesXEasp1YQCYcIq/YBKx3VbR2Xh5Lj+PMAf2drKHqStL+dzNntWpaJnPFpfj94uOcdKj+mjr8uXsIUuvd1w8B5IgdMxLB8jbC7gD4EZQpub/ioOGy8dT205fo9ulKysIwGoqbFeOTiG5EPViEZrJOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=F7yvNXzL; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="F7yvNXzL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=6D55HdNBFgogkbxZ9B6R/xFqNQaywSSEdDJEMT48Flw=;
	b=F7yvNXzLWcYYggmho/921Cdsj6BQqjQJgBSJHBEj4Vw9puKVQlnetagQ5l37K3
	8ux/HqhEJB2aARWpwEBywajYM6gLq9/+4k1oxuO6opefsdSeHpQCrA3AzY1QeNfG
	Klrgdk9QPyY/3nPqdQs2t6q70aBKgd0j18K2DHtpBNzRQ=
Received: from [192.168.50.71] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCnr9J+O8lpUdKTCA--.51946S2;
	Sun, 29 Mar 2026 22:47:27 +0800 (CST)
Message-ID: <fbff8f2a-f4a9-4e06-b5ae-cfb554e73664@163.com>
Date: Sun, 29 Mar 2026 22:47:26 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] PCI: of: Remove max-link-speed generation
 validation
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, florian.fainelli@broadcom.com,
 jim2101024@gmail.com, robh@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, claudiu.beznea.uj@bp.renesas.com,
 linux-mediatek@lists.infradead.org, linux-tegra@vger.kernel.org,
 linux-omap@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 shawn.lin@rock-chips.com
References: <20260327164250.GA1513325@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20260327164250.GA1513325@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wCnr9J+O8lpUdKTCA--.51946S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFyDCr18WF1UtFyfJr4rGrg_yoW5WrWDpa
	y2kF40vry0qr43Xr4DX3W5Z3WYq3ZxurWjyryFg3s7Z3ZxCrsxXFyIvayFqF9Ikrsxury2
	qF12qF4akFW7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U7fHbUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbC7AC7X2nJO4BGqwAA3+



On 3/28/26 00:42, Bjorn Helgaas wrote:
> On Sat, Mar 14, 2026 at 12:55:17AM +0800, Hans Zhang wrote:
>> Hi,
>>
>> This series moves the validation from the common OF function to the
>> individual PCIe controller drivers.  To protect against out-of-bounds
>> accesses to the pcie_link_speed[] array, we first introduce a helper
>> function pcie_get_link_speed() that safely returns the speed value
>> (or PCI_SPEED_UNKNOWN) for a given generation number.
>>
>> Then all direct uses of pcie_link_speed[] as an array are converted to
>> use the new helper, ensuring that even if an invalid generation number
>> reaches those code paths, no out-of-bounds access occurs.
>>
>> For several drivers that read the "max-link-speed" property
>> (pci-j721e, brcmstb, mediatek-gen3, rzg3s-host), we add an explicit
>> validation step: if the value is missing, out of range, or unsupported
>> by the hardware, a safe default is used (usually Gen2). Other drivers
>> (mainly DesignWare glue drivers) rely on the helper to safely handle
>> invalid values, but do not yet include fallback logic or warnings.
>>
>> Finally, the range check is removed from of_pci_get_max_link_speed(),
>> so that future PCIe generations can be supported without modifying
>> drivers/pci/of.c.
> 
> Thanks for this series.
> 
> We still have a couple references to pcie_link_speed[] that bypass
> pcie_get_link_speed().  These are safe because PCI_EXP_LNKSTA_CLS is
> 0xf and pcie_link_speed[] is size 16, but I'm not sure the direct
> reference is necessary.
> 
> The array itself is exported, which I suppose we needed for modular
> PCI controller drivers, but we probably don't need it now that
> pcie_get_link_speed() is exported?
> 
>    $ git grep "\<pcie_link_speed\>"
>    drivers/pci/pci-sysfs.c:        speed = pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
>    drivers/pci/pci.c:      return pcie_link_speed[FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)];
>    drivers/pci/pci.h:extern const unsigned char pcie_link_speed[];
>    drivers/pci/pci.h:      bus->cur_bus_speed = pcie_link_speed[linksta & PCI_EXP_LNKSTA_CLS];
>    drivers/pci/probe.c:const unsigned char pcie_link_speed[] = {
>    drivers/pci/probe.c:EXPORT_SYMBOL_GPL(pcie_link_speed);
>    drivers/pci/probe.c:    if (speed >= ARRAY_SIZE(pcie_link_speed))
>    drivers/pci/probe.c:    return pcie_link_speed[speed];
>    drivers/pci/probe.c:            bus->max_bus_speed = pcie_link_speed[linkcap & PCI_EXP_LNKCAP_SLS];

Hi Bjorn,

Yes, I also realized that this array is directly used in other places. 
So I submitted this series and I would appreciate it if you could review 
it to ensure its correctness.

See also this series:
https://patchwork.kernel.org/project/linux-pci/patch/20260315160057.127639-1-18255117159@163.com/

Best regards,
Hans

