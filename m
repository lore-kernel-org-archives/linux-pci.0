Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31801301486;
	Wed, 24 Jun 2026 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782269558; cv=none; b=VJ6s/CxM8z173sQxNbFbp39YpLWGqoAUAyEuyU9XqSyb0LvWGaKhCjW8xNYGzaZg1YxVTfcHOQAFe2fL3U9YgB/rsZq767j+ibwiVUXH+pa7UA+Rsp7IW1x5X9bZG+egx554bfUL5xA3sRw/D9J6BB+K9sNAzCAn3k9Z4YDYFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782269558; c=relaxed/simple;
	bh=+pkhtZV7cHzdY4xfBVsajdjncVSStDB/8DfZ41vmzoE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=JcYs2vUX2ySibWX+E4vbSEF79S8sjVOBt8GfgCbD6Bnf/GagogdqvH+XMCfjhtcFdiAuBuUUhrTBoMt1m71eDxB1k0RYWAA7L7B+ELAowHoFAevfBS080Y8H1e741Cr/VLrK2Q8lZhv3x45ShzLkhb0/h2ugUBAfepGvv3xWdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EwyDqY7h; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=EwyDqY7h; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EwyDqY7h";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="EwyDqY7h"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tuPEYKAXHwnOctxscMp832TkPnAowrsg0yfEBTwY/RU=;
	b=EwyDqY7hnpVdF6ZE6PVG+oYnWKF+6uCV2mIalot3SLum9yVTsGl2E/lsCunCnDfecCUis+ze3
	sGT555OaXBd3xXVQNGf/enN+VliEirbdV20YohTGPaNl3vENv1+dHNBpQA4q7BABUKKNulduOF/
	TdtPHX6rAmf/AOquUs/8j2I=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4glRKQ68Bsz1BFn9;
	Wed, 24 Jun 2026 10:51:38 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=tuPEYKAXHwnOctxscMp832TkPnAowrsg0yfEBTwY/RU=;
	b=EwyDqY7hnpVdF6ZE6PVG+oYnWKF+6uCV2mIalot3SLum9yVTsGl2E/lsCunCnDfecCUis+ze3
	sGT555OaXBd3xXVQNGf/enN+VliEirbdV20YohTGPaNl3vENv1+dHNBpQA4q7BABUKKNulduOF/
	TdtPHX6rAmf/AOquUs/8j2I=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4glR7z0qqPz1T4LR;
	Wed, 24 Jun 2026 10:43:27 +0800 (CST)
