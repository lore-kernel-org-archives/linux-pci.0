Return-Path: <SRS0=6A7A=Q3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D0C43381
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 08:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8AA52146E
	for <linux-pci@archiver.kernel.org>; Wed, 20 Feb 2019 08:42:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbfBTIma (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 20 Feb 2019 03:42:30 -0500
Received: from smtp6-g21.free.fr ([212.27.42.6]:51194 "EHLO smtp6-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfBTIma (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Feb 2019 03:42:30 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp6-g21.free.fr (Postfix) with ESMTPSA id A6FFD78034E;
        Wed, 20 Feb 2019 08:42:23 +0000 (UTC)
Subject: Re: WIP: PCIe on MSM8998
To:     Bjorn Helgaas <helgaas@kernel.org>
References: <c97b6f4e-4b4c-027f-5a0b-80b3f7054177@free.fr>
 <20190220054307.GB217569@google.com>
Cc:     PCI <linux-pci@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <11017597-3ba0-d32e-ff00-b2cf82adc9f7@free.fr>
Date:   Wed, 20 Feb 2019 09:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190220054307.GB217569@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 20/02/2019 06:43, Bjorn Helgaas wrote:

> On Tue, Feb 19, 2019 at 05:54:43PM +0100, Marc Gonzalez wrote:
> 
>> Next up: PCIe
>> WIP changes on top of next-20190213
> 
> I assume this is basically a bug report and some debugging info?
> It doesn't have a changelog or signed-off-by (and doesn't touch
> anything in drivers/pci/) so I assume you're not expecting this
> to be merged?

Hello Bjorn,

You are correct, there is nothing for you to merge.
WIP stands for "work in progress".
Perhaps I should have added RFC as well.

I am merely trying to enable PCIe on msm8998, and running into unexpected issues
(which I knew to expect).

Regards.
