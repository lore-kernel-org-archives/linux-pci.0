Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56146 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755430AbeCSKTy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Mar 2018 06:19:54 -0400
Received: from mail-pf0-f198.google.com ([209.85.192.198])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1exrtQ-0007xO-MY
        for linux-pci@vger.kernel.org; Mon, 19 Mar 2018 10:19:52 +0000
Received: by mail-pf0-f198.google.com with SMTP id p10so1108375pfl.22
        for <linux-pci@vger.kernel.org>; Mon, 19 Mar 2018 03:19:52 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Subject: Re: [PATCH] PCI / PM: Always check PME wakeup capability for runtime
 wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <2242415.DLYj1vY8hi@aspire.rjw.lan>
Date: Mon, 19 Mar 2018 18:19:45 +0800
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Message-Id: <48D2ECB8-4A95-4910-912C-67F17CA824EC@canonical.com>
References: <20180318191215.10005-1-kai.heng.feng@canonical.com>
 <2242415.DLYj1vY8hi@aspire.rjw.lan>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



> On Mar 19, 2018, at 6:00 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> On Sunday, March 18, 2018 8:12:15 PM CET Kai-Heng Feng wrote:
>> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
>> core: Drop run_wake flag from struct dev_pm_info").
>>
>> The device in question is not power managed by platform firmware,
>> furthermore, it only supports PME# from D3cold:
>> Capabilities: [78] Power Management version 3
>>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>
> That's somewhat unusual, but OK.
>
>> Before the commit, the device never gets runtime suspended. After the
>> commit, the device gets runtime suspended, so it does not respond to any
>> PME#.
>>
>> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
>> device_can_wakeup() in pci_dev_run_wake() always returns true.
>>
>> So pci_dev_run_wake() needs to check PME wakeup capability as its first
>> condition.
>>
>> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
>> dev_pm_info")
>> Cc: stable@vger.kernel.org # 4.13+
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> ---
>>  drivers/pci/pci.c | 11 ++++-------
>>  1 file changed, 4 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index f6a4dd10d9b0..e026d8f313ec 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -2125,16 +2125,13 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>>  {
>>  	struct pci_bus *bus = dev->bus;
>>
>> -	if (device_can_wakeup(&dev->dev))
>> -		return true;
>> -
>> -	if (!dev->pme_support)
>> -		return false;
>
> Why are you removing this check?

Because this is implicitly checked by pci_pme_capable().

But I guess it's better to keep it explicit.

I'll send a v2 to address this.

Kai-Heng

>
>> -
>>  	/* PME-capable in principle, but not from the target power state */
>> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
>> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>>  		return false;
>>
>> +	if (device_can_wakeup(&dev->dev))
>> +		return true;
>> +
>>  	while (bus->parent) {
>>  		struct pci_dev *bridge = bus->self;
>
> Thanks,
> Rafael
