Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Mon, 3 Nov 2014 10:41:09 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
	x86@kernel.org, Grant Likely <grant.likely@linaro.org>,
	Prarit Bhargava <prarit@redhat.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tony Luck <tony.luck@intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	linux-pm@vger.kernel.org
Subject: Re: [Patch v8 15/18] x86, irq, ACPI: Implement interface to support
 ACPI based IOAPIC hot-addition
In-Reply-To: <1414908273-7552-16-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1411031039470.5308@nanos>
References: <1414908273-7552-1-git-send-email-jiang.liu@linux.intel.com> <1414908273-7552-16-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, 2 Nov 2014, Jiang Liu wrote:
> +	down_write(&acpi_ioapic_rwsem);

That wants to be acpi_ioapic_lock. Same issue in the following
patches. You fixed it up in the last patch.

Please don't resend. I folded the hunks back to the proper places
already.

Thanks,

	tglx


