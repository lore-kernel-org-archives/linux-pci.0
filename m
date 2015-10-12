Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:30537 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751973AbbJLVFs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 12 Oct 2015 17:05:48 -0400
Date: Mon, 12 Oct 2015 21:05:46 +0000 (UTC)
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Keith Busch <keith.busch@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	linux-pci@vger.kernel.org, Jiang Liu <jiang.liu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bryan Veal <bryan.e.veal@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCHv2] x86/pci: Initial commit for new VMD device
 driver
In-Reply-To: <20151006231412.GF29420@localhost>
Message-ID: <alpine.LNX.2.00.1510122050180.27742@localhost.lm.intel.com>
References: <1443721454-25467-1-git-send-email-keith.busch@intel.com> <20151006231412.GF29420@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 6 Oct 2015, Bjorn Helgaas wrote:
>> +static int __init vmd_init(void)
>> +{
>> +	return pci_register_driver(&vmd_drv);
>> +}
>> +module_init(vmd_init);
>
> module_pci_driver(vmd_drv)?

We actually only have a module_init in this driver, and purposely left
out module_exit. We don't want to be able to unload this because we
can't reference count this module for modules depending on it.

'rmmod <module>' returns busy if you're actively using a device that
module is driving, but the end devices VMD provides are not driven by the
VMD driver; it'd be kind of like being able to unload the pci core driver.
