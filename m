Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 28 Jan 2015 13:46:39 +0000
From: Will Deacon <will.deacon@arm.com>
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Russell King <linux@arm.linux.org.uk>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Michal Simek <michal.simek@xilinx.com>,
	=?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Srikanth Thokala <sthokal@xilinx.com>,
	Tony Luck <tony.luck@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Russell King <rmk+kernel@arm.linux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v2 18/22] PCI: Use common resource list management code
 instead of private implementation
Message-ID: <20150128134639.GN1569@arm.com>
References: <1422442660-455-1-git-send-email-jiang.liu@linux.intel.com>
 <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422442660-455-19-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 28, 2015 at 10:57:36AM +0000, Jiang Liu wrote:
> Use common resource list management data structure and interfaces
> instead of private implementation.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  arch/arm/kernel/bios32.c            |    5 ++---
>  arch/x86/pci/bus_numa.c             |    4 ++--
>  drivers/pci/bus.c                   |   18 ++++++------------
>  drivers/pci/host-bridge.c           |    8 ++++----
>  drivers/pci/host/pci-host-generic.c |    4 ++--
>  drivers/pci/host/pci-xgene.c        |    4 ++--
>  drivers/pci/host/pcie-xilinx.c      |    4 ++--
>  drivers/pci/probe.c                 |   10 +++++-----
>  include/linux/pci.h                 |    9 ++-------
>  9 files changed, 27 insertions(+), 39 deletions(-)

The arch/arm/ and drivers/pci/host/pci-host-generic.c bits look fine to
me:

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
