Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39141 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752759AbeA3G3c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Jan 2018 01:29:32 -0500
Received: by mail-ot0-f169.google.com with SMTP id d9so8962139oth.6
        for <linux-pci@vger.kernel.org>; Mon, 29 Jan 2018 22:29:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
References: <20180129213145.26068-1-keith.busch@intel.com> <20180129213145.26068-2-keith.busch@intel.com>
 <56d77093-b630-148d-52ab-14dcb7714e6b@codeaurora.org>
From: Oza Pawandeep <oza.pawandeep@gmail.com>
Date: Tue, 30 Jan 2018 11:59:31 +0530
Message-ID: <CAK1A=4w-uDm+gau6WdwM=ZrgO=bWDtDKqwabxWxm2EZZb+YoKw@mail.gmail.com>
Subject: Re: [PATCH 2/6] PCI/DPC: Leave interrupts enabled while handling event
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Keith Busch <keith.busch@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, poza@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ Oza

On Tue, Jan 30, 2018 at 7:41 AM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 1/29/2018 4:31 PM, Keith Busch wrote:
>> +     if (!work_busy(&dpc->work))
>> +             schedule_work(&dpc->work);
>
> Isn't there a race condition between the time that dpc_work() clears PCI_EXP_DPC_STATUS
> register and when work actually completes by returning from dpc_work()?
>
> If the interrupt arrives just in this window, this code will not schedule the work.
>
> --
> Sinan Kaya
> Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
> Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
