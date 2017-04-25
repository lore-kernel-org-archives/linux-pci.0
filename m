Return-Path: <SRS0=YqD6=4B=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=YqD6=4B=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170425130346.GA30542@localhost>
References: <1492115445-4069-1-git-send-email-jnair@caviumnetworks.com>
 <1492115445-4069-3-git-send-email-jnair@caviumnetworks.com>
 <20170414001911.GA13163@bhelgaas-glaptop.roam.corp.google.com>
 <20170414210646.GA5346@localhost> <CAErSpo731xSzrnKF+G+8SA_UUHy7ROA1V9oFkpwKi85GQf9VAg@mail.gmail.com>
 <20170417174712.GA7575@localhost> <CAErSpo6+do8GXon3EzZAUpqc2TFsA0BDwWBULqZCd1ayCJhD6w@mail.gmail.com>
 <20170421170414.GA2429@localhost> <20170421175705.GB17916@bhelgaas-glaptop.roam.corp.google.com>
 <20170425130346.GA30542@localhost>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 25 Apr 2017 08:37:21 -0500
Message-ID: <CAErSpo4vyyocOUCVa9c7o4psLHdmUTnaKoOtjW5_oSyW=YKeGw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
To: Jayachandran C <jnair@caviumnetworks.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
	"open list:INTEL IOMMU (VT-d)" <iommu@lists.linux-foundation.org>, Jon Masters <jcm@redhat.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 25, 2017 at 8:03 AM, Jayachandran C
<jnair@caviumnetworks.com> wrote:
> On Fri, Apr 21, 2017 at 12:57:05PM -0500, Bjorn Helgaas wrote:

>> I did notice that all the Root Port devices claim to *not* be connected to
>> slots, which doesn't seem right.  For example,
>>
>>   12:00.0 PCI bridge: Broadcom Corporation Device 9084
>>       Bus: primary=12, secondary=13, subordinate=14, sec-latency=0
>>       Capabilities: [ac] Express (v2) Root Port (Slot-), MSI 00
>>
>>   13:00.0 Ethernet controller: Intel Corporation 82599EB 10-Gigabit SFI/SFP+ Network Connection
>>
>> It seems strange because the 12:00.0 Root Port looks like it probably
>> *does* lead to a slot where the NIC is plugged in.  Or is that NIC really
>> soldered down?
>>
>> But I assume there are *some* PCIe slots, so at some of those Root Ports
>> should advertise "Slot+" (which by itself does not imply hotplug support,
>> if that's the concern).
>
> The Root Ports are connected to a slot, so I am not sure why the slot implemented
> bit is not set. There seems to be nothing useful in the slot capabilites, so this
> may be ok for now. I have reported this to the hardware team.

Thanks.  The "Slot Implemented" bit and the slot registers aren't
essential if you don't want to support hotplug on those slots.  But
even without hotplug, they do contain things like a slot number, which
may be useful in the user interface.
