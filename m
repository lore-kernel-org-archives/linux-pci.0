Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
Return-Path: <SRS0=K4fR=YN=rjwysocki.net=rjw@kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Kilian Singer <kilian.singer@quantumtechnology.info>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>, linux-pci <linux-pci@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCI: Revert "PCI: Add runtime PM support for PCIe ports"
Date: Fri, 30 Dec 2016 01:41:36 +0100
Message-ID: <17449344.N3OXt5xEF0@aspire.rjw.lan>
In-Reply-To: <7e01be8a-d334-3c58-8919-d79697d9064f@quantumtechnology.info>
References: <20161227235737.GB24366@bhelgaas-glaptop.roam.corp.google.com> <2589829.sCArIQeDWm@aspire.rjw.lan> <7e01be8a-d334-3c58-8919-d79697d9064f@quantumtechnology.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 30, 2016 01:39:46 AM Kilian Singer wrote:
> I did for all but
> 
> 0000:01:00:0
> 
> there bash on the mate desktop did not show a new prompt.
> 
> I opened a second terminal and for the same one it also did not show a
> prompt.
> 
> But after clicking on lock screen I had same issue.

Something fishy is going on here.

What kernel did you test it with?

Thanks,
Rafael
