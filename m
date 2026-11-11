Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794369269;
	b=V8VKRzL4cLAkoI8hfaJAtvJndaIC2OkSrL/NIcbS67e8xHX6O6iiKp4/dY9WgfRhXRrX
	 vicspMsVnKicD6HiFbpTrSTmSPzFXVnDmYOFotpZCvRhLGPH7MIc2V86WW09zFBuvy5D9
	 JbDf2+37DWLSBm3VcSJk8Gb0v8cPvFLI46yPYHCaeAqcyshrttFlJsUss/CPLcgqBOt+g
	 H67DDMdLdv2NB0pDcZ9UpUG0RT6XLvcUZdcT5zHT0dZnxA4TySTBGwpGpPhYnK0nyzpj3
	 migPRE+lczarhot/NlX4luhNq0RI8oH13kNA1K/qLaxMyzT5tjg+O1hZiBcCr12qiRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794369269;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:Feedback-ID:X-Zoho-CM-AccountID:
	 X-ZohoMailClient;
	bh=i3mB2mTPJB8hy8ZMsw4SbFATQOhQUy4CkU6vkNwxOtE=;
	b=mylOIaanBIgzWETi9CevTij94d3Ucvf2zsGqbKp3QDb7hcyF8Cf4n41e4hoit+e5gbcU
	 tqZ74/jpmDPPX36TRVJ7b6UW2Sl0AxBwxvjnANcHc43HmDoWZPsGCbt6YrD1LV7z2id5K
	 fMl9OKBevXp1iW4hKXS4f1O8sgcAWBao/sDKxnLssRCQqxqQAXAPyZ0tuDRzPas9QLz/4
	 05Z70Vc5z6ox/ht2VtNe9TmsbGPjImqDpVNjXjHY0uhj0xhI1XWj2bH+4LEDHN9xO83s1
	 GhkDLmdF+3JfklqM5vQUW+hZNgb/S7gJkYZf7Cqa9gVlgpqyj2d8LCqjaMhlamSSmiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zohomail.com;
	spf=pass smtp.mailfrom=zohomail.com;
	dkim=pass header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Zk2kSe8F;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.94
Received: from sender5-pp-o94.zoho.com (sender5-pp-o94.zoho.com [165.173.182.94])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EEC606A331;
	Wed, 11 Nov 2026 03:54:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7EEC606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zohomail.com header.i=@zohomail.com header.a=rsa-sha256 header.s=zm2022 header.b=Zk2kSe8F
ARC-Seal: i=1; a=rsa-sha256; t=1794369254; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DJDp+dPPBYtmOWFbwWpqJM8YN9EwCZsnofkBBoY/+FwBJynGbKumQmzVuORoKPA1T+YP9lsN064OzXYcVBwyVQ5xOPxVVRS0n0SaqUHqBU0WNcKrslG+EQbMBpGbe3Nb7fkimbH2cD7vaU8GCzd0jzmjwt1ejT42av0Tww7tR1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794369254; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i3mB2mTPJB8hy8ZMsw4SbFATQOhQUy4CkU6vkNwxOtE=; 
	b=mz/UW9cN1q5XPxQrrL8k1gdNa6xEdabRgzrRO5VhWWzSxc3862ccMyzUP/BbkwNI9lIv0eBXYRI8y5QiTg9IPb6WZetCiJth0N/SWK/eClncpfGW5cFRkXkPFt6+DWQE6eT4IP32HIII9EQOIOb6aNxD8w1EvxL7AOxU/3zX+a0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: a=rsa-sha256; b=Zk2kSe8F12ow4HMxPJtpUQTfYcfdO+zayFfkz40FvusnTHA3MZcWc5/BVOODBk4oMvJjePEMw71OmwFHAPZahPX+JrTleYwIhCeHkLoR18tllalW1lDCOpVj9ybESNTmXCNezMh4SOwvPebH8zhV6RzUjVS9Vcv2psh9MqccE0U=; c=relaxed/relaxed; s=zm2022; d=zohomail.com; v=1; bh=i3mB2mTPJB8hy8ZMsw4SbFATQOhQUy4CkU6vkNwxOtE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794369253871795.9354658343498;
	Tue, 10 Nov 2026 19:54:13 -0800 (PST)
Message-ID: <a2226978-8200-41f9-9763-7916b946899b@zohomail.com>
Date: Wed, 11 Nov 2026 11:54:07 +0800
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 11/19] PCI/CXL: Cache endpoint HDM state during PCI
 enumeration
From: Li Ming <ming.li@zohomail.com>
To: Srirangan Madhavan <smadhavan@nvidia.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Dave Jiang <dave.jiang@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Vishal Verma
 <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Joshua Machauer <machaujo@amazon.de>,
 Alex Williamson <alex.williamson@redhat.com>, vsethi@nvidia.com,
 alwilliamson@nvidia.com,
 Sai Yashwanth Reddy Kancherla <skancherla@nvidia.com>,
 Vishal Aslot <vaslot@nvidia.com>, Manish Honap <mhonap@nvidia.com>,
 Jiandi An <jan@nvidia.com>, Richard Cheng <icheng@nvidia.com>,
 linux-tegra@vger.kernel.org
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-12-smadhavan@nvidia.com>
 <e8084759-ce40-4a74-b47f-cf62080be7d5@zohomail.com>
