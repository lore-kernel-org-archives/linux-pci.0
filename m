Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 2 Apr 2013 15:16:52 -0700
From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
To: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	huang ying <huang.ying.caritas@gmail.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Len Brown <lenb@kernel.org>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup
 notifications
Message-ID: <20130402221652.GB3693@xanatos>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
 <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
 <51548C9E.9090703@fold.natur.cuni.cz>
 <2990024.LMTIBUbM3d@vostro.rjw.lan>
 <51564804.9000700@fold.natur.cuni.cz>
 <CAC=cRTMJH+40oPSM9pFzkb5x6Q42rWR8BPtUOxJn_3WopmOSvQ@mail.gmail.com>
 <515AF312.1010507@fold.natur.cuni.cz>
 <CAErSpo6EAkSniVF7NnDVsR=H_x0dHK=xQNbdKf67WDW=o1D+_Q@mail.gmail.com>
 <515B17D9.6030805@fold.natur.cuni.cz>
 <515B45A6.1020404@fold.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <515B45A6.1020404@fold.natur.cuni.cz>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 02, 2013 at 10:55:02PM +0200, Martin Mokrejs wrote:
> > 2) xHCI dead due to to its suspend - 3.8 series and above
> 
> Not fixed by port_dbg.patch applied over 3.8.5. Interestingly, a NEC-based
> XHCI card *in an express card slot* does not suffer this suspend issue.
> Although it is being put into suspend if a device is unplugged.

Wait, wait, wait.  Time out.  You have *two* xHCI host controllers?  Are
they different vendors?  Are they exhibiting different broken behaviors?
Please state for each host controller exactly the symptoms you are
seeing (no dmesg or other log files yet, just one paragraph for each
host).

Sarah Sharp
