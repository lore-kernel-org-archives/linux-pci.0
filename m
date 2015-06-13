Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47151 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751330AbbFMBA0 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 12 Jun 2015 21:00:26 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatja@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	Rafael Wysocki <rafael.j.wysocki@intel.com>,
	Myron Stowe <mstowe@redhat.com>,
	"Brown, Len" <len.brown@intel.com>
Subject: Re: Fwd: [Bug 99751] New: Enormous resume delay, unless pcie_ports=compat
Date: Sat, 13 Jun 2015 03:26:18 +0200
Message-ID: <1490436.NQc6Hzet1C@vostro.rjw.lan>
In-Reply-To: <CAErSpo4ui+a4PRC8sWCzcSM1iWG7SHD_=x0Z9cj90-tgNKUvmw@mail.gmail.com>
References: <bug-99751-41252@https.bugzilla.kernel.org/> <CAErSpo4ui+a4PRC8sWCzcSM1iWG7SHD_=x0Z9cj90-tgNKUvmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, June 12, 2015 01:01:27 PM Bjorn Helgaas wrote:
> FYI.  There's more information and analysis, but no resolution yet, in
> the bugzilla.

pciehp_resume() seems to be problematic (and "pcie_ports=compat" probably
simply disables PCIe hotplug on that system).

> ---------- Forwarded message ----------
> From:  <bugzilla-daemon@bugzilla.kernel.org>
> Date: Wed, Jun 10, 2015 at 11:25 AM
> Subject: [Bug 99751] New: Enormous resume delay, unless pcie_ports=compat
> To: bhelgaas@google.com
> 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=99751
> 
>             Bug ID: 99751
>            Summary: Enormous resume delay, unless pcie_ports=compat
>            Product: Drivers
>            Version: 2.5
>     Kernel Version: 3.15 through 4.1rc5
>           Hardware: All
>                 OS: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: PCI
>           Assignee: drivers_pci@kernel-bugs.osdl.org
>           Reporter: lenb@kernel.org
>         Regression: No
> 
> Created attachment 179451
>   --> https://bugzilla.kernel.org/attachment.cgi?id=179451&action=edit
> lspci -vvv output
> 
> On a Dell XPS11 laptop, pcieport 0000:00:1c.0 takes
> several seconds to resume from suspend.
> 
> Booting with "pcie_ports=compat", or
> building with  CONFIG_HOTPLUG_PCI_PCIE=n
> makes this delay go away.
> 
> I've tested Linux-3.14.44 and do not see this delay.
> I've tested Linux-3.15.0 and others up through 4.1-rc5
> and I do see this delay.  So I'll mark this as a regression.
> 
> while I use analyze_suspend.py to trace resume,
> initcall_debug is sufficient to show this delay in dmesg,
> and I notice some additional PCI warnings there:
> 
> [   55.897986] pciehp 0000:00:1c.0:pcie04: Link Training Error occurs
> [   55.897988] pciehp 0000:00:1c.0:pcie04: Failed to check link status
> [   55.897992] call 0000:00:1c.0+ returned 0 after 2197660 usecs
> 
> (yes, that is 2.19 SECONDS -- where anything> 50ms for resume is considered
> slow)
> 
> Unclear (to me) what pcie04 is...
> 
> $ lspci
> 00:00.0 Host bridge: Intel Corporation Haswell-ULT DRAM Controller (rev 0b)
> 00:02.0 VGA compatible controller: Intel Corporation Device 0a1e (rev 0b)
> 00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev
> 0b)
> 00:04.0 Signal processing controller: Intel Corporation Device 0a03 (rev 0b)
> 00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04)
> 00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 (rev 04)
> 00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
> 00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 1 (rev e4)
> 00:1c.1 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 2 (rev e4)
> 00:1c.3 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 4 (rev e4)
> 00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev 04)
> 00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
> 00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1 [AHCI
> mode] (rev 04)
> 00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
> 00:1f.6 Signal processing controller: Intel Corporation 8 Series Thermal (rev
> 04)
> 05:00.0 Unassigned class [ff00]: Realtek Semiconductor Co., Ltd. RTS5249 PCI
> Express Card Reader (rev 01)
> 07:00.0 Network controller: Intel Corporation Wireless 7260 (rev 6b)
> 
> This 04 item appears under 1c.0 when I ask lspci about topology:
> $ lspci -tv
> -[0000:00]-+-00.0  Intel Corporation Haswell-ULT DRAM Controller
>            +-02.0  Intel Corporation Device 0a1e
>            +-03.0  Intel Corporation Haswell-ULT HD Audio Controller
>            +-04.0  Intel Corporation Device 0a03
>            +-14.0  Intel Corporation 8 Series USB xHCI HC
>            +-16.0  Intel Corporation 8 Series HECI #0
>            +-1b.0  Intel Corporation 8 Series HD Audio Controller
>            +-1c.0-[04]--
>            +-1c.1-[05]----00.0  Realtek Semiconductor Co., Ltd. RTS5249 PCI
> Express Card Reader
>            +-1c.3-[07]----00.0  Intel Corporation Wireless 7260
>            +-1d.0  Intel Corporation 8 Series USB EHCI #1
>            +-1f.0  Intel Corporation 8 Series LPC Controller
>            +-1f.2  Intel Corporation 8 Series SATA Controller 1 [AHCI mode]
>            +-1f.3  Intel Corporation 8 Series SMBus Controller
>            \-1f.6  Intel Corporation 8 Series Thermal
> 
> --
> You are receiving this mail because:
> You are watching the assignee of the bug.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
