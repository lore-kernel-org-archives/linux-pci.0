Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Tue, 30 Jan 2018 09:11:27 -0600
From: Rob Herring <robh@kernel.org>
To: John Garry <john.garry@huawei.com>
Cc: mika.westerberg@linux.intel.com, rafael@kernel.org,
        lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, bhelgaas@google.com,
        arnd@arndb.de, mark.rutland@arm.com, olof@lixom.net,
        hanjun.guo@linaro.org, dann.frazier@canonical.com,
        benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, minyard@acm.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
        rdunlap@infradead.org,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>
Subject: Re: [PATCH v12 3/9] PCI: Add fwnode handler as input param of
 pci_register_io_range()
Message-ID: <20180130151127.tqklt7o6zrv3ddqq@rob-hp-laptop>
References: <1516725385-24535-1-git-send-email-john.garry@huawei.com>
 <1516725385-24535-4-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1516725385-24535-4-git-send-email-john.garry@huawei.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 24, 2018 at 12:36:19AM +0800, John Garry wrote:
> From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> 
> In preparation for having the PCI MMIO helpers to use the new generic
> I/O space management(LOGIC_PIO) we need to add the fwnode handler as
> extra input parameter.
> This patch changes the signature of pci_register_io_range() and of
> its callers as needed.
> 
> Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/acpi/pci_root.c | 8 +++++---
>  drivers/of/address.c    | 4 +++-
>  drivers/pci/pci.c       | 3 ++-
>  include/linux/pci.h     | 3 ++-
>  4 files changed, 12 insertions(+), 6 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