In-Reply-To: <e8084759-ce40-4a74-b47f-cf62080be7d5@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Feedback-ID: zu08011227118f64964b902de5b9697586000001d9bb5f2d1a9f4f3a0e45cc8b0c9b9577b4ed1ce632e7e5b9:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External


在 2026/11/10 22:12, Li Ming 写道:
>
> 在 2026/11/6 02:59, Srirangan Madhavan 写道:
>> Cache HDM state in pci_dev->hdm after BAR resource setup and before 
>> driver
>> binding, so reset can restore it without a bound CXL driver.
>>
>> Limit caching to devices that advertise CXL.cache, CXL.mem, CXL Reset,
>> and Reset Memory Clear. Save their HDM register location, decoder
>> settings, and Device DVSEC state.
>>
>> Validate capability reads and decoder counts, and restore PCI_COMMAND
>> after temporary MMIO access, reporting restoration failures. Publish the
>> cache under the PCI device lock and protect later updates with the DPA
>> lock.
>>
>> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>
>> Assisted-by: LLM
>>
>> ---
>> Changes in v17:
>> - Publish the cache under the PCI device lock without taking
>>    cxl_rwsem.dpa, and drop the cxl_hdm_cache_present() and
>>    cxl_hdm_cache_publish() helpers (Li Ming)
>> https://lore.kernel.org/linux-cxl/d581f2a0-dd9e-4d0a-bd19-639c1bd9b832@zohomail.com/
>> - Reject an all-ones DVSEC Control read in cxl_set_mem_enable() before
>>    it is written back or cached (Sashiko)
>> https://sashiko.dev/#/patchset/20261029145703.2185231-1-smadhavan@nvidia.com?part=11
>> - Explain why cxl_set_mem_enable() refreshes the cached DVSEC Control
>>    when MEM_ENABLE already matches (Richard)
>> https://lore.kernel.org/linux-cxl/auRQN6a3QVtqjd5a@MWDK4CY14F/
>>
>> Reference branch: 
>> https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/commit/?id=b12baa1105f33cc1a10f9c9c0c6376194397d9f3
>> ---
>>   MAINTAINERS                   |   1 +
>>   drivers/cxl/core/hdm_regs.c   |  96 +++++++++++++++
>>   drivers/cxl/core/hdm_state.c  |  37 +++++-
>>   drivers/cxl/core/pci.c        |  29 +++--
>>   drivers/pci/Makefile          |   1 +
>>   drivers/pci/bus.c             |   1 +
>>   drivers/pci/cxl.c             | 225 ++++++++++++++++++++++++++++++++++
>>   drivers/pci/pci.h             |   8 ++
>>   drivers/pci/probe.c           |   1 +
>>   include/cxl/hdm.h             |   9 ++
>>   include/uapi/linux/pci_regs.h |   2 +
>>   11 files changed, 399 insertions(+), 11 deletions(-)
>>   create mode 100644 drivers/pci/cxl.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index c2414447892c..b874340b0265 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6572,6 +6572,7 @@ S:    Maintained
>>   F:    Documentation/driver-api/cxl
>>   F:    Documentation/userspace-api/fwctl/fwctl-cxl.rst
>>   F:    drivers/cxl/
>> +F:    drivers/pci/cxl.c
>>   F:    include/cxl/
>>   F:    include/uapi/linux/cxl_mem.h
>>   F:    tools/testing/cxl/
>> diff --git a/drivers/cxl/core/hdm_regs.c b/drivers/cxl/core/hdm_regs.c
>> index cc5d77c4abf5..c92dbb017162 100644
>> --- a/drivers/cxl/core/hdm_regs.c
>> +++ b/drivers/cxl/core/hdm_regs.c
>> @@ -2,6 +2,7 @@
>>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>>   #include <linux/delay.h>
>>   #include <linux/bug.h>
>> +#include <linux/device.h>
>>   #include <linux/errno.h>
>>   #include <linux/export.h>
>>   #include <linux/kernel.h>
>> @@ -190,3 +191,98 @@ int cxl_hdm_read_decoder(struct 
>> cxl_decoder_config *config, void __iomem *hdm,
>>       return cxl_hdm_unpack_decoder(config, id, ctrl, base, size);
>>   }
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_hdm_read_decoder, "cxl_core");
>> +
>> +/**
>> + * cxl_hdm_decoder_count_mapped() - read the decoder count of a 
>> mapped block
>> + * @dev: device for error reporting
>> + * @hdm: mapped HDM decoder capability
>> + * @size: size of the mapping
>> + *
>> + * Return: the decoder count, or a negative errno if the count is 
>> reserved or
>> + * the mapping cannot hold every decoder.
>> + */
>> +int cxl_hdm_decoder_count_mapped(struct device *dev, void __iomem *hdm,
>> +                 resource_size_t size)
>> +{
>> +    int count;
>> +
>> +    count = cxl_hdm_decoder_count(readl(hdm + 
>> CXL_HDM_DECODER_CAP_OFFSET));
>> +    if (count < 0)
>> +        return count;
>> +
>> +    /* The last decoder's target-list high register must fit in the 
>> mapping. */
>> +    if (CXL_HDM_DECODER0_TL_HIGH(count - 1) + sizeof(u32) > size) {
>> +        dev_err(dev, "CXL HDM decoder count exceeds mapped register 
>> block\n");
>> +        return -ENXIO;
>> +    }
>> +
>> +    return count;
>> +}
>> +
>> +/* Read one endpoint decoder; a disabled decoder keeps only its id. */
>> +static int cxl_hdm_read_decoder_settings(struct device *dev,
>> +                     struct cxl_endpoint_decoder_settings *settings,
>> +                     void __iomem *hdm, int id)
>> +{
>> +    u64 lo, hi;
>> +    u32 ctrl;
>> +    int rc;
>> +
>> +    ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
>> +    rc = cxl_hdm_read_decoder(&settings->config, hdm, id, ctrl);
>> +    if (rc) {
>> +        dev_err(dev,
>> +            "CXL HDM decoder %d has invalid configuration: %d\n",
>> +            id, rc);
>> +        return rc;
>> +    }
>> +
>> +    if (!(settings->config.flags & CXL_DECODER_F_ENABLE)) {
>> +        *settings = (struct cxl_endpoint_decoder_settings) {
>> +            .config.id = id,
>> +        };
>> +    } else {
>> +        lo = readl(hdm + CXL_HDM_DECODER0_SKIP_LOW(id));
>> +        hi = readl(hdm + CXL_HDM_DECODER0_SKIP_HIGH(id));
>> +        settings->skip = (hi << 32) | lo;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +/**
>> + * cxl_hdm_read_state() - read endpoint HDM decoder state
>> + * @dev: device for error messages
>> + * @hdm: mapped HDM decoder capability
>> + * @info: state to fill; @info->decoder_count must be set
>> + *
>> + * Return: 0 on success, or a negative errno if a decoder holds an 
>> invalid
>> + * configuration or the decoder count changed while reading.
>> + */
>> +int cxl_hdm_read_state(struct device *dev, void __iomem *hdm,
>> +               struct cxl_hdm_info *info)
>> +{
>> +    int count;
>> +    int rc;
>> +
>> +    info->global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>> +    for (int i = 0; i < info->decoder_count; i++) {
>> +        rc = cxl_hdm_read_decoder_settings(dev, &info->settings[i],
>> +                           hdm, i);
>> +        if (rc)
>> +            return rc;
>> +    }
>> +
>> +    /*
>> +     * A changed decoder count means the snapshot no longer 
>> describes the
>> +     * complete hardware state. Reject it rather than publish a 
>> partial cache.
>> +     */
>> +    count = cxl_hdm_decoder_count(readl(hdm + 
>> CXL_HDM_DECODER_CAP_OFFSET));
>> +    if (count != info->decoder_count) {
>> +        dev_err(dev, "CXL HDM decoder count changed from %d to %d\n",
>> +            info->decoder_count, count);
>> +        return -ENXIO;
>> +    }
>> +
>> +    return 0;
>> +}
>> diff --git a/drivers/cxl/core/hdm_state.c b/drivers/cxl/core/hdm_state.c
>> index d4c2be1ef833..9def4a7439c9 100644
>> --- a/drivers/cxl/core/hdm_state.c
>> +++ b/drivers/cxl/core/hdm_state.c
>> @@ -1,21 +1,37 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /* Copyright (c) 2026 NVIDIA Corporation & Affiliates */
>> +#include <linux/cleanup.h>
>>   #include <linux/export.h>
>>   #include <linux/io.h>
>>   #include <linux/pci.h>
>>   #include <linux/rwsem.h>
>> +#include <linux/slab.h>
>>     #include <cxl/hdm.h>
>> -
>>   #include "cxl.h"
>>   #include "core.h"
>>   +/*
>> + * CXL state that must stay available while no CXL driver is bound: 
>> the CXL
>> + * locks and the per-device HDM cache filled during PCI enumeration.
>> + */
>>   struct cxl_rwsem cxl_rwsem = {
>>       .region = __RWSEM_INITIALIZER(cxl_rwsem.region),
>>       .dpa = __RWSEM_INITIALIZER(cxl_rwsem.dpa),
>>   };
>>   EXPORT_SYMBOL_FOR_MODULES(cxl_rwsem, "cxl_core");
>>   +void cxl_hdm_cache_set_dvsec_ctrl(struct pci_dev *pdev, u16 ctrl)
>> +{
>> +    guard(rwsem_write)(&cxl_rwsem.dpa);
> Is this lock needed? “pdev->hdm->dvsec_ctrl” could be modified 
> concurrently? Seems like it is called during the endpoint port probing.

I realize that we may need this lock while I was reviewing patch #13. 
The CXL reset operation could be triggered during the endpoint port probing.

Would you mind moving the code of holding cxl_rwsem.dpa to patch #13? I 
think this could make it easier to review.


[snip]

