Return-Path: <SRS0=vi1x=SO=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62157C10F0E
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3569C20850
	for <linux-pci@archiver.kernel.org>; Fri, 12 Apr 2019 20:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfDLUxG (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 12 Apr 2019 16:53:06 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39448 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbfDLUxF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Apr 2019 16:53:05 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hF3AU-00085R-Ou; Fri, 12 Apr 2019 14:53:04 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20190410210532.4538-1-logang@deltatee.com>
 <20190410210532.4538-3-logang@deltatee.com>
 <20190412204456.GG141472@google.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9aa577ca-aa64-51e0-d1e8-f52e1e4a7bdf@deltatee.com>
Date:   Fri, 12 Apr 2019 14:53:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190412204456.GG141472@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v2 2/2] PCI: Clean up resource_alignment parameter to not
 require static buffer
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-04-12 2:44 p.m., Bjorn Helgaas wrote:
> On Wed, Apr 10, 2019 at 03:05:32PM -0600, Logan Gunthorpe wrote:
>> Clean up the 'resource_alignment' parameter code to use kstrdup
>> in the initcall routine instead of a static buffer that wastes memory
>> regardless of whether the feature is used. This allows us to drop
>> 'COMMAND_LINE_SIZE' bytes (typically 256-4096 depending on architecture)
>> of static data.
>>
>> This is similar to what has been done for the 'disable_acs_redir'
>> parameter.
>>
>> This conversion also allows us to use RCU instead of the spinlock to
>> deal with the concurrency issue which further reduces memory usage.
> 
> I'm unconvinced about this part.  Spinlocks are CS 101 material and
> I'm a little hesitant to use a graduate-level technique like RCU in a
> case where it doesn't really buy us much -- we don't need the
> performance advantage and the size advantage seems minimal.  But I'm
> an RCU ignoramus and maybe need to be educated.

That's a reasonable point. I didn't think it was that difficult and the
kernel's RCU API is pretty straightforward. But I can resubmit later
keeping the spinlock. You're right that it's not that big of a gain.

>> As part of the clean up we also squash pci_get_resource_alignment_param()
>> into resource_alignment_show() and pci_set_resource_alignment_param()
>> into resource_alignment_store() seeing these functions only had one
>> caller and the show/store wrappers were needlessly thin.
> 
> Squashing makes sense and would be nice as a separate patch.

Ok, will do.

Logan
