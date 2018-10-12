Return-Path: <SRS0=mL0v=MY=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1844C6787C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 17:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782C32077C
	for <linux-pci@archiver.kernel.org>; Fri, 12 Oct 2018 17:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 782C32077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbeJMB17 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:27:59 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39024 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726717AbeJMB16 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Oct 2018 21:27:58 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gB1dd-0002U7-Oa; Fri, 12 Oct 2018 11:54:15 -0600
To:     Jonathan Corbet <corbet@lwn.net>,
        Wesley Sheng <wesleyshenggit@sina.com>
Cc:     kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, linux-ntb@googlegroups.com,
        Wesley Yung <wesley.yung@microchip.com>,
        Kelvin Cao <kelvin.cao@microchip.com>
References: <1539174788-25878-1-git-send-email-wesleyshenggit@sina.com>
 <20181012113040.52bfff58@lwn.net>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f6dbcdc1-b1e1-98e8-fbcb-73fc6f92ce67@deltatee.com>
Date:   Fri, 12 Oct 2018 11:54:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181012113040.52bfff58@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: kelvin.cao@microchip.com, wesley.yung@microchip.com, linux-ntb@googlegroups.com, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, kurt.schwemmer@microsemi.com, wesleyshenggit@sina.com, corbet@lwn.net
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3] NTB: switchtec_ntb: Update switchtec documentation
 with pre-requisites for NTB
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-10-12 11:30 a.m., Jonathan Corbet wrote:
> On Wed, 10 Oct 2018 20:33:08 +0800
> Wesley Sheng <wesleyshenggit@sina.com> wrote:
> 
>> The ntb_hw_switchtec driver has requirements on kernel configuration
>> so we add these notes to the documentation and also clean up a few 
>> other sentences in the documentation.
>>
>> Signed-off-by: Wesley Yung <wesley.yung@microchip.com>
>> Signed-off-by: Kelvin Cao <kelvin.cao@microchip.com>
>> Signed-off-by: Wesley Sheng <wesleyshenggit@sina.com>
> 
> So why all of these signoffs for such a small patch?  Who is the actual
> author of the patch?

It was originally two very small patches from Mr. Yung[1] and Mr. Cao[2]
combined and then cleaned up for upstream by Mr. Sheng.

There will likely be a bit more of this as they intend on upstreaming
more of the work that has been done out-of-tree. I believe most of this
is minor bug fixes and small feature additions.

Logan

[1]
https://github.com/Microsemi/switchtec-kernel/commit/5e7e7709c8ce6f37163113a8b6282aa4a788b6a0

[2]
https://github.com/Microsemi/switchtec-kernel/commit/e25fbb7267a742d08ca0802e0a6886c183e8b7b4


