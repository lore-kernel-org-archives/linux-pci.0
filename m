Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 26 Feb 2018 12:22:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Rolf Evers-Fischer <embedded24@evers-fischer.de>
Cc: kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andy.shevchenko@gmail.com
Subject: Re: [PATCH v2 0/2] pci: endpoint: Fix double free in pci_epf_create()
Message-ID: <20180226182259.GD25159@bhelgaas-glaptop.roam.corp.google.com>
References: <20180226171617.10016-1-embedded24@evers-fischer.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180226171617.10016-1-embedded24@evers-fischer.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 26, 2018 at 06:16:15PM +0100, Rolf Evers-Fischer wrote:
> This is version 2 of a patchset to avoid double free in function
> 'pci_epf_create()'.
> 
> When I accidentally created a new endpoint device with an empty name,
> the kernel warned about "attempted to be registered with empty name!"
> and crashed afterwards.
> 
> It turned out that the crash was not caused by the 'device_add()'
> function itself, but by a double kfree of 'epf->name' and 'epf'.
> 
> The first patch just simplifies the code, while the second patch
> fixes the problem.
> 
> Changes in v2:
> - Based on feedback from Lorenzo, Andy and Kishon (thanks!)
> - Change IDs removed
> - First patch completely reworked in order to eliminate the
>   need for the second 'kstrdup' allocation and the 'kfree' of
>   the first allocation.
>   It was tested with name="pci_epf_test.0" and name="pci_epb":
>   The 'epf->name' was "pci_epf_test" or "pci_epb" (=unchanged).
> 
> Rolf Evers-Fischer (2):
>   pci: endpoint: Simplify name allocation for epf device
>   pci: endpoint: Fix kernel panic after put_device()

$ git log --oneline --no-merges drivers/pci/endpoint/
fc41df28f89e PCI: endpoint: Fix EPF device name to support multi-function devices
4494738de0d9 PCI: endpoint: Add the function number as argument to EPC ops
b330104fa76d PCI: endpoint: Use EPC's device in dma_alloc_coherent()/dma_free_coherent()
35ad61921f49 PCI: endpoint: Fix find_first_zero_bit() usage
0c47cd7a9b6c PCI: endpoint: Populate func_no before calling pci_epc_add_epf()
...

Please make yours match.
