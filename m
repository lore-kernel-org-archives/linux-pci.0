Return-Path: <SRS0=EIIT=BB=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=EIIT=BB=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20171002232941.GF5407@bhelgaas-glaptop.roam.corp.google.com>
References: <8776535.A6PtrVU7Ea@aspire.rjw.lan> <20171002232941.GF5407@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 3 Oct 2017 01:45:34 +0200
Message-ID: <CAJZ5v0gMPBgt_sAHL243oU4eZ6E32JemomTgN0pADB_s6-vkmg@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Add dev_dbg() to print device suspend power states
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 3, 2017 at 1:29 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Sep 30, 2017 at 01:31:15AM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> It sometimes is useful to know what power states the kernel thinks
>> it puts PCI devices into during system suspend, so add a dev_dbg()
>> statement for that.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I think you have other pending changes in this path, so can you take
> this one as well?

Yes, I can, thanks!
