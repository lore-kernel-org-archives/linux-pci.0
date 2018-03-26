Return-Path: <SRS0=HzDk=GQ=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=HzDk=GQ=linux.intel.com=mika.westerberg@kernel.org>
Date: Mon, 26 Mar 2018 14:26:47 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Wolfgang Denk <wd@denx.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: PCIe x4 cards not detected on Z370 mainboards
Message-ID: <20180326112647.GC2703@lahna.fi.intel.com>
References: <20180322184840.E31D4247251@gemini.denx.de>
 <20180322192759.GA252023@bhelgaas-glaptop.roam.corp.google.com>
 <20180323084855.E3EAF247251@gemini.denx.de>
 <20180324044716.GF210003@bhelgaas-glaptop.roam.corp.google.com>
 <20180325122828.7FC55247245@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180325122828.7FC55247245@gemini.denx.de>
List-ID: <linux-pci.vger.kernel.org>

On Sun, Mar 25, 2018 at 02:28:28PM +0200, Wolfgang Denk wrote:
> Dear Bjorn,
> 
> maybe it helps to provide some more information.  I can reproduce the
> same problem on 3 different mainboards from 2 different vendors:
> 
> - Gigabyte AB350 Gaming CF
> - Gigabyte Z270X Ultra Gaming CF
> - MSI Z370 Tomahawk
>
> 
> I now have all 3 systems ready at hands to run additional tests if
> needed.
> 
> I have updated the information (lspci output, dmesg output) for all
> three boards here:
> 
> https://owncloud.denx.de/index.php/s/wXiCMMYJodGj5Kr
> 

Looking at the MSI Tomahawk dmesg when you have the adaptec card
connected, the BIOS adds an additional ACPI SSDT table:

[    0.000000] ACPI: SSDT 0x000000008C039120 002611 (v02 PegSsd PegSsdt 00001000 INTL 20160422)

This is missing when LSI card is connected. There might be some sort of
preboot protocol or whitelist that prevents the root port to be enabled
in BIOS.

Wolfgang, could you also add acpidump output of these systems to that
share site?
