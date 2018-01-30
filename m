Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 30 Jan 2018 13:18:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: =?utf-8?B?5Yav6ZSQ?= <rui_feng@realsil.com.cn>
Cc: "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: =?utf-8?B?562U5aSNOiDnrZTlpI06IOetlA==?= =?utf-8?B?5aSNOg==?=
 [PATCH v6] mfd: Add support for RTS5250S power saving
Message-ID: <20180130191827.GI232763@bhelgaas-glaptop.roam.corp.google.com>
References: <1504772799-15173-1-git-send-email-rui_feng@realsil.com.cn>
 <20171214222522.GL30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8150B@RS-MBS01.realsil.com.cn>
 <20171215151522.GT30595@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8193C@RS-MBS01.realsil.com.cn>
 <20171227233750.GB79892@bhelgaas-glaptop.roam.corp.google.com>
 <20180117210121.GD7039@bhelgaas-glaptop.roam.corp.google.com>
 <2A308283684ECD4B896628E09AF5361E01A8A102@RS-MBS01.realsil.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2A308283684ECD4B896628E09AF5361E01A8A102@RS-MBS01.realsil.com.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jan 19, 2018 at 07:38:22AM +0000, 冯锐 wrote:
> > On Wed, Dec 27, 2017 at 05:37:50PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Dec 19, 2017 at 08:15:24AM +0000, 冯锐 wrote:
> > > > > On Fri, Dec 15, 2017 at 09:42:45AM +0000, 冯锐 wrote:
> > > > > > > [+cc Hans, Dave, linux-pci]
> > > > > > >
> > > > > > > On Thu, Sep 07, 2017 at 04:26:39PM +0800,
> > > > > > > rui_feng@realsil.com.cn
> > > > > wrote:
> > > > > > > > From: Rui Feng <rui_feng@realsil.com.cn>
> > > > > > >
> > > > > > > I wish this had been posted to linux-pci before being merged.
> > > > > > >
> > > > > > > I'm concerned because some of this appears to overlap and
> > > > > > > conflict with PCI core management of ASPM.
> > > > > > >
> > > > > > > I assume these devices advertise ASPM support in their Link
> > > > > > > Capabilites registers, right?  If so, why isn't the existing
> > > > > > > PCI core ASPM support sufficient?
> > > > > > >
> > > > > > When L1SS is configured, the device(hardware) can't enter L1SS
> > > > > > status automatically, it need driver(software) to do some work
> > > > > > to achieve the
> > > > > function.
> > > > >
> > > > > So this is a hardware defect in the device?  As far as I know,
> > > > > ASPM and L1SS are specified such that they should work without special
> > driver support.
> > > > >
> > > > Yes, you can say that.
> > > >
> > > > > > > > Enable power saving for RTS5250S as following steps:
> > > > > > > > 1.Set 0xFE58 to enable clock power management.
> > > > > > >
> > > > > > > Is this clock power management something specific to RTS5250S,
> > > > > > > or is it standard PCIe architected stuff?
> > > > > > >
> > > > > > 0xFE58 is specific register to RTS5250S not standard PCIe architected
> > stuff.
> > > > >
> > > > > OK.  I asked because devices often mirror architected PCIe config
> > > > > things in device-specific MMIO space, and if I squint just right,
> > > > > I can sort of match up the register bits you used with things in the PCIe
> > spec.
> > > > >
> > > > > > > > 2.Check cfg space whether support L1SS or not.
> > > > > > >
> > > > > > > This sounds like standard PCIe ASPM L1 Substates, right?
> > > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > > > 3.If support L1SS, set 0xFF03 to free clkreq.
> > > > > > > > 4.When entering idle status, enable aspm
> > > > > > > >   and set parameters for L1SS and LTR.
> > > > > > > > 5.Wnen entering run status, disable aspm
> > > > > > > >   and set parameters for L1SS and LTR.
> > > > > > >
> > > > > > > In general, drivers should not configure ASPM, L1SS, and LTR
> > > > > > > themselves; the PCI core should do that.
> > > > > > >
> > > > > > > If a driver needs to tweak ASPM at run-time, it should use
> > > > > > > interfaces exported by the PCI core to do so.
> > > > > > >
> > > > > > Which interface I can use to set ASPM? I use "pci_write_config_byte"
> > now.
> > > > >
> > > > > What do you need to do?  include/linux/pci-aspm.h exports
> > > > > pci_disable_link_state(), which is mainly used to avoid ASPM
> > > > > states that have hardware errata.
> > > > >
> > > > I want to enable ASPM(L0 -> L1) and disable ASPM(L1 -> L0), which
> > > > interface can I use?
> > >
> > > You can use pci_disable_link_state() to disable usage of L1.
> > >
> > > Currently there is no corresponding pci_enable_link_state().  What if
> > > we added something like the following (untested)?  Would that work for
> > > you?
> > 
> > Hi Rui,
> > 
> > Any thoughts on the patch below?
> 
> I'm busy with other work, the patch seems ok, I will test it later.

Any idea when you might get back to this?

If you can't do it, I can try doing it myself, but of course, I don't
know the details about the device errata and I wouldn't be able to
test it.

Bjorn
