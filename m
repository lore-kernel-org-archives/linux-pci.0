Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6522F547F
	for <linux-pci@vger.kernel.org>; Wed,  4 Mar 2026 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772588109; cv=none; b=qL7p07L+rN5twBaeDuyjJLjR8mXiHdbNnTQpC+e6Ulut05bQrFtFnXZkOomby+j/QO9zkGkxZGAO8s4uJfF1KurUVcfMgVrVxg5VWnlpQ/1gCfEHFXnMxNuY7WztfTQ7EyZZwyKweTZ0lBPjFhZJxZvzFeCjHbYZVczSgDe15ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772588109; c=relaxed/simple;
	bh=eZsUsfkfv3VikK2/AIDEjYSqD+sqYbq1UqrebOuBzDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DmUexyCscOHYDe7o0MY1k0xywETgbGam7Lm/YW0tMOxeSChI5id+G4pPmGy2biVUYBRBQHwGRCNJzf3LwzNKSo0zuGfI9L3dD2h4sI9Mq30e+LUidyeICACzeW3rjUrxgALbtZP3lSxrXeo+/+vTUreBnnAuWsXU+NAFXSnawjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=S5uav+bN; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="S5uav+bN"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hPkYNfeM5LK89OppTUapoVKeWmmPL0MfPQnaMayVLtA=;
	b=S5uav+bNEIGANSFUU1tHrhh2S19K3899I9tlIq/lpY5I0KrKCVjQOE8SQLPgxnpQvGxUhs15d
	8uJDCjDRiY2oToy/AZHGjGLZmVfRlT9Bh3xFfW1g+6i4ZOxhtp3dF+3ZgEnnXdOnlVg/0bWU3Ib
	UrDfm+KI5zixwLzyNLT9dlY=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fQZpy493wz1prmg;
	Wed,  4 Mar 2026 09:30:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D292740569;
	Wed,  4 Mar 2026 09:34:55 +0800 (CST)
Received: from [10.67.112.40] (10.67.112.40) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Mar
 2026 09:34:55 +0800
Message-ID: <b35698a4-4ac0-4db4-86a0-db794047e7c4@huawei.com>
Date: Wed, 4 Mar 2026 09:34:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
To: Bjorn Helgaas <helgaas@kernel.org>, Paul Menzel <pmenzel@molgen.mpg.de>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
References: <20260303215558.GA4076158@bhelgaas>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20260303215558.GA4076158@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2026/3/4 5:55, Bjorn Helgaas wrote:
> [+cc Yunsheng, author of ad5086108b9f,
> +bcc commenters on https://bugzilla.kernel.org/show_bug.cgi?id=218951,
> see the email thread at
> https://lore.kernel.org/all/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]
> 
> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
>> Dear Linux folks,
>>
>> On the servers below Linux warns:
>>
>>      Unknown NUMA node; performance will be reduced
>>
>> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0
>> 05/14/2021
>> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5
>> 09/06/2016
>> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4
>> 11/08/2016
>> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0
>> 08/29/2013
>> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1
>> 01/02/2020
>> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4
>> 08/17/2017
>> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4
>> 10/04/2015
>> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0
>> 12/23/2019
>> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5
>> 04/13/2016
>> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022
> 
> Similar reports in the bugzilla for:
> 
>   Host: VMware VM Ubuntu 24.04.1
>   CPU: Intel(R) Xeon(R) Silver 4310 CPU @ 2.10GHz
>   Kernel: 6.11.0-rc6
> 
> and 
> 
>   Lenovo P700 workstation
>   6.19.5 kernel
> 
> ad5086108b9f ("PCI: Warn if no host bridge NUMA node info") added this
> "Unknown NUMA node; performance will be reduced" warning.
> 
> The problem is that firmware didn't tell us anything about which CPUs
> are closest to this PCI host bridge, so we can't try to optimize by
> running the driver on a CPU that's close to the device.
> 
> The kernel can't figure out this locality information itself, so
> there's nothing we can really do in the kernel, and there's nothing
> users can do either other than check for BIOS updates.
> 
> What if we just downgraded the message to "info"?  And/or we could
> reword this to be less alarming.

If I recalled it correctly, the purpose of the above warning is about
having some kind of pressure for vendor to update the BIOS and fix
that, perhaps the warning can be reworded to something like below
so that users can know where they get the help to fix that?

"Unknown NUMA node; performance will be reduced, please check it with
the BIOS vendor."

> 
> I guess we could even drop the message altogether and assume that
> vendors will provide the locality information if there's any
> meaningful performance benefit.  It could be that it really doesn't
> matter where drivers run on these machines, so there's no benefit to
> providing the locality information.
> 
> Bjorn
> 
