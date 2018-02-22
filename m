Return-Path: <SRS0=pRJG=FQ=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=pRJG=FQ=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <93faaf7b-5f9a-72e7-7816-47b83887740d@intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
 <20180220181554.GA32228@bhelgaas-glaptop.roam.corp.google.com>
 <20180222131834.GA5527@wunner.de> <93faaf7b-5f9a-72e7-7816-47b83887740d@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 22 Feb 2018 18:24:12 +0100
Message-ID: <CAJZ5v0jy8Bz1xe_rVFkbzKeS04N=mBihaB6rgnL_g6myqXFGgw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
To: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Wu <peter@lekensteyn.nl>,
	Qipeng Zha <qipeng.zha@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>, Dave Airlie <airlied@gmail.com>,
	Qi Zheng <qi.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 22, 2018 at 2:31 PM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 2/22/2018 2:18 PM, Lukas Wunner wrote:
>>
>> On Tue, Feb 20, 2018 at 12:15:54PM -0600, Bjorn Helgaas wrote:
>>>
>>> Basically I was hoping to partially rectify what I think was a mistake
>>> on my part when we merged this.  9d26d3a8f1b0 ("PCI: Put PCIe ports
>>> into D3 during suspend") is somewhat misleading because it suggests
>>> that PCI bridge power management can only be supported on non-hotplug
>>> PCIe ports, when in fact this was mostly a question of testing and "we
>>> know this works on the systems we care about so we're going to
>>> minimize our risk by excluding others".  These constraints seem pretty
>>> Intel-centric and it's not clear how or whether they apply to other
>>> architectures.
>>>
>>> Adding the comments will help with that some, but in general I don't
>>> like to artificially limit feature support because it reduces testing
>>> exposure and makes future maintenance more difficult.
>>>
>>> For example, we disallow D3 for hotplug bridges.  I don't think the
>>> spec requires that, so the fact that we put that limitation in
>>> suggests that there was some issue we didn't fully understand, and now
>>> it will be hard to go back and figure that out if and when we *do*
>>> want to support D3 for hotplug bridges.
>>
>> Some x86 machines which handle hotplug in firmware, rather than natively
>> by the OS, require that the OS doesn't transition them to D3hot behind
>> the firmware's back.  That's the reason why Mika excluded them from
>> runtime PM:
>> https://bugzilla.kernel.org/show_bug.cgi?id=53811
>>
>> If the OS handles hotplug natively, transitioning the ports to D3hot
>> should be fine in theory.  I submitted this series last May to extend
>> runtime PM to those:
>> https://www.spinics.net/lists/linux-pci/msg60962.html
>>
>> However Ashok Raj tested them on a Xeon-SP system and got Hardware Errors:
>> https://lkml.org/lkml/2017/5/3/480
>>
>> I'm not sure if I've done anything wrong in that series or if we're
>> dealing with an incompatibility of this particular platform with D3hot
>> on hotplug ports.
>
>
> Thanks for mentioning that, and for the pointers!
>
>> We do need runtime PM on hotplug ports to power off Thunderbolt
>> controllers when nothing is plugged in.  That saves 1.5 W, so a
>> noticeable amount of power.  I was going to respin the series one
>> of these days, I think the best I can do is continue to forbid
>> runtime PM on hotplug ports by default, but whitelist it for
>> Thunderbolt and allow manually enabling it on other platforms via
>> the command line.  That way, vendors are put in a position to
>> validate their platforms for runtime PM of hotplug ports, and
>> perhaps someday we can enable it for all platforms by default,
>> but with a BIOS cut-off date.
>>
>> As for the existing 2015 cut-off for non-hotplug ports, I remember
>> Rafael writing that we may try to slowly push the cut-off further
>> back into the past and stop as soon as problems are reported.
>> That hasn't happened yet because noone had a need for it.
>
>
> Right.
>
> There's more background related to this particular thing worth mentioning
> IMO.  I'll write about it later today.

It is generally advisable to realize that in many cases platform
validation is relative to the specific software stack the given
platform is going to ship with.  If there are hardware (firmware,
similar) features in the platform that aren't exercised by that
software stack, they may receive limited testing coverage and they may
not be reliable in practice even though the formal specification of
the hardware etc may require them to be functional.

Now, I'm not aware of any OS doing PCI-to-PCI bridge power management
in a serious way.  It is formally there in the PCI PM spec, but it is
optional and that spec itself was separate from the PCI proper in the
past.  AFAICS, PM is mandatory in PCIe only.

For this reason, there is a huge risk related to enabling PM on
PCI-to-PCI bridges which is why we don't do that.

Also nobody hadn't really done runtime PM even on PCIe in practice
before 2009 and power management of ports started to be done in the
Windows 8 time frame, presumably because of Connected Standby.  It
generally is risky to assume it to work in hardware that shipped
earlier and that's the reason for the cut-off date: we knew that there
had to be a cut-off, but there's no reliable science on how far in the
past to put it, so we chose a date relatively close to "now" with an
option to move it back if need be.

Thanks,
Rafael
