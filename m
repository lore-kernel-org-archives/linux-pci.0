Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <53081614.4020503@linux.intel.com>
References: <1388707565-16535-1-git-send-email-yinghai@kernel.org>
	<1388707565-16535-11-git-send-email-yinghai@kernel.org>
	<53070393.5020005@linux.intel.com>
	<CAE9FiQV8B271XCJQV=80S6pZDOVxG9LG0gaj9G98dCRetjkMUg@mail.gmail.com>
	<53081614.4020503@linux.intel.com>
Date: Fri, 21 Feb 2014 23:44:40 -0800
Message-ID: <CAE9FiQXnMgG=mOmcSK9ZwKR6tFAkJX2dVnGTj9Mmg3daDhPmEA@mail.gmail.com>
Subject: Re: [PATCH v5 10/33] iommu, irq: Allocate irq_desc for dmar_msi with
 local node
From: Yinghai Lu <yinghai@kernel.org>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
	"H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Donald Dutile <ddutile@redhat.com>,
	Sebastian Andrzej Siewior <sebastian@breakpoint.cc>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 21, 2014 at 7:14 PM, Jiang Liu <jiang.liu@linux.intel.com> wrote:

>         Seems there is no such protection on IA64 side. I feel create_irq_nr()
> returns 0 for error is a little risky, 0 may be
> a valid IRQ number on other platforms(no sure about this).
> Thanks!

in [PATCH] ia64, irq: Add dummy create_irq_nr()

+unsigned int create_irq_nr(unsigned int from, int node)
+{
+       int irq = create_irq();
+
+       if (irq < 0)
+               irq = 0;
+
+       return irq;
+}
+

so that from is ignored.

create_irq_nr() is only with x86 and ia64.

Thanks

Yinghai
