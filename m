Return-Path: <SRS0=WZ4f=NE=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B72C67863
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8566A206B5
	for <linux-pci@archiver.kernel.org>; Wed, 24 Oct 2018 07:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8566A206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbeJXQZV (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:25:21 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:53228 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbeJXQZV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Oct 2018 12:25:21 -0400
X-Greylist: delayed 567 seconds by postgrey-1.27 at vger.kernel.org; Wed, 24 Oct 2018 12:25:20 EDT
Subject: Re: HH DL585 warm boot fail (old)
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org
References: <alpine.LRH.2.21.1807051515260.21817@math.ut.ee>
 <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <b36c537a-90ee-c474-9efa-df2ead8e0376@linux.ee>
Date:   Wed, 24 Oct 2018 10:47:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAErSpo6Fp8XpTQi7gcSQEuvpuJMYCMn5Y0cXRNvmO_opSR08HQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Would you mind opening a report at https://bugzilla.kernel.org?  I'm
> not sure if anybody will be able to do anything about this, but it's
> always possible.

Submitted now, https://bugzilla.kernel.org/show_bug.cgi?id=201503

> 
> A complete dmesg log and "sudo lspci -vv" output from a successful
> boot would be a good start.  And if you have a screenshot of the
> failure, that would help, too.  You can use the "ignore_loglevel"
> kernel parameter to make sure we see everything on the console.

Added.

>  Does
> this machine have an iLO?  If so, it may have logs that could be
> useful if this is related to some sort of bus error.

Nothing in the ILO logs.

-- 
Meelis Roos <mroos@linux.ee>
