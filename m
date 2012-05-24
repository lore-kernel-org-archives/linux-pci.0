Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 24 May 2012 21:45:38 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	Len Brown <lenb@kernel.org>, Wei Kong <wkong@novell.com>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH] PCI / ACPI: Do not request control of ASPM if the BIOS
 has disabled it
Message-ID: <20120524204538.GA27819@srcf.ucam.org>
References: <201205242245.45888.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201205242245.45888.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 24, 2012 at 10:45:45PM +0200, Rafael J. Wysocki wrote:

> However, knowing that the BIOS doesn't support ASPM, we shouldn't
> request the control of it, so we should remove
> (OSC_ACTIVE_STATE_PWR_SUPPORT | OSC_CLOCK_PWR_CAPABILITY_SUPPORT)
> from the flags before calling acpi_pci_osc_control_set() in those
> cases.  Failing to do so causes the evaluation of _OSC for the PCI
> root bridge to return error codes on some systems where it should
> work correctly.

Is there an example of an affected machine's DSDT?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
