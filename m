Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B34C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1A320828
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 22:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLlU84Uk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfCYW00 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:26:26 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35840 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYW00 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 18:26:26 -0400
Received: by mail-oi1-f194.google.com with SMTP id t206so8343679oib.3;
        Mon, 25 Mar 2019 15:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5h/GyZza/doCtTkWOkQGieP2czo8XItTBc2FSkF+nrI=;
        b=WLlU84Ukf56ufikTqkZ55RU4W746kd5wCrCwEh+uZ+d0SawIBPv1xIaEPahync2+yD
         NCyNTPFCeOQGkMVrzv+LbRdDq2SoCK0iKgBxklEtB+RIs5Ua1bVh4Egv7rED6VN27nIZ
         6abZKFLJZ42ZOsVpKs07/PQOjhNxKFGCGDgpkxAEMRhqufc2Rncf9GKhFw88/1hnZZ5M
         lgs1N47J2xvO5nSzWrWf9gmAlR47PrTxip9NOXaMNeEzkxaNCpGnYgXPoOblkhxtn1In
         Jlk5ZvgodN07RrdQ+iAe6AoKDD09VcF/QSmdZx/keCuy9K/P5RqeKmTfcqJ5cEsLnYGw
         Rluw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5h/GyZza/doCtTkWOkQGieP2czo8XItTBc2FSkF+nrI=;
        b=kyC3hGqp1p+jrRjuo2/ntPDXE/rJ4Q5iljiQOEpobLZkiGKOqRABz+RyygLvEHH2xR
         WwuqwwISFoxS4no/efOfZrNkKHov2OnOhHuB/R0GJDaX0UAYKNjVgx+9cRvO6ptS5Qm/
         ZHNXVF11V2G/Z/Vn4CTarfDSFos/obOtAcA6h4K0w8Fx5SKDugah00qWhzGsHytbauP5
         V7tcn+8JozJQNsTydFUdk/9/E0mxuxJuGYXDZmh2uTN+SGT3MjSG9rwfsuMt3DQQThNb
         s+XpG66243dbYrhTtyVba9S+eScLy6vnTucgXx/gLlLlcBcpWVNXr9VBSdyF2iSGBvgC
         pzKQ==
X-Gm-Message-State: APjAAAUSV2IA8BWFGpJA37AYQD7otWPSzsv4RVrSbvggVBujAp7SMwUq
        mdKCVaj4q1uCsVtVdxygSAA7FAGO6ZM=
X-Google-Smtp-Source: APXvYqzCXjyaRrwnl8q4AuAfRG52BbqaubUP0ujevBUez/z+Xp4QxxTy9D/lUs3pdlN63HayKGdLSQ==
X-Received: by 2002:aca:c4cc:: with SMTP id u195mr12845107oif.40.1553552785003;
        Mon, 25 Mar 2019 15:26:25 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id n77sm6518885ota.77.2019.03.25.15.26.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 15:26:24 -0700 (PDT)
Subject: Re: [PATCH v2] PCI/LINK: bw_notification: Do not leave interrupt
 handler NULL
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, torvalds@linux-foundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190320193504.GC251185@google.com>
 <20190323003700.7294-1-mr.nuke.me@gmail.com>
 <20190325222502.GC24180@google.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <2dce09cf-dba2-2b2a-412d-40a546d9e2ac@gmail.com>
Date:   Mon, 25 Mar 2019 17:26:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190325222502.GC24180@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 3/25/19 5:25 PM, Bjorn Helgaas wrote:
> On Fri, Mar 22, 2019 at 07:36:51PM -0500, Alexandru Gagniuc wrote:
>> A threaded IRQ with a NULL handler does not work with level-triggered
>> interrupts. request_threaded_irq() will return an error:
>>
>>    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 16
>>    pcie_bw_notification: probe of 0000:00:1b.0:pcie010 failed with error -22
>>
>> For level interrupts we need to silence the interrupt before exiting
>> the IRQ handler, so just clear the PCI_EXP_LNKSTA_LBMS bit there.
>>
>> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> 
> Applied with the following subject line to for-linus for v5.1, thanks!
> 
>    PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked

You're so much better at formulating commit messages. That sounds a lot 
smoother. Thanks!

>> ---
>> Changes since v1:
>>   - move pcie_update_link_speed() to irq to prevent duplicate read of link_status
>>   - Add Fixes: to commit message
>>   
>>   drivers/pci/pcie/bw_notification.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
>> index d2eae3b7cc0f..c48746f1cf3c 100644
>> --- a/drivers/pci/pcie/bw_notification.c
>> +++ b/drivers/pci/pcie/bw_notification.c
>> @@ -44,11 +44,10 @@ static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
>>   	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
>>   }
>>   
>> -static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>> +static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
>>   {
>>   	struct pcie_device *srv = context;
>>   	struct pci_dev *port = srv->port;
>> -	struct pci_dev *dev;
>>   	u16 link_status, events;
>>   	int ret;
>>   
>> @@ -58,6 +57,17 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>>   	if (ret != PCIBIOS_SUCCESSFUL || !events)
>>   		return IRQ_NONE;
>>   
>> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>> +	pcie_update_link_speed(port->subordinate, link_status);
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>> +{
>> +	struct pcie_device *srv = context;
>> +	struct pci_dev *port = srv->port;
>> +	struct pci_dev *dev;
>> +
>>   	/*
>>   	 * Print status from downstream devices, not this root port or
>>   	 * downstream switch port.
>> @@ -67,8 +77,6 @@ static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
>>   		__pcie_print_link_status(dev, false);
>>   	up_read(&pci_bus_sem);
>>   
>> -	pcie_update_link_speed(port->subordinate, link_status);
>> -	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
>>   	return IRQ_HANDLED;
>>   }
>>   
>> @@ -80,7 +88,8 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>>   	if (!pcie_link_bandwidth_notification_supported(srv->port))
>>   		return -ENODEV;
>>   
>> -	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
>> +	ret = request_threaded_irq(srv->irq, pcie_bw_notification_irq,
>> +				   pcie_bw_notification_handler,
>>   				   IRQF_SHARED, "PCIe BW notif", srv);
>>   	if (ret)
>>   		return ret;
>> -- 
>> 2.19.2
>>
