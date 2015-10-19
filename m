Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:50209 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbJSSvg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 19 Oct 2015 14:51:36 -0400
Message-ID: <56253B91.5040807@ti.com>
Date: Mon, 19 Oct 2015 14:50:57 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: "Kwok, WingMan" <w-kwok2@ti.com>, Arnd Bergmann <arnd@arndb.de>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"pawel.moll@arm.com" <pawel.moll@arm.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
	"galak@codeaurora.org" <galak@codeaurora.org>,
	KISHON VIJAY ABRAHAM <kishon@ti.com>,
	"Quadros, Roger" <rogerq@ti.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"ssantosh@kernel.org" <ssantosh@kernel.org>,
	"linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and
 pcie
References: <1444919145-30845-1-git-send-email-w-kwok2@ti.com> <5192855.p6QLDWTiVi@wuerfel> <561FCDC0.3080109@ti.com> <6215485.RTPqreMEMX@wuerfel> <230CBA6E4B6B6B418E8730AC28E6FC7E04229363@DFLE11.ent.ti.com>
In-Reply-To: <230CBA6E4B6B6B418E8730AC28E6FC7E04229363@DFLE11.ent.ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/19/2015 10:47 AM, Kwok, WingMan wrote:
> Hi,
>
>> -----Original Message-----
>> From: Arnd Bergmann [mailto:arnd@arndb.de]
>> Sent: Thursday, October 15, 2015 3:35 PM
>> To: Karicheri, Muralidharan
>> Cc: linux-arm-kernel@lists.infradead.org; Kwok, WingMan; robh+dt@kernel.org;
>> pawel.moll@arm.com; mark.rutland@arm.com; ijc+devicetree@hellion.org.uk;
>> galak@codeaurora.org; KISHON VIJAY ABRAHAM; Quadros, Roger;
>> bhelgaas@google.com; ssantosh@kernel.org; linux@arm.linux.org.uk;
>> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
>> pci@vger.kernel.org
>> Subject: Re: [PATCH v1 1/2] phy: keystone: serdes driver for gbe 10gbe and
>> pcie
>>
>> On Thursday 15 October 2015 12:01:04 Murali Karicheri wrote:
>>>
>>>>> + * Redistributions in binary form must reproduce the above copyright
>>>>> + * notice, this list of conditions and the following disclaimer in the
>>>>> + * documentation and/or other materials provided with the
>>>>> + * distribution.
>>>>
>>>> The current code does not do this when compiled, which might be a
>>>> problem for distributors. Can you clarify the license?
>>>>
>>> Arnd,
>>>
>>> Can you elaborate on this? I did a grep on the string "Redistributions
>>> in binary form must reproduce the above copyright" and I could find
>>> several instance of this. So I am not sure what you mean by "The current
>>> code does not do this when compiled".
>>
>> You write that the binary form of the code must produce the copyright
>> notice. I don't see any code that does this. If I was looking in the
>> wrong place, let me know.
>>
>> 	Arnd
>

Thanks Wingman for the response.

Arnd, by your statement 'I don't see any code that does this' do you 
expect a piece of code that embed the license in the binary image? If 
so, that seems weired to me.

Many of the drivers including this patch has the following statement in 
the license that is additional company specific license such as BSD that 
is applicable.

==== Cut and pasted from drivers/crypto/fcrypt.c =======================
  * 2. Redistributions in binary form must reproduce the above copyright
  *    notice, this list of conditions and the following disclaimer in the
  *    documentation and/or other materials provided with the distribution.
=========================================================================
I read this as if the source is compiled and distributed as a binary 
either a kernel module ko file or as part of the kernel binary, this 
term must apply. Usually this is part of documentation that goes with 
the product AFAIK.

Murali

> For example, we did a grep of the following
>
> mypc:linux(personal/linux/serdes) $ grep -rnI "Redistributions in binary form must reproduce the above copyright" ./net/
> ./net/sunrpc/auth_gss/auth_gss.c:18: *  2. Redistributions in binary form must reproduce the above copyright
> ./net/sunrpc/auth_gss/gss_mech_switch.c:15: *  2. Redistributions in binary form must reproduce the above copyright
> ./net/sunrpc/auth_gss/gss_krb5_mech.c:16: *  2. Redistributions in binary form must reproduce the above copyright
> ./net/bluetooth/ecc.c:10: *  * Redistributions in binary form must reproduce the above copyright
> ./net/bluetooth/ecc.h:10: *  * Redistributions in binary form must reproduce the above copyright
> ./net/can/gw.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/can/af_can.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/can/proc.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/can/bcm.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/can/raw.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/can/af_can.h:10: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/discover.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/node.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/netlink_compat.c:10: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/name_distr.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/bearer.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/name_table.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/name_distr.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/addr.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/subscr.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/link.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/net.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/netlink.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/sysctl.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/udp_media.c:11: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/socket.h:11: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/subscr.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/msg.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/name_table.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/msg.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/core.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/socket.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/net.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/bcast.c:14: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/bearer.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/core.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/node.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/addr.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/ib_media.c:17: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/link.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/netlink.h:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/server.c:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/discover.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/eth_media.c:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/bcast.h:13: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/tipc/server.h:12: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/6lowpan/iphc.c:29: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/sched/sch_codel.c:17: * 2. Redistributions in binary form must reproduce the above copyright
> ./net/ieee802154/6lowpan/core.c:27: * 2. Redistributions in binary form must reproduce the above copyright
>
> Thanks,
> WingMan
>


-- 
Murali Karicheri
Linux Kernel, Keystone
