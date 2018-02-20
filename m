Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519062520-198902-6-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com> <1519062520-198902-6-git-send-email-john.garry@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:36:59 +0200
Message-ID: <CAHp75VcS7zU=sefmMHHCSeOF14tw=hVysKHR78EazThBkHS-=g@mail.gmail.com>
Subject: Re: [PATCH v14 5/9] OF: Add missing I/O range exception for
 indirect-IO devices
To: John Garry <john.garry@huawei.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Dann Frazier <dann.frazier@canonical.com>,
        Rob Herring <robh@kernel.org>, Joe Perches <joe@perches.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, Corey Minyard <minyard@acm.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 7:48 PM, John Garry <john.garry@huawei.com> wrote:
> From: Zhichang Yuan <yuanzhichang@hisilicon.com>
>
> There are some special ISA/LPC devices that work on a specific I/O range
> where it is not correct to specify a 'ranges' property in DTS parent node
> as cpu addresses translated from DTS node are only for memory space on
> some architectures, such as Arm64. Without the parent 'ranges' property,
> current of_translate_address() return an error.
> Here we add special handlings for this case.
> During the OF address translation, some checkings will be perfromed to
> identify whether the device node is registered as indirect-IO. If yes,
> the I/O translation will be done in a different way from that one of PCI
> MMIO. In this way, the I/O 'reg' property of the special ISA/LPC devices
> will be parsed correctly.

> +               /*
> +                * For indirectIO device which has no ranges property, get
> +                * the address from reg directly.
> +                */
> +               iorange = find_io_range_by_fwnode(&dev->fwnode);
> +               if (iorange && (iorange->flags != PIO_CPU_MMIO)) {
> +                       result = of_read_number(addr + 1, na - 1);
> +                       pr_debug("indirectIO matched(%s) 0x%llx\n",
> +                                       of_node_full_name(dev), result);

%pOF ?

> +                       *host = of_node_get(dev);
> +                       break;
> +               }

> +static u64 of_translate_ioport(struct device_node *dev, const __be32 *in_addr,
> +                       u64 size)
> +{
> +       u64 taddr;
> +       unsigned long port;
> +       struct device_node *host;
> +
> +       taddr = __of_translate_address(dev, in_addr, "ranges", &host);
> +       if (host) {
> +               /* host specific port access */
> +               port = logic_pio_trans_hwaddr(&host->fwnode, taddr, size);
> +               of_node_put(host);
> +       } else {
> +               /* memory mapped I/O range */
> +               port = pci_address_to_pio(taddr);
> +       }
> +
> +       if (port == (unsigned long)-1)
> +               return OF_BAD_ADDR;

~0UL ?

Ah, okay, old code on plate.

> +
> +       return port;
> +}

-- 
With Best Regards,
Andy Shevchenko
