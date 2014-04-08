Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5344679E.1030008@pobox.com>
Date: Tue, 08 Apr 2014 17:18:22 -0400
From: Mark Lord <mlord@pobox.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: driver skip pci_set_master, fix it? No.
References: <5344251D.7040805@pobox.com> <CAErSpo6KuYLaoEsxR4jJQ98P23kNEMzMcu_-RyM3nWd6YRxgag@mail.gmail.com>
In-Reply-To: <CAErSpo6KuYLaoEsxR4jJQ98P23kNEMzMcu_-RyM3nWd6YRxgag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14-04-08 02:27 PM, Bjorn Helgaas wrote:
> [+cc Ben, linux-pci]
> 
> On Tue, Apr 8, 2014 at 10:34 AM, Mark Lord <mlord@pobox.com> wrote:
>> I am working a couple of drivers for chips that perform extensive bus-mastering ops.
>> These including full SRIOV support, and allow assigning virtual functions to virtual machines, etc.
>>
>> One thing the driver (still in development) does for safety,
>> is defer the call to pci_set_master() until *after* it has mapped
>> the MMIO space of the chips, so it can reset/flush the DMA engines
>> before giving them permission to scribble over host RAM.
>>
>> But a recent patch to the kernel has removed this from the driver's control.
>> The core PCI now does pci_set_master() immediately on pci_enable_device().
> 
> I assume you're talking about the one added by cf3e1feba7f9 ("PCI:
> Workaround missing pci_set_master in pci drivers"), but as far as I
> can tell, it only calls pci_set_master() for *bridge* devices.  What
> am I missing?  Is pci_set_master() being called for your endpoint?
> What path is that?

Yes, it is being called during execution of the _probe() function in my driver,
as evidenced by the annoying (and wrong) message it produces.

Next time I've got the hardware at hand, I'll put a "dump_stack()" into there
to see the exact calling path.
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com
