Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Thu, 1 Dec 2016 11:14:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Robert Richter <robert.richter@cavium.com>
Subject: Re: [PATCH V1 1/2] PCI: thunder: Enable ACPI PCI controller for
 ThunderX pass2.x silicon version
Message-ID: <20161201171430.GB30746@bhelgaas-glaptop.roam.corp.google.com>
References: <1479201298-25494-1-git-send-email-tn@semihalf.com>
 <1479201298-25494-2-git-send-email-tn@semihalf.com>
 <20161201002812.GB9409@bhelgaas-glaptop.roam.corp.google.com>
 <eba92ea8-bdab-9a3a-7b18-caaeac15db5d@semihalf.com>
 <20161201135549.GP2213@rric.localdomain>
MIME-Version: 1.0
In-Reply-To: <20161201135549.GP2213@rric.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, gabriele.paoloni@huawei.com, rafael@kernel.org,
 linux-pci@vger.kernel.org, will.deacon@arm.com, andrea.gallo@linaro.org,
 Lorenzo.Pieralisi@arm.com, Tomasz Nowicki <tn@semihalf.com>,
 linaro-acpi@lists.linaro.org, ddaney@caviumnetworks.com,
 linux-acpi@vger.kernel.org, liudongdong3@huawei.com, msalter@redhat.com,
 arnd@arndb.de, jcm@redhat.com, Christopher Covington <cov@codeaurora.org>,
 mw@semihalf.com, linux-arm-kernel@lists.infradead.org, jchandra@broadcom.com,
 ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, jeremy.linton@arm.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:55:49PM +0100, Robert Richter wrote:
> Tomasz, Bjorn,
> 
> On 01.12.16 09:49:51, Tomasz Nowicki wrote:
> > I put the picture together here (on top of your pci/ecam branch):
> > [1] https://github.com/semihalf-nowicki-tomasz/linux/commits/pci-quirks-thunderx-v2
> 
> please note that acpi_* functions must be protected with acpi_disabled
> or something else to make sure an acpi enabled kernel does not break
> dt. See the crash below with above branch.

Yes, thanks!  I added

  if (acpi_disabled)
    return NULL;

to acpi_resource_consumer(), which I think should fix this.

> [   12.493028] Unable to handle kernel NULL pointer dereference at virtual address 00000018
> [   12.501113] pgd = ffff0000090a0000
> [   12.504511] [00000018] *pgd=0000010fffef0003[   12.508602] , *pud=0000010fffef0003
> , *pmd=0000010fffee0003[   12.514093] , *pte=0000000000000000
> [   12.517575]
> [   12.519064] Internal error: Oops: 96000005 [#1] SMP
> [   12.523933] Modules linked in:
> [   12.526987] CPU: 73 PID: 1 Comm: swapper/0 Tainted: G        W       4.9.0-rc6.0.vanilla10-00019-g09abd2b6bbeb #135
> [   12.537409] Hardware name: Cavium ThunderX CRB/To be filled by O.E.M., BIOS 5.11 12/12/2012
> [   12.545748] task: ffff800fe85b8000 task.stack: ffff800ff4288000
> [   12.551674] PC is at acpi_ns_walk_namespace+0x68/0x1d4
> [   12.556803] LR is at acpi_get_devices+0x6c/0x94
> ...
> [   13.124920] [<ffff0000084dc5a0>] acpi_ns_walk_namespace+0x68/0x1d4
> [   13.131090] [<ffff0000084dcadc>] acpi_get_devices+0x6c/0x94
> [   13.136663] [<ffff0000084c0aec>] acpi_resource_consumer+0x34/0x44
> [   13.142752] [<ffff000008496bc0>] pci_ecam_create+0x80/0x228
> [   13.148314] [<ffff000008498e64>] pci_host_common_probe+0x294/0x348
> [   13.154486] [<ffff00000849bf3c>] thunder_ecam_probe+0x2c/0x38
> [   13.160226] [<ffff0000085880b8>] platform_drv_probe+0x60/0xc8
> [   13.165970] [<ffff000008585a04>] driver_probe_device+0x26c/0x420
> [   13.171966] [<ffff000008585cdc>] __driver_attach+0x124/0x128
> [   13.177615] [<ffff000008583238>] bus_for_each_dev+0x70/0xb0
> [   13.183177] [<ffff000008585060>] driver_attach+0x30/0x40
> [   13.188478] [<ffff000008584a98>] bus_add_driver+0x200/0x2b8
> [   13.194041] [<ffff000008586860>] driver_register+0x68/0x100
> [   13.199602] [<ffff000008587fdc>] __platform_driver_register+0x54/0x60
> [   13.206038] [<ffff000008c39b98>] thunder_ecam_driver_init+0x18/0x20
> [   13.212296] [<ffff000008082d94>] do_one_initcall+0x44/0x138
> [   13.217862] [<ffff000008c00d0c>] kernel_init_freeable+0x1ac/0x24c
> [   13.223950] [<ffff0000088605f0>] kernel_init+0x18/0x110
> [   13.229165] [<ffff000008082b30>] ret_from_fork+0x10/0x20
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
