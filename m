Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A4C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF1121526
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 08:05:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DF1121526
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731455AbeITNrs (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 09:47:48 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:37088 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbeITNrs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 09:47:48 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-09 (Coremail) with SMTP id swCowAB3XR23VKNb2wB3Cw--.29767S2;
        Thu, 20 Sep 2018 16:05:12 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [PATCH v6 07/16] x86/pci: Add Hygon Dhyana support to PCI and
 north bridge
To:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Cc:     "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <cover.1536550549.git.puwen@hygon.cn>
 <035e5d0a4f2a0edf68ca0f1019e47b878eaa5da6.1536550550.git.puwen@hygon.cn>
 <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Message-ID: <b44e0656-7d57-3f9e-03fb-1dcf04091cdc@hygon.cn>
Date:   Thu, 20 Sep 2018 16:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <d05c7aa5-05ba-5ac2-c70f-414d9539925f@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowAB3XR23VKNb2wB3Cw--.29767S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1xGF15GrWfAFW8tF13Arb_yoW8uF1Upr
        W5Xws5urn5Wr1Yqayjqr4UXr40vrWDWay7WrW3Gwn5GF1Duw18Zr429w1Sy3ZxJr4kua17
        J3WkXF15Ar4ktFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWxJVW8Jr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7
        Mxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07UE-erUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/20 1:20, Lendacky, Thomas wrote:
>> @@ -197,12 +212,25 @@ int amd_cache_northbridges(void)
>>   	u16 i = 0;
>>   	struct amd_northbridge *nb;
>>   	struct pci_dev *root, *misc, *link;
>> +	const struct pci_device_id *root_ids = NULL;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +	const struct pci_device_id *link_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
>> +		root_ids = amd_root_ids;
>> +		misc_ids = amd_nb_misc_ids;
>> +		link_ids = amd_nb_link_ids;
>> +	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
>> +		root_ids = hygon_root_ids;
>> +		misc_ids = hygon_nb_misc_ids;
>> +		link_ids = hygon_nb_link_ids;
>> +	}
>
> To be compatible with "before this patch" you should probably do:
>
> 	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
> 		root_ids = hygon_root_ids;
> 		misc_ids = hygon_nb_misc_ids;
> 		link_ids = hygon_nb_link_ids;
> 	} else {
> 		root_ids = amd_root_ids;
> 		misc_ids = amd_nb_misc_ids;
> 		link_ids = amd_nb_link_ids;
> 	}
>
> That way they are always the AMD values if not your chip.
>
...
>> @@ -263,9 +291,15 @@ bool __init early_is_amd_nb(u32 device)
>>   {
>>   	const struct pci_device_id *id;
>>   	u32 vendor = device & 0xffff;
>> +	const struct pci_device_id *misc_ids = NULL;
>> +
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
>> +		misc_ids = amd_nb_misc_ids;
>> +	else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +		misc_ids = hygon_nb_misc_ids;
>
> Same comment as above.  This will probably eliminate the PANIC that
> that was reported by LKP.

Yes, it's this modification that caused the PANIC reported by LKP.
Because the misc_ids will be NULL if running on Intel chip.

If change the vendor checking like this:

+	if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		misc_ids = hygon_nb_misc_ids;
+	else
+		misc_ids = amd_nb_misc_ids;

The PANIC will be eliminated.

The PANIC will also be eliminated by adding AMD vendor checking in
amd_gart_present:

+	if(boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
+		return false;

To prevent the function return true on non AMD platform.

Thanks,
Pu Wen

