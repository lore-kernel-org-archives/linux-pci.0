Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6504E3AEF28;
	Thu,  9 Jul 2026 11:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783596552; cv=none; b=G37pENR2fJNdING6naYEfMvQ1ZNnwIBB2TlvfyIlegj65dD8S3eTnko+4DjqlT4VWj3VpAkfD5RuTEsWHuadiG24zHho5VXJiKIQsDtsdyLRmT9M2tNEoYE7MMSFpn3408clhKbjanEE9eaHU2kvQk5z9LXcsZgbfvi1lHuEOqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783596552; c=relaxed/simple;
	bh=dttovKsgdTALzqG14NOlTJ3K28IDuY7UhJ3GCItvNos=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PcLD/PgdUdV8OXUSsvCILy8Y0+XDXSgjJVlYkFwUzIImrE3jE+llJkmdrzhuHzx+QH186+0DnuGvOda34v1S7VaJoqE0RbhXULo/9b7qUv3s4MVyZ7wes1ADzLn0EZji6Fti+rchM3UAt7iFnfZLTk0rSWXX0TOrY9aCIGqIkwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y7E4zTJr; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y7E4zTJr"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=4rDJ1Q0UgWNKtTD6noBVDj+2dWCi8Wn40ibvakeVnc0=;
	b=y7E4zTJr8GBw6EksgRAIRaMttITa7ZdV3A7LYA6wbyOHo0E2hGOZ8pQmG16BwlOSdH64MLIp9
	DNi4bZ5jI16Kp+vMmB8VZ87U7sNysbTaGtsmuUdHIJaFjVrGN5klLfN/OQ5Kbk2xi+qTXZqwFQF
	bdXjdbxbfOfdDACQ7w7la4E=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gwsvX1vJyzpStn;
	Thu,  9 Jul 2026 19:20:24 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 5FD5B4057A;
	Thu,  9 Jul 2026 19:29:06 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 9 Jul 2026 19:29:05 +0800
Message-ID: <8c5c1be5-6ffa-4aef-a644-19f3be732bd0@huawei.com>
Date: Thu, 9 Jul 2026 19:29:05 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 10/18] vfio/pci: Introduce tph policy parameter for
 staged TPH feature enablement
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <helgaas@kernel.org>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-11-fengchengwen@huawei.com>
 <20260708173141.31aae027@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260708173141.31aae027@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Alex,

On 7/9/2026 7:31 AM, Alex Williamson wrote:
> On Thu, 2 Jul 2026 20:42:16 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add a module parameter 'tph' to implement staged TPH feature enabling
>> policy. The parameter accepts a value from 0 to 3 to progressively enable
>> TPH capabilities:
>>
>> 0 = No-ST mode: RESOLVE only returns PH for DMABUF source;
>>                 ST programming unavailable
>> 1 = Add IV mode: RESOLVE only returns PH for DMABUF source;
>>                  ST program supports NONE/DMABUF/CPU sources
>> 2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;
>>                  ST program supports NONE/DMABUF/CPU sources
>> 3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;
>>                  ST program supports NONE/DMABUF/CPU/LITERAL sources
>>
>> This commit only adds parameter plumbing and state storage, no
>> functional TPH logic is introduced yet.
> 
> This adds module options for a feature that doesn't exist yet.  That's
> the wrong ordering.  The module option is the only introspection that
> the administrator has to the capabilities of the driver.
> 
> The intention of the proposal was also that support is added
> incrementally, ie. "an incremental support path".
> 
> We should start with adding No-ST support to the driver, concluding
> with the module parameter infrastructure that essentially advertises
> the driver support on the host, 0 (default) is the only accepted value.
> 
> The next step would be incrementally revising the driver support to
> include IV mode, concluding with exposing it and configuring it through
> the driver option. Repeat for DS mode.  Repeat for LITERAL mode.
> 
> This is what allows us to decide where to stop in the implementation.
> For example, we've designed LITERAL mode, but if no VMM intends to
> support it, why implement it?
> 
> Also, this module option is being defined on vfio_pci.  Are we
> intending that this is a feature that each variant driver would
> opt-in to via their own module options?  LITERAL mode is incompatible
> with migration, so it's possible each variant driver would define what
> level of support they expose.  Thanks,

Thanks for the clear feedback on module parameter ordering and variant driver
concerns, I fully agree with your incremental implementation principle.

First about patch ordering: It’s wrong to add full 0~3 policy plumbing ahead
of corresponding functional logic, admins see param descriptions unmatched
with actual driver capability. I will reorganize the series into incremental
steps:
1. Initial patch only implements No-ST(policy=0), param limited to 0 with
   minimal MODULE_PARM_DESC only describing level 0;
