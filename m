Return-Path: <SRS0=it8y=IJ=gmail.com=rjwysocki@kernel.org>
Return-Path: <SRS0=it8y=IJ=gmail.com=rjwysocki@kernel.org>
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180522130612.GB161672@bhelgaas-glaptop.roam.corp.google.com>
References: <2360046.ecez94sF1Y@aspire.rjw.lan> <20180522130612.GB161672@bhelgaas-glaptop.roam.corp.google.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 22 May 2018 17:21:47 +0200
Message-ID: <CAJZ5v0gssLSpaN+OdeGP5-O4RFwwONL6FF0=swo+kc2R0+Av1g@mail.gmail.com>
Subject: Re: [PATCH] PCI / PM: Clean up outdated comments in pci_target_state()
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PCI <linux-pci@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2018 at 3:06 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Mon, May 21, 2018 at 01:11:12PM +0200, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> Two comments in pci_target_state() are outdated, as the function
>> doesn't set the target power state for the device any more, only
>> finds one for it, so fix them accordingly.
>>
>> Reported-by: Bjorn Helgaas <bhelgaas@google.com>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume you'll merge this; let me know if you'd rather that I take it.

I will take it, thanks!

Can you have a look at https://patchwork.kernel.org/patch/10408977/
too, please, while at it?
