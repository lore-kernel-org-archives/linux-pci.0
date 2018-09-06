Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 6 Sep 2018 18:04:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        "D . J . Bernstein" <djb@cr.yp.to>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH 04/10] PCI: pciehp: Do not handle events if interrupts
 are masked
Message-ID: <20180906160435.ebqmjd4iejlrznqw@wunner.de>
References: <20180906155020.51700-1-mika.westerberg@linux.intel.com>
 <20180906155020.51700-5-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180906155020.51700-5-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 06, 2018 at 06:50:14PM +0300, Mika Westerberg wrote:
> PCIe native hotplug shares MSI vector with native PME so the interrupt
> handler might get called even the hotplug interrupt is masked. In that
> case we should not handle any events because the interrupt was not meant
> for us. Modify the PCIe hotplug interrupt handler to check this
> accordingly and bail out if it finds out that the interrupt was not
> about hotplug.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>
