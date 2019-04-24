Return-Path: <SRS0=9smm=S2=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C52C282CE
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 581F22064A
	for <linux-pci@archiver.kernel.org>; Wed, 24 Apr 2019 17:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmE2Yk0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403923AbfDXRmX (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:42:23 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37306 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392001AbfDXRfy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Apr 2019 13:35:54 -0400
Received: by mail-oi1-f194.google.com with SMTP id k6so1243760oic.4;
        Wed, 24 Apr 2019 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RoiHWPNMrW1wAZiv9BalAZvBSP4FzqSrxbMz8PnXL24=;
        b=cmE2Yk0wjzqgTtMAU7K2bGXt33qkVvJCcQYzNCinhhqRauWmVPq/hdrQhNxMwaVLrs
         bvvqWtUeYVD7INNqNjSiLtGOu6C2voTqD/n54vG6n65ULh1f7+J1tSWFlmHJtbJCNe6h
         FtF5OOW2Id9Dll9YduLZJfjcdqwtczX1g1XnojZMq5QQw24WR21sPTndwQG5WGFKq4Id
         3bGOlxmXfISJTbbzSiQriUfGMCzdA0NyN6To92sN2xsTZqTPF3uRFMaSj9CiTnHMnzZc
         srT4h+q5KyYG83y8eSFC0MT7HK+sExfxinjv/KSQNNTK8f525O++wujZta0cIyDeoMXs
         qF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RoiHWPNMrW1wAZiv9BalAZvBSP4FzqSrxbMz8PnXL24=;
        b=epQQSmLJaBX2P17GGwo7e0kb6V+ifptH5UCTtOReQ3BpsEc2OevXGh/FOEVVVILnFi
         NiUoj4z3pN4yW8rsRBGJdDP3MuBVcdS2iz26lf3sBudXpYMSJrasCI+oNZIuyYDhUF1J
         q9NtXy+ybA2pE8NM4y2uP0cKQhstzftOvYHOGKwUkdtcooLWNo1EMJz4j3+2RZtmndbs
         s6lNyqc2a4RsMKssrwChZlmTS7GATlhqH+jNzvKRB6W86kynVi9ZbB8wo2UtxV2UGzlg
         br0mapN9J06LrmH4ri5PNA1VbabzIqngEQKdXZqJAAb2rj5XFDJyPBCr+fRJXBjKVECm
         TAxQ==
X-Gm-Message-State: APjAAAXqE38m1/clIcp2V2mEQOGh5NPC+h8H2Ct4/IoCygV4sIJWd/Qc
        9AUGcrVYaCXZqNzgFlV9wiEZhdWixBM=
X-Google-Smtp-Source: APXvYqwqpysJtUpOFE289xqEGkNeYoEoZ3HyQV63T+OWlvUv+OApdxgs2oN0VodPBtDQYKf0hgO63g==
X-Received: by 2002:aca:b588:: with SMTP id e130mr128467oif.161.1556127353588;
        Wed, 24 Apr 2019 10:35:53 -0700 (PDT)
Received: from nukespec.gtech ([2601:2c1:8501:182d::6fe])
        by smtp.gmail.com with ESMTPSA id 75sm1474746otn.31.2019.04.24.10.35.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 10:35:52 -0700 (PDT)
Subject: Re: [PATCH] PCI: Add link_change error handler and vfio-pci user
To:     Alex Williamson <alex.williamson@redhat.com>,
        Alex_Gagniuc@Dellteam.com
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        Austin.Bolen@dell.com, keith.busch@intel.com, Shyam.Iyer@dell.com,
        lukas@wunner.de, okaya@kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <155605909349.3575.13433421148215616375.stgit@gimli.home>
 <44c43b8c1739488181930c074bb6eddb@ausx13mps321.AMER.DELL.COM>
 <20190424111943.376d7d24@x1.home>
From:   Alex G <mr.nuke.me@gmail.com>
Message-ID: <1ee5f50e-a34b-5e15-e6d8-c32f1e1e73ea@gmail.com>
Date:   Wed, 24 Apr 2019 12:35:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424111943.376d7d24@x1.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/24/19 12:19 PM, Alex Williamson wrote:
> On Wed, 24 Apr 2019 16:45:45 +0000
> <Alex_Gagniuc@Dellteam.com> wrote:
>> On 4/23/2019 5:42 PM, Alex Williamson wrote:
>>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>> index 7e12d0163863..233cd4b5b6e8 100644
>>> --- a/drivers/pci/probe.c
>>> +++ b/drivers/pci/probe.c
>>> @@ -2403,6 +2403,19 @@ void pcie_report_downtraining(struct pci_dev *dev)
>>
>> I don't think you want to change pcie_report_downtraining(). You're
>> advertising to "report" something, by nomenclature, but then go around
>> and also call a notification callback. This is also used during probe,
>> and you've now just killed your chance to notice you've booted with a
>> degraded link.
>> If what you want to do is silence the bandwidth notification, you want
>> to modify the threaded interrupt that calls this.
> 
> During probe, ie. discovery, a device wouldn't have a driver attached,
> so we'd fall through to simply printing the link status.  Nothing
> lost afaict.  The "report" verb doesn't have a subject here, report to
> whom?  Therefore I thought it reasonable that a driver ask that it be
> reported to them via a callback.  I don't see that as such a stretch of
> the interface.

That's just stretching the logic, and IMO makes the intent harder to 
understand. The argument relies on the state of the PCI device and 
logic, which is not obvious to the casual observer. If you want to 
bypass the bandwidth notification, then bypass the notification.

>>>    	if (PCI_FUNC(dev->devfn) != 0 || dev->is_virtfn)
>>>    		return;
>>>    
>>> +	/*
>>> +	 * If driver handles link_change event, defer to driver.  PCIe drivers
>>> +	 * can call pcie_print_link_status() to print current link info.
>>> +	 */
>>> +	device_lock(&dev->dev);
>>> +	if (dev->driver && dev->driver->err_handler &&
>>> +	    dev->driver->err_handler->link_change) {
>>> +		dev->driver->err_handler->link_change(dev);
>>> +		device_unlock(&dev->dev);
>>> +		return;
>>> +	}
>>> +	device_unlock(&dev->dev);
>>
>> Can we write this such that there is a single lock()/unlock() pair?
> 
> Not without introducing a tracking variable, ex.
[snip bad code]
> That's not markedly better imo, but if it's preferred I can send a v2.

How about:

if (!invoke_link_changed_handler(pdev))
	very_useful_downtraining_message(pdev);

> Alex
Alex
