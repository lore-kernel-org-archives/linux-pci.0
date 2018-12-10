Return-Path: <SRS0=6KXC=OT=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E020C04EB8
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4E3220821
	for <linux-pci@archiver.kernel.org>; Mon, 10 Dec 2018 19:39:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E3220821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeLJTjm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:39:42 -0500
Received: from ale.deltatee.com ([207.54.116.67]:32886 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727610AbeLJTjm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Dec 2018 14:39:42 -0500
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1gWROy-0003EO-Vs; Mon, 10 Dec 2018 12:39:37 -0700
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
 <f00c1a70-b022-0fd7-71dd-b9d37b916ef7@deltatee.com>
 <DD8FB053C05D2D4DB8AA6C9332617878599788A2@sjceml521-mbs.china.huawei.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <41f870ad-2255-4840-34b1-eff0d20b993d@deltatee.com>
Date:   Mon, 10 Dec 2018 12:39:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <DD8FB053C05D2D4DB8AA6C9332617878599788A2@sjceml521-mbs.china.huawei.com>
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



On 2018-12-10 12:36 p.m., Eric Wehage wrote:
> There are 5 TLP types described in each of the three P2P Routes. I'm
> not sure that anyone would care about Message Bandwidth, so I
> could simply add 3 bits to each Route register indicating whether the
> P2P route bandwidth supports the same or more bandwidth than if it
> targeted DRAM.
> 
> The three RO/HWInit bits for each route register would be:
> - P2P Memory Read Bandwidth is equal to or greater than to Main
>    Memory
> - P2P Memory Write Bandwidth is equal to or greater than to Main
>    Memory
> - P2P Memory AtomicOp Bandwidth is equal to or greater than to Main
>    Memory

Yeah! That sounds great. Thanks.

Logan
