Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Wed, 30 Apr 2014 08:41:43 +0200
From: Robert Richter <rric@kernel.org>
To: Myron Stowe <myron.stowe@redhat.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	suravee.suthikulpanit@amd.com, aravind.gopalakrishnan@amd.com,
	kim.naru@amd.com, daniel@numascale.com, tglx@linutronix.de,
	mingo@redhat.com, hpa@zytor.com, x86@kernel.org, bp@suse.de,
	sp@numascale.com, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] x86/PCI: Support additional MMIO range
 capabilities
Message-ID: <20140430064143.GM32718@rric.localhost>
References: <20140419025308.2408.51252.stgit@amt.stowe>
 <20140419025323.2408.88764.stgit@amt.stowe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140419025323.2408.88764.stgit@amt.stowe>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 18.04.14 20:53:23, Myron Stowe wrote:
> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

> -		start = reg & 0xffffff00; /* 39:16 on 31:8*/
> -		start <<= 8;
> -		reg = read_pci_config(bus, slot, 1, 0x84 + (i << 3));
> +		start = (reg & 0xffffff00UL) << 8;	/* 39:16 on 31:8 */

I think this is not save anymore with respect to u32/u64 casting. The
original was.

-Robert
