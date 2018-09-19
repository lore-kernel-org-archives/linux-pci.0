Return-Path: <SRS0=bOp+=MB=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F30ECE564
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 13:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AD682150F
	for <linux-pci@archiver.kernel.org>; Wed, 19 Sep 2018 13:54:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AD682150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbeISTcO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 19 Sep 2018 15:32:14 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:54162 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727771AbeISTcO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Sep 2018 15:32:14 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowAB3fWHrVKJbqEtHDA--.5307S2;
        Wed, 19 Sep 2018 21:53:48 +0800 (CST)
From:   Pu Wen <puwen@hygon.cn>
Subject: Re: [LKP] [x86/pci] 7ffb31888c: PANIC:early_exception
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, thomas.lendacky@amd.com, helgaas@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-pci@vger.kernel.org, lkp@01.org
References: <20180919031923.GC8820@shao2-debian>
Message-ID: <4f5166f8-97b8-a58f-3e5d-19d1751a4601@hygon.cn>
Date:   Wed, 19 Sep 2018 21:53:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919031923.GC8820@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowAB3fWHrVKJbqEtHDA--.5307S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF43Cr1kKw4DZr1fKF18Grg_yoW8ury7pF
        yUXr1DGr48JF1UJr1UJF15Cw12krnrZ3WUXr17Gr18AF18W3WUJr18ArWUtw1DJr4DXry2
        yrWDJ3WxtrWUKaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvEb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8Jr0_Cr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
        42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
        evJa73UjIFyTuYvjxUqX4SDUUUU
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org
Message-ID: <20180919135345.CF0Qheq2PMUCWR0-k-_awYh2CB0cjoNEFPUYf2csm3w@z>

On 2018/9/19 11:19, kernel test robot wrote:
> [    0.800215] AGP: No AGP bridge found
> PANIC: early exception 0xe3 IP 10:ffffffff8294623f error 0 cr2 0x0
> [    0.815262] CPU: 0 PID: 0 Comm: swapper Not tainted 4.19.0-rc2-00018-g7ffb318 #1
> [    0.826860] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> [    0.839894] RIP: 0010:early_is_amd_nb+0x30/0x4b
> [    0.846986] Code: 15 07 3e c8 ff 0f b7 cf 48 c7 c0 c0 6a 01 82 80 fa 02 74 13 80 fa 09 48 c7 c0 20 69 01 82 ba 00 00 00 00 48 0f 45 c2 c1 ef 10 <8b> 10 85 d2 74 0f 39 ca 75 05 39 78 04 74 09 48 83 c0 20 eb eb 31
> [    0.876321] RSP: 0000:ffffffff82403e38 EFLAGS: 00010017 ORIG_RAX: 0000000000000000
> [    0.888131] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000000ffff
> [    0.899187] RDX: 0000000000000000 RSI: 000000000000c000 RDI: 000000000000ffff
> [    0.910233] RBP: 0000000000000018 R08: 0000000000000002 R09: 0000000000000000
> [    0.921388] R10: ffffffff829ecc40 R11: ffffffff82aeed87 R12: 0000000000000000
> [    0.932476] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [    0.943658] FS:  0000000000000000(0000) GS:ffffffff82909000(0000) knlGS:0000000000000000
> [    0.956271] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.965216] CR2: 0000000000000000 CR3: 00000000029a2000 CR4: 00000000000006a0
> [    0.976358] Call Trace:
> [    0.980238]  ? early_gart_iommu_check+0xef/0x2c5
> [    0.987493]  ? setup_arch+0x4fa/0xc67
> [    0.993231]  ? printk+0x52/0x6e
> [    0.998157]  ? start_kernel+0x6e/0x4dc
> [    1.004044]  ? load_ucode_bsp+0x42/0x12e
> [    1.010145]  ? secondary_startup_64+0xa4/0xb0
> BUG: kernel hang in boot stage
> 
> Elapsed time: 700
> 
> #!/bin/bash
> 
> 
> 
> To reproduce:
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email

I cannot reproduce this panic on Hygon Dhyana platform. I tired lkp-tests
both in Ubuntu 16.04 (with gcc-5) and Ubuntu 18.04 (with gcc-7).
What kind of host do you use to run the qemu? A Intel one or AMD one?

Thanks,
Pu Wen

