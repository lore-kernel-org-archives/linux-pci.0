Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <20170621104538.GA8477@red-moon>
References: <20170608141342.2018-1-lorenzo.pieralisi@arm.com>
 <CACRpkdZ1rBq9eLJkz_gRuXAG=if+xXf-jPzDEPCfG8EgUmUG3A@mail.gmail.com>
 <20170621103042.GA1712@red-moon> <20170621104538.GA8477@red-moon>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Jun 2017 17:14:13 +0200
Message-ID: <CACRpkda_6=qWRQDpTy67MFc=-fYRhqWDPx0NnNG5mjXQLyAAkw@mail.gmail.com>
Subject: Re: [RFT PATCH v2 00/42] PCI: ARM/ARM64: remove pci_fixup_irqs() usage
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Gabriele Paoloni <gabriele.paoloni@huawei.com>,
 linux-pci <linux-pci@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Will Deacon <will.deacon@arm.com>, Michal Simek <michal.simek@xilinx.com>,
 Thierry Reding <thierry.reding@gmail.com>, Tanmay Inamdar <tinamdar@apm.com>,
 Matthew Minter <matt@masarand.com>, Rob Herring <robh@kernel.org>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Pratyush Anand <pratyush.anand@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Murali Karicheri <m-karicheri2@ti.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>,
 Mingkai Hu <mingkai.hu@freescale.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Jingoo Han <jingoohan1@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>,
 Minghuan Lian <minghuan.Lian@freescale.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, Roy Zang <tie-fei.zang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 21, 2017 at 12:45 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:

> Sorry I miss yet another usage of struct pci_bus before bus is
> scanned in faraday_pci_parse_map_dma_ranges(), all these config
> accessors want is to access bus number 0 and writei/read some config
> values in there, please confirm.
>
> Updated patch here:

I fixed it. This was needed:
diff --git a/drivers/pci/host/pci-ftpci100.c b/drivers/pci/host/pci-ftpci100.c
index 86f8a3d1c1da..5162dffc102b 100644
--- a/drivers/pci/host/pci-ftpci100.c
+++ b/drivers/pci/host/pci-ftpci100.c
@@ -450,6 +450,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
     struct resource *io;
     struct pci_host_bridge *host;
     struct clk *clk;
+    unsigned char max_bus_speed = PCI_SPEED_33MHz;
+    unsigned char cur_bus_speed = PCI_SPEED_33MHz;
     int ret;
     u32 val;
     LIST_HEAD(res);
@@ -553,27 +555,27 @@ static int faraday_pci_probe(struct platform_device *pdev)
         unsigned long rate;
         u32 val;

-        faraday_pci_read_config(p->bus, 0,
-                    FARADAY_PCI_STATUS_CMD, 4, &val);
+        faraday_raw_pci_read_config(p, 0, 0,
+                        FARADAY_PCI_STATUS_CMD, 4, &val);
         rate = clk_get_rate(p->bus_clk);

         if ((rate == 33000000) && (val & PCI_STATUS_66MHZ_CAPABLE)) {
             dev_info(dev, "33MHz bus is 66MHz capable\n");
-            p->bus->max_bus_speed = PCI_SPEED_66MHz;
+            max_bus_speed = PCI_SPEED_66MHz;
             ret = clk_set_rate(p->bus_clk, 66000000);
             if (ret)
                 dev_err(dev, "failed to set bus clock\n");
         } else {
             dev_info(dev, "33MHz only bus\n");
-            p->bus->max_bus_speed = PCI_SPEED_33MHz;
+            max_bus_speed = PCI_SPEED_33MHz;
         }

         /* Bumping the clock may fail so read back the rate */
         rate = clk_get_rate(p->bus_clk);
         if (rate == 33000000)
-            p->bus->cur_bus_speed = PCI_SPEED_33MHz;
+            cur_bus_speed = PCI_SPEED_33MHz;
         if (rate == 66000000)
-            p->bus->cur_bus_speed = PCI_SPEED_66MHz;
+            cur_bus_speed = PCI_SPEED_66MHz;
     }

     ret = faraday_pci_parse_map_dma_ranges(p, dev->of_node);
@@ -587,6 +589,8 @@ static int faraday_pci_probe(struct platform_device *pdev)
         return ret;
     }
     p->bus = host->bus;
+    p->bus->max_bus_speed = max_bus_speed;
+    p->bus->cur_bus_speed = cur_bus_speed;

     pci_bus_assign_resources(p->bus);
     pci_bus_add_devices(p->bus);


I'll send a modified and tested version of your patch.

Yours,
Linus Walleij

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
