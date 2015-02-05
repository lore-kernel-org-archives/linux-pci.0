Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [Patch v4 00/23] Improve ACPI resource parsing interfaces and enable IOAPIC hotplug
Date: Thu, 05 Feb 2015 16:16:44 +0100
Message-ID: <2064980.4nxN3J5VNl@vostro.rjw.lan>
In-Reply-To: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, February 05, 2015 01:44:26 PM Jiang Liu wrote:
> During enabling ACPI based IOAPIC hotplug, Thomas noticed some issues
> in ACPI resource parsing interfaces. So this is an effort to improve them.
> 
> Patch 1 refines ACPICA resource descriptors, which has already been
> merged into "git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge"
> 
> Patch 2-12 improve ACPI resource parsing interfaces and also fixes some
> bugs.
> 
> Patch 13-20 try to share the common data structure resource_list_entry
> between PCI and ACPI. It may also be shared with PNP too.
> 
> Patch 21-23 enable ACPI based IOAPIC hotplug.
> 
> The patchset is based on v3.19-rc6+ and passed Fengguang's 0day test
> suite. You may get it from:
> https://github.com/jiangliu/linux.git acpires_v2
> 
> V3->V4:
> 1) rename resource_list_entry as resource_entry to avoid conflicts
> 2) kill pcibios_disable_device()
> 3) Patch 1-16 are the same with v3

OK, I've applied patches [17-23/23] on top of the previous [1-16/23], thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
