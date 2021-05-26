Return-Path: <linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA19C47082
	for <linux-pci@archiver.kernel.org>; Wed, 26 May 2021 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47D68613E5
	for <linux-pci@archiver.kernel.org>; Wed, 26 May 2021 17:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbhEZRCw (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 May 2021 13:02:52 -0400
Received: from ale.deltatee.com ([204.191.154.188]:35614 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhEZRCu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 13:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=emQP3iUjzhFPD58xdPEXIRObduOufZv03fV6fu2Abxs=; b=tn0uzJmaPj9P2JP4anYvG4tUuS
        fYYXDVGMkbbOgwa34PQsmbZ48nUmTj6875oK7fnI6lspm7r0q+82BXk+GNzJ9k3cZzxcuSjq4YjGi
        iseT9R2XCXsTMgE/PXs1WOf/nfKxRTk4QUBe7bbOqxJzk7W+Hffrlkpec+mGDyNWUplaIen8jzmho
        URujB1E4+wEGfXKlANfZXPCcgBUVVeEQMhrse+XOXu9OU3zJ2hGG6omIRdADvIl6qRpVYenTqkiCJ
        ETaYpYkGdgvrzuw9O79asZkAmeIG4BtuJ3bGF37OcxOopfHff4478X4oyDWO827YDPTCTtp0Ajaqy
        bO73NuqQ==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1llwuA-0006nm-MX; Wed, 26 May 2021 11:01:15 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Mason <jdmason@kudzu.us>
Cc:     linux-pci@vger.kernel.org
References: <20210526162854.GA1300083@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4268cd10-37b7-443f-2c77-d5421c2574e0@deltatee.com>
Date:   Wed, 26 May 2021 11:01:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210526162854.GA1300083@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, jdmason@kudzu.us, kishon@ti.com, tharvey@gateworks.com, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: PCIe endpoint network driver?
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-05-26 10:28 a.m., Bjorn Helgaas wrote:
> [+to Kishon, Jon, Logan, who might have more insight]
> 
> On Wed, May 26, 2021 at 08:44:59AM -0700, Tim Harvey wrote:
>> Greetings,
>>
>> Is there an existing driver to implement a network interface
>> controller via a PCIe endpoint? I'm envisioning a system with a PCIe
>> master and multiple endpoints that all have a network interface to
>> communicate with each other.

That sounds awfully similar to NTB. See ntb_netdev and ntb_transport.

Though IMO NTB has proven to be a poor solution to the problem. Modern
network cards with RDMA are pretty much superior in every way.

Logan
