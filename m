Return-Path: <SRS0=lgne=XA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0728C3A5A5
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 10:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 968C22184B
	for <linux-pci@archiver.kernel.org>; Thu,  5 Sep 2019 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567677735;
	bh=gcFm+bRqEmfCSpXqAXsi3tvcBuO4wVohWAaR4h+dEuw=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=mm2n0YIwG7I2I4Wh2bpORMgI9hi3sCn5s57PzLZHMqix+0yGTgILB5NiNPybtw5w2
	 GcIZMoQW4n9x4TGcroLSVDZ6wCW7zPDEt6ujgSuNLQ6ABDbsvYbzj2pDgx/R6O69LY
	 G2X6QSjWuM2JmY7unNBqlufhMVZfehvdLjq+mJig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbfIEKCP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 5 Sep 2019 06:02:15 -0400
Received: from foss.arm.com ([217.140.110.172]:40868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbfIEKCO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 06:02:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D53DB1576;
        Thu,  5 Sep 2019 03:02:13 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A4C93F67D;
        Thu,  5 Sep 2019 03:02:12 -0700 (PDT)
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     John Garry <john.garry@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
Date:   Thu, 5 Sep 2019 11:02:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/09/2019 10:39, John Garry wrote:
>>
>> That's a "feature" of the architecture. The ITT is sized by the number
>> of bits used to index the table, meaning that you can only describe a
>> power of two >= 2.
>>
>> John, could you stick a "#define DEBUG 1" at the top of irq-gic-v3-its.c
>> and report the LPI allocations for this device?
>>
> 
> Hi Marc,
> 
> As requested, I enabled debug for that driver and here are some kernel 
> log snippets:
> 
> [    8.435707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
> [    8.461467] scsi host0: hisi_sas_v3_hw
> [    9.683463] ITS: alloc 9920:32
> [    9.686509] ITT 32 entries, 5 bits
> [    9.690044] ID:0 pID:9920 vID:23
> [    9.693263] ID:1 pID:9921 vID:24
> [    9.696480] ID:2 pID:9922 vID:25
> [    9.699696] ID:3 pID:9923 vID:26
> [    9.702911] ID:4 pID:9924 vID:27
> [    9.706128] ID:5 pID:9925 vID:28
> [    9.709344] ID:6 pID:9926 vID:29
> [    9.712560] ID:7 pID:9927 vID:30
> [    9.715776] ID:8 pID:9928 vID:31
> [    9.718990] ID:9 pID:9929 vID:32
> [    9.722207] ID:10 pID:9930 vID:33
> [    9.725510] ID:11 pID:9931 vID:34
> [    9.728813] ID:12 pID:9932 vID:35
> [    9.732116] ID:13 pID:9933 vID:36
> [    9.735419] ID:14 pID:9934 vID:37
> [    9.738721] ID:15 pID:9935 vID:38
> [    9.742024] ID:16 pID:9936 vID:39
> 
> <snip>
> 
> (none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
> 
> <snip>
> 
> root@(none)$
> $ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
> [   41.110557] scsi host0: hisi_sas_v3_hw
> [   42.335455] Reusing ITT for devID 7410
> [   42.359151] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
> sh: echo: write error: No such device
> root@(none)$

Very interesting. Somehow, we think that this is a *new* device that 
aliases with itself. Needless to say, that's unexpected. My hunch is 
that something goes wrong when freeing the device. Can you try adding 
the patch below and report what is happening on unbind?

Thanks,

	M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..3fed87e551d9 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2651,6 +2651,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 
 		/* Nuke the entry in the domain */
 		irq_domain_reset_irq_data(data);
+
+		pr_debug("Freed devid %x LPI %ld\n", its_dev->device_id, data->hwirq);
 	}
 
 	mutex_lock(&its->dev_alloc_lock);
@@ -2667,6 +2669,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 			     its_dev->event_map.nr_lpis);
 		kfree(its_dev->event_map.col_map);
 
+		pr_debug("Unmap devid %x\n", its_dev->device_id);
 		/* Unmap device/itt */
 		its_send_mapd(its_dev, 0);
 		its_free_device(its_dev);

-- 
Jazz is not dead, it just smells funny...
