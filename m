Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180]:47464 "EHLO
	mail-vc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbaBTHmH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 02:42:07 -0500
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <8a021ad12c5548fe8e79e0208725c14f@DM2PR05MB671.namprd05.prod.outlook.com>
References: <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
	<CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
	<20131108012352.GE2955@google.com>
	<CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
	<CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
	<CADTPrLRJD0er1kijjm2SEE6wUA9eQaz+OOd67E3MpHLu6k-R6Q@mail.gmail.com>
	<20131123005102.GA14690@google.com>
	<a3dc3d613f274e4d993d6a7612f1dde6@BLUPR05MB118.namprd05.prod.outlook.com>
	<CAErSpo7J8UZpYSaAPavJrR8iOt368expOuF-s_M7x+jW7drnWw@mail.gmail.com>
	<18997e8c20fb4bdd8a72e4c01b3fd308@BLUPR05MB118.namprd05.prod.outlook.com>
	<20140212003458.GE21057@google.com>
	<8a021ad12c5548fe8e79e0208725c14f@DM2PR05MB671.namprd05.prod.outlook.com>
Date: Wed, 19 Feb 2014 23:42:05 -0800
Message-ID: <CAA93t1rjOfVgSWepOEWBx6G0mVrdGTVt=VX9X_S-zeYSyjgsAA@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
From: Rajat Jain <rajatxjain@gmail.com>
To: Rajat Jain <rajatjain@juniper.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatjain.linux@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

>>
>> On Mon, Nov 25, 2013 at 07:03:11PM +0000, Rajat Jain wrote:
>> > Hello,
>> >
>> > > > On a different note, I feel there is still a need to apply my
>> > > > original
>> > > patch. There is still an open problem in case of spurious interrupts
>> > > (or in any case where the condition "if (slot_status &
>> PCI_EXP_SLTSTA_CC)"
>> > > becomes true in pcie_write_cmd()). That is because once that
>> > > happens, we never clear that interrupt, and no further hotplug
>> > > interrupts shall be received unless we do that.
>> > >
>> > > I agree this is an issue and we should address it somehow.  My
>> > > hesitation is just that I'd prefer to do some more aggressive
>> > > restructuring rather than apply a point fix.  For example:
>> >
>> > OK, I'll attempt to fix it that way when I get time.
>> >
>> > >
>> > > - We currently look at PCI_EXP_SLTSTA_CC in pcie_isr(),
>> > > pcie_poll_cmd(), and pcie_write_cmd().  I think it would be better
>> > > to look at it only in pcie_isr().
>> > >
>> > > - I don't think pcie_poll_cmd() should exist at all; we should poll
>> > > by calling pcie_isr() instead.
>> > >
>> > > - We need pcie_write_cmd(), but I think the way it waits is
>> backwards.
>> > >  Currently we issue the command, then wait for it to complete.  I
>> > > think we should issue the command, note the current time, and return
>> > > without waiting.  The *next* time we need to issue a command, we can
>> > > wait for completion of the previous one (or timeout) if necessary.
>> > >
>> > > But maybe we need the point fix in the interim, especially if
>> > > anybody can actually produce the scenario you mention.
>> >
>> > Ok.
>>
>> This patch is still in patchwork, but I've lost track of where we are.
>> Did you resolve this in the series that I just applied, or is it still
>> an outstanding issue?
>
> No, I did not solve it. It is still an outstanding issue. So far I am using your patch to overcome this:
>
> http://www.spinics.net/lists/hotplug/msg05830.html
>
> I'll just attempt to conclude the status on this issue so that you can make the decision on the course of action. IMHO there are 2 independent issues that we discussed in this thread:
>
> 1) PCIe compliant HW (that generates cmd completed interrupts at every write of Slot_ctrl register) being penalized with 1 second delay during the boot up. Your patch solves this.
>
> 2) If there is a genuine spurious interrupt, it does not get acknowledged. I had originally posted a patch for THIS problem.
> http://www.spinics.net/lists/hotplug/msg05815.html
>
> You had indicated that you would rather want a bigger restructuring of the driver to solve (2).
>
> My observation: MY problem (in my setup) is not seen if I use either of the patches (yours or mine).
>
> My opinion: I think my patch solves (2) but might not solve (1) for all corner cases. Also your patch solves (1) but may not solve (2) for all corner cases -Thus we should probably solve both of these problems individually.
>

Just wondering if you decided on how to solve this problem?

Are you planning this for 3.15?

Thanks,

Rajat
