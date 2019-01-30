Return-Path: <SRS0=6RWV=QG=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D93C282D8
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 10:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57FA221852
	for <linux-pci@archiver.kernel.org>; Wed, 30 Jan 2019 10:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQeWgZG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfA3KZh (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:25:37 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55369 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727752AbfA3KZh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2019 05:25:37 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so20853106wmc.5;
        Wed, 30 Jan 2019 02:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=HMfAj4RzlX1XnDfgUELyfPYynmQa4PT0FdtcX8nLAvg=;
        b=nQeWgZG+3okJ3xJP/5vtiHEjozfG9PNxu1TD1aBQ6Ti7TWdzgJl2Q3GvVpAMRKj/gG
         v8VmvqoUOflO8tKhAN+hVgGBm1P89zcR9zQUNE0NjWcnxyHSBBn8rOvgFsYFNTl5juKA
         r5qu3AQtx6M2I0xOOjyECQmKJ7nyG1rywSLDaDLospHbPc9RwQbRtL38x4uGb+cHv6sB
         dNsBLpPZOUTq57Rwc/KiVyXMYhrixeu8p26WfD0lPXUiyp6Uc7C5T7nVgAi841mhcnKN
         9ALOQy3epnrxWJJXr89K51wqUMPQWoiWI+uGj1KFif/arpEid/MQKSI1yVFjCMvtTXp/
         jtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=HMfAj4RzlX1XnDfgUELyfPYynmQa4PT0FdtcX8nLAvg=;
        b=IZNti7bvrE4wuGnMivXDreB+ha/ZOJeSM+6xVyJs5OTOviHraNP7brjoyBLi8rw0cJ
         oFMJHFAogl+P3sUP4JbghBgoJKh62yIiF7S0Auo6cOzmsLUHc0oS3Nuc/KP7VVB6N7/C
         gjtmiJTjxUcUP8fkhe+uQWbeg2Pu4WbisWYzQIfcMOEaNk445iDGdiYJ3Mt09Xm1smzV
         mrpYkWI5QSug6qoXz13BHfkFf4Bl4Zi144Co14fRN1//Xe9zC1ULtS0BVlI3DE6c6sSX
         +Amhg7y2SWTE1jy/r6DgN7kW6ZMMBZ6JIXlTPHvDAQb529MwsDGk+mNFR5/clrxrU2iN
         MQrQ==
X-Gm-Message-State: AJcUuke9e5XGQ+GRwBtB6myBDuZTQNt/i6boEXtpUcJYx395hgLfSsxu
        bc360VmCMuIdzasmirxtuRg=
X-Google-Smtp-Source: ALg8bN7YvuWVZeFypre8aGXXvQP91o/M7l9lFXYWW0v/0gLd419E55sGFQXtn4PBsmBOuDaRwvY+iA==
X-Received: by 2002:a1c:be11:: with SMTP id o17mr24245832wmf.111.1548843935769;
        Wed, 30 Jan 2019 02:25:35 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id y13sm665205wrn.73.2019.01.30.02.25.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 02:25:34 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [RFC PATCH 1/5] pci/p2p: add a function to test peer to peer
 capability
To:     Logan Gunthorpe <logang@deltatee.com>,
        Alex Deucher <alexdeucher@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>
Cc:     Joerg Roedel <jroedel@suse.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-mm <linux-mm@kvack.org>, iommu@lists.linux-foundation.org,
        Jason Gunthorpe <jgg@mellanox.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20190129174728.6430-1-jglisse@redhat.com>
 <20190129174728.6430-2-jglisse@redhat.com>
 <CADnq5_N8QLA_80j+iCtMHvSZhc-WFpzdZhpk6jR9yhoNoUDFZA@mail.gmail.com>
 <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <6739544c-0122-ad8c-d3cf-86a4d8a1d7a2@gmail.com>
Date:   Wed, 30 Jan 2019 11:25:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <83acb590-25a5-f8ae-1616-bdb8b069fa0f@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Am 29.01.19 um 21:24 schrieb Logan Gunthorpe:
>
> On 2019-01-29 12:56 p.m., Alex Deucher wrote:
>> On Tue, Jan 29, 2019 at 12:47 PM <jglisse@redhat.com> wrote:
>>> From: Jérôme Glisse <jglisse@redhat.com>
>>>
>>> device_test_p2p() return true if two devices can peer to peer to
>>> each other. We add a generic function as different inter-connect
>>> can support peer to peer and we want to genericaly test this no
>>> matter what the inter-connect might be. However this version only
>>> support PCIE for now.
>>>
>> What about something like these patches:
>> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=4fab9ff69cb968183f717551441b475fabce6c1c
>> https://cgit.freedesktop.org/~deathsimple/linux/commit/?h=p2p&id=f90b12d41c277335d08c9dab62433f27c0fadbe5
>> They are a bit more thorough.
> Those new functions seem to have a lot of overlap with the code that is
> already upstream in p2pdma.... Perhaps you should be improving the
> p2pdma functions if they aren't suitable for what you want already
> instead of creating new ones.

Yeah, well that's what I was suggesting for the very beginning :)

But completely agree the existing functions should be improved instead 
of adding new ones,
Christian.

>
> Logan
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

