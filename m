Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <57BB9537.6040002@intel.com>
Date: Tue, 23 Aug 2016 08:13:43 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org,
 Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] PCI: Add Precision Time Measurement (PTM) support
References: <20160613185945.12503.32760.stgit@bhelgaas-glaptop2.roam.corp.google.com> <20160613190534.12503.18923.stgit@bhelgaas-glaptop2.roam.corp.google.com> <57AA984E.8040308@intel.com> <20160815185931.GD9790@localhost> <57B2C90F.8010109@intel.com> <20160816133715.GA30825@localhost> <20160822170110.GE18628@localhost>
In-Reply-To: <20160822170110.GE18628@localhost>
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-pci.vger.kernel.org>

On 08/23/2016 01:01, Bjorn Helgaas wrote:
> On Tue, Aug 16, 2016 at 08:37:15AM -0500, Bjorn Helgaas wrote:
>> On Tue, Aug 16, 2016 at 04:04:31PM +0800, Yong, Jonathan wrote:
>>> On 08/16/2016 02:59, Bjorn Helgaas wrote:
>>>>
>>>> I guess I was hoping you could test these patches.  Do you have any
>>>> way to do that?
>>>>
>>>
>>> No real hardware with this feature yet, so testing is entirely on software.
>>
>> OK, let me know the results of your software testing with these patches.
> 
> Do you have some software testing you can do on these patches?
> 

Yes, they're entirely synthetic however and do not reflect real hardware.

At the moment, they're hooks to pci_scan_bus and providing a fake config
space for the driver to manipulate, inspected with lspci.

The PTM bits are set properly as far as I can tell.
