Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8A8C10F11
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4675F218D3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 08:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/PnvXUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfDXIvu (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 04:51:50 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41932 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbfDXIvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 04:51:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so17791690wrt.8
        for <linux-pci@vger.kernel.org>; Wed, 24 Apr 2019 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=hZNoGRQTub6pVmcM1SXiUK94HQnf2OGBhpWLncOSjkE=;
        b=J/PnvXUMu/DzcdipNQStsqJQ8iEsjYj7SS0en4wi2AuFo944jYfpCBcLnfan+bC00f
         mwi1QVg+0KK57yNetf3skShORndHfZGhh30N1+Z4A9kEAAAkwy89XQhY4guYAIRQiYJW
         xKT0eD2ko9XAaKbnYXTpSlQ6ocqKq4u65xO8ynPjUK4st6qlnhUaUnVQjZR0NJhGQF2C
         Wu9VEco4rwyczrhg3vuG5382B2O1VEYdaKlt5DOiFdN1fYqVory3CF+W4VRs3EbeRSIg
         oYc1t3baqe/nb/Zz/5kAPtnIr8KbW2af8W34icg2b9y0QtY/HY7X/SBwj68a4bOr4GTw
         CBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=hZNoGRQTub6pVmcM1SXiUK94HQnf2OGBhpWLncOSjkE=;
        b=IDxosb1a/cjXok0fA7o/dfRd83S/eL+koJmwL1nAPlGGxlSELOm2BejSZ3ros9pwvH
         ZnKkpr2UQytbPiApg/Hb/8o3mJETGEexjKAFwP/wC9QjgzHsp22i2znuMpEJ9dRlOyR/
         L5XPKT89Qe8JDQHZP7g932Dio9Vym4tSzDg5uUpXWpo+acxbb/MIf+PFPxOkwq9V4Ymc
         M9vBrOlLPF2erzxxJKomOFaBdV4UaC8idNhJdr5p0PRlHg2+mtYxAAZhJBhSX8xpl24b
         t1MPcM4IYXJV6AzwJ/V5TrMP+2G3zZxHHyrJ7k3kf12dTWTgmNCBsu/RuaDfNmMp9HGG
         RwNA==
X-Gm-Message-State: APjAAAUfO22V8Grh86zC3T8PmfNIWaWWd/JMu6hixhgmD4gS7xl2FB2q
        6iIiWGobxlNtRD36f1SUK9m07lMM
X-Google-Smtp-Source: APXvYqxiG6APhwi0tgC7dC3FnTvpAP2mJPn7pWmdyjdB1bhE5CMbUHbB+NiyXfpuZ1O+yJEX8RoSow==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr20188426wrj.249.1556095907963;
        Wed, 24 Apr 2019 01:51:47 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id y197sm19279845wmd.34.2019.04.24.01.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 01:51:47 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     logang@deltatee.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
References: <20190418115859.2394-1-christian.koenig@amd.com>
 <20190419191912.GG173520@google.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0d9e862a-1e83-731e-5e02-5de9103664ec@gmail.com>
Date:   Wed, 24 Apr 2019 10:51:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419191912.GG173520@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 19.04.19 um 21:19 schrieb Bjorn Helgaas:
> On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
>> A lot of root complexes can still do P2P even when PCI devices
>> don't share a common upstream bridge.
>>
>> Start adding a whitelist and allow P2P if both participants are
>> attached to known good root complex.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++++++++++---
>>   1 file changed, 35 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
>> index c52298d76e64..212baaa7f93b 100644
>> --- a/drivers/pci/p2pdma.c
>> +++ b/drivers/pci/p2pdma.c
>> @@ -274,6 +274,31 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>   	seq_buf_printf(buf, "%s;", pci_name(pdev));
>>   }
>>   
>> +/*
>> + * If we can't find a common upstream bridge take a look at the root complex and
>> + * compare it to a whitelist of known good hardware.
>> + */
>> +static bool root_complex_whitelist(struct pci_dev *dev)
>> +{
>> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
>> +	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
> The fact that 00.0 is a host bridge and that its vendor/device ID
> tells us whether peer-to-peer is supported between two *other* devices
> (provider and client) is all totally vendor-specific.  There's nothing
> in the PCI specs that says the host bridge even has to exist as a PCI
> device.

Crap, I hoped that at least the notion that the root complex is always 
00.0 is standardized somewhere.

> Is there any chance you could identify it by the Root Port
> vendor/device instead of groping around for the 00:0 device?  That
> would have been simpler, so I suppose that doesn't work for some
> reason.

I can give that a try. The main issue is that you got more different 
root ports than root complexes, so our list is going to get longer this way.

> I'm surprised that you don't need both the provider and the client to
> figure this out.  Wouldn't it would be possible to have two Root Ports
> under host bridge A that could do peer-to-peer to each other, but not
> to a Root Port under host bridge B?  E.g., I'd think you would need
> something like this:

At least for our hardware it's actually more likely that when devices 
are connected to different host bridges that they can talk directly to 
each other.

In other words when you have devices connected to the same host bridge 
you need to have P2P support inside that host bridge.

But when you have different host bridges P2P accesses look to the host 
bridge just like accesses coming from one of the CPU cores.

Regards,
Christian.

>
>    if (pci_find_host_bridge(a->bus) == pci_find_host_bridge(b->bus) &&
>        a->vendor == PCI_VENDOR_ID_AMD &&
>        b->vendor == PCI_VENDOR_ID_AMD &&
>        a->device == X &&
>        b->device == X)
>          return true;
>
>    return false;
>
> But I guess that still implicitly relies on the notion that everything
> under one PNP0A03 device is potentially connected via P2P, and I don't
> think there's anything the PCI or ACPI specs that would support that.
>
> Maybe we should add a pci_dev.p2p_group and make it so "a.p2p_group ==
> b.p2p_group" means that P2P is possible between them.  You'd have to
> have a quirk for the root ports to initialize p2p_group using whatever
> vendor-specific information you need, then everything under them could
> inherit from the parent.

Well exactly that's not going to work.

E.g. it can be that devices A can talk to devices B and C, but on the 
other hand B and C can't talk directly to each other.

Regards,
Christian.

>
>> +	unsigned short vendor, device;
>> +
>> +	if (!root)
>> +		return false;
>> +
>> +	vendor = root->vendor;
>> +	device = root->device;
>> +	pci_dev_put(root);
>> +
>> +	/* AMD ZEN host bridges can do peer to peer */
>> +	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
>> +		return true;
>> +
>> +	/* TODO: Extend that to a proper whitelist */
>> +	return false;
>> +}
>> +
>>   /*
>>    * Find the distance through the nearest common upstream bridge between
>>    * two PCI devices.
>> @@ -317,13 +342,13 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>>    * In this case, a list of all infringing bridge addresses will be
>>    * populated in acs_list (assuming it's non-null) for printk purposes.
>>    */
>> -static int upstream_bridge_distance(struct pci_dev *a,
>> -				    struct pci_dev *b,
>> +static int upstream_bridge_distance(struct pci_dev *provider,
>> +				    struct pci_dev *client,
>>   				    struct seq_buf *acs_list)
>>   {
>> +	struct pci_dev *a = provider, *b = client, *bb;
>>   	int dist_a = 0;
>>   	int dist_b = 0;
>> -	struct pci_dev *bb = NULL;
>>   	int acs_cnt = 0;
>>   
>>   	/*
>> @@ -354,6 +379,13 @@ static int upstream_bridge_distance(struct pci_dev *a,
>>   		dist_a++;
>>   	}
>>   
>> +	/* Allow the connection if both devices are on a whitelisted root
>> +	 * complex, but add an arbitary large value to the distance.
>> +	 */
>> +	if (root_complex_whitelist(provider) &&
>> +	    root_complex_whitelist(client))
>> +		return 0x1000 + dist_a + dist_b;
>> +
>>   	return -1;
>>   
>>   check_b_path_acs:
>> -- 
>> 2.17.1
>>

