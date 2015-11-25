Return-Path: <linux-acpi-owner@vger.kernel.org>
Subject: Re: [Bugfix] x86/PCI: Fix regression caused by commit 4d6b4e69a245
To: Keith Busch <keith.busch@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
References: <1447648057-13644-1-git-send-email-jiang.liu@linux.intel.com>
 <20151124164907.GA24819@localhost>
 <CAJZ5v0irOUq6C9eSfCfmzyOiY1n1rUSxyUeUbvS9Nj0jNT2JrQ@mail.gmail.com>
 <20151124230413.GA11608@localhost.localdomain>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
	x86@kernel.org
From: Arthur Marsh <arthur.marsh@internode.on.net>
Message-ID: <5655019C.7070700@internode.on.net>
Date: Wed, 25 Nov 2015 11:02:28 +1030
MIME-Version: 1.0
In-Reply-To: <20151124230413.GA11608@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Keith Busch wrote on 25/11/15 09:34:
> On Tue, Nov 24, 2015 at 11:19:34PM +0100, Rafael J. Wysocki wrote:
>> Quite frankly, I'm more likely to revert the offending commit at this
>> point as that's not the only regression reported against it and the
>> fix only helps in one case (out of three known to me).
>
> Using 4.4-rc1 and can confirm the patch fixes my regression report. The
> revert also fixes it, so either way is good for me!
>

To re-cap, all was fine for me until:

4d6b4e69a245e9df4b84dba387596086cb66887d is the first bad commit
commit 4d6b4e69a245e9df4b84dba387596086cb66887d
Author: Jiang Liu <jiang.liu@linux.intel.com>
Date:   Wed Oct 14 14:29:41 2015 +0800

      x86/PCI/ACPI: Use common interface to support PCI host bridge

      Use common interface to simplify ACPI PCI host bridge implementation.

      Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
      Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>
      Acked-by: Bjorn Helgaas <bhelgaas@google.com>
      Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 a3447eea376b5a3e6f57deb35cf064c5481b45e3 
f64d8e49fd87b776933dfa3dfefcb33509004d3f M      arch

 From the boot-up I get the message as shown in the images at: 
http://www.users.on.net/~arthur.marsh/20151107601.jpg and
http://www.users.on.net/~arthur.marsh/20151107602.jpg

The boot-up suggests trying rebooting with pci=alloc but that didn't help.

The errors shown include
"BAR 0: trying firmware assignment [io  size 0x0020]"
"BAR 0: [io  size 0x0020] conflicts with PCI Bus #00 [io  0x0000-0xffff]
"BAR 0: failed to assign [io  size 0x0020]

Applying the following patch on top of the patch above from 14 October 
2015 worked for me:


 From 02818ba34bfa76d93f2a29c85660da0323b0b457 Mon Sep 17 00:00:00 2001
From: Liu Jiang <jiang.liu@linux.intel.com>
Date: Mon, 9 Nov 2015 13:36:48 +0800
Subject: [PATCH]


Signed-off-by: Liu Jiang <jiang.liu@linux.intel.com>
---
  arch/x86/pci/bus_numa.c |    3 +++
  1 file changed, 3 insertions(+)

diff --git a/arch/x86/pci/bus_numa.c b/arch/x86/pci/bus_numa.c
index 7bcf06a7cd12..022d83158cdb 100644
--- a/arch/x86/pci/bus_numa.c
+++ b/arch/x86/pci/bus_numa.c
@@ -51,6 +51,8 @@ void x86_pci_root_bus_resources(int bus, struct 
list_head *resources)
          pci_add_resource(resources, &info->busn);

      list_for_each_entry(root_res, &info->resources, list) {
+        pci_add_resource(resources, &root_res->res);
+#if 0
          struct resource *res;
          struct resource *root;

@@ -61,6 +63,7 @@ void x86_pci_root_bus_resources(int bus, struct 
list_head *resources)
          else
              root = &iomem_resource;
          insert_resource(root, res);
+#endif
      }
      return;

###

The patch postd by Jian Liu on 16 November 2015 "[Bugfix] x86/PCI: Fix 
regression caused by commit 4d6b4e69a245" had *not* been seen or tested 
by me before being posted to the linux-acpi list and when I did test it 
(after removing the patch above from 9 November 2015), things broke:
http://www.users.on.net/~arthur.marsh/20151116611.jpg

So if "commit 4d6b4e69a245e9df4b84dba387596086cb66887d
x86/PCI/ACPI: Use common interface to support PCI host bridge" stays, 
then the patch "16 November 2015 [Bugfix] x86/PCI: Fix regression caused 
by commit 4d6b4e69a245" would need to go and the patch above from 9 
November 2015 would need to be accepted into the mainline for my machine 
to boot from the mainline code.

Arthur.
