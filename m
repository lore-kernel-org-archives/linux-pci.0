Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.sysgo.com ([176.9.12.79]:36786 "EHLO mail.sysgo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932174AbcDYNEu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 25 Apr 2016 09:04:50 -0400
Subject: [PATCH] Re: Exception due to PCI: Use pci_is_root_bus() to check for
 root bus
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5704F85B.4080501@sysgo.com> <20160406133502.GB4976@localhost>
 <570516CB.7080406@sysgo.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-pci@vger.kernel.org
From: David Engraf <david.engraf@sysgo.com>
Message-ID: <571E15EF.9080507@sysgo.com>
Date: Mon, 25 Apr 2016 15:04:47 +0200
MIME-Version: 1.0
In-Reply-To: <570516CB.7080406@sysgo.com>
Content-Type: multipart/mixed;
 boundary="------------020009000100000500090904"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020009000100000500090904
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

Am 06.04.2016 um 16:01 schrieb David Engraf:
> Hi Bjorn,
>
> Am 06.04.2016 um 15:35 schrieb Bjorn Helgaas:
>> Hi David,
>>
>> On Wed, Apr 06, 2016 at 01:51:55PM +0200, David Engraf wrote:
>>> Hi,
>>>
>>> I have an exception in __pci_bus_size_bridges() when pci_is_root_bus
>>> returns false but bus->self == NULL. My driver registers a virtual
>>> bus, like virtfn_add_bus(). pci_add_new_bus() is called with a
>>> parent but without a pci_dev. Thus bus->parent is set but bus->self
>>> is NULL. When __pci_bus_size_bridges() is called I get an exception
>>> at:
>>>
>>> switch (bus->self->class >> 8)
>>>
>>> The previous version of the code, checking for bus->self != NULL
>>> worked for me. I think an additional check is required to make sure
>>> we're not accessing a NULL pointer.
>>
>> When you say "previous version of the code," do you mean a previous
>> version of Linux worked correctly but a newer version does not?  What
>> versions are they?  Did you identify a commit that changed the
>> behavior?  I assume you're talking about an out-of-tree driver that
>> registers a virtual bus?  Can you point us to the code?  Can you share
>> the dmesg log, including the backtrace?
>
> With previous version, I mean reverting commit
> 2ba29e270e977b213a7d58ae1152c23a1c3074a3. This will check for bus->self
> instead of using pci_is_root_bus().
> I'm working on a driver which is basically based on drivers/pci/iov.c.
>
> The code looks like this:
>
> child = pci_add_new_bus(parent, NULL, busnr);
>
> This will create child with child->parent = parent and child->self =
> NULL. When the kernel calls __pci_bus_size_bridges(), accessing
> bus->self->class crashes:
>
> /* The root bus? */
> if (pci_is_root_bus(bus))
>      return;
>
> switch (bus->self->class >> 8) { <- crash here because of bus->self == NULL

With this patch the system no longer crashes and the virtual PCI bus 
works. It returns on bus->self == NULL, thus the switch instruction does 
not access a NULL pointer.

Best regards
- David


--------------020009000100000500090904
Content-Type: text/x-diff;
 name="setup-pci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="setup-pci.patch"

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 55641a3..ddb3381 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1245,6 +1245,10 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 	if (pci_is_root_bus(bus))
 		return;
 
+	/* bridge device available? */
+	if (!bus->self)
+		return;
+
 	switch (bus->self->class >> 8) {
 	case PCI_CLASS_BRIDGE_CARDBUS:
 		/* don't size cardbuses yet. */

--------------020009000100000500090904--
