Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1519062520-198902-9-git-send-email-john.garry@huawei.com>
References: <1519062520-198902-1-git-send-email-john.garry@huawei.com> <1519062520-198902-9-git-send-email-john.garry@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 20 Feb 2018 16:52:46 +0200
Message-ID: <CAHp75Vdy53cNq0qveM6MPVaukxZ856jCex7EnRKZudwaidJ3_Q@mail.gmail.com>
Subject: Re: [PATCH v14 8/9] HISI LPC: Add ACPI support
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
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 19, 2018 at 7:48 PM, John Garry <john.garry@huawei.com> wrote:
> Based on the previous patches, this patch supports the
> LPC host on hip06/hip07 for ACPI FW.
>
> It is the responsibility of the LPC host driver to
> enumerate the child devices, as the ACPI scan code will
> not enumerate children of "indirect IO" hosts.

>         if (!acpi_device)
>                 ret = of_platform_populate(dev->of_node, NULL, NULL, dev);
> +       else
> +               ret = hisi_lpc_acpi_probe(dev);
>         if (ret) {
>                 dev_err(dev, "populate children failed (%d)\n", ret);
>                 return ret;

Ah, please, ignore one comment to previous patch.

-- 
With Best Regards,
Andy Shevchenko
