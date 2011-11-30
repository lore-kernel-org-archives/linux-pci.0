Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4ED656F6.4080709@ladisch.de>
Date: Wed, 30 Nov 2011 17:16:54 +0100
From: Clemens Ladisch <clemens@ladisch.de>
MIME-Version: 1.0
To: =?UTF-8?B?VG9tw6HFoSBKYW5vdcWhZWs=?= <tomi@nomi.cz>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
	Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	linux1394-devel@lists.sourceforge.net,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: DMAR:[fault reason 02] Present bit in context entry is clear
 (firewire-ohci)
References: <4BF7B147.9020502@s5r6.in-berlin.de> <20100522121212.GQ10452@parisc-linux.org> <1274553643.11551.17300.camel@macbook.infradead.org> <20100522120905.154ff932@jbarnes-x201> <20111119172127.GA31915@nomi.cz>
In-Reply-To: <20111119172127.GA31915@nomi.cz>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Tomáš Janoušek wrote:
> On Sat, May 22, 2010 at 12:09:05PM -0700, Jesse Barnes wrote:
>> On Sat, 22 May 2010 19:40:43 +0100
>> David Woodhouse <dwmw2@infradead.org> wrote:
>>> [...]
>>> Yeah, the DMAR looks at the source-id in the PCIe transactions, and it
>>> sounds like those are all 04:00.0. But we've probably set up the DMAR to
>>> allow the transactions from 04:00.4, and then it naturally faults when a
>>> "different" device actually ends up doing the transaction.
>>>
>>> If you make the pci_find_upstream_pcie_bridge() function do the
>>> appropriate thing for this device, does it then work as expected?
>>>
>>> Whether that's a _sane_ thing to do or not is possibly more of a Jesse
>>> question...
>>
>> Well, if cardbus bridges tend to behave this way in general it would
>> make sense to simply use the cardbus bride id everywhere, rather than
>> the specific functions of the device.  Cc'ing Dominik.
>
> Any news on this one?

Apparently not.

Try the patch in <https://bugzilla.redhat.com/show_bug.cgi?id=605888>
that is intended to work around the bug in your Ricoh chip.  Alternatively,
disable VT-d or FireWire in the BIOS, or add the kernel parameter
"intel_iommu=off".


Regards,
Clemens
