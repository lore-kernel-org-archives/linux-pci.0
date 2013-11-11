Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f171.google.com ([209.85.128.171]:38621 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256Ab3KKV0H (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2013 16:26:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
References: <52797238.8070304@gmail.com>
	<20131106002505.GC3359@google.com>
	<CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
	<CADTPrLQpaCDo_YCC2=MmT1iCrWRPqzDpnqQZrE8OMjRMc6WYmQ@mail.gmail.com>
	<20131108012352.GE2955@google.com>
	<CADTPrLTYOXsGovL8HJ7=+K30OWVeSdMKTma_UuMV8ZRFB6CkYA@mail.gmail.com>
	<CAErSpo7MH=+Jk-ujBoHquk2e+no1cqEV6p=R1E6LGvcLSJQyKw@mail.gmail.com>
Date: Mon, 11 Nov 2013 13:26:06 -0800
Message-ID: <CADTPrLRJD0er1kijjm2SEE6wUA9eQaz+OOd67E3MpHLu6k-R6Q@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
From: Rajat Jain <rajatjain.linux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux hotplug mailing <linux-hotplug@vger.kernel.org>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	Rajat Jain <rajatjain@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

>> With my patch, we'd eliminate the 1 second delay and the second line
>> of output above. If we also want to get rid of the first line
>> "Unexpected CMD_COMPLETED..." also, that would probably have to be
>> solved by changing the behavior to assume that CC shall be generated
>> for every SLOTCTRL register write.
>
> I *do* want to get rid of the "Unexpected CMD_COMPLETED" complaint.
> We shouldn't complain about hardware that is working perfectly fine.
> I don't know the best way to do that yet.  I have found a box with the
> same hardware that was fixed by 5808639bfa98, so I hope to play with
> it and figure out something that will work nicely for both scenarios.

Please keep posted :-)

>
> BTW, can you open a report at bugzilla.kernel.org and attach your
> "lspci -vvxxx" and dmesg output?  When we eventually merge a fix, I'd
> like to have the details archived somewhere.

Done:

https://bugzilla.kernel.org/show_bug.cgi?id=64821

Please let me know if you need any help in trying something out - I'd
be more than keen to help - write code or test.

BTW, I figured another way that solves the current problem at hand
(for both kind of controllers). Today the events are cleared just
before call to pcie_disable_notification, if we clear them afterwards
also, the current problem is taken care of for all controllers. Of
course this does not look the right way to solve the problem though
(since the ctrl->no_cmd_completed shall still be 1, which is not
right).

@@ -948,6 +948,10 @@ struct controller *pcie_init(struct pcie_device *dev)

        /* Clear all remaining event bits in Slot Status register */
        if (pciehp_writew(ctrl, PCI_EXP_SLTSTA, 0x1f))
                goto abort_ctrl;

        /* Disable sotfware notification */
        pcie_disable_notification(ctrl);

+       /* Clear all remaining event bits in Slot Status register */
+       if (pciehp_writew(ctrl, PCI_EXP_SLTSTA, 0x1f))
+               goto abort_ctrl;
+
        ctrl_info(ctrl, "HPC vendor_id %x device_id %x ss_vid %x ss_did %x\n",
                  pdev->vendor, pdev->device, pdev->subsystem_vendor,
                  pdev->subsystem_device);


Thanks,

Rajat
