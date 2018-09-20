Return-Path: <SRS0=Tpvo=MC=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49F4C433F4
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 00:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 915D321524
	for <linux-pci@archiver.kernel.org>; Thu, 20 Sep 2018 00:28:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915D321524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbeITGIz (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 20 Sep 2018 02:08:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:53273 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbeITGIz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Sep 2018 02:08:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2018 17:28:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,396,1531810800"; 
   d="scan'208";a="93235674"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.4]) ([10.239.13.4])
  by orsmga002.jf.intel.com with ESMTP; 19 Sep 2018 17:26:08 -0700
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
To:     Pu Wen <puwen@hygon.cn>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, lkp@01.org
References: <20180919031923.GC8820@shao2-debian>
 <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <dfc09a36-cfc5-0479-a862-696c224f9a19@intel.com>
Date:   Thu, 20 Sep 2018 08:26:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09/19/2018 09:53 PM, Pu Wen wrote:
> On 2018/9/19 11:19, kernel test robot wrote:
>> [    0.800215] AGP: No AGP bridge found
>> PANIC: early exception 0xe3 IP 10:ffffffff8294623f error 0 cr2 0x0
>> [    0.815262] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc2-00018-g7ffb318 #1
>> [    0.826860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
>> [    0.839894] RIP: 0010:early_is_amd_nb+0x30/0x4b
>> [    0.846986] Code: 15 07 3e c8 ff 0f b7 cf 48 c7 c0 c0 6a 01 82 80 fa 02 74 13 80 fa 09 48 c7 c0 20 69 01 82 ba 00 00 00 00 48 0f 45 c2 c1 ef 10 <8b> 10 85 d2 74 0f 39 ca 75 05 39 78 04 74 09 48 83 c0 20 eb eb 31
>> [    0.876321] RSP: 0000:ffffffff82403e38 EFLAGS: 00010017 ORIG_RAX: 0000000000000000
>> [    0.888131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000ffff
>> [    0.899187] RDX: 0000000000000000 RSI: 000000000000c000 RDI: 000000000000ffff
>> [    0.910233] RBP: 0000000000000018 R08: 0000000000000002 R09: 0000000000000000
>> [    0.921388] R10: ffffffff829ecc40 R11: ffffffff82aeed87 R12: 0000000000000000
>> [    0.932476] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>> [    0.943658] FS:  0000000000000000(0000) GS:ffffffff82909000(0000) knlGS:0000000000000000
>> [    0.956271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [    0.965216] CR2: 0000000000000000 CR3: 00000000029a2000 CR4: 00000000000006a0
>> [    0.976358] Call Trace:
>> [    0.980238]  ? early_gart_iommu_check+0xef/0x2c5
>> [    0.987493]  ? setup_arch+0x4fa/0xc67
>> [    0.993231]  ? printk+0x52/0x6e
>> [    0.998157]  ? start_kernel+0x6e/0x4dc
>> [    1.004044]  ? load_ucode_bsp+0x42/0x12e
>> [    1.010145]  ? secondary_startup_64+0xa4/0xb0
>> BUG: kernel hang in boot stage
>>
>> Elapsed time: 700
>>
>> #!/bin/bash
>>
>>
>>
>> To reproduce:
>>
>>           git clone https://github.com/intel/lkp-tests.git
>>           cd lkp-tests
>>           bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
> both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
> What kind of host do you use to run the qemu? A Intel one or AMD one?
It's a Intel one,

model: Nehalem-EX
memory: 224G
nr_node: 4
nr_cpu: 64
nr_socket: 4
brand: Intel(R) Xeon(R) CPU X7560 @ 2.27GHz

Best Regards,
Rong Chen
