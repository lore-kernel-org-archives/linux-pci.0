Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:58034 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934114AbaLKXXr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 11 Dec 2014 18:23:47 -0500
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <gwshan@linux.vnet.ibm.com>;
	Fri, 12 Dec 2014 04:53:45 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id BA4E2E0056
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2014 04:54:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id sBBNNtvU62980322
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2014 04:53:55 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id sBBNNgGx008698
	for <linux-pci@vger.kernel.org>; Fri, 12 Dec 2014 04:53:43 +0530
Date: Fri, 12 Dec 2014 10:23:36 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rafael Wysocki <rjw@sisk.pl>
Subject: Re: [PATCH RFC] PCI: Turn off BARs when disabling device
Message-ID: <20141211232336.GA7479@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1418277792-4090-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <CAErSpo4y=MjRkAmxFChD4mOqQ_okkib5MLjTy-m=adXvnJqf4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAErSpo4y=MjRkAmxFChD4mOqQ_okkib5MLjTy-m=adXvnJqf4w@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 11, 2014 at 09:49:57AM -0700, Bjorn Helgaas wrote:
>On Wed, Dec 10, 2014 at 11:03 PM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
>> When unbinding PCI device mlx4 from its driver, the PCI device is
>> disabled by pci_disable_device() and the BARs (IO and memory) should
>> be disabled at the point. However, the memory BARs are still active
>> after the mlx4_core driver is unloaded as following logs show.
>>
>>  # lspci -vv -s 0003:0f:00.0
>>  0003:0f:00.0 Network controller: Mellanox Technologies \
>>               MT27500 Family [ConnectX-3]
>>  Subsystem: Mellanox Technologies Device 0061
>>  Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- \
>>           ParErr+ Stepping- SERR+ FastB2B- DisINTx+
>>     :
>>  Kernel driver in use: mlx4_core
>>  # echo 0003:0f:00.0 > /sys/bus/pci/drivers/mlx4_core/unbind
>>  # lspci -vv -s 0003:0f:00.0
>>  0003:0f:00.0 Network controller: Mellanox Technologies \
>>               MT27500 Family [ConnectX-3]
>>  Subsystem: Mellanox Technologies Device 0061
>>  Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- \
>>           ParErr+ Stepping- SERR+ FastB2B- DisINTx-
>>
>> The patch turns off all BARs (IO and memory) in do_pci_disable_device().
>>
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>>  drivers/pci/pci.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 625a4ac..8d2924b 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -1496,12 +1496,14 @@ void __weak pcibios_penalize_isa_irq(int irq, int active) {}
>>
>>  static void do_pci_disable_device(struct pci_dev *dev)
>>  {
>> -       u16 pci_command;
>> +       u16 cmd, flags = (PCI_COMMAND_IO |
>> +                         PCI_COMMAND_MEMORY |
>> +                         PCI_COMMAND_MASTER);
>>
>> -       pci_read_config_word(dev, PCI_COMMAND, &pci_command);
>> -       if (pci_command & PCI_COMMAND_MASTER) {
>> -               pci_command &= ~PCI_COMMAND_MASTER;
>> -               pci_write_config_word(dev, PCI_COMMAND, pci_command);
>> +       pci_read_config_word(dev, PCI_COMMAND, &cmd);
>> +       if (cmd & flags) {
>> +               cmd &= ~flags;
>> +               pci_write_config_word(dev, PCI_COMMAND, cmd);
>
>Does this fix an actual problem?  If so, I'd like to see details about
>what the problem is.
>

It doesn't fix any real problems and I had "RFC" in the subject for
more discussion on this. The phenomenon I observed: In kexec scenario,
the first kernel expects to shutdown all PCI devices by struct pci_driver::
shutdown() and pci_disable_device() should be called there though lots
of drivers missed to call pci_disable_device(). The result is that
PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits, which were enabled by the
first kernel, aren't cleared by the first kernel before starting the
second kernel. Then we see enabled PCI_COMMAND_IO and PCI_COMMAND_MEMORY
bits in the second kernel all the way and we don't want see them until
the driver is loaded.

The above phenomenon can be observed in driver unbinding scenario as
well. Generally speaking, we've having unbalanced pci_enable_device()
and pci_disable_device(). Also, I am thinking there might be some
reasons for us to keep those bits even the PCI device has been
disabled by pci_disable_device(), which is another reason I put "RFC"
in the subject.

>I'm a bit concerned about turning off IO/MEMORY/MASTER unconditionally
>because we have code that is a bit careful to avoid that in some
>cases.  Search for "mmio_always_on" and see commit 253d2e549818 ("PCI:
>disable mmio during bar sizing").
>

Yep, those PCI devices with "mmio_always_on" should be immune from
clearing PCI_COMMAND_IO and PCI_COMMAND_MEMORY bits in pci_disable_device().

>So if this patch fixes a problem, all well and good, but we do need to
>make sure we don't introduce another problem at the same time.
>

I was sending the patch just for discussion :-)

Thanks,
Gavin

>Bjorn
>
>>         }
>>
>>         pcibios_disable_device(dev);
>> --
>> 1.8.3.2
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

