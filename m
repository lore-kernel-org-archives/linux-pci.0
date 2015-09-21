Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:34573 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756298AbbIUVcR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Sep 2015 17:32:17 -0400
Received: by vkhf67 with SMTP id f67so74072869vkh.1
        for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2015 14:32:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c7712b0f947d43db957a199f5085ae33@XCGVAG27.northgrum.com>
References: <c7712b0f947d43db957a199f5085ae33@XCGVAG27.northgrum.com>
Date: Mon, 21 Sep 2015 14:32:17 -0700
Message-ID: <CAE9FiQWN9BhdOb2HOgoWibgV2wdXoy-jyazzmvDV3tmcfv8Pdw@mail.gmail.com>
Subject: Re: :Re: [PATCH v1 3/7] PCI: Let kcmdline reserve bus numbers for
 hotplug bridges
From: Yinghai Lu <yinghai@kernel.org>
To: "Tang, Jason (ES)" <Jason.Tang2@ngc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 21, 2015 at 9:01 AM, Tang, Jason (ES) <Jason.Tang2@ngc.com> wrote:
>> -----Original Message-----
>> From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
>> Yinghai Lu
>> Sent: Sunday, September 20, 2015 02:20
>> To: Bjorn Helgaas
>> Cc: Tang, Jason (ES); linux-pci@vger.kernel.org
>> Subject: EXT :Re: [PATCH v1 3/7] PCI: Let kcmdline reserve bus numbers for
>> hotplug bridges
>>
>> from bus [old_max, old_max+pci_hotplug_buses) could be used by other
>> bridges,
>> and other bridges could even get probed yet.
>
> I have tested the case where a subsequent bridge has not been probed yet and the BIOS is assigning it the same bus number. The behavior I observed is that conflicting bus numbers will be fixed during the second pass of PCI probing. See pci_scan_bridge() in drivers/pci/probe.c, lines 875-880 on tag v4.3-rc2. Also observe how patch 7 in my series updates the preceding conditional (line 874) to also check if the device is a hotpluggable bridge.
>

so there is a window that two peer bridges have been configured to
overlapped bus range?

>> Also it could even cross the boundary to other peer root bus range.
>
> I am not sure what you mean by this. Can you elaborate?

couple peer bus range:
root bus 0: [0,7f], root bus [80, ff]
if one bridge under first root bus get add range blindly, it will
cross the boundary at 0x7f.

Yinghai
