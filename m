Return-Path: <SRS0=l472=MF=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62798ECE562
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 12:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FAC02148D
	for <linux-pci@archiver.kernel.org>; Sun, 23 Sep 2018 12:55:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FAC02148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hygon.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbeIWSw0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 23 Sep 2018 14:52:26 -0400
Received: from smtp17.cstnet.cn ([159.226.251.17]:41878 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726126AbeIWSw0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Sep 2018 14:52:26 -0400
Received: from [192.168.1.9] (unknown [110.184.153.249])
        by APP-09 (Coremail) with SMTP id swCowADHrR0NjadbMzVUDA--.5452S2;
        Sun, 23 Sep 2018 20:54:38 +0800 (CST)
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
 <20180923111046.GA20575@zn.tnic>
Message-ID: <f20743b0-cad2-4eb4-ac6d-f1aa7b34ce16@hygon.cn>
Date:   Sun, 23 Sep 2018 20:54:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923111046.GA20575@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: swCowADHrR0NjadbMzVUDA--.5452S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY67k0a2IF6w4xM7kC6x804xWl14x267AK
        xVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGw
        A2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j
        6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Gr
        0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAa
        Y2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4
        A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY
        1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU8IzuJUUUUU==
X-Originating-IP: [110.184.153.249]
X-CM-SenderInfo: psxzv046klw03qof0z/
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2018/9/23 19:10, Borislav Petkov wrote:
>> Signed-off-by: Pu Wen <puwen@hygon.cn>
>> Acked-by: Bjorn Helgaas <bhelgaas@google.com>	# pci_ids.h
>> Reviewed-by: Borislav Petkov <bp@suse.de>
>
> A note for your future submissions: if you rework a patch in a
> non-trivial way, you *must* drop Reviewed-by/Acked-by tags because they
> are not valid anymore.
>
> In this case I guess Bjorn's tag can stay because he's acking the
> pci_ids.h addition but mine definitely must go.

Thanks for the note. I'm sorry for not removing the Reviewed-by tag.
Is this revision still OK by you? :)

-- 
Regards,
Pu Wen

