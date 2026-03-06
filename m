Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B673D33F581;
	Fri,  6 Mar 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812125; cv=none; b=ANoISC3ohujlMgG+/kTlLHx7A5pvfTefsSkoqHCvJJQ+8fRIouTeNB0nNbBisVy3QILCwG2Ga5JlTz+F02f1qVB0rIGI1wvwUHZ10KVx+GwmTXZfxenIWV2tc28NW4nDpqBu/pbQntaPIWNedUC223Hnhrapbi+HQf8Rs/6H9OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812125; c=relaxed/simple;
	bh=NrPqJsvZ3LD8pr8ycv5loNTcp4o72ucMHrYcQU+RyC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SyGlYHrC1I7rhZmFvfeUlXZYdkurpxhlZs0mk4GxfH566IkwVvvRSimGa1VDOfTYzAtS+XgDqbC3al2meCSSNwCElBanTjM4+uK19lA4meRm9/tRFOpKU9pl4WegOaJUlixKa9mJXrVaONQqYVSEMx/rYtakXjobFSuuvJ3UjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RP/zq+TU; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RP/zq+TU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=0bMJsDC1jTMA/bRZ8IOj99a37a8NHcIxgkzTYf0oGOw=;
	b=RP/zq+TUwClKRzE2WG+V7gWU5kEGbKvd7mvxaihkawfVIJeJs8cpxtbtgr8RI/
	FMCK1hBmGrTAVyC9sEmbWiy7uj3/ZwrM3XdSHOhRJjkeevUsteEOIHw78AVMDSE+
	0fVE8pqHiBxqw77isAk+U2XCNouJAfMi01neGY/9c42jU=
Received: from [IPV6:240e:b8f:927e:1000:3542:2c51:dbe0:7121] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wBXAPMf96ppEcQDOQ--.755S2;
	Fri, 06 Mar 2026 23:47:44 +0800 (CST)
Message-ID: <e8803d3a-e6d5-4626-87ec-228cdf8b0fb5@163.com>
Date: Fri, 6 Mar 2026 23:47:43 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] PCI: of: Remove max-link-speed generation
 validation
To: bhelgaas@google.com, helgaas@kernel.org
Cc: mani@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251218132036.308094-1-18255117159@163.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20251218132036.308094-1-18255117159@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wBXAPMf96ppEcQDOQ--.755S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCw1UXr48Cr48ZF4UuryrtFb_yoW5Ar4kpF
	WjyryrurW8Wr4fWw4DGa1UZFyjg3Z3WrWktr4rGwnrZw13JF1aqFySgF1YvFnF9FZ5CF47
	Z3W2qa17G34jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRxMa5UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbCxAELrmmq9yGSfQAA3a

Hi,

Gentle ping.

Best regards,
Hans

On 2025/12/18 21:20, Hans Zhang wrote:
> The current implementation of of_pci_get_max_link_speed() validates
> max-link-speed property values to be in the range 1~4 (Gen1~Gen4).
> However, this creates maintenance overhead as each new PCIe generation
> requires updating this validation logic.
> 
> Since device tree binding validation already enforces the allowed
> values through the schema, and the callers of this function perform
> their own validation checks, this intermediate validation becomes
> redundant.
> 
> Furthermore, with upcoming SOCs using Synopsys/Cadence IP requiring
> Gen5/Gen6 support, removing this hardcoded check enables seamless
> support for future PCIe generations without requiring kernel updates
> for each new speed grade.
> 
> Remove the max-link-speed > 4 validation check while retaining the
> property existence and non-zero check. This simplifies maintenance
> and aligns with the existing validation architecture where DT binding
> and driver-level checks provide sufficient validation.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
> Changes for v6:
> - It'd be good to return the actual errno as of_property_read_u32() can return
>    -EINVAL, -ENODATA and -EOVERFLOW. (Mani)
> 
> Changes for v5:
> https://patchwork.kernel.org/project/linux-pci/patch/20251218125909.305300-1-18255117159@163.com/
> 
> - Delete the check for speed. (Mani)
> 
> Changes for v4:
> https://patchwork.kernel.org/project/linux-pci/patch/20251105134701.182795-1-18255117159@163.com/
> 
> - Add pcie_max_supported_link_speed.(Ilpo)
> 
> Changes for v3:
> https://patchwork.kernel.org/project/linux-pci/patch/20251101164132.14145-1-18255117159@163.com/
> 
> - Modify the commit message.
> - Add Reviewed-by tag.
> 
> Changes for v2:
> https://patchwork.kernel.org/project/linux-pci/cover/20250529021026.475861-1-18255117159@163.com/
> - The following files have been deleted:
>    Documentation/devicetree/bindings/pci/pci.txt
> 
>    Update to this file again:
>    dtschema/schemas/pci/pci-bus-common.yaml
> ---
>   drivers/pci/of.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 3579265f1198..b56fdbcb3d72 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -888,10 +888,11 @@ bool of_pci_supply_present(struct device_node *np)
>   int of_pci_get_max_link_speed(struct device_node *node)
>   {
>   	u32 max_link_speed;
> +	int ret;
>   
> -	if (of_property_read_u32(node, "max-link-speed", &max_link_speed) ||
> -	    max_link_speed == 0 || max_link_speed > 4)
> -		return -EINVAL;
> +	ret = of_property_read_u32(node, "max-link-speed", &max_link_speed);
> +	if (ret)
> +		return ret;
>   
>   	return max_link_speed;
>   }

