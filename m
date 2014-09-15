Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:49694 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753971AbaIOKEo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 15 Sep 2014 06:04:44 -0400
Received: by mail-ig0-f179.google.com with SMTP id r10so3632828igi.0
        for <linux-pci@vger.kernel.org>; Mon, 15 Sep 2014 03:04:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140915095305.GA7669@richard>
References: <20140913031818.GA25656@google.com> <1410732627-25445-1-git-send-email-andreas.noever@gmail.com>
 <20140915095305.GA7669@richard>
From: Andreas Noever <andreas.noever@gmail.com>
Date: Mon, 15 Sep 2014 12:04:22 +0200
Message-ID: <CAMxnaaXuHHe--wtBAFNwuFngz5pfXVXkGpoOBxm_D3rQkD+TYQ@mail.gmail.com>
Subject: Re: [PATCH] Add pci=assign-busses quirk to Dell Latitude D505
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Henningsson <david.henningsson@canonical.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Richter <thor@math.tu-berlin.de>,
	gwshan@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 15, 2014 at 11:53 AM, Wei Yang <weiyang@linux.vnet.ibm.com> wrote:
> On Mon, Sep 15, 2014 at 12:10:27AM +0200, Andreas Noever wrote:
>>[+cc Thomas, your regression has probably the same cause]
>>
>>This looks a like it is going to be a little more complicated than anticipated.
>>
>>pci_scan_bus has two main branches. One for "broken" hardware and cardbus and
>>another one for bridges whose configuration looks sane.
>>
>>David's working 3.2 Kernel does the following:
>>pci 0000:00:1e.0: PCI bridge to [bus 01-01] (subtractive decode)
>>pci 0000:01:01.0: bridge configuration invalid ([bus 00-00]), reconfiguring
>>
>>The 00:1e bridge is deemed sane and the 01:01 (cardbus) bridge below it is
>>deemed broken. pci_scan_bridge than assigns bus [2-5] to 01:01 without touching
>>1e (so we just got 4 imaginary busses). We just print a warning:
>>pci_bus 0000:02: [bus 02-05] partially hidden behind transparent bridge 0000:01 [bus 01-01]
>>
>>After returning to 00:1e (in the sane branch) we also do not update our
>>subordinate and just return. Later yenta_socket sees that this is nuts and
>>carefully increases the subordinate of 00:1e.
>>
>>My patch series for 3.15 was trying to make sure that pci_scan_bus does not
>>overstep its resources. So now we now refuse to create bus 2 under [01-01]
>>(fc1b2531 PCI: Don't scan random busses in pci_scan_bridge()) and a little
>>later we would forbid the cardbus code in pci_scan_bridge from reserving 4 more
>>busses (1820ffdc PCI: Make sure bus number resources stay within their parents
>>bounds). At least these two would need to be reverted.
>>
>>As an alternative the following patch tries grow the bus window, if necessary
>>by growing its parents bus window (recursively). This should make the yenta
>>fixup unnecessary. I have tested the patch with normal pci bridges + setpci,
>>since I don't have access to a cardbus system.
>>
>>So if you have time please test this and/or try to revert the two mentioned
>>commits.
>>
>>Thanks,
>>Andreas
>>---
>> drivers/pci/probe.c | 45 ++++++++++++++++++++++++++++++++++++---------
>> 1 file changed, 36 insertions(+), 9 deletions(-)
>>
>>diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>>index e3cf8a2..81dd668 100644
>>--- a/drivers/pci/probe.c
>>+++ b/drivers/pci/probe.c
>>@@ -740,6 +740,30 @@ struct pci_bus *pci_add_new_bus(struct pci_bus *parent, struct pci_dev *dev,
>> }
>> EXPORT_SYMBOL(pci_add_new_bus);
>>
>>+int pci_grow_bus(struct pci_bus *bus, int bus_max)
>>+{
>>+      struct resource *res = &bus->busn_res;
>>+      struct resource old_res = *res;
>>+      int ret;
>>+      if (res->end >= bus_max)
>>+              return 0;
>>+      if (!bus->self || pci_is_root_bus(bus)) {
>>+              dev_printk(KERN_DEBUG, &bus->dev,
>>+                         "root busn_res %pR cannot grow\n", &res);
>>+              return -EBUSY;
>>+      }
>>+      ret = pci_grow_bus(bus->parent, bus_max);
>>+      if (ret)
>>+              return ret;
>>+      ret = adjust_resource(res, res->start, bus_max - res->start + 1);
>>+      dev_printk(KERN_DEBUG, &bus->dev,
>>+                      "busn_res: %pR end %s grown to %02x\n",
>>+                      &old_res, ret ? "cannot be" : "has", bus_max);
>>+
>
> If adjust_resource fails, I think we can't write the bus_max into the bridge
> register.
Right, there is an if statement missing. Thanks.

>>+      pci_write_config_byte(bus->self, PCI_SUBORDINATE_BUS, bus_max);
>>+      return ret;
>>+}
>>+
>> /*
>>  * If it's a bridge, configure it and scan the bus behind it.
>>  * For CardBus bridges, we don't scan behind as the devices will
>>@@ -814,12 +838,11 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>>               }
>>
>>               cmax = pci_scan_child_bus(child);
>>-              if (cmax > subordinate)
>>-                      dev_warn(&dev->dev, "bridge has subordinate %02x but max busn %02x\n",
>>-                               subordinate, cmax);
>>-              /* subordinate should equal child->busn_res.end */
>>-              if (subordinate > max)
>>-                      max = subordinate;
>>+              if (cmax > child->busn_res.end)
>>+                      dev_warn(&dev->dev, "bridge has bus resource %pR but max busn %02x\n",
>>+                               &child->busn_res, cmax);
>>+              if (child->busn_res.end > max)
>>+                      max = child->busn_res.end;
>
> By a quick look, I don't see some place change the busn_res.end. And in the
> pci_bus_insert_busn_res(), the child->busn_res.end is set to subordinate. So I
> don't see the reason you change it.
adjust_resource in pci_grow_bus changes busn_res.end. The value in
'subordinate' is then stale at this point.

>
> Do I miss something?
>
>>       } else {
>>               /*
>>                * We need to assign a number to this bus which we always
>>@@ -840,8 +863,10 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>>
>>               if (max >= bus->busn_res.end) {
>>                       dev_warn(&dev->dev, "can't allocate child bus %02x from %pR\n",
>>-                               max, &bus->busn_res);
>>-                      goto out;
>>+                               max + 1, &bus->busn_res);
>>+                      /* Try to resize bus */
>>+                      if (pci_grow_bus(bus, max + 1))
>>+                              goto out;
>
> On some platforms, like powerpc, we have some limitations of the bus number a
> bridge could have. Sometimes, we need the start bus number to be power 2
> aligned.
>
> Hmm... hope I don't make a mistake, add Gavin in CC list. Gavin, is my
> understanding correct?
Hm I have not seen any code that would enforce this. Is it possible to
do pci=assign-busses on PowerPC?

>>               }
>>
>>               /* Clear errors */
>>@@ -908,6 +933,7 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>>                                       break;
>>                               }
>>                       }
>>+                      dev_info(&dev->dev, "adding %02x bus numbers for cardbus\n", i);
>>                       max += i;
>>               }
>>               /*
>>@@ -916,7 +942,8 @@ int pci_scan_bridge(struct pci_bus *bus, struct pci_dev *dev, int max, int pass)
>>               if (max > bus->busn_res.end) {
>>                       dev_warn(&dev->dev, "max busn %02x is outside %pR\n",
>>                                max, &bus->busn_res);
>>-                      max = bus->busn_res.end;
>>+                      if (pci_grow_bus(bus, max))
>>+                              max = bus->busn_res.end;
>>               }
>>               pci_bus_update_busn_res_end(child, max);
>>               pci_write_config_byte(dev, PCI_SUBORDINATE_BUS, max);
>>--
>>2.1.0
>>
>>--
>>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> Richard Yang
> Help you, Help me
>
