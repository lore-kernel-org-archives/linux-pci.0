Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:37301 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab2HASD5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 1 Aug 2012 14:03:57 -0400
Received: by wgbdr13 with SMTP id dr13so7182060wgb.1
        for <linux-pci@vger.kernel.org>; Wed, 01 Aug 2012 11:03:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQUZvMyXjydOdsiBG7YJGA696ihdFkuKj6NMu589NTELCA@mail.gmail.com>
References: <CAOp+P+o5frkFRkrG9=2-3OL1AgDy+zVCbLgRqRVkm0yW_MaFVw@mail.gmail.com>
	<CAE9FiQUZvMyXjydOdsiBG7YJGA696ihdFkuKj6NMu589NTELCA@mail.gmail.com>
Date: Wed, 1 Aug 2012 19:03:55 +0100
Message-ID: <CAOp+P+rsAW2pBZNNSW2ehEDVQB=zSFkweVRDmPcePCiEd5_8DA@mail.gmail.com>
Subject: Re: PCI express switch
From: =?ISO-8859-1?Q?Miguel_=C1ngel_=C1lvarez?=
	<caronteycerbero@gmail.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: linux-pci@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 1, 2012 at 6:48 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Aug 1, 2012 at 6:42 AM, Miguel Ángel Álvarez
> <caronteycerbero@gmail.com> wrote:
>> Dear all,
>>
>> We are developing a board using a Freescale P2020. This micro has
>> three PCIexpress ports. 2 1xlane PCIe and 1 2xlane PCIe.
>>
>> We have been able to successfully use the PCIe interfaces.
>>
>> However, now we want to expand the number of PCIe slots connecting the
>> 2xlane PCIe to a PCIe switch (89HPES6T5E). This switch offers a 2xlane
>> upstream port and 4 1xlane downstream ports.
>>
>> The problem is that we do not really know how PCIe switches are
>> managed in Linux. If any of you can recommend us some resources to
>> read, we will appreciate it very much.
>
> pcie switch should show as three or more pci bridges in the pci tree.
>

OK.

>>
>> If there is no information to read, let me describe our main problem.
>>
>> The question is that if I let u-boot scan the PCIe, the upstream and
>> downstream ports are detected as well as the cards connected to the
>> downstream port. However when u-boot launches Linux, this last just
>> finds a device (the HPES6T5E), and none of the downstream ports or
>> card connected to them.
>>
>>
>> I know that the problem could be in the u-boot, so I am trying to
>> analyse its code also... but I think there could be something in Linux
>> I am not taking into account yet.
>
> can you post whole log with pci debug enabled?
>

Which one? The one in which the switch is detected by the u-boot or
the one in which the switch is detected by the Linux?

Thanks

Miguel Ángel
