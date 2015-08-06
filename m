Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <55C2C4F4.1040600@roeck-us.net>
References: <1438308908-12259-1-git-send-email-linux@roeck-us.net>
	<CAE9FiQXuTKmXXCFsKUiMK43U+LpOzfa3oV0iNWS+Jh879EDNsw@mail.gmail.com>
	<CAE9FiQVGhfbFW5-5deYcU2bDWE9k0-4+V+cepwdqZ661sLWOFA@mail.gmail.com>
	<55C2C4F4.1040600@roeck-us.net>
Date: Wed, 5 Aug 2015 21:25:03 -0700
Message-ID: <CAE9FiQXtSDBFy1rf4TPHwD-JjoB+5Wii1MBMBfGTaNosqnRJGg@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: Only enable IO window if supported
From: Yinghai Lu <yinghai@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 5, 2015 at 7:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On 08/05/2015 06:38 PM, Yinghai Lu wrote:
>>
>> On Wed, Aug 5, 2015 at 6:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>>
>>>
>>> It only can avoid warning with bridge, and still have warning on
>>> devices under the bridge.
>>>
>>> also would have problem on transparent bridges, like
>>>
>>> BRIDGE_A ---- BRIDGE_AA----DEVICE_AA
>>>                     |
>>>                     \-- BRIDGE_AB ---DEVICE_AB
>>>
>>> if only BRIDGE_A and BRIDGE_AA are transparent, and BRIDGE_AB is not.
>>>
>>> and if pci_bridge_supports_io() return false for BRIDGE_A.
>>>
>>> We will have all three bridges have PCI_BUS_FLAGS_SUPPORTS_IO cleared.
>>> so all will not been sized and will not get assigned io port resource.
>>>
>>> later DEVICE_AA could root bus io port as parent, and get io resource
>>> assigned.
>>> but DEVICE_AB will not get assigned.
>>>
>>> so we should get rid of pci_bridge_supports_io(), and just check root
>>> resource IO port.
>>
>>
>> I would suggest this version instead:
>>
>> Subject: [PATCH] PCI: Only try to assign io port only if root bus support
>> that
>>
>
> Bjorn had asked me to move the IO support check out of
> pci_bridge_check_ranges().
> It looks like you want to keep it there.
>
> Can you explain your reasons ? Sorry, I just don't understand.

in pci_alloc_child_bus(), child bus's bus_flags will be assigned with
parent's bus_flags.

so if one parent bus has bridge's io bar can not changed, then all
children bus will also
have same bus_flags, and their bridge io bar will not used.

then if BRIDGE_AB is not transparent, we do need to use it's bridge io bar.
