Return-Path: <SRS0=N/Da=QW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E84C43381
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 06:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06CF3214DA
	for <linux-pci@archiver.kernel.org>; Fri, 15 Feb 2019 06:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jOUoVPLQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729871AbfBOGUM (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 15 Feb 2019 01:20:12 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34966 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfBOGUL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Feb 2019 01:20:11 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1F6JrfR083423;
        Fri, 15 Feb 2019 00:19:53 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550211593;
        bh=VvYosYLXTZE6Xwyjczf/0uYinaS7PQPeE6ljLNmbDgc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=jOUoVPLQmKbqsitdkvRyRrmkqcoziJBqhVj5Yly5QTX34OkliiQz7JLrH+TLKJJfZ
         wySnQRfSzYfmG6N8uHg7HmiWzdzmkReLIULgEzALzo4+zsD8uxDqnGHvmh4w2Z3qPP
         8GPt5BpMLSRurtmpD0Xjkb24LD4c4M+jI0F9BALg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1F6JrKR015573
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 00:19:53 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 00:19:52 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 00:19:52 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1F6JmOD016900;
        Fri, 15 Feb 2019 00:19:49 -0600
Subject: Re: [PATCH v2 08/15] PCI: endpoint: Fix pci_epf_alloc_space to set
 correct MEM TYPE flags
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Alan Douglas <adouglas@cadence.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190114111513.21618-1-kishon@ti.com>
 <20190114111513.21618-9-kishon@ti.com>
 <20190211173723.GA31035@e107981-ln.cambridge.arm.com>
 <ebadc615-f633-e84e-041a-99b7936a123b@ti.com>
 <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <edc76e9b-bdd4-80bb-3dff-1d44a100c153@ti.com>
Date:   Fri, 15 Feb 2019 11:49:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190214162928.GA32523@e107981-ln.cambridge.arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

On 14/02/19 9:59 PM, Lorenzo Pieralisi wrote:
> On Wed, Feb 13, 2019 at 07:17:14PM +0530, Kishon Vijay Abraham I wrote:
>> Hi Lorenzo,
>>
>> On 11/02/19 11:07 PM, Lorenzo Pieralisi wrote:
>>> On Mon, Jan 14, 2019 at 04:45:06PM +0530, Kishon Vijay Abraham I wrote:
>>>> pci_epf_alloc_space() sets the MEM TYPE flags to indicate a 32-bit
>>>> Base Address Register irrespective of the size. Fix it here to indicate
>>>> 64-bit BAR if the size is > 2GB.
>>>>
>>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>>> ---
>>>>  drivers/pci/endpoint/pci-epf-core.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> This looks like a fix and should me marked as such. Does it work
>>> as as standalone patch if it gets backported ?
>>
>> Yeah, it should work. But the current users doesn't allocate > 2GB and some
>> EPC drivers configure their registers based on size. So nothing is broken
>> without this patch as such.
> 
> I suspect you mean 4GB (here and the commit log), right ? I am checking
> the commit logs, aiming at merging the patches.

A 32bit BAR register can support a 'size' of only up to 2GB. Though it can hold
a memory address of up to 4GB.

This is also mentioned in the PCI Local Bus Specification.
"A 32-bit register can be implemented to support a single memory size that is a
power of 2 from 16 bytes to 2 GB"

Thanks
Kishon
