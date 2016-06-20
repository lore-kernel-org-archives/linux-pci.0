Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Subject: Re: [PATCH] PCI: mvebu: Don't try to add an MBus window that already
 exists
To: Bjorn Helgaas <helgaas@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
References: <20160602125247.17566-1-sr@denx.de>
 <20160602151818.0989ee50@free-electrons.com> <57511C4E.5040501@denx.de>
 <20160617234645.GD21200@localhost>
From: Stefan Roese <sr@denx.de>
Message-ID: <5767F2C2.9020201@denx.de>
Date: Mon, 20 Jun 2016 15:42:26 +0200
MIME-Version: 1.0
In-Reply-To: <20160617234645.GD21200@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Jisheng Zhang <jszhang@marvell.com>, Jason Cooper <jason@lakedaemon.net>,
 Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Gr=c3=a9gory_Clement?= <gregory.clement@free-electrons.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Russell King <rmk+kernel@arm.linux.org.uk>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn, Hi Thomas,

On 18.06.2016 01:46, Bjorn Helgaas wrote:
> On Fri, Jun 03, 2016 at 07:57:34AM +0200, Stefan Roese wrote:
>> Hi Thomas,
>>
>> On 02.06.2016 15:18, Thomas Petazzoni wrote:
>>> On Thu,  2 Jun 2016 14:52:47 +0200, Stefan Roese wrote:
>>>> Add a check to mvebu_pcie_add_windows() to detect, if an MBus window is
>>>> already configured. If this is the case (base address, size, target and
>>>> attribute are identical), then this window is not created. This fixes
>>>> a problem I'm currently seeing on a custom Armada XP based board, which
>>>> generates this error upon PCI rescanning (in this case via sysfs):
>>>>
>>>> $ echo 1 > /sys/bus/pci/rescan
>>>> mvebu_mbus: cannot add window '4:e8', conflicts with another window
>>>> mvebu-pcie soc:pcie-controller: Could not create MBus window at [mem 0x9e000000-0x9e0fffff]: -22
>>>
>>> Thanks for the patch. I am not familiar with what happens during a PCI
>>> rescan, but shouldn't the MBus windows be deleted and then re-added?
>>
>> It does not happen in this rescan case.
>>
>>> The pci-mvebu driver deletes the MBus windows for a given PCI device
>>> when invalid memory base/limits are set in the emulated PCI bridge.
>>> Shouldn't this happen over a rescan?
>>
>> I'm not sure what *should* happen upon rescan. But testing shows, that
>> no MBus window is removed upon rescan. I just tested what happens,
>> if the PCI devices are "removed" via sysfs. And this also does not
>> delete any of the MBus windows.
>>
>>> If it doesn't, then the other question is whether the check you're
>>> adding should be done in the PCI driver or in the MBus driver.
>>>
>>> In commit b566e782be32145664d96ada3e389f17d32742e5, we already relaxed
>>> the checks done by the MBus driver, and since this commit we allow
>>> different windows to have the same target/attribute.
>>>
>>> Should the MBus driver also allow re-creating a	window that
>>> already exists, if all its properties are the same?
>>
>> This sounds like a good idea to me. To move this detection / decision
>> one layer up. So that it will work for other drivers using this
>> MBus interface as well.
>
> I don't know how you want to solve it, but it definitely should be
> safe to write the bridge window registers multiple times, either with
> the same values, a new invalid base/limit pair, or a new valid
> base/limit pair.
>
> A complete emulation should handle all those, including disposing of
> an old valid window and replacing it with a new, different, valid
> window.
>
> And of course, it should handle individual 16-bit writes for the
> base/limit of the 32-bit windows.

So this patch under discussion allows the re-creation of the identical
MBus window (a Marvell special internal bus). Which is a result of a
PCI re-scan with unchanged PCIe devices.

For a "complete emulation" as mentioned above, we would need to
remove all MBus windows matching the target and attribute for this
PCIe port and lane. This is usually one window - I can't currently
think of a situation with multiple MBus windows with the same
properties here.

Thomas, should I go this way and rework this patch to first remove
the MBus window(s) and then create the new one? Or what is your
preferred solution here?

Thanks,
Stefan

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
