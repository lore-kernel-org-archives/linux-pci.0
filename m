Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E3723E229;
	Thu,  5 Mar 2026 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772674190; cv=none; b=Vl4QQersQSvdMxnDrcxK53lvhmZp0dOIIFqswO++XrDuHVTHP8rmINzfjNutrP1g+LSHe+P+cep8lY887ne8ahlL3PNi0ZCvK7fi5RrkS4Vqfx0gaxcieaS3ElE3dtLTi3+IgIkQQgv1zOs9kqSA3+GnWnrEaq8CtKe1KQX/qGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772674190; c=relaxed/simple;
	bh=wNhGnIYc9cePUyQH4swsUs0Q4ojWwoAx7bxtPJGnlDE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OIPaj66FOgryoukr2C0ET88/5SllMzeI51aev4b2et+56GnZ6m1L3PYp91QcgXEfSSbTJQwC/Y+OV0XiohuZUG8z+Q0xyquHO1xy4aqugUUfmJYht14wqW6uzUyTUDZPkZkzlqDYSzwyzbm24bkBNIj3KelatVkBmypZ75mab4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=xWpdCZOP; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="xWpdCZOP"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=x/94umT6jqubIgKZ9WK2NkT5vhgX2G5p0Y8h1EIosRY=;
	b=xWpdCZOPYTyA4lOwESvAGfHrz6mVdAAijLzUwB9EqUSrFAl8eqpVV8eGQE86kysoJSDhrW4eW
	kEeXCi/adJr6Y4H0DAYgxKKjMSbblE+nb8o7VOVVs2DRe4WTX/IAkp9FybxWHBTgDSyOw1VFHIB
	RnvrTQ8HClj8l5BAolVnT8c=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4fRBfQ5BL3zKmVb;
	Thu,  5 Mar 2026 09:24:46 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D6ECA40565;
	Thu,  5 Mar 2026 09:29:38 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 09:29:38 +0800
Message-ID: <092b53f0-98b5-438c-8da9-f7d9bbd747be@huawei.com>
Date: Thu, 5 Mar 2026 09:29:36 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Remove warning about host bridge on unknown NUMA
 node
To: Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC: Paul Menzel <pmenzel@molgen.mpg.de>, <linux-kernel@vger.kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
References: <20260305002128.51147-1-bhelgaas@google.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20260305002128.51147-1-bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2026/3/5 8:21, Bjorn Helgaas wrote:
> ad5086108b9f ("PCI: Warn if no host bridge NUMA node info") added warnings
> like this when there are multiple NUMA nodes and we discover a PCI host
> bridge where no node is specified, e.g., there's no ACPI _PXM method or DT
> "numa-node-id" property:
> 
>   pci_bus 0000:ff: Unknown NUMA node; performance will be reduced
> 
> The hope was that the message would encourage vendors to add NUMA node
> information to their firmware or DTs, but that hasn't happened.  The
> message just leads to bug reports that we can't do anything about.
> 
> In some cases BIOS has _PXM methods for some bridges but not others, which
> suggests that the vendor thinks node information isn't useful to the OS,
> e.g., maybe there are no real devices below the bridge.
> 
> Remove the warning message when the NUMA node is unknown.  If it is known,
> include it in an existing message:
> 
>   PCI host bridge to bus 0000:00 NUMA node 0

LGTM.
Reviewed-by: Yunsheng Lin <linyunsheng@huawei.com>

> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218951
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/probe.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index bccc7a4bdd79..e3e81926a6f3 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -993,9 +993,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	LIST_HEAD(resources);
>  	struct resource *res, *next_res;
>  	bool bus_registered = false;
> -	char addr[64], *fmt;
> +	char numa[32], addr[64], *fmt;
>  	const char *name;
> -	int err;
> +	int err, node;
>  
>  	bus = pci_alloc_bus(NULL);
>  	if (!bus)
> @@ -1071,13 +1071,17 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	/* Create legacy_io and legacy_mem files for this bus */
>  	pci_create_legacy_files(bus);
>  
> +	numa[0] = '\0';
> +	if (nr_node_ids > 1) {
> +		node = pcibus_to_node(bus);
> +		if (node != NUMA_NO_NODE)
> +			snprintf(numa, sizeof(numa), " on NUMA node %u", node);
> +	}
> +
>  	if (parent)
> -		dev_info(parent, "PCI host bridge to bus %s\n", name);
> +		dev_info(parent, "PCI host bridge to bus %s%s\n", name, numa);
>  	else
> -		pr_info("PCI host bridge to bus %s\n", name);
> -
> -	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> -		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
> +		pr_info("PCI host bridge to bus %s%s\n", name, numa);
>  
>  	/* Check if the boot configuration by FW needs to be preserved */
>  	bridge->preserve_config = pci_preserve_config(bridge);
