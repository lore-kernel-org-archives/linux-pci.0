Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150803191340.GM7557@n2100.arm.linux.org.uk>
References: <1437514519-18545-1-git-send-email-m-karicheri2@ti.com> <20150803191340.GM7557@n2100.arm.linux.org.uk>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 3 Aug 2015 17:34:36 -0500
Message-ID: <CAErSpo4PBKL9KFf80C6n8CwGRB6zq02rJ9i-LhG5RQYaYKcsWg@mail.gmail.com>
Subject: Re: [PATCH] ARM/PCI: set MPS before pci_bus_add_devices()
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Murali Karicheri <m-karicheri2@ti.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 3, 2015 at 2:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jul 21, 2015 at 05:35:19PM -0400, Murali Karicheri wrote:
>> The MPS configuration should be done *before* pci_bus_add_devices().
>> After pci_bus_add_devices(), drivers may be bound to devices, and
>> the PCI core shouldn't touch device configuration while a driver
>> owns the device.
>>
>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  arch/arm/kernel/bios32.c | 19 +++++--------------
>>  1 file changed, 5 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
>> index fcbbbb1..17efde7 100644
>> --- a/arch/arm/kernel/bios32.c
>> +++ b/arch/arm/kernel/bios32.c
>> @@ -520,7 +520,8 @@ void pci_common_init_dev(struct device *parent, struct hw_pci *hw)
>>       list_for_each_entry(sys, &head, node) {
>>               struct pci_bus *bus = sys->bus;
>>
>> -             if (!pci_has_flag(PCI_PROBE_ONLY)) {
>> +             if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>
> Let's get rid of that useless check.  bus can't be NULL here.
>
> In the original code (below) if bus was NULL, then we would've already
> oopsed before we got here.  As we don't oops here, no one is ever
> seeing it being NULL, so the test is redundant.
>
>> -     list_for_each_entry(sys, &head, node) {
>> -             struct pci_bus *bus = sys->bus;
>> -
>> -             /* Configure PCI Express settings */
>> -             if (bus && !pci_has_flag(PCI_PROBE_ONLY)) {
>

Sorry, I had forgotten to push this branch, but I did already get rid
of the check for bus being NULL:

http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/commit/?id=808b27a5ae05
