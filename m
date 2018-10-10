Return-Path: <SRS0=medT=MW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D06C43441
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5042075C
	for <linux-pci@archiver.kernel.org>; Wed, 10 Oct 2018 23:14:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5042075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbeJKGiP (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Oct 2018 02:38:15 -0400
Received: from ale.deltatee.com ([207.54.116.67]:54276 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727693AbeJKGiP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Oct 2018 02:38:15 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gANfp-000698-QX; Wed, 10 Oct 2018 17:13:50 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Doug Meyer <dmeyer@gigaio.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>
References: <20181005154940.964-1-logang@deltatee.com>
 <20181010210825.GK5906@bhelgaas-glaptop.roam.corp.google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <13a46658-8b16-6f82-2add-75bd0be63ff5@deltatee.com>
Date:   Wed, 10 Oct 2018 17:13:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181010210825.GK5906@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kurt.schwemmer@microsemi.com, bhelgaas@google.com, dmeyer@gigaio.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2] PCI: Fix Switchtec DMA aliasing quirk dmesg noise
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-10 3:08 p.m., Bjorn Helgaas wrote:
> Applied to pci/misc for v4.20, thanks!
> 
> I split this into two patches so the important change doesn't get lost in
> the noise of the SWITCHTEC_QUIRK() addition:
> 
>   - Add the SWITCHTEC_QUIRK() macro, but don't change anything else
>   - Change SWITCHTEC_QUIRK() to use DECLARE_PCI_FIXUP_CLASS_FINAL

Perfect, thanks!

Logan
