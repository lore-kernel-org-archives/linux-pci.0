Return-Path: <SRS0=EwSf=FO=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=EwSf=FO=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0irpPi4PXPHWaSpa3=MpUY4Sg3C-iHd0LPQN+FN-VTRpQ@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Feb 2018 10:57:07 +0100
Message-ID: <CAJZ5v0goX+Op9WwyPn1eNNreatA0WFsqpEYontmEL7etNDudpQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of
 conventional and hotplug bridges
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>, Linux PM <linux-pm@vger.kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:41 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>> From: Bjorn Helgaas <bhelgaas@google.com>
>>
>> Previously "pcie_port_pm=force" enabled power management of PCI bridges,
>> but only for PCIe ports (not conventional PCI bridges) and only for ports
>> that do not support hotplug.  Those limitations are there because we're not
>> confident that all those configurations work, not because the spec requires
>> them.
>>
>> Change "pcie_port_pm=force" to enable power management of conventional PCI
>> bridges and hotplug bridges as well as PCIe ports.  As with the previous
>> PCIe port-only behavior, this is not expected to work in all systems.
>>
>> Add a "pci=bridge_pm" parameter to reflect the increased scope.  For
>> backward compatibility, retain "pcie_port_pm=force" as an undocumented
>> equivalent.
>>
>> Add "pci=no_bridge_pm" as an equivalent to "pcie_port_pm=off".  This
>> disables power management for all PCI bridges, which is results in the same
>> behavior as before, since we always disabled power management of
>> conventional PCI bridges, and "pcie_port_pm=off" disabled it for PCIe
>> ports.
>>
>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> Honestly, I wouldn't do that, at least not this way.
>
> Somebody might be using pcie_port_pm=force already, for example, and
> it works for them for PCIe, but the PCI-to-PCI part of the same system
> may not.
>
> IMO the behavior of pcie_port_pm= should be as is and I don't see
> what's wrong with it being documented.

That said it may be useful to add something like this to the
documentation of it in kernel-parameters.txt:

[PCIe port power management is needed to enable SoC-wide power
management on some SoCs shipping since 2015, so it is enabled by
default on systems from 2015 and newer.  Some older systems may still
benefit from it and it may not work on some newer systems due to
hardware problems.  Use this parameter in those cases.]
