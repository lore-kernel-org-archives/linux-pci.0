Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54142C004D3
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 14:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE25A20824
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 14:48:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE25A20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeJXXRM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 19:17:12 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:53741 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726457AbeJXXRL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 19:17:11 -0400
Subject: Re: HP DL585 warm boot fail (old)
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
 <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
 <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
 <20181024134946.GA214775@bhelgaas-glaptop.roam.corp.google.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <8a8c6cf8-dd21-87db-3498-48f1ddb8fbc1@linux.ee>
Date:   Wed, 24 Oct 2018 17:47:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181024134946.GA214775@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Can you try the patch below?  This is extracted from the code here:
> https://github.com/joyent/illumos-joyent/blob/b6a0b04d591f5b877cfe05f45e81f0e8a5cfc2b3/usr/src/uts/intel/io/pci/pci_boot.c#L1805

Thank you. Unfortunately it does not change anything noticable.

> I'm not sure why this would be only an intermittent problem, but at
> least we can see if this is related.

It seems 4.19 and current git are 100% reproducers so far - I have not managed to
successfully boot either of them yet. I have seen 4.19-rc1 era git kernel booting at least once.

I noticed that Debian packaged 4.17 with initramfs worked fine so far for my test,
from these I have in grub menu. My selfcompiled kernels do not use initramfs.

-- 
Meelis Roos <mroos@linux.ee>
