Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A979C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FC020823
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBITszvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbfCYS1S (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 14:27:18 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42176 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYS1S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 25 Mar 2019 14:27:18 -0400
Received: by mail-oi1-f194.google.com with SMTP id w139so7779739oie.9;
        Mon, 25 Mar 2019 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8LyoMGjH5c+Hqc7iI1IZsTrpuCorPYvhv9hg2JSJwSw=;
        b=nBITszvEWj8DRmYma0AyC5LGgUdys732rnp6Oh2KnVZVRvuaiBtcC89iz9v6MiZjDp
         ux870q29YxJO4upBrKiMpsCL2ZHAhDGsYOhFwHHPurLkefL9y5O+I8x3qCljGn3hy6SC
         TMwCyxmMZIJ+pkVT8D3q8Qcmn0uOKcmFoMRvjD3rKk4GLmO+Sb9kYxbEURDmwKsZCCtp
         B98mRKqLnXi5gO/4i1vB3Hh+RuJf8lC5pOzpYS3g6YLzdRkPHHk45RgqUyjrpT0QG3DT
         yL9yh5+oSXwU9H6G+6uAsaI4WjO65cmV+NdYZ84TeJ0Wk2DkOjk6J2z74paw8BAgDPEY
         Qabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8LyoMGjH5c+Hqc7iI1IZsTrpuCorPYvhv9hg2JSJwSw=;
        b=QRFYSG87+MqP+A+Cwb0oAQmJost5fJrirxws8GnJ/hhWeetBYmqd8BrhviA3HDwhdG
         OEV4d/SUnqnILLL5StSSvsBxV/wZad6BZgVyQhOqfrNOMJwKy1BrWuAzhY5ep8rSuV5e
         bRPt5ibYc0uCvdXmzyJ+JO1auut7YqmXIPidskuI48L69cN7VnnjvNYRQ5wDJMNfR73+
         v91uU5QSZ1Ghkbkna2UrOGT5ihIWV9I+DGeJ7UnqSf2EnPn3gKGX5+uTVWL9CrRZPWTN
         0Q2YBtsjis/LGVdZ5jcRDaD5MqFwN7W3vU7EfzDV4DI2VJ3mWCOdfGgoaNWBESOSIgjx
         vxcQ==
X-Gm-Message-State: APjAAAUWc9FP110RIHy6IkAvm3ylKzkZouzXI9QIR7AOYn45lYRK1cuW
        8yQUCMK8kmj5jI8opIpW/bUFfkfW
X-Google-Smtp-Source: APXvYqzpjUaKNdJVApHeCRz53b3qgfvovrnVg6vc/JYL1WRPAo8MPvNmlvRb/xjMSnRAO85G2KcOWw==
X-Received: by 2002:aca:550c:: with SMTP id j12mr13054899oib.52.1553538437122;
        Mon, 25 Mar 2019 11:27:17 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id x89sm5255326ota.30.2019.03.25.11.27.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 11:27:16 -0700 (PDT)
Subject: Re: [PATCH] PCI/LINK: Request a one-shot IRQ with NULL handler
To:     Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
References: <20190325182338.13609-1-bp@alien8.de>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <0340b2f8-1301-2c3f-54a0-69a24c9e0d20@gmail.com>
Date:   Mon, 25 Mar 2019 13:27:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190325182338.13609-1-bp@alien8.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Borislav,

Thanks for the update. We've settled on a different fix [1], since Lukas 
was not happy with IRQF_ONESHOT [2].

Alex

[1] 
https://lore.kernel.org/linux-pci/20190323003700.7294-1-mr.nuke.me@gmail.com/
[2] 
https://lore.kernel.org/linux-pci/20190318043314.noyj6t4sh26spuzt@wunner.de/

On 3/25/19 1:23 PM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Booting v5.1-rc1 causes these new messages in dmesg here:
> 
>    genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 24
>    pcie_bw_notification: probe of 0000:00:02.0:pcie010 failed with error -22
> 
> because requesting a threaded IRQ with NULL handler needs to be oneshot.
> Otherwise a level-triggered interrupt endless loop can happen, see the
> detailed explanation above the "Threaded irq... " error message in
> kernel/irq/manage.c.
> 
> And PCI-MSI type interrupts are one-shot safe but not in the IOAPIC
> case:
> 
>    24: ... IO-APIC   28-fasteoi   PCIe BW notif, PCIe BW notif, PCIe BW notif
>    25: ... IO-APIC   29-fasteoi   PCIe BW notif, PCIe BW notif
> 
> Make the BW notification handler oneshot too.
> 
> Fixes: e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth notification")
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Cc: linux-pci@vger.kernel.org
> ---
>   drivers/pci/pcie/bw_notification.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> index d2eae3b7cc0f..16e11c09f6bd 100644
> --- a/drivers/pci/pcie/bw_notification.c
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -81,7 +81,7 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>   		return -ENODEV;
>   
>   	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
> -				   IRQF_SHARED, "PCIe BW notif", srv);
> +				   IRQF_SHARED | IRQF_ONESHOT, "PCIe BW notif", srv);
>   	if (ret)
>   		return ret;
>   
> 
