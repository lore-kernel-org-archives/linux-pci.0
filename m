Return-Path: <SRS0=4zPb=NS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61356C0044C
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2527F20882
	for <linux-pci@archiver.kernel.org>; Wed,  7 Nov 2018 13:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RL/MQsaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2527F20882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeKGXVy (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:21:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41261 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbeKGXVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Nov 2018 18:21:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id 70so1773267pgh.8;
        Wed, 07 Nov 2018 05:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rucc7aUCdkhJRnn1/uw6PuIgpBic9W5BcUjPz/9T8BQ=;
        b=RL/MQsaq4LMS9y9LtEYIPHHRoS6WeSHKtHzf/E1o7ZfOP+DSM5ewbipQgxhq7dDdY5
         JUocp39eu6cvTfN24h5h3SLuYtUbjU61S4nXDI7jCqhMqetzouKNg4iC7b8MXV3yOUVt
         ulgm6qHgW2GVuRdlb7ptGRB6EdaOS0lPCPGrd7RNayUHffu0lj7Vo9pe0ZF8PL3Z6ffw
         eJV6bJi/Qj9Q3ob0d5a+9QGe9wN4LqJXGVX58bxkE42eXObOb9sodHF7ybG2bzAwG7xn
         ayxnN5XSJcMxQSMtDEW7omubPmSNVezRJt1zcga7Fh9wp+FUAfdbrb0s7uDCH8x5mgNv
         FCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rucc7aUCdkhJRnn1/uw6PuIgpBic9W5BcUjPz/9T8BQ=;
        b=tyTdpTFwqDHHOCNLVgMF4AO+EQttcZEfht3VFgLc82zfcaojpQgg/5sfKs6C8HxQhZ
         SqHN5eEhItl9VEYdchsBnW2WdRmeBo8423A6aKcSIzc0L+pMeaIrHiDw2xkEb5C2WZOM
         zx+ucpc4WmtySrPUgui9dvuKQDKZp8XT0fFUaaqO7R5FDAtLj4WBNBJBUOKeNxSfLHwo
         7WmXIO+oZgGERoveRJIdku5wj2iMsBMMm+kPedQ4itxyq0vqodvCN9Tfcmv5du+h4R0b
         cvUPIDTGYuLNjt4Appru71dGQnocsL8IGgUEexPWY/Y7rBC9EeEzjl9WoCp+oESvmBNT
         f9Kw==
X-Gm-Message-State: AGRZ1gISSIJiMYN6hu3l3//vW3V/k1Fw0RedkS3jsbyoMLTUH9psAKuo
        6LsvQt+ntGo8Kc4Kfs67WDfR7ce4
X-Google-Smtp-Source: AJdET5fRD04ZjvYZymsuXEKD0EaS0ho2VjOgKQAbCH5l93XaRoWAaEY8L7+V74zptXMWyQcpWcAzZA==
X-Received: by 2002:a63:1cd:: with SMTP id 196-v6mr264145pgb.152.1541598685573;
        Wed, 07 Nov 2018 05:51:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r81-v6sm1337732pfa.110.2018.11.07.05.51.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 05:51:24 -0800 (PST)
Subject: Re: [PATCH 2/4] x86/amd_nb: add support for newer PCI topologies
To:     Borislav Petkov <bp@alien8.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Woods, Brian" <Brian.Woods@amd.com>,
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
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20181102181055.130531-1-brian.woods@amd.com>
 <20181102181055.130531-3-brian.woods@amd.com>
 <20181102195925.GB160487@google.com> <20181102232948.GC26770@zn.tnic>
 <20181105214537.GA19420@google.com> <20181105215650.GG26868@zn.tnic>
 <20181106214256.GA65443@google.com> <20181106220059.GA4139@zn.tnic>
 <20181106232040.GA85755@google.com> <20181107091838.GA10835@zn.tnic>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <72f4a144-fe83-dc0d-b839-133873ed589b@roeck-us.net>
Date:   Wed, 7 Nov 2018 05:51:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107091838.GA10835@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/7/18 1:18 AM, Borislav Petkov wrote:
> On Tue, Nov 06, 2018 at 05:20:41PM -0600, Bjorn Helgaas wrote:
>> Or maybe even drivers/acpi/thermal.c, which claims every Thermal Zone
>> (ACPI 6.2, sec 11), would be sufficient.  I don't know what the
>> relationship between hwmon and other thermal stuff, e.g.,
>> Documentation/thermal/sysfs-api.txt is.  acpi/thermal.c looks tied
>> into the drivers/thermal stuff (it registers "thermal_zone" devices),
>> but not to hwmon.
> 
> Err, I still don't think I'm catching your drift but let me stop you
> right there: amd_nb is not there only for hwmon/k10temp. It is a small
> interface glue if you will, which exports the CPU functionality in PCI
> config space to other consumers.
> 

Also, thermal and hwmon are orthogonal, just like hwmon and iio. One would
typically have a driver in one subsystem, in some cases bridging to the
other subsystem, but one would not have drivers in both subsystems.
I think Bjorn is suggesting that the k10temp driver should move to the
thermal subsystem, though I don't really understand what that has to do
with finding the correct PCI device(s) to query. Or maybe I misunderstand.

Guenter

> So it is not really a driver - it is used by drivers to talk/query CPU
> settings through it.
> 
> With that said, I don't think I understand all that talk about PNP IDs
> and ACPI methods. But maybe I'm missing something...
> 
> So what's up?
> 

