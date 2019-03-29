Return-Path: <SRS0=8ruR=SA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C628FC43381
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973BA218D9
	for <linux-pci@archiver.kernel.org>; Fri, 29 Mar 2019 17:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EC8sc3aE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbfC2RDn (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 29 Mar 2019 13:03:43 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42012 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729808AbfC2RDn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Mar 2019 13:03:43 -0400
Received: by mail-yw1-f66.google.com with SMTP id e76so913242ywa.9
        for <linux-pci@vger.kernel.org>; Fri, 29 Mar 2019 10:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=W7lLylrMLPHCAGUksv7phTRR5l4lL+wrbNb4nVTTI3U=;
        b=EC8sc3aEu+o42Lz7ZTNOiKzzHjK/Cc1qEFQ3QLL+kviu9j/p4EcYSruPF3mg9PYqy/
         UBhsl4c+ufriWbWNHUwWO0GLUoUw2rgMRFoGU49Km7HR2R6JO3yCCUDCvvY1rcPZZw8v
         4J2Livfcgm024FE7wgwrq/VAQkbMqQovzl1Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=W7lLylrMLPHCAGUksv7phTRR5l4lL+wrbNb4nVTTI3U=;
        b=SHz084wjiyLEFN2yefVpsBomF8CCW0MoRHE65CmorpAldK3btOaypjQ9xDnG0ZBZ36
         rDE570dAjnmPp8MeW6w/XEkU+IjtqIk2kbPoFMUd4VKodGx4A9tRGpc3ghiZ0O1n7dTM
         fvWmd745YN37/KeFLPEROGWn98daQn0do90t1CTSz4/NSAttCJsynuOgUNGlgaj8YwH0
         zvtaUCLyTYjxvPztlv3S+K1xZC1gWDevuZQjp7Ea7HYYQnSrk1gNWeaqws4fEyrSnrCP
         bSm+2H+Gv3lovUd7ngBOwQiSPtOZzw4gziI2dJGN8kskI/Whi0VThoABKWo/iQKE7v24
         4gjA==
X-Gm-Message-State: APjAAAX6Sp5DCk6h4DBnDp2IPHysM0qJPiuNd/ZW8evYNB9CMo3RZ7d8
        +e0YwovyN5mmJ+gwjJ8jlaIC6w==
X-Google-Smtp-Source: APXvYqyeYDSQexnr3FGr8Gh2a+0J0RUTkckT7E54wveUyaGPapJFfeTzUlNBN9krRvmaeRINQUO9Vw==
X-Received: by 2002:a0d:e707:: with SMTP id q7mr19402037ywe.148.1553879022151;
        Fri, 29 Mar 2019 10:03:42 -0700 (PDT)
Received: from [10.136.13.65] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id 79sm1461582ywr.110.2019.03.29.10.03.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 10:03:40 -0700 (PDT)
Subject: Re: [PATCH v4 0/2] Add IPROC PCIe new features
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1551415936-30174-1-git-send-email-srinath.mannam@broadcom.com>
 <20190329165145.GC8768@e107981-ln.cambridge.arm.com>
From:   Scott Branden <scott.branden@broadcom.com>
Message-ID: <f154e036-c3c3-ad31-d7b1-09a81f11c23e@broadcom.com>
Date:   Fri, 29 Mar 2019 10:03:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190329165145.GC8768@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 2019-03-29 9:51 a.m., Lorenzo Pieralisi wrote:
> On Fri, Mar 01, 2019 at 10:22:14AM +0530, Srinath Mannam wrote:
>> This patch set extends support of new IPROC PCIe host controller features
>>   - Add CRS check using controller register status flags
>>   - Add outbound window mapping configuration for 32-bit I/O region
>>
>> This patch set is based on Linux-5.0-rc2.
>>
>> Changes from v3:
>>    - Addressed Lorenzo Pieralisi comments.
>>
>> Changes from v2:
>>    - Based on Lorenzo Pieralisi comments, commit logs are expanded.
>>
>> Changes from v1:
>>    - Addressed Bjorn Helgaas comments.
>>    - Removed set order mode patch from patchset.
>>
>> Srinath Mannam (2):
>>    PCI: iproc: Add CRS check in config read
>>    PCI: iproc: Add outbound configuration for 32-bit I/O region
>>
>>   drivers/pci/controller/pcie-iproc.c | 44 +++++++++++++++++++++++++++++++++----
> I need Ray a/o Scott ACK to merge this series, thanks.

Unfortunately we need this due to hardware design (which we continue to 
inform the silicon team to provide a proper design).


Acked-by: Scott Branden <scott.branden@broadcom.com>
>
> Lorenzo
