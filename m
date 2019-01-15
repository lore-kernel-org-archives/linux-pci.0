Return-Path: <SRS0=HN6g=PX=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECE8C43387
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6F520656
	for <linux-pci@archiver.kernel.org>; Tue, 15 Jan 2019 12:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UxLyqOKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfAOMxT (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 15 Jan 2019 07:53:19 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:45930 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728181AbfAOMxT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Jan 2019 07:53:19 -0500
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id C582410C0E4A;
        Tue, 15 Jan 2019 04:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1547556799; bh=+ByG6ENJiZfAE4fY/IqQhBm0udSjJEkkpfhn2uD8Z+Y=;
        h=Subject:To:CC:References:From:Date:In-Reply-To:From;
        b=UxLyqOKHFtuCulGv6m++xT2KUbchInpyCv6ehrGN3tex9YP/eB3z7lO7U8jvj39dk
         /Uj05m2IpURC3eI+y47pBUFSL7b3Dgj8eS0MDV1bRLgqXrYy8tTqXASCg4CVlmH0CE
         UDrtXRfK/VUvRPBy0J3aiasRwXBpfi8qX/CLmhoha+aQVVwsQSi76C9ICj+8uoKo+i
         +aduEQyosOdPn+aSRXJ3hrgJG9cgIMe3YPNYUMmuBQnjeAjrb+kIOlVIU31jntd8Lc
         BXHvGS1z3bR5bz7mn1l2tqw+y0u8V9awxm3C/Ajps92LHN//Z0u1jiNoscAHuIiAXK
         A9elyD9MZ7lYw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1768139C7;
        Tue, 15 Jan 2019 04:53:18 -0800 (PST)
Received: from DE02WEHTCB.internal.synopsys.com (10.225.19.94) by
 US01WXQAHTC1.internal.synopsys.com (10.12.238.230) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 04:53:18 -0800
Received: from DE02WEHTCA.internal.synopsys.com (10.225.19.92) by
 DE02WEHTCB.internal.synopsys.com (10.225.19.94) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 13:53:15 +0100
Received: from [10.107.25.131] (10.107.25.131) by
 DE02WEHTCA.internal.synopsys.com (10.225.19.80) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 15 Jan 2019 13:53:15 +0100
Subject: Re: [RFC v3 5/7] dmaengine: Add Synopsys eDMA IP PCIe glue-logic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Joao Pinto <joao.pinto@synopsys.com>,
        Jose Abreu <jose.abreu@synopsys.com>,
        Luis Oliveira <luis.oliveira@synopsys.com>,
        Vitor Soares <vitor.soares@synopsys.com>,
        Nelson Costa <nelson.costa@synopsys.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>
References: <cover.1547230339.git.gustavo.pimentel@synopsys.com>
 <a70d096e96f34cd9ea773da519965076d74d12ec.1547230339.git.gustavo.pimentel@synopsys.com>
 <20190111194705.GU9170@smile.fi.intel.com>
 <916f319b-9e45-6d78-4ecc-850feda84bb3@synopsys.com>
 <20190115054358.GB9170@smile.fi.intel.com>
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Message-ID: <9b887e39-9de3-2285-f3b4-174a72e6c4d3@synopsys.com>
Date:   Tue, 15 Jan 2019 12:48:34 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190115054358.GB9170@smile.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.107.25.131]
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 15/01/2019 05:43, Andy Shevchenko wrote:
> On Mon, Jan 14, 2019 at 11:38:02AM +0000, Gustavo Pimentel wrote:
>> On 11/01/2019 19:47, Andy Shevchenko wrote:
>>> On Fri, Jan 11, 2019 at 07:33:41PM +0100, Gustavo Pimentel wrote:
> 
>>>> +static bool disable_msix;
>>>> +module_param(disable_msix, bool, 0644);
>>>> +MODULE_PARM_DESC(disable_msix, "Disable MSI-X interrupts");
>>>
>>> Why?!
>>> We are no allow new module parameters without very strong arguments.
>>
>> Since this is a reference driver and might be used to test customized HW
>> solutions, I added this parameter to allow the possibility to test the solution
>> forcing the MSI feature binding. This is required specially if who will test
>> this solution has a Root Complex with both features available (MSI and MSI-X),
>> because the Kernel will give always preference to MSI-X binding (assuming that
>> the EP has also both features available).
> 
> Yes, you may do it for testing purposes, but it doesn't fit the kernel standards.

Ok, but how should I proceed? May I leave it or substitute by another way to do
it? If so, how?
As I said, the intended is to be only used for this test case, on normal
operation the parameter it should be always false.

> 
>>>> +	if (!pdata) {
>>>> +		dev_err(dev, "%s missing data structure\n", pci_name(pdev));
>>>> +		return -EFAULT;
>>>> +	}
>>>
>>> Useless check.
>>
>> Why? It's just a precaution, isn't it a good practice always to think of the
>> worst case?
> 
> You just can put an implicit requirement of pdata rather than doing this

Ok, how can I do it? What I should add to the code to force that?

> useless check. I don't believe it would make sense to have NULL pdata for the
> driver since it wouldn't be functional anyhow.

Yes, you're right without pdata the driver can't do anything.
> 
>>>> +	/* Mapping PCI BAR regions */
>>>> +	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar) |
>>>> +				       BIT(pdata->ll_bar) |
>>>> +				       BIT(pdata->dt_bar),
>>>> +				 pci_name(pdev));
>>>> +	if (err) {
> 
>>>> +		return err;
>>>> +	}
> 
>>>> +	if (!pcim_iomap_table(pdev))
>>>> +		return -EACCES;
>>>
>>> Never happen condition. Thus useless.
>>
>> pcim_iomap_table() can return NULL in case of allocation failure. Besides that,
>> isn't it a good practice always to think of the worst case?
> 
> No, it can't in the conditions your have in the code. See above the lines I left.
> If pcim_iomap_regions() successfully finished...

Nice catch, I didn't saw that. I added that validation because of coverity
analysis. I'll add a comment here to suppress this coverity false positive error.

> 
>>>> +	dev_info(dev, "DesignWare eDMA PCIe driver loaded completely\n");
>>>
>>> Useless.
>>
>> It's helpful for bring up, I can pass it to dbg.
> 
> It just shows that someone didn't use existing tools and features. This message and similar are useless.
> Hint: initcall_debug.

I wasn't aware of it. Thanks for the hint :)

> 
>>>> +	dev_info(dev, "DesignWare eDMA PCIe driver unloaded completely\n");
>>>
>>> Ditto.
>>
>> It's helpful for bring up, I can pass it to dbg.
> 
> Ditto.
> 

