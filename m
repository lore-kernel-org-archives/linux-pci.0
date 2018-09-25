Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E29C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5FB208D9
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 12:57:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5FB208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbeIYTFI (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 25 Sep 2018 15:05:08 -0400
Received: from smtp20.cstnet.cn ([159.226.251.20]:44801 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728881AbeIYTFI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Sep 2018 15:05:08 -0400
Received: from [172.20.20.131] (unknown [182.150.46.145])
        by APP-10 (Coremail) with SMTP id tACowACXnWGyMKpbq5D7DQ--.16571S2;
        Tue, 25 Sep 2018 20:57:23 +0800 (CST)
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
 <8ed72e5f-c85c-67f6-67e9-460ef99ab372@hygon.cn>
 <20180925123035.GC23986@zn.tnic>
From:   Pu Wen <puwen@hygon.cn>
Message-ID: <d565ef8a-6d53-4490-2cba-1f237b0aa9d5@hygon.cn>
Date:   Tue, 25 Sep 2018 20:57:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925123035.GC23986@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: tACowACXnWGyMKpbq5D7DQ--.16571S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYD7k0a2IF6w1UM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
        6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z2
        80aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIE
        c7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jbUUUUUUUU=
X-Originating-IP: [182.150.46.145]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/25 20:30, Borislav Petkov wrote:
> On Tue, Sep 25, 2018 at 08:27:15PM +0800, Pu Wen wrote:
>> All right, I will change these in the next version patch set.
> 
> Just send two patches as a reply to this thread here:
> 
> 1. add the vendor check to both amd_gart_present() and early_is_amd_nb()
> 2. redo 7/16 ontop of the first patch.
> 
> I don't think you need to resend the whole patchset as the rest is still
> good.

OK, I got the point. :)
I'll just send the two patches.

Thx.

-- 
Regards,
Pu Wen

