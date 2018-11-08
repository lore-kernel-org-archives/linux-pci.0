Return-Path: <SRS0=XjPq=NT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9536C0044C
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 01:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7751F20818
	for <linux-pci@archiver.kernel.org>; Thu,  8 Nov 2018 01:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCnd/rE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7751F20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKHLNV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 8 Nov 2018 06:13:21 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38506 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728372AbeKHLNU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Nov 2018 06:13:20 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4-v6so6341019plo.5;
        Wed, 07 Nov 2018 17:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jeqY7eFzEKBYQPj+khgCjKjeM43EIFozZ8l2056K7eM=;
        b=iCnd/rE5PC+xeDoTFurFN9es+d64VclCudvsfPv5/mQ3qLO62fZfIa++91Qd5Vpam8
         ONPlr9FLZkr86aKY8F6pT77YkRmq8s4RLKzlFNVU9RR/KNRlkodt6EvEOZSTQWnCTQVJ
         8+xNcStzc+Fq+AunPpVoXwtQQmVsUFkO5q62B9YHKXP/wWxsp2I2xJaPmYTaSJByy8M6
         lhYWVphKIK5kYTODm+UaQ8urFTLspyiKDL3xdDv6kFhJf5wYDry3ZQNMZwuLgVbBTAbW
         WobG74ueElb/iARN/t9fQY1EiCrkw2MMcVgaRfA9FY2Y3IouIHsgz1xPxuMgyxupaENk
         WjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jeqY7eFzEKBYQPj+khgCjKjeM43EIFozZ8l2056K7eM=;
        b=n+wkxU/ttEIT4+zoC07rNrVN427WuLOTFU6E7u3Fp0OMW9F9xott/s11g6cZzLCVN1
         20A2u2vvS5B8sTyS6992nNy2fcBlkdrJhnhCqPnpSGCoBoG1CXHzbheevi4e7rbKaWam
         yZ/x82/DHY+wqEsYq08ZCU4bgZXYy5KlfTp9w7c+sN/uwp3FO494yOHxKefKU+VwkihY
         47nOuxI2gxv3Wrb6lcRkOjJuRZXL5HQKGvrHjW0QQYUd2an1BvVYhuhxpmQWdmzlnJi5
         kNRlDaaZNoCKpoDh5p82hZEgw8nDtWUGyJxGQS7BHVY4Du0TVJqQuqe4iINQEnXTE1gy
         bdrA==
X-Gm-Message-State: AGRZ1gJtVo7W6Lt1eNrc39+Eo233R9Q1lNmYUaB6h6blp4/lMRcsLA07
        lVOjll79gqFM9oaLwj+g8rKkvKWW
X-Google-Smtp-Source: AJdET5eV2hXvshwIRSrkwqcxWqilU5tXX0iRtQJ8zdcMYuZWFZ2Qc02PoPGx2h0aaGtLXqqwcedDWQ==
X-Received: by 2002:a17:902:7a2:: with SMTP id 31-v6mr2562567plj.277.1541641218379;
        Wed, 07 Nov 2018 17:40:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 3-v6sm2049338pga.12.2018.11.07.17.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 17:40:17 -0800 (PST)
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        "Woods, Brian" <Brian.Woods@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, Pu Wen <puwen@hygon.cn>,
        Jia Zhang <qianyue.zj@alibaba-inc.com>,
        Takashi Iwai <tiwai@suse.de>,
        Andy Whitcroft <apw@canonical.com>,
        Colin Ian King <colin.king@canonical.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20181102195925.GB160487@google.com>
 <20181102232948.GC26770@zn.tnic> <20181105214537.GA19420@google.com>
 <20181105215650.GG26868@zn.tnic> <20181106214256.GA65443@google.com>
 <20181106220059.GA4139@zn.tnic> <20181106232040.GA85755@google.com>
 <75748b089ee696d5cbaa5c0ce68bad228699894c.camel@linux.intel.com>
 <20181107213103.GA41183@google.com>
 <baf4b2e9c9b7cb2f827fd3bffce4b72f6d9376a8.camel@linux.intel.com>
 <20181107231411.GB41183@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <2c4b9e7e-6558-e5ce-50e6-58aaec22fd1c@roeck-us.net>
Date:   Wed, 7 Nov 2018 17:40:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107231411.GB41183@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/18 3:14 PM, Bjorn Helgaas wrote:
>
>>
>> There is no INT3401 on any newer atom or core platforms, so you can't
>> enumerate on this device. We don't control what ACPI device is present
>> on a system. It depends on what the other non-Linux OS is using.
> 
> Sure, you can't *force* OEMs to supply a given ACPI device, but you
> can certainly say "if you want this functionality, supply INT3401
> devices."  That's what you do with PNP0A03 (PCI host bridges), for
> example.  If an OEM doesn't supply PNP0A03 devices, the system can
> boot just fine as long as you don't need PCI.
> 
> This model of using the PCI IDs forces OS vendors to release updates
> for every new platform.  I guess you must have considered that and
> decided whatever benefit you're getting was worth the cost.
> 

I really dislike where this is going. Board vendors - and that included
Intel when Intel was still selling boards - have a long history of only
making mandatory methods available in ACPI. Pretty much all of them don't
make hardware monitoring information available via ACPI. This is a pain
especially for laptops where the information is provided by an embedded
controller. On systems with Super-IO chips with dedicated hardware
monitoring functionality, they often go as far as signing mutual NDAs
with chip vendors, which lets both the board and the chip vendor claim
that they can not provide chip specifications to third parties, aka
users.

You are pretty much extending that to CPU temperature monitoring. The
fallout, if adopted, will be that it will effectively no longer be
possible to monitor the temperature on chips supporting this
"feature".

I do not think that would be a good idea.

Guenter
