Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <56A281B6.6070709@gmail.com>
References: <1453167913-16248-1-git-send-email-chen.fan.fnst@cn.fujitsu.com>
	<6239489.QX2A2kAHWp@vostro.rjw.lan>
	<20160120002431.GA7973@localhost>
	<56A0EE00.80709@cn.fujitsu.com>
	<CAJZ5v0iq29mq_sFzk=mEbjPGJV9vPL9MCgU4WamrGV_fWcpEMA@mail.gmail.com>
	<20160122175332.GA11004@localhost>
	<56A281B6.6070709@gmail.com>
Date: Sat, 23 Jan 2016 03:00:48 +0100
Message-ID: <CAJZ5v0hW1jusNnW8TFTX_fwXzsfBjkFTjHTBQ+iWQyDKe3CETw@mail.gmail.com>
Subject: Re: [PATCH] pci: fix unavailable irq number 255 reported by BIOS
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: David Daney <ddaney.cavm@gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Cao jin <caoj.fnst@cn.fujitsu.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Chen Fan <chen.fan.fnst@cn.fujitsu.com>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, izumi.taku@jp.fujitsu.com,
	wency@cn.fujitsu.com, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 22, 2016 at 8:23 PM, David Daney <ddaney.cavm@gmail.com> wrote:
> On 01/22/2016 09:53 AM, Bjorn Helgaas wrote:
>>
>> On Thu, Jan 21, 2016 at 11:58:26PM +0100, Rafael J. Wysocki wrote:
>>>
>>> On Thu, Jan 21, 2016 at 3:41 PM, Cao jin <caoj.fnst@cn.fujitsu.com>
>>> wrote:
>>>>
>>>> Hi,
>>>>
>>>>      IMHO, I think maybe modification on i801_smbus driver is easier.
>>>>
>>>>      Because when i801_smbus request_irq using pci_dev->irq, this
>>>> pci_dev->irq seems still holds the value read from register(
>>>> pci_setup_device->pci_read_irq), if the value is 255, it is invalid in
>>>> register,
>>>
>>>
>>> Right.
>>>
>>> Which is why the PCI core should not leak it into the driver's ->probe
>>> callback.
>>
>>
>> Is there a reserved IRQ value we could use to mean "invalid"?
>
>
> In many (most) cases, zero indicates no irq.

Zero is a valid timer IRQ on x86, though, so it's better not to give
any special meaning to it in general.

Using ~0 as suggested by Bjorn should work as it would cause
request_irq() to return -EINVAL if passed to it AFAICS.

Thanks,
Rafael
