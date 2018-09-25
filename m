Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C73AC43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 109742086B
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 109742086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbeIYSe6 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:34:58 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:56377 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728542AbeIYSe6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 14:34:58 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowAAnDCymKapbp0L6DQ--.16498S2;
        Tue, 25 Sep 2018 20:27:19 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v8 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
To:     Borislav Petkov <bp@alien8.de>
Cc:     bhelgaas@google.com, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        helgaas@kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-pci@vger.kernel.org
References: <cover.1537533368.git.puwen@hygon.cn>
 <580dc519d37ad9257520fe8c533f2c61d3e0cd83.1537533369.git.puwen@hygon.cn>
 <20180924152448.GE20187@zn.tnic>
Message-ID: <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
Date:   Tue, 25 Sep 2018 20:27:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180924152448.GE20187@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAAnDCymKapbp0L6DQ--.16498S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryrAry7XF4kXryfZr45GFg_yoW5Cry8pr
        98Aws3urs5Gr1SqayUtw4Uur4FvFZrWayfCrW3Gwn8Jw4DZ3W8ZF4I9r1Ik3WkG3ykJa47
        JFWvqF1fAr4vyFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
        4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
        n2IY04v7Mxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAKzI0EY4vE52x082I5MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU0byCDUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/24 23:24, Borislav Petkov wrote:
>> diff --git a/arch/x86/include/asm/amd_nb.h b/arch/x86/include/asm/amd_nb.h
>> index fddb6d2..1ae4e57 100644
>> --- a/arch/x86/include/asm/amd_nb.h
>> +++ b/arch/x86/include/asm/amd_nb.h
>> @@ -103,6 +103,9 @@ static inline u16 amd_pci_dev_to_node_id(struct pci_dev *pdev)
>>   
>>   static inline bool amd_gart_present(void)
>>   {
>> +	if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
>> +		return false;
>> +
> 
> What is that for?
> 
> Hygon doesn't have F15h so that function will return false there too...

This modification is used to solve the 0day PANIC occurred on Intel
platform. The function will always return false when running on Hygon
Dhyana platform, but will return true on Intel platform with CPU family
0xf/0x10/0x15.
Then the Intel CPU will run through early_gart_iommu_check and call
early_is_amd_nb, but misc_ids for Intel in patch v7 Is NULL so there
will be a PANIC:
[    0.839894] RIP: 0010:early_is_amd_nb+0x30/0x4b
...
[    0.976358] Call Trace:
[    0.980238]  ? early_gart_iommu_check+0xef/0x2c5
[    0.987493]  ? setup_arch+0x4fa/0xc67
[    0.993231]  ? printk+0x52/0x6e
[    0.998157]  ? start_kernel+0x6e/0x4dc
[    1.004044]  ? load_ucode_bsp+0x42/0x12e
[    1.010145]  ? secondary_startup_64+0xa4/0xb0

> ... or is that because the qemu script you got from the 0day bot guys
> uses -cpu kvm64 which is family 0xf:
> 
> [    0.214353] smpboot: CPU0: AMD Common KVM processor (family: 0xf, model: 0x6, stepping: 0x1)
> 
> ?
> 
> and that makes amd_gart_present() say yes.
> In that case, please make a *prepatch* which adds the vendor check to
> both amd_gart_present() and early_is_amd_nb() and send it as a reply to
> this message.

OK, I'll make a separate prepatch for this change.

> 
> *Then*, do this patch ontop and also as a reply.

Do you mean do the follow change on top of the prepatch?

>> @@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
>>   	u16 i = 0;
>>   	struct amd_northbridge *nb;
>>   	struct pci_dev *root, *misc, *link;
>> +	const struct pci_device_id *root_ids = NULL;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +	const struct pci_device_id *link_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		root_ids = hygon_root_ids;
>> +		misc_ids = hygon_nb_misc_ids;
>> +		link_ids = hygon_nb_link_ids;
>> +	} else {
>> +		root_ids = amd_root_ids;
>> +		misc_ids = amd_nb_misc_ids;
>> +		link_ids = amd_nb_link_ids;
>> +	}
> 
> Also, you can make this assignment differently:
> 
> 	const struct pci_device_id *root_ids = amd_root_ids;
> 	const struct pci_device_id *misc_ids = amd_nb_misc_ids;
> 	const struct pci_device_id *link_ids = amd_nb_link_ids;
> 
> 
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	}
> 
> This way the change is obvious and it is only for Hygon without
> affecting the other vendors.
> 
> Ditto for the other assignment.

All right, I will change these in the next version patch set.

Thanks,
Pu Wen

