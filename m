Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B3618A92F;
	Sat,  9 May 2026 03:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778297296; cv=none; b=lm8lAzAJNFAVpyHVO+tW1Nw7MBrov5OBVGVfswlmz+jnaRu31HfxZellvM5OLgljUNmcDHFstqbnTQJl2LZGytJnSltCN+fQGnMRb8g6roc/4W6fdQrFyxc4cR2vLBwPNcwv/kjM/QWAaIhp9bVQvddPWxSq/Kfi3HTXJgI1PE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778297296; c=relaxed/simple;
	bh=+g3LVpLAIYtG7MRn5pLcltFaa760xW206BEeENAcrqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bhoyMPtqbeO9D5jYuHEgpo6LV09vnPqjyx0xlVp94FE3hZEXb3ryax5e2muv03jMGHuX7+gzbp2h0B8E7jVUyjAiVbuPIOKwGxK5kOEALACTd+c6hlOiPnfKujskhZ+4XmbABPMSjt6L2PyMcovXW/59namRJsX5fS6z6kIj9H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3xqneVsJ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3xqneVsJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=8wsVxYBF+HbWZmM9SkeWkWH4YNIGWuIU3cJ+r0VuW+I=;
	b=3xqneVsJflRqVAbIiABUazmktjpEv1n12IxUL7ZKZfedAKRZcVlhArLwRS0J5gnDV0qXrRqa8
	2Ek/dtzZIsS8T7s8qwBPyPAJnlZomqgv5G30uux8IfC/hSbWzCqtFbbR52/eCY8mLp/Tc+62T6R
	9lDDfDnNH/KeuT7MigtrI8o=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gCB7x3qHgz1T4Hv;
	Sat,  9 May 2026 11:20:29 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
	by mail.maildlp.com (Postfix) with ESMTPS id D910040537;
	Sat,  9 May 2026 11:28:04 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 9 May 2026 11:28:04 +0800
Message-ID: <f1f11651-c86d-47a9-974c-da0b3d423657@huawei.com>
Date: Sat, 9 May 2026 11:28:03 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/7] vfio/pci: Add PCIe TPH interface with capability
 query
To: Alex Williamson <alex@shazbot.org>
CC: <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>, <helgaas@kernel.org>,
	<wei.huang2@amd.com>, <wangzhou1@hisilicon.com>, <wangyushan12@huawei.com>,
	<liuyonglong@huawei.com>, <kvm@vger.kernel.org>, <linux-pci@vger.kernel.org>
References: <20260508064053.37529-1-fengchengwen@huawei.com>
 <20260508064053.37529-5-fengchengwen@huawei.com>
 <20260508164003.70918c0c@shazbot.org>
Content-Language: en-US
From: fengchengwen <fengchengwen@huawei.com>
In-Reply-To: <20260508164003.70918c0c@shazbot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500009.china.huawei.com (7.202.194.94)

On 5/9/2026 6:40 AM, Alex Williamson wrote:
> On Fri, 8 May 2026 14:40:50 +0800
> Chengwen Feng <fengchengwen@huawei.com> wrote:
> 
>> Add VFIO_DEVICE_PCI_TPH IOCTL to allow userspace to query device TPH
>> capabilities, supported modes, and steering tag table information.
>>
>> Add module parameter 'enable_unsafe_tph_ds_mode' to restrict unsafe
>> device-specific TPH mode to trusted userspace only.
>>
>> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
>> ---
>>  drivers/vfio/pci/vfio_pci.c      |  13 ++-
>>  drivers/vfio/pci/vfio_pci_core.c |  56 ++++++++++++-
>>  include/linux/vfio_pci_core.h    |   3 +-
>>  include/uapi/linux/vfio.h        | 133 +++++++++++++++++++++++++++++++
>>  4 files changed, 202 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
>> index 0c771064c0b8..40bf5aa9fd0b 100644
>> --- a/drivers/vfio/pci/vfio_pci.c
>> +++ b/drivers/vfio/pci/vfio_pci.c
>> @@ -60,6 +60,12 @@ static bool disable_denylist;
>>  module_param(disable_denylist, bool, 0444);
>>  MODULE_PARM_DESC(disable_denylist, "Disable use of device denylist. Disabling the denylist allows binding to devices with known errata that may lead to exploitable stability or security issues when accessed by untrusted users.");
>>  
>> +#ifdef CONFIG_PCIE_TPH
>> +static bool enable_unsafe_tph_ds_mode;
>> +module_param(enable_unsafe_tph_ds_mode, bool, 0444);
>> +MODULE_PARM_DESC(enable_unsafe_tph_ds_mode, "Enable UNSAFE TPH device-specific (DS) mode. This mode provides weak isolation, cannot be safely used for virtual machines. If you do not know what this is for, step away. (default: false)");
>> +#endif
>> +
> 
> Why is the "unsafe" aspect of this keyed on mode rather than storage
> location?
> 
> Currently the user cannot enable TPH, the capability is read-only, but
> the user does have direct access to the MSI-X table.  We rely on an
> agreement that the user needs to use SET_IRQS to allocate host vectors
> and we use interrupt remapping as protection against abuse, but there's
> no mediation of STs written directly to the MSI-X table.  If the device
> supports IV mode with ST in the MSI-X table, nothing prevents the user
> from writing those ST entries directly to the MSI-X table.  Therefore
> doesn't it have the same security concern as DS mode?


