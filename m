Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:58954 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeH1AGO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Aug 2018 20:06:14 -0400
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
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <4bf1a54c-4622-0472-7a43-a6d6ff049322@codeaurora.org>
Date: Mon, 27 Aug 2018 16:18:03 -0400
MIME-Version: 1.0
In-Reply-To: <8bc2c143-5938-33ed-d852-7f039bde7a13@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/27/2018 3:52 PM, Dennis Dalessandro wrote:
>>
>> can you please confirm?
> 
> Ah yes, silly me. pci_bus_reset() returns 0 and it does go on but doesn't make 
> it to the trylock, it gets hung calling pci_bus_save_and_disable().
>

OK. That makes sense now. pci_bus_save_and_disable() is also trying to
obtain a device lock via pci_dev_lock().

Since you are calling this from probe time, you are getting dead lock
because device is locked.

Is it possible to defer this secondary bus reset operation to post probe?

Possible solutions are:
1. introduce a locked reset API
2. skip lock during probe
3. bring back raw reset API even though it is undesirable.

Other opinions?

BTW, please file a bugzilla and capture your email details there so that we
can have record of what we are doing?

> -Denny
