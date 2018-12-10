Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D352DC04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D0F520672
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:01:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D0F520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbeLJTB0 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:01:26 -0500
Received: from ale.deltatee.com ([207.54.116.67]:60770 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeLJTBZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 14:01:25 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gWQns-0002WN-KT; Mon, 10 Dec 2018 12:01:22 -0700
To:     Eric Wehage <Eric.Wehage@huawei.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Stephen Bates <sbates@raithlin.com>
References: <20181210115653.0000615a@huawei.com>
 <45b01572-7d53-c3d0-9a9b-77917ffe6171@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
Date:   Mon, 10 Dec 2018 12:01:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <DD8FB053C05D2D4DB8AA6C933261787859975862@sjceml521-mbs.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, linuxarm@huawei.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com, linux-pci@vger.kernel.org, jonathan.cameron@huawei.com, Eric.Wehage@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [RFC] Proposed PCI ECR for description of Advanced Peer to Peer
 Capabilities
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2018-12-10 11:02 a.m., Eric Wehage wrote:
> Hi Logan,
> 
> 	Thank you for reviewing this.
> 
> 	Although I mentioned the minimum bandwidth requirement in the introduction of the ECR, I did not include any specification changes that would require this. I recognized that for p2p to be useful, there must be a useful level of bandwidth, however, I could see no easy way to adequately advertise this. Ultimately, bandwidth levels could be seen as part of the platform architecture of each OEM. Performance differences between OEM's is often what makes a buyer choose one OEM's system over another in a competitive environment. So requiring a particular bandwidth level is like requiring an OEM to include a minimum number of cores in a system or a minimum number of PCIe links. So ultimately, I excluded any discussion of bandwidth in the ECR spec changes.
> 
> 	However, if you see a particular way that this issue could be approached, I am still willing to consider a change.

Yeah, per my last email, I don't want to advertise bandwidth. And I gave
a rough rule as to what might qualify as "sufficient" bandwidth (ie. a
boolean indicating whether it is roughly expected to be as fast or
faster than RAM).

I also was trying to get the point across that even if a particular
piece of hardware does not have "sufficient" bandwidth it would still be
valuable to publish whether the link is expected to work for the
different TLP types. Some applications don't care about bandwidth and
just want to know if they can ring doorbells, etc.

Logan
