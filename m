Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Hans de Bruin <jmdebruin@xmsnet.nl>,
	Keith Busch <keith.busch@intel.com>,
	Arthur Marsh <arthur.marsh@internode.on.net>
Cc: Jiang Liu <jiang.liu@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH] x86/PCI: Fix regression caused by commit 4d6b4e69a245
Date: Wed, 02 Dec 2015 03:08:02 +0100
Message-ID: <1576679.cyINxMsXYv@vostro.rjw.lan>
In-Reply-To: <565DEE62.9080105@xmsnet.nl>
References: <5655B392.7070701@intel.com> <2099144.E7yRfeyfk4@vostro.rjw.lan> <565DEE62.9080105@xmsnet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, December 01, 2015 08:00:50 PM Hans de Bruin wrote:
> On 11/30/2015 03:11 AM, Rafael J. Wysocki wrote:
> > On Monday, November 30, 2015 09:20:06 AM Jiang Liu wrote:
> >> On 2015/11/28 0:06, Rafael J. Wysocki wrote:
> ...
> >>
> >> And I only refined the commit message based on the test patch
> >> I sent to Authur as an attachment at Nov 25.
> >
> > OK, thanks.
> >
> > Keith, Hans, can you test this version too please?
> >
> 
> This version of the patch works on my laptop too.

Thank you all for verifying!

The patch is in my queue for 4.4-rc4.

Thanks,
Rafael

