Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 19 May 2015 15:35:48 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lv Zheng <lv.zheng@intel.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>
Subject: Re: [RFC 0/4] Introduce a mechanism to allocate PCI IRQ on demand
In-Reply-To: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1505191535190.4225@nanos>
References: <1430968374-29286-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 7 May 2015, Jiang Liu wrote:

> This patch set introduces a mechanism to allocate PCI IRQ on demand and
> free it when not used anymore by hooking pci_device_probe() and
> pci_device_remove().
> 
> It will be used to track IOAPIC pin usage on x86 so we could support
> IOAPIC hot-removal.

Bjorn, any opinion on this?

Thanks,

	tglx
