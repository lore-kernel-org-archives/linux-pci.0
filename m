Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1434106314.30003.199.camel@citrix.com>
Subject: Re: [PATCH 1/1] PCI: X-Gene: Disable Configuration Request Retry
 Status for X-Gene v1 PCIe
From: Ian Campbell <ian.campbell@citrix.com>
To: Duc Dang <dhdang@apm.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>,
	Marcin Juszkiewicz <mjuszkiewicz@redhat.com>,
	Tanmay Inamdar <tinamdar@apm.com>, <patches@apm.com>
Date: Fri, 12 Jun 2015 11:51:54 +0100
In-Reply-To: <1434053294-10962-1-git-send-email-dhdang@apm.com>
References: <1434053294-10962-1-git-send-email-dhdang@apm.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-06-11 at 13:08 -0700, Duc Dang wrote:
> X-Gene v1 PCIe controller has a bug in Configuration Request Retry
> Status (CRS) logic:
>   When CPU tries to read Vendor ID and Device ID of not-existed
>   remote device, the controller returns 0xFFFF0001 instead of
>   0xFFFFFFFF; this will add significant delay in boot time as
>   pci_bus_read_dev_vendor_id will wait for 60 seconds before
>   giving up.
> 
> So for X-Gene v1 PCIe controllers, disable CRS capability
> advertisement by clearing CRS Software Visibility bit before
> returning the Root Capability value to the callers. This is done
> by implementing X-Gene PCIe specific xgene_pcie_config_read32 for
> CFG read accesses to replace the generic default pci_generic_config_read32
> function.
> 
> Signed-off-by: Duc Dang <dhdang@apm.com>

Applied onto v4.1-rc7 and:
Tested-by: Ian Campbell <ian.campbell@citrix.com>

Thanks!


