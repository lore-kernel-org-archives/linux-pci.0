Return-Path: <SRS0=jDI6=QI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3CCC282D8
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EB5E218EA
	for <linux-pci@archiver.kernel.org>; Fri,  1 Feb 2019 17:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfBAR1m (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:27:42 -0500
Received: from ale.deltatee.com ([207.54.116.67]:59484 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726542AbfBAR1m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Feb 2019 12:27:42 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gpcbG-000333-Eu; Fri, 01 Feb 2019 10:27:35 -0700
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Eric Pilmore <epilmore@gigaio.com>,
        David Woodhouse <dwmw2@infradead.org>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-2-logang@deltatee.com>
 <20190201164401.GT32526@8bytes.org>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
Date:   Fri, 1 Feb 2019 10:27:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190201164401.GT32526@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: dwmw2@infradead.org, epilmore@gigaio.com, fancer.lancer@gmail.com, dave.jiang@intel.com, allenbh@gmail.com, bhelgaas@google.com, jdmason@kudzu.us, linux-kselftest@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, joro@8bytes.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for
 aliased devices
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2019-02-01 9:44 a.m., Joerg Roedel wrote:
> On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:
>> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>>  		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
>>  				       dev->bus->number));
>> +	else if (data.count >= 2 && data.busmatch_count == data.count)
>> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>> +			     PCI_DEVID(dev->bus->number,
>> +				       dev->bus->number));
> 
> The dev->bus->number argument for the devfn parameter of PCI_DEVID is
> not needed, right?

Oh, yes. I think you are right.

> Also, this requires at least a comment to document that special case.

I'll add a comment for v2.

Thanks for the review!

Logan
