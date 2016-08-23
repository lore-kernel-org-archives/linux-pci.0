Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Tue, 23 Aug 2016 16:44:21 -0400
From: Keith Busch <keith.busch@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] pci: Add ignore indicator quirk for devices
Message-ID: <20160823204421.GA10993@localhost.localdomain>
References: <20160817230951.GD25146@localhost.localdomain>
 <20160818195656.GH27353@localhost>
 <20160818224610.GA28276@localhost.localdomain>
 <20160822165524.GC18628@localhost>
 <20160822211536.GE28276@localhost.localdomain>
 <20160823133913.GN18628@localhost>
 <20160823171018.GB10224@localhost.localdomain>
 <eed69a47-633b-0c0c-e5c1-663bf37a9ec3@codeaurora.org>
 <20160823192330.GA10866@localhost.localdomain>
 <20160823195221.GA3725@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160823195221.GA3725@localhost>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 23, 2016 at 02:52:21PM -0500, Bjorn Helgaas wrote:
> Everybody probably knows this, but the problem is not with LED control
> per se.  The problem is multiple writers to the Slot Control register.
> Each write to Slot Control is a "command", and software is responsible
> for waiting for one command to complete before writing another (see
> PCIe r3.0, sec 6.7.3.2).
> 
> It's no problem to make pciehp keep its mitts off the LEDs; the
> problem is if ledmon writes Slot Control for the indicators, and
> pciehp writes Slot Control for some other reason at about the same
> time.
> 
> Sinan has a very interesting idea...  Maybe we can work with that.
> Hmm, it looks like if we have an attention indicator, we already put
> an "attention" file in sysfs (see attention_write_file()).  That
> should eventually call into pciehp_set_attention_status(), where we
> currently only support off/on/blink states.
> 
> What if you made a quirk that replaced pciehp_set_attention_status()
> with a special version that supported the extra states you need and
> made ledmon use that sysfs file instead of writing Slot Control
> directly?  Would everything just work?

I'm on board with this idea. I'll get some testing started and send a
new version if/when successful.
