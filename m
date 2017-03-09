Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
MIME-Version: 1.0
In-Reply-To: <1489046254-19919-9-git-send-email-kishon@ti.com>
References: <1489046254-19919-1-git-send-email-kishon@ti.com>
 <1489046254-19919-9-git-send-email-kishon@ti.com>
From: Rami Rosen <roszenrami@gmail.com>
Date: Thu, 9 Mar 2017 23:59:18 +0200
Message-ID: <CAKoUArkTXbMvfTmNjA_VGWodbP5JxVNBP1DNUTYND2LvUfKsJQ@mail.gmail.com>
Subject: Re: [PATCH v3 08/23] Documentation: PCI: Add binding documentation
 for pci-test endpoint function
To: Kishon Vijay Abraham I <kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao Pinto <Joao.Pinto@synopsys.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-pci@vger.kernel.org,
 nsekhar@ti.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 hch@infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

Hi,
Minor comment: typo, should be: don't care:

> +revid           : dont't care
> +progif_code     : don't care
> +subclass_code   : don't care
> +baseclass_code  : should be 0xff
> +cache_line_size         : don't care
> +subsys_vendor_id : don't care
> +subsys_id       : don't care
> +interrupt_pin   : Should be 1 - INTA, 2 - INTB, 3 - INTC, 4 -INTD
> +msi_interrupts  : Should be 1 to 32 depending on the number of msi

Regards,
Rami Rosen

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
