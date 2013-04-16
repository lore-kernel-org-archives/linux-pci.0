Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailhub.stratus.com ([134.111.1.18]:37894 "EHLO
	mailhub5.stratus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934781Ab3DPUSX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 16 Apr 2013 16:18:23 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: USB PCI quirk issue
Date: Tue, 16 Apr 2013 16:17:18 -0400
Message-ID: <5AA430FFE4486C448003201AC83BC85E03DEA379@EXHQ.corp.stratus.com>
In-Reply-To: <CAE9FiQVe95hT2mv4G+v_FMk5_qQDSg0e0fPdZdoe8Cgam70EnA@mail.gmail.com>
References: <5AA430FFE4486C448003201AC83BC85E01F83F0D@EXHQ.corp.stratus.com><20130415182614.GB9224@xanatos> <CAE9FiQVe95hT2mv4G+v_FMk5_qQDSg0e0fPdZdoe8Cgam70EnA@mail.gmail.com>
From: "Bulkow, David" <David.Bulkow@stratus.com>
To: "Yinghai Lu" <yinghai@kernel.org>,
	"Sarah Sharp" <sarah.a.sharp@linux.intel.com>
Cc: "Lawrence, Joe" <Joe.Lawrence@stratus.com>,
	<linux-pci@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	"Bulkow, David" <David.Bulkow@stratus.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Excellent.  The quirk is no longer triggering resource issues.

This leaves an issue with dev->enable_cnt in pci_disable_device.  We
still get the message 'disabling already-disabled device'.  I was hoping
by not having the resource errors, enable_cnt would be more accurate.
This occurs after:

- clean boot
- hot remove devices (effectively half of machine's PCI devices)
- hot add devices (returned to service as described in original mail)
- hot remove devices *** this is where we get 'disabling
already-disabled device'

I'll dig into this tomorrow.  Thank you for this first step.

-----Original Message-----
From: yhlu.kernel@gmail.com [mailto:yhlu.kernel@gmail.com] On Behalf Of
Yinghai Lu
Sent: Monday, April 15, 2013 4:41 PM
To: Sarah Sharp; Bulkow, David
Cc: Lawrence, Joe; linux-pci@vger.kernel.org; linux-usb@vger.kernel.org;
Bjorn Helgaas; Rafael J. Wysocki
Subject: Re: USB PCI quirk issue

On Mon, Apr 15, 2013 at 11:26 AM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> Cc-ing the public Linux PCI and USB mailing lists.
>
> On Fri, Apr 12, 2013 at 02:59:29PM -0400, Bulkow, David wrote:
>> Susan,
>
> I'm Sarah. :)
>
>> While testing Linux 3.9 we ran into an issue which I believe is a 
>> conflict between a couple of PCI changes.  Stratus has hardware that 
>> can hot add/remove chunks of its PCI hierarchy which has tickled some

>> of the newer code.  I am mailing you because I believe the second 
>> change I list below holds the key.
>>
>> I believe we are experiencing a collision between two changes.  The
>> first:
>>
>> PCI: Put pci_dev in device tree as early as possible
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
>> t/?id=4f535093cf8f6da8cfda7c36c2c1ecd2e9586ee4
>>
>> is causing device_add to be called during pci_scan_slot.  The second:
>>
>> USB: Fix handoff when BIOS disables host PCI device 
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commi
>> t/?id=cab928ee1f221c9cc48d6615070fefe2e444384a
>>
>> is getting activated by device_add.

looks like we call quirk_final too early for hotadd path.

Please check if attached can workaround the problem.

Thanks

Yinghai
