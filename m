Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <556F1A22.7050400@roeck-us.net>
Date: Wed, 03 Jun 2015 08:15:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net> <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon> <556DE1B9.6020100@roeck-us.net> <CAErSpo4WyQqc+En6hAB9B63sszKc8B93FiycwaDG42tecSB9Mg@mail.gmail.com>
In-Reply-To: <CAErSpo4WyQqc+En6hAB9B63sszKc8B93FiycwaDG42tecSB9Mg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 06/02/2015 12:58 PM, Bjorn Helgaas wrote:
> On Tue, Jun 2, 2015 at 12:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:
[ ... ]
>>>>
>>>> I wonder if we can do the same with pci_read_bridge_mmio_pref(), and
>>>> somehow get rid of pci_bridge_check_ranges() altogether?
>>>>
>>>> I think I looked at doing that a while back, and it seems like there was
>>>> some wrinkle, but I don't remember what it was.
>>
>> After looking into this some more, I think the wrinkle may be that
>> pci_read_bridge_bases() and thus pci_read_bridge_io() isn't called
>> on probe-only systems (if PCI_PROBE_ONLY is set). A secondary
>> problem is that pci_read_bridge_io() does not enable a resource
>> if it is explicitly disabled (base > limit), but the subsequent call
>> to pci_bridge_check_ranges() unconditionally enables it.
>
> I haven't researched this, but it sounds wrong that we skip
> pci_read_bridge_bases() if PCI_PROBE_ONLY is set.  I think
> PCI_PROBE_ONLY should mean "look, but don't touch."  So I think we
> should always look at the bridge windows, and my advice is to see if
> it looks reasonable to change this aspect of PCI_PROBE_ONLY.
>

Looks like Lorenzo's patch is going to take care of that problem.

How about the second problem mentioned above ? One option might be to
keep pci_bridge_check_ranges() but only use it to _enable_ the various
ranges (and maybe rename it accordingly) ?

Thanks,
Guenter

