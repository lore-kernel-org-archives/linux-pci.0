Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <562A4372.4040008@ti.com>
Date: Fri, 23 Oct 2015 10:25:54 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, Loc Ho <lho@apm.com>
CC: Russell King - ARM Linux <linux@arm.linux.org.uk>,
	KISHON VIJAY <kishon@ti.com>, WingMan Kwok <w-kwok2@ti.com>,
	Rob Herring <robh+dt@kernel.org>, <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	<galak@codeaurora.org>, <rogerq@ti.com>, <bhelgaas@google.com>,
	<ssantosh@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] Common SerDes driver for TI's Keystone Platforms
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com> <56295B9E.9030201@ti.com> <CAPw-ZTk1vJA3YSwLHBNMYP0t5k2tW0HTKse+37rL8izWN33y-w@mail.gmail.com> <3702663.07h6YO0UjY@wuerfel>
In-Reply-To: <3702663.07h6YO0UjY@wuerfel>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/23/2015 05:17 AM, Arnd Bergmann wrote:
> On Thursday 22 October 2015 15:27:05 Loc Ho wrote:
>>>
>>> phy-xgene.c
>>> -----------
>>>
>>> Looking at other drivers under drivers/phy, I could find phy-xgene.c which
>>> is close Keystone SerDes driver (. This is called APM X-Gene Multi-Purpose
>>> PHY driver. It defines following mode per the driver code
>>>
>>>          MODE_SATA       = 0,    /* List them for simple reference */
>>>          MODE_SGMII      = 1,
>>>          MODE_PCIE       = 2,
>>>          MODE_USB        = 3,
>>>          MODE_XFI        = 4,
>>>
>>> But seems to support only MODE_SATA. From the code, it appears, this driver
>>> is expected to be enhanced in the future to support additional modes. I have
>>> copied the author to this email to participate in this discussion.
>>
>> Let me comment on this APM X-Gene driver. This driver is dead and
>> won't be supported in near or foreseeable future. And someday, it will
>> be ripped out. Based on experience, this solution (having PHY driver
>> in Linux) can't be supported across boards and etc as it is just too
>> much maintenance. And therefore, we followed Arnd B guidance and move
>> all this into the boot loader. From Linux or OS perspective, it only
>> cares about the interface in which its interface with. This is just
>> your reference and may be this will help you as well.
>
> This depends a lot on the use case. If the chip is only used on server
> parts that have a real firmware and you can deliver bug fixes for the
> firmware if necessary, it's always best to do as much of the setup as
> possible there, and let Linux see a simplified view of the hardware.
>
> However, for embedded systems that tend to ship with a minimal binary
> bootloader and no way to update that as an end-user, we rely on Linux
> to know about all the hardware that requires some form of setup, which
> is why we have all sorts of drivers and frameworks in the kernel that
> a server can easily ignore.
>
> While keystone can show up in servers that won't use this driver, my
> impression is that its main market is actually in embedded space.
It is in embedded space predominantly. From our experience, this has to 
be a Linux driver and moving this to boot loader doesn't make sense.

Murali
>
> 	Arnd
>


-- 
Murali Karicheri
Linux Kernel, Keystone
