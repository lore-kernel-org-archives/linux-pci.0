Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: [PATCH v3 0/3] PM / sleep: Make it possible to check if suspend/resume goes via firmware
Date: Wed, 07 Oct 2015 00:48:33 +0200
Message-ID: <2723857.EVg1dAvTli@vostro.rjw.lan>
In-Reply-To: <5472042.4c1h9diL7E@vostro.rjw.lan>
References: <10641052.oOBhM6BU9G@vostro.rjw.lan> <5472042.4c1h9diL7E@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, October 02, 2015 03:50:42 AM Rafael J. Wysocki wrote:
> On Wednesday, September 30, 2015 02:46:10 AM Rafael J. Wysocki wrote:
> > Hi All,
> > 
> > Patch [1/2] introduces a new mechanism that can be used to check whether or not
> > platform firmware is going to be involved in system suspend or was involved
> > in system resume.
> 
> That's still the case, but patch [2/2] modifies the PCI PM layer and the general
> ACPI PM domain only to use the mechanism added by the [1/2].

The first two patches are unchanged (in the face of the continuing lack of
comments I'll add them to my v4.4 queue at one point).

The last patch is new and actually is an RFC, but it shows how the new
mechanism introduced by [1/3] can be used.

Thanks,
Rafael