2. Separate follow-up patches add IV, DS, Literal mode one by one, each
   extends param valid range and updates param description only after full
   policy logic lands;
If Literal mode turns out unnecessary for real VMM workloads later, we can
stop at policy=2 without dead code or unused param documentation.

Second, your question about variant drivers and migration conflict of Literal:
Variant drivers refer to different vfio-pci derivatives built on vfio-pci-core.
For this v7.3 version, we do not plan to support custom TPH policy control
inside vendor variant drivers, the global tph module param in vfio-pci is the
only official host-wide security baseline.
We explicitly mark level 3(Literal) breaks live migration in param desc, users
running migration workloads shall set tph <= 2.

I will drop this standalone module parameter patch and integrate param
plumbing into incremental feature implementation patches for v20.

Thanks

> 
> Alex
> 
>  
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci.c      | 25 +++++++++++++++++++++++++
>>  drivers/vfio/pci/vfio_pci_priv.h |  7 +++++++
>>  include/linux/vfio_pci_core.h    |  1 +
>>  3 files changed, 33 insertions(+)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 830369ff878d..7ef82b445722 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -60,6 +60,28 @@ static bool disable_denylist;
>>  module_param(disable_denylist, bool, 0444);
>>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>>  
>> +static unsigned int tph_policy;
>> +static int tph_set(const char *val, const struct kernel_param *kp)
>> +{
>> +	return param_set_uint_minmax(val, kp, VFIO_PCI_TPH_POLICY_NO_ST,
>> +				     VFIO_PCI_TPH_POLICY_LITERAL);
>> +}
>> +static const struct kernel_param_ops tph_param_ops = {
>> +	.set = tph_set,
>> +	.get = param_get_uint,
>> +};
>> +module_param_cb(tph, &tph_param_ops, &tph_policy, 0644);
>> +MODULE_PARM_DESC(tph,
>> +	"Global TPH policy level (0=default No-ST):\n"
>> +	"0 = No-ST mode: RESOLVE only returns PH for DMABUF source;\n"
>> +	"                ST programming unavailable\n"
>> +	"1 = Add IV mode: RESOLVE only returns PH for DMABUF source;\n"
>> +	"                 ST program supports NONE/DMABUF/CPU sources\n"
>> +	"2 = Add DS mode: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
>> +	"                 ST program supports NONE/DMABUF/CPU sources\n"
>> +	"3 = Add LITERAL: RESOLVE returns PH+ST for DMABUF/CPU sources;\n"
>> +	"                 ST program supports NONE/DMABUF/CPU/LITERAL sources\n");
>> +
>>  static bool vfio_pci_dev_in_denylist(struct pci_dev *pdev)
>>  {
>>  	switch (pdev->vendor) {
>> @@ -142,6 +164,9 @@ static int vfio_pci_init_dev(struct vfio_device *core_vdev)
>>  #ifdef CONFIG_VFIO_PCI_VGA
>>  	vdev->disable_vga = disable_vga;
>>  #endif
>> +#ifdef CONFIG_PCIE_TPH
>> +	vdev->tph_policy = tph_policy;
>> +#endif
>>  
>>  	return vfio_pci_core_init_dev(core_vdev);
>>  }
>> diff --git a/drivers/vfio/pci/vfio_pci_priv.h b/drivers/vfio/pci/vfio_pci_priv.h
>> index fca9d0dfac90..c997cc9bf330 100644
>> --- a/drivers/vfio/pci/vfio_pci_priv.h
>> +++ b/drivers/vfio/pci/vfio_pci_priv.h
>> @@ -11,6 +11,13 @@
>>  /* Cap maximum number of ioeventfds per device (arbitrary) */
>>  #define VFIO_PCI_IOEVENTFD_MAX		1000
>>  
>> +enum vfio_pci_tph_policy {
>> +	VFIO_PCI_TPH_POLICY_NO_ST = 0,
>> +	VFIO_PCI_TPH_POLICY_IV_ST = 1,
>> +	VFIO_PCI_TPH_POLICY_DS_ST = 2,
>> +	VFIO_PCI_TPH_POLICY_LITERAL = 3,
>> +};
>> +
>>  struct vfio_pci_ioeventfd {
>>  	struct list_head	next;
>>  	struct vfio_pci_core_device	*vdev;
>> diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
>> index 9a1674c152aa..a0641286dd90 100644
>> --- a/include/linux/vfio_pci_core.h
>> +++ b/include/linux/vfio_pci_core.h
>> @@ -149,6 +149,7 @@ struct vfio_pci_core_device {
>>  	struct notifier_block	nb;
>>  	struct rw_semaphore	memory_lock;
>>  	struct list_head	dmabufs;
>> +	u8			tph_policy;
>>  };
>>  
>>  enum vfio_pci_io_width {
> 

