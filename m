Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Return-Path: <SRS0=tWbE=YN=quantumtechnology.info=kilian.singer@kernel.org>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com>
 <1180505121.522.1483056977880.JavaMail.zimbra@quantumtechnology.info>
 <3ae00c72-a4e1-dd97-e9d4-2450ee274b72@quantumtechnology.info>
 <2589829.sCArIQeDWm@aspire.rjw.lan>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
From: Kilian Singer <kilian.singer@quantumtechnology.info>
Message-ID: <7e01be8a-d334-3c58-8919-d79697d9064f@quantumtechnology.info>
Date: Fri, 30 Dec 2016 01:39:46 +0100
MIME-Version: 1.0
In-Reply-To: <2589829.sCArIQeDWm@aspire.rjw.lan>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

I did for all but

0000:01:00:0

there bash on the mate desktop did not show a new prompt.

I opened a second terminal and for the same one it also did not show a
prompt.

But after clicking on lock screen I had same issue.


On 30-Dec-16 01:22, Rafael J. Wysocki wrote:
> On Friday, December 30, 2016 01:24:19 AM Kilian Singer wrote:
>> The
>>
>> echo on > /sys/bus/pci/devices/0000:00:1c.0/power/control
>>
>> did not help neither.
> So does it help if you do "echo on > .../power/control" for all devices under
> /sys/bus/pci/devices/ ?
>
> Thanks,
> Rafael
>
