Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36314 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbcGVWBo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2016 18:01:44 -0400
Received: by mail-wm0-f41.google.com with SMTP id q128so71538902wma.1
        for <linux-pci@vger.kernel.org>; Fri, 22 Jul 2016 15:01:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXQNZPiWzL=hMsnQjkR7HSfbOxptFeLXWoEj30ucLSBMA@mail.gmail.com>
References: <CAH=XD5-6QXxA42ukxJ40sOzGXqScS7u3QZAwCaCYT2r3pJxdCA@mail.gmail.com>
 <CAE9FiQXQNZPiWzL=hMsnQjkR7HSfbOxptFeLXWoEj30ucLSBMA@mail.gmail.com>
From: Kallol Biswas <kallol@nucleodyne.com>
Date: Fri, 22 Jul 2016 15:01:41 -0700
Message-ID: <CAH=XD59KK7H2jSoie4xPMXQkezJDacXVphYJkAi6_TqXi=g4zg@mail.gmail.com>
Subject: Re: No bus number available for hot-added bridge
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Thank you very much for response.


I have worked around the failure by manually allocating bus number,
and memory bar window for a specific downstream port.


I will send you the logs when I get back to this issue again.
Thank you very much for response.



On Fri, Jul 22, 2016 at 2:17 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Jul 15, 2016 at 1:33 PM, Kallol Biswas <kallol@nucleodyne.com> wrote:
>> Hi,
>>    I have been trying to hot-add a PCIe bridge and getting the
>> following message in dmesg:
>>
>> No bus number available for hot-added bridge 0000:06:00.
>>
>> The kernel is 4.4. Do we have any patch for this?  I tried Yinghai's
>> for-pci-busn-alloc patch. Did not work. Not sure I picked up the right
>> changes.
>>
>> Any input...
>>
>> [  794.085909] pci 0000:06:00.0: [10b5:9797] type 01 class 0x060400
>> [  794.086232] pci 0000:06:00.0: Max Payload Size set to 256 (was 128, max 512)
>> [  794.086563] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
>> [  794.086884] iommu: Adding device 0000:06:00.0 to group 47
>> [  794.093797] No bus number available for hot-added bridge 0000:06:00.0
>
>
> Can you please send out the whole boot log with
> CONFIG_PCI_DEBUG=y ?
>
> also output for lspci -tv and lspci -vvxxx.
>
> Thanks
>
> Yinghai