Received: from kwepemo500009.china.huawei.com (unknown [7.202.194.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 89D0340569;
	Wed, 24 Jun 2026 10:52:07 +0800 (CST)
Received: from [10.67.121.161] (10.67.121.161) by
 kwepemo500009.china.huawei.com (7.202.194.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 24 Jun 2026 10:52:06 +0800
Message-ID: <3a8a248a-3b4e-48ce-843e-b5d5052ef72a@huawei.com>
Date: Wed, 24 Jun 2026 10:52:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v18 08/12] PCI/TPH: Add sysfs binary file to export
 CPU to steering-tag mapping
From: fengchengwen <fengchengwen@huawei.com>
To: <helgaas@kernel.org>
CC: <alex@shazbot.org>, <jgg@ziepe.ca>, <wathsala.vithanage@arm.com>,
	<wei.huang2@amd.com>, <zhipingz@meta.com>, <wangzhou1@hisilicon.com>,
	<wangyushan12@huawei.com>, <liuyonglong@huawei.com>, <kvm@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-9-fengchengwen@huawei.com>
Content-Language: en-US
In-Reply-To: <20260623085048.51139-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemo500009.china.huawei.com (7.202.194.199)

Hi Bjorn,

This v18 patch adds a read-only sysfs binary attribute tph_cpu_st on PCIe
Root Ports to expose ACPI DSM CPU-to-TPH steering tag mappings to userspace.

All prior review feedback from Alex has been fully addressed, including
unaligned partial read support, zero-filled sparse CPU entries, cleaner
struct initialization, soft lockup mitigation via cond_resched(), full
ABI docs, and dynamic file visibility filtering.

Two implementation options exist for this CPU-to-ST mapping interface:
- The current patch: sysfs binattr entirely implemented inside the PCI
  subsystem with dedicated uapi definitions.
- Alternative: A VFIO_DEVICE_FEATURE for on-demand ST entry queries.

Jason previously commented that the community generally discourages new
binary array sysfs attributes, which is the core concern around this ABI
design. Full prior discussion can be found [1]

Since this sysfs implementation is self-contained within PCI subsystem
code, I'd like to ask your opinion Bjorn: do you accept this binary blob
sysfs interface for the PCI tree?

[1] https://lore.kernel.org/linux-pci/20260616144224.GB3577091@ziepe.ca/

Thanks

On 6/23/2026 4:50 PM, Chengwen Feng wrote:
> Add per-Root-Port-only sysfs binary attribute tph_cpu_st to expose ACPI
> DSM CPU-to-ST mapping to userspace, addressing concerns that VFIO should
> not host CPU steering tag translation interfaces.
> 
> ABI: /sys/bus/pci/devices/<root-port-bdf>/tph_cpu_st
> - Read-only root-only (0400) binary blob;
> - Each entry is packed 8-byte struct pci_tph_cpu_st defined in uapi/pci.h;
> - Support arbitrary offset partial read/sub-field extraction;
> - Non-present/impossible CPUs return zero-filled entries to avoid
>   sequential read abort on sparse CPU topology;
> - Insert cond_resched() in read loop to avoid soft lockup when dumping full
>   blob.
> 
> Dynamic visibility rules enforced via is_bin_visible:
> 1. Only expose file on PCIe Root Port devices, hide on all endpoints;
> 2. Root Port must implement TPH Completer capability in DevCap2;
> 3. Platform must provide valid ACPI DSM for CPU-to-ST mapping.
> 
> Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci |  24 ++++
>  drivers/pci/pci-sysfs.c                 |   3 +
>  drivers/pci/pci.h                       |   4 +
>  drivers/pci/tph.c                       | 151 +++++++++++++++++++++---
>  include/uapi/linux/pci.h                |  16 +++
>  5 files changed, 183 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index b767db2c52cb..edc64e4e5640 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -702,3 +702,27 @@ Description:
>  		When present and the tsm/ attribute directory is present, the
>  		authenticated attribute is an alias for the device 'connect'
>  		state. See the 'tsm/connect' attribute for more details.
> +
> +What:		/sys/bus/pci/devices/<root-port-bdf>/tph_cpu_st
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		Read-only binary attribute only exposed on PCIe Root Ports that
> +		support TPH Completer capability and implement the ACPI DSM
> +		method for CPU-to-ST mapping. File permission is root-only
> +		(0400).
> +
> +		The blob is a sequence of fixed-size 8-byte entries defined by
> +		struct pci_tph_cpu_st in uapi/linux/pci.h:
> +		  __u8 vm_st;
> +		  __u8 pm_st;
> +		  __u16 vm_xst;
> +		  __u16 pm_xst;
> +		  __u16 reserved;
> +
> +		Each entry corresponds to a logical CPU index. Seek offset =
> +		cpu_id * PCI_TPH_CPU_ST_ENTRY_SZ. Arbitrary unaligned partial
> +		reads are supported; no alignment restriction enforced.
> +
> +		For CPUs outside cpu_possible_mask or offline CPUs, the entry
> +		is filled with all zeros to avoid breaking sequential dump tools
> +		like cat/hexdump on sparse CPU topologies.
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5ec0b245a69b..b28732bd1554 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1911,6 +1911,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #ifdef CONFIG_PCI_TSM
>  	&pci_tsm_auth_attr_group,
>  	&pci_tsm_attr_group,
> +#endif
> +#ifdef CONFIG_PCIE_TPH
> +	&pcie_tph_cpu_st_attr_group,
>  #endif
>  	NULL,
>  };
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4469e1a77f3c..5d28bec94add 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1366,6 +1366,10 @@ static inline pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
>  extern const struct attribute_group aspm_ctrl_attr_group;
>  #endif
>  
> +#ifdef CONFIG_PCIE_TPH
> +extern const struct attribute_group pcie_tph_cpu_st_attr_group;
> +#endif
> +
>  #ifdef CONFIG_X86_INTEL_MID
>  bool pci_use_mid_pm(void);
>  int mid_pci_set_power_state(struct pci_dev *pdev, pci_power_t state);
> diff --git a/drivers/pci/tph.c b/drivers/pci/tph.c
> index c080cf5401a3..bb6f24eccafc 100644
> --- a/drivers/pci/tph.c
> +++ b/drivers/pci/tph.c
> @@ -11,6 +11,7 @@
>  #include <linux/msi.h>
>  #include <linux/bitfield.h>
>  #include <linux/pci-tph.h>
> +#include <linux/sched.h>
>  
>  #include "pci.h"
>  
> @@ -130,8 +131,47 @@ static acpi_status tph_invoke_dsm(acpi_handle handle, u32 cpu_uid,
>  
>  	return AE_OK;
>  }
> +
> +static int tph_get_cpu_st_info(struct pci_dev *pdev, unsigned int cpu,
> +			       union st_info *info)
> +{
> +	acpi_handle rp_acpi_handle;
> +	struct pci_dev *rp;
> +	u32 cpu_uid;
> +	int ret;
> +
> +	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +	if (ret != 0)
> +		return ret;
> +
> +	rp = pcie_find_root_port(pdev);
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return -ENODEV;
> +
> +	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> +	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, info) != AE_OK)
> +		return -EINVAL;
> +
> +	return 0;
> +}
>  #endif
>  
> +static bool tph_dsm_supported(struct pci_dev *pdev)
> +{
> +#ifdef CONFIG_ACPI
> +	struct pci_dev *rp = pcie_find_root_port(pdev);
> +	acpi_handle rp_acpi_handle;
> +
> +	if (!rp || !rp->bus || !rp->bus->bridge)
> +		return false;
> +
> +	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> +	return acpi_check_dsm(rp_acpi_handle, &pci_acpi_dsm_guid, 7,
> +			      BIT(TPH_ST_DSM_FUNC_INDEX));
> +#endif
> +	return false;
> +}
> +
>  /* Update the TPH Requester Enable field of TPH Control Register */
>  static void set_ctrl_reg_req_en(struct pci_dev *pdev, u8 req_type)
>  {
> @@ -230,31 +270,37 @@ static int write_tag_to_st_table(struct pci_dev *pdev, int index, u16 tag)
>  	return pci_write_config_word(pdev, offset, tag);
>  }
>  
> +static int get_cpu_all_st(struct pci_dev *pdev, unsigned int cpu,
> +			   struct pci_tph_cpu_st *st)
> +{
> +#ifdef CONFIG_ACPI
> +	union st_info info;
> +	int ret;
> +
> +	ret = tph_get_cpu_st_info(pdev, cpu, &info);
> +	if (ret == 0) {
> +		st->vm_st = info.vm_st_valid ? info.vm_st : 0;
> +		st->pm_st = info.pm_st_valid ? info.pm_st : 0;
> +		st->vm_xst = info.vm_xst_valid ? info.vm_xst : 0;
> +		st->pm_xst = info.pm_xst_valid ? info.pm_xst : 0;
> +	}
> +
> +	return ret;
> +#endif
> +	return -ENODEV;
> +}
> +
>  static int get_cpu_st(struct pci_dev *pdev, enum tph_mem_type mem_type,
>  		      u8 req_type, unsigned int cpu, u16 *tag)
>  {
>  #ifdef CONFIG_ACPI
> -	struct pci_dev *rp;
> -	acpi_handle rp_acpi_handle;
>  	union st_info info;
> -	u32 cpu_uid;
>  	int ret;
>  
> -	ret = acpi_get_cpu_uid(cpu, &cpu_uid);
> +	ret = tph_get_cpu_st_info(pdev, cpu, &info);
>  	if (ret != 0)
>  		return ret;
>  
> -	rp = pcie_find_root_port(pdev);
> -	if (!rp || !rp->bus || !rp->bus->bridge)
> -		return -ENODEV;
> -
> -	rp_acpi_handle = ACPI_HANDLE(rp->bus->bridge);
> -
> -	if (tph_invoke_dsm(rp_acpi_handle, cpu_uid, &info) != AE_OK) {
> -		*tag = 0;
> -		return -EINVAL;
> -	}
> -
>  	*tag = tph_extract_tag(mem_type, req_type, &info);
>  
>  	pci_dbg(pdev, "get steering tag: mem_type=%s, req_type=%u, cpu=%d, tag=%#04x\n",
> @@ -615,3 +661,78 @@ bool pcie_tph_supported(struct pci_dev *pdev, bool want_ext)
>  	return pdev->tph_ext_support;
>  }
>  EXPORT_SYMBOL(pcie_tph_supported);
> +
> +static ssize_t tph_cpu_st_read(struct file *filp, struct kobject *kobj,
> +			       const struct bin_attribute *bin_attr, char *buf,
> +			       loff_t off, size_t count)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	const size_t entry_sz = PCI_TPH_CPU_ST_ENTRY_SZ;
> +	const size_t total_size = nr_cpu_ids * entry_sz;
> +	size_t copied = 0;
> +	loff_t pos = off;
> +
> +	if (pos >= total_size)
> +		return 0;
> +
> +	count = min_t(size_t, count, total_size - pos);
> +
> +	while (copied < count) {
> +		unsigned int cpu_idx = pos / entry_sz;
> +		size_t entry_off = pos % entry_sz;
> +		size_t remain = entry_sz - entry_off;
> +		size_t chunk = min_t(size_t, remain, count - copied);
> +		struct pci_tph_cpu_st st = {0};
> +
> +		if (cpu_possible(cpu_idx))
> +			get_cpu_all_st(pdev, cpu_idx, &st);
> +
> +		memcpy(buf + copied, (char *)&st + entry_off, chunk);
> +
> +		copied += chunk;
> +		pos += chunk;
> +
> +		cond_resched();
> +	}
> +
> +	return copied;
> +}
> +static BIN_ATTR(tph_cpu_st, 0400, tph_cpu_st_read, NULL, 0);
> +
> +static const struct bin_attribute *const tph_cpu_st_bin_attrs[] = {
> +	&bin_attr_tph_cpu_st,
> +	NULL,
> +};
> +
> +static size_t tph_cpu_st_bin_size(struct kobject *kobj,
> +				  const struct bin_attribute *a, int n)
> +{
> +	return nr_cpu_ids * PCI_TPH_CPU_ST_ENTRY_SZ;
> +}
> +
> +static umode_t tph_cpu_st_attr_is_visible(struct kobject *kobj,
> +					  const struct bin_attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	bool is_root_port = pci_is_pcie(pdev) &&
> +				pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT;
> +	u32 devcap2 = 0;
> +
> +	if (!is_root_port)
> +		return 0;
> +
> +	pci_read_config_dword(pdev, PCI_EXP_DEVCAP2, &devcap2);
> +	if (!(devcap2 & PCI_EXP_DEVCAP2_TPH_COMP_MASK))
> +		return 0;
> +
> +	if (!tph_dsm_supported(pdev))
> +		return 0;
> +
> +	return a->attr.mode;
> +}
> +
> +const struct attribute_group pcie_tph_cpu_st_attr_group = {
> +	.bin_attrs = tph_cpu_st_bin_attrs,
> +	.bin_size = tph_cpu_st_bin_size,
> +	.is_bin_visible = tph_cpu_st_attr_is_visible,
> +};
> diff --git a/include/uapi/linux/pci.h b/include/uapi/linux/pci.h
> index 4f150028965d..5c4ea44d66d2 100644
> --- a/include/uapi/linux/pci.h
> +++ b/include/uapi/linux/pci.h
> @@ -19,6 +19,7 @@
>  #define _UAPILINUX_PCI_H
>  
>  #include <linux/pci_regs.h>	/* The pci register defines */
> +#include <linux/types.h>
>  
>  /*
>   * The PCI interface treats multi-function devices as independent
> @@ -46,4 +47,19 @@ enum pci_hotplug_event {
>  	PCI_HOTPLUG_CARD_NOT_PRESENT,
>  };
>  
> +/*
> + * PCIe TPH sysfs binary entry for CPU-to-ST mapping
> + * Sysfs file: /sys/bus/pci/devices/<BDF>/tph_cpu_st
> + * Each entry is 8 bytes aligned, seek offset = cpu_id * PCI_TPH_CPU_ST_ENTRY_SZ
> + */
> +struct pci_tph_cpu_st {
> +	__u8  vm_st;        /* Volatile Memory Steering Tag (1 byte) */
> +	__u8  pm_st;        /* Persistent Memory Steering Tag (1 byte) */
> +	__u16 vm_xst;       /* Volatile Memory Extended Steering Tag (2 bytes) */
> +	__u16 pm_xst;       /* Persistent Memory Extended Steering Tag (2 bytes) */
> +	__u16 reserved;     /* Padding to 8 bytes for aligned offset lookup */
> +} __packed;
> +
> +#define PCI_TPH_CPU_ST_ENTRY_SZ sizeof(struct pci_tph_cpu_st)
> +
>  #endif /* _UAPILINUX_PCI_H */

