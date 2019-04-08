Return-Path: <SRS0=/7fE=SK=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D6BC10F13
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4533218EA
	for <linux-pci@archiver.kernel.org>; Mon,  8 Apr 2019 13:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tbSljnQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfDHNrF (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:47:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33891 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfDHNrF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 8 Apr 2019 09:47:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7674092pfd.1;
        Mon, 08 Apr 2019 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bA3xHovmU0AxpjkISvV7+u6Ja6S4kibtytv24C/NXU4=;
        b=tbSljnQqMQASvvFOR0nbGbyT2qK0aW2sYDXEFmQHt78rCw9q8jtj2Qi0bN/5ko3QU4
         P4i8/JWSsBrvYI8fbMB0zvDHHWQ2pJ9DB8u+1hzb5FB2hkhXur66CRcw1iPilIxK23ZK
         UHQOWDXOKbvlfWaVLZYmqjvonZDqYE/nQdCDr7lerttJ4b8IV3h+GmcWHoNbuY2JsSaY
         xOm4xO1JfL2bDl1M4BuQEbyXEHM+sV6HF5admLe+EkhSvquLiyy5KeVStU+XDAAx3i1M
         cYKGuJExczKfziDE6rDw15LgCZehgkrsPAblEgKUnUXzCTLmitXMyWUsAcjgdf0HJyz1
         6nVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bA3xHovmU0AxpjkISvV7+u6Ja6S4kibtytv24C/NXU4=;
        b=Q56WUVwEnGhoyMaCsEwPd6oKmRcJO6dnSxuunVUkWySlNb12sIu3sMjMGhkcwsJr2f
         o0lYQp5TZ1ga+4goOglqmeC9YE95cJ1SI2ApCsKvAg9s7/Pp4WD8DmWCGtbuSMMgWsNd
         UvF5H7wadTqQ8FETozvbHBiOVncGNkx33gNVmXedHJFXn5Dnkas5nqktqiVWOAck9Pe1
         Pg9kSeFKdlAgnTZUtpUlzc1YKorcX925BKfeEaw8QoB6+P6jfq58h0dwPMkMrI4Md2dG
         XA2O+MYiDSJLQV7jS4K2np2cwFPaxL7vp+jM5rUx/9QzCRtt/0SgQBJxQi2jmcW2rfqJ
         maZA==
X-Gm-Message-State: APjAAAXjYslLJGgHJs7hU64TnTA4IgDT5uVOCyCWMFhiisnH8sbYHksP
        MwsyvH1K87q1UgLUieBRHfSO7ELk
X-Google-Smtp-Source: APXvYqwF0rcJMo1kG5NSxrW8klOtxThLb74Ar+9qDGHR/8J+RPBW4uY1rKDQSss7qXWTJeb3zSrzyw==
X-Received: by 2002:a63:170d:: with SMTP id x13mr28794840pgl.169.1554731223998;
        Mon, 08 Apr 2019 06:47:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 8sm55508729pfs.50.2019.04.08.06.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 06:47:02 -0700 (PDT)
Subject: Re: [PATCH v3 3/4] lib: logic_pio: Reject accesses to unregistered
 CPU MMIO regions
To:     John Garry <john.garry@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     wangkefeng.wang@huawei.com, lorenzo.pieralisi@arm.com,
        arnd@arndb.de, rafael@kernel.org, linux-pci@vger.kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, andy.shevchenko@gmail.com,
        catalin.marinas@arm.com, bp@suse.de,
        linux-arm-kernel@lists.infradead.org,
        Hardware Monitoring <linux-hwmon@vger.kernel.org>
References: <1554393602-152448-1-git-send-email-john.garry@huawei.com>
 <1554393602-152448-4-git-send-email-john.garry@huawei.com>
 <20190404164130.GA12203@roeck-us.net>
 <24cc8006-0f0d-6b20-a466-e4a32a0bb656@huawei.com>
 <20190404174336.GA10404@roeck-us.net> <20190404185815.GA26522@google.com>
 <2d0f583a-cabe-df4e-ad89-c1800d9b4804@huawei.com>
 <20190405180615.GB109021@google.com> <20190405182923.GA11563@roeck-us.net>
 <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <9be8d131-d1d5-cc97-26fe-e32fe30c0544@roeck-us.net>
Date:   Mon, 8 Apr 2019 06:47:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <ec054678-ce9e-bd5c-5225-a025214f1075@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/19 1:19 AM, John Garry wrote:
> On 05/04/2019 19:29, Guenter Roeck wrote:
>> On Fri, Apr 05, 2019 at 01:06:15PM -0500, Bjorn Helgaas wrote:
>>> On Fri, Apr 05, 2019 at 09:10:27AM +0100, John Garry wrote:
>>>> On 04/04/2019 19:58, Bjorn Helgaas wrote:
>>>>> On Thu, Apr 04, 2019 at 10:43:36AM -0700, Guenter Roeck wrote:
>>>>>> On Thu, Apr 04, 2019 at 05:52:35PM +0100, John Garry wrote:
>>>>>>>>> Note that the f71805f driver does not call
>>>>>>>>> request_{muxed_}region(), as it should.
>>>>>>>
>>>>>>>> ... which is the real problem, one that is not solved by this
>>>>>>>> patch. This may result in parallel and descructive accesses if
>>>>>>>> there is another device on the LPC bus, and another driver
>>>>>>>> accessing that device. Personally I'd rather have
>>>>>>>> request_muxed_region() added to the f71805f driver.
>>>>>>>
>>>>>>> Right, we should and will still fix f71805f. If you recall, I did
>>>>>>> have the f71805f fix in the v1 series, but you committed that it
>>>>>>> was orthogonal, so I decided to take it out of this work for now.
>>>>>>>
>>>>>>> And even if we fix up f71805f and other known drivers which don't
>>>>>>> call request_muxed_region(), we still need to police against these
>>>>>>> rogue accesses, which is what this patch attempts to do.
>>>>>>>
>>>>>> Do we ? I am personally not convinced that LPC accesses _have_ to
>>>>>> occur through PCI on any given system.
>>>>>
>>>>> On current systems, I suspect ISA/LPC devices are typically connected
>>>>> via a PCI-to-ISA/LPC bridge.  But AFAIK there's no actual requirement
>>>>> for that bridge, and there certainly *were* systems with ISA devices
>>>>> but no PCI at all.
>>>>>
>>>>> IMO, if you want to build ISA drivers on your arch, you need to make
>>>>> sure the inb() probing done by those drivers works like it does on
>>>>> x86.  If there's no device there, the inb() should return 0xff with no
>>>>> fuss and no crash.
>>>>
>>>> Right, and this is what I am attempting to do here.
>>>>
>>>> So today a call to request_muxed_region() can still succeed even if no IO
>>>> space mapped.
>>>>
>>>> As such, even well-behaved drivers like f71882fg can still crash the system,
>>>> as noted in RFC patch 1/4 ("resource: Request IO port regions from children
>>>> of ioport_resource").
>>>
>>> Maybe I'm missing something, but on x86, drivers like f71882fg do not
>>> crash the system because inb() *never* causes a crash.
>>>
>>> If you want to build that driver for ARM, I think you need to make
>>> sure that inb() on ARM also *never* causes a crash.  I don't think
>>> changing f71882fg and all the similar drivers is the right answer.
>>>
>>
>> Agreed. As I had mentioned earlier, the driver changes are orthogonal:
>> the drivers should request the IO region before accessing it, primarily
>> to avoid conflicting accesses by multiple drivers in parallel. For
>> example, the f71882fg driver supports chips which implement hardware
>> monitoring as well as watchdog functionality, and both the hwmon
>> and the watchdog driver may try to access the io space.
>>
>> If and how the system ensures that the IO region exists and/or that
>> inb() always succeeds is a different question. I would prefer a less
>> complex solution than the one suggested here, but that is my personal
>> opionion.
> 
> Hi Guenter,
> 
> I have a question about these super-IO accesses:
> 
> To me, it's not good that these hwmon, watchdog, gpio, etc drivers make unconstrained accesses to 0x2e and 0x4e ports (ignoring the request_muxed_region() call).
> 
> The issue I see is that on an arm, IO space for some other device may be mapped in this region, so it would not be right for these drivers to access those same regions.
> 
Yes, but then there _could_ be some arm or arm64 device supporting one of those chips,
so we can not just add something like "depends on !(ARM || ARM64)".

> Is there any other platform check which can be made to ensure that accesses these super-IO ports is appropriate?
> 

Not that I know of. It would make some sense to provide API functions
for Super-IO accesses, but that would be a lot of work, and I guess
it isn't really valuable enough for anyone to pick up and do.

Normally, if you have such a system, the respective drivers should not be
built. After all, this isn't the only instance where drivers unconditionally
access some io region, no matter if the underlying hardware exists or not.
The only real defense against that is to not build those drivers into
a given kernel.

Guenter
