Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46516 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbbKJAnN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 9 Nov 2015 19:43:13 -0500
Subject: Re: ECRC and Max Read Request Size
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56310B34.6000102@codeaurora.org>
 <20151106172205.GA1002@localhost> <563CE93F.5060209@codeaurora.org>
 <20151109191517.GA4789@localhost>
Cc: linux-pci@vger.kernel.org
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <56413D9F.5050902@codeaurora.org>
Date: Mon, 9 Nov 2015 19:43:11 -0500
MIME-Version: 1.0
In-Reply-To: <20151109191517.GA4789@localhost>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 11/9/2015 2:15 PM, Bjorn Helgaas wrote:
>> I talked to our performance team. They are saying that max read
>> >request does not gain you much compared to max payload size single
>> >direction but it helps tremendously if you are moving data forth and
>> >back between the card. I don't have real numbers though.
> I'm not enough of a hardware or performance person to visualize how
> MRRS makes a tremendous difference in this situation.  Sample
> timelines comparing small vs. large MRRS would help everybody
> understand what's happening here.
>
> Bjorn

The LSI SAS 9211i card supports 4k maximum read request size. I manually 
forced this to 4k instead of the maximum payload size of the platform on 
both the host bridge and the endpoint.

I did a quick test with:
dd if=/dev/zero of=/dev/sda bs=1G count=1

It gave me %9 higher write performance.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