Agree, from this perspective, even if it is in MSI-X table, it is still unsafe.
So TPH is unsafe as a whole, not just DS mode.

> 
> Further, config space lives in the device and various devices are known
> to have alternate means for accessing their config space.
> Virtualization of config space is more to present the device in the VM
> address space and bridge features between guest and host.  It's not
> great as a security barrier.
> 
> Maybe it's really neither the mode nor storage location, and we need to
> decide if TPH as a whole introduces any new security considerations.

I will adjust the module parameter to control TPH globally instead of only DS mode.

> It seems arguable whether we can actually prevent a device from
> including arbitrary STs on TLPs in any case and maybe we're really only
> exposing a curated programming interface.
> 
> ...
>> diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
>> index 5de618a3a5ee..81da2bd0c21b 100644
>> --- a/include/uapi/linux/vfio.h
>> +++ b/include/uapi/linux/vfio.h

...

>> +#define VFIO_DEVICE_PCI_TPH	_IO(VFIO_TYPE, VFIO_BASE + 22)
>> +
> 
> This seems like the wrong shape to me and introduces yet another ioctl
> multiplexer.  We already have that via the device feature interface.
> I'd propose this only needs one new DEVICE_FEATURE ioctl, TPH_ST.  The
> uAPI would look like:
> 
> struct vfio_device_feature_tph_st {
> 	__u32 flags;
> #define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
> 	__u16 index;
> 	__u16 count;
> 	__u32 data[]; /* host CPU# on SET, ST value on GET */
> }
> 
> The user can SET multiple STs at once that have the same mem_type
> (assuming that's a reasonable limitation).  On SET, each {cpu#,

Agree, using the same mem_type for a batch is a good idea.

Because it could set multiple index, so how about:

struct vfio_pci_tph_entry {
	__u32 cpu;
	__u16 val;	/* ST index on SET, ST value on GET */
	__u16 reserved;
}

struct vfio_device_feature_tph_st {
	__u32 op;
#define VFIO_TPH_OP_GET_ST	0
#define VFIO_TPH_OP_SET_ST	1
	__u32 flags;
#define VFIO_TPH_ST_MEM_TYPE_PM	(1 << 0)
	__u16 count;
	__u16 reserved1;
	struct vfio_pci_tph_entry ents[];
}

> mem_type} is translated to a host value and stored internally.  A GET

Should we store internally? How about writing directly to the device?

> returns that translated ST value for DS use cases.
> 
> The user can use PROBE to determine if this feature is available.
> 
> We already provide the TPH capability read-only in config space, we can
> use that rather than an explicit INFO/GET_CAP interface.

OK

> 
> When the feature is available, the TPH control register is virtualized.
> On enabling TPH via config space, vfio will store the translated ST
> values to the appropriate location, or none, and enable TPH.  On SET
> while already enabled, vfio will update both the internal table and the
> device location (or none).  Thanks,
> 
> Alex

