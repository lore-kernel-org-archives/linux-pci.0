Return-Path: <SRS0=Txbz=2I=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AD2C43603
	for <linux-pci@archiver.kernel.org>; Wed, 18 Dec 2019 05:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5076218AC
	for <linux-pci@archiver.kernel.org>; Wed, 18 Dec 2019 05:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jonmasters-org.20150623.gappssmtp.com header.i=@jonmasters-org.20150623.gappssmtp.com header.b="zNU9URTp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbfLRFZG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 18 Dec 2019 00:25:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38935 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbfLRFZF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Dec 2019 00:25:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id e5so1003808qtm.6
        for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2019 21:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jonmasters-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uIMTyYXR3nXqdy95e1OaQ4blqi70Uo0OIJA0JwHv2YQ=;
        b=zNU9URTpXbNk0H+bfxQuplRFAZ/+QuFZ6Yd096coCKdylsucVnKFkkww084LxKN7G6
         ulzFsZdIg6SVR4tgU5cDYYlo0CXtfCmJPQycPblX0FFaYBE+cL5OKLuhei9teC6wUmmK
         Oc84j0+Vw2gcCS4XC4WrHqz+fOgW/0CdiGR1dfMf/HODZ23IlHU7H1OJ2CmQoBfC4Z94
         f3LbaBfhZ7wGluYaje4wnjvDGbcUfG9nrco1qf0kRn8/Ks0eSGsFKNjKDm+D7ZY8tNEi
         OLH5Ejd9W1dUkuKA9ZRRYIkpvVpXSQKY6b9y3iYGtMQQIKB/nk3glaiVf+nHotXjSwF/
         CilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=uIMTyYXR3nXqdy95e1OaQ4blqi70Uo0OIJA0JwHv2YQ=;
        b=GN4lFOADJn7lFgsWWAV43rp00uudumdpTZELehjSJ8N2N2ZoukPR247FH+dwuLm4PR
         AEJWfV5ZKU5Ctjq2ic3HgRYr5WQ7KvF9IvvDyMsFP71FcYM9PP4hL/YyaJB44hpVwAYX
         oxS+3SpoXPZVyZo44YdrB5m+xsc2km4Xpa1+X0eYV8rSJ6qPmgEXIqpU1z9HFZ8qR0HV
         EzyUmzWh+RnAAFssDbgJ1b0J4G2DZk3kCjwKHWNSs8FHD6aSU3RjHmhBflhTzDvtMNxL
         tHvrk8ydJ7nLKMWj/1hvLOvEDkZPyjwpZf5K9kJ/iveRuFbuTAm5wuBWGGD0D0u3E2ca
         sIYw==
X-Gm-Message-State: APjAAAXiazcmU2qkwT0vzDXZJvbIegZo/lJ+zgKLOTkZL+OCr4cdSIwR
        ozKCcCOBKADH81Kk7/1Tiu2G9Q==
X-Google-Smtp-Source: APXvYqw0LJ2pIxnufMfbafewC8CwiqT+EqKHOTuPpD18gUxiTVv4YVZQUuZHJ8Y4ZurUv0V5JwW/og==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr659933qta.367.1576646704962;
        Tue, 17 Dec 2019 21:25:04 -0800 (PST)
Received: from independence.bos.jonmasters.org (Boston.jonmasters.org. [50.195.43.97])
        by smtp.gmail.com with ESMTPSA id t7sm315351qkm.136.2019.12.17.21.25.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 21:25:04 -0800 (PST)
Subject: Re: [PATCH] pcie: Add quirk for the Arm Neoverse N1SDP platform
To:     Will Deacon <will@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20191209160638.141431-1-andre.przywara@arm.com>
 <20191209162645.GA7489@willie-the-truck>
From:   Jon Masters <jcm@jonmasters.org>
Organization: World Organi{s,z}ation of Broken Dreams
Message-ID: <dacfd8bf-0f68-f2af-9238-4b0fadfbdfe3@jonmasters.org>
Date:   Tue, 17 Dec 2019 21:21:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191209162645.GA7489@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 12/9/19 11:26 AM, Will Deacon wrote:
> On Mon, Dec 09, 2019 at 04:06:38PM +0000, Andre Przywara wrote:
>> From: Deepak Pandey <Deepak.Pandey@arm.com>
>>
>> The Arm N1SDP SoC suffers from some PCIe integration issues, most
>> prominently config space accesses to not existing BDFs being answered
>> with a bus abort, resulting in an SError.
> 
> "Do as I say, not as I do"?

In my former role I asked nicely that these patches not be posted 
upstream, but I see that they ended up being posted anyway. Hacking up 
upstream Linux to cover for the fact that a (reference) platform is 
non-standard is not only not good form but it actively harms the community.

You'll have people consume this platform and not realize that it's 
broken, IP won't get fixed, and generally it'll be a mess. Yes, it's 
unfortunate, but so was taping out that platform without working PCI. We 
all know what should have happened, and what the right move ahead is.

Jon.

-- 
Computer Architect
