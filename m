Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727212AbeH1RRW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Aug 2018 13:17:22 -0400
Subject: Re: bug in pci_try_reset_bus
To: Dennis Dalessandro <dennis.dalessandro@intel.com>,
        bhelgaas@google.com, linux-pci@vger.kernel.org
References: <3d3d78fb-f1f2-ec4f-38f9-0b0d14564f53@intel.com>
 <323b3bbe-d255-8a5d-2a9c-d64e1f86cb64@codeaurora.org>
 <bd7dbd5a-eebc-9142-f9a2-3b5ff8de9b8b@intel.com>
 <d437400c-7eed-19d3-9cf2-b8a42217136b@codeaurora.org>
 <2f0fb394-f1c9-d782-ffec-dac04b1ac0a9@intel.com>
 <84484c45-64ff-ca2d-39dd-ee579e28558e@codeaurora.org>
 <8bc2c143-5938-33ed-d852-7f039bde7a13@intel.com>
 <4bf1a54c-4622-0472-7a43-a6d6ff049322@codeaurora.org>
 <980dc79b-a1b7-08ab-294f-1cb318d996fe@intel.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <401a24b3-c7bb-03ee-8753-0c94d8aee79c@codeaurora.org>
Date: Tue, 28 Aug 2018 09:25:40 -0400
MIME-Version: 1.0
In-Reply-To: <980dc79b-a1b7-08ab-294f-1cb318d996fe@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/27/2018 4:48 PM, Dennis Dalessandro wrote:
>> Possible solutions are:
>> 1. introduce a locked reset API > 2. skip lock during probe
>> 3. bring back raw reset API even though it is undesirable.
> 
> I think the first option is the cleanest. I can put together a patch and 
> post it soon.

I was thinking about this. These locked API are getting out of control. It could
be a simpler solution to change the mutex type of device_lock such that it can
be locked twice. I think I have seen some examples of how to do this in the
NVMe driver.
