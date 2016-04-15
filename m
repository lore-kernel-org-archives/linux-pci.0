Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
References: <1460654743-7896-1-git-send-email-lorenzo.pieralisi@arm.com>
	<1460654743-7896-10-git-send-email-lorenzo.pieralisi@arm.com>
Date: Fri, 15 Apr 2016 13:29:14 -0500
Message-ID: <CAOZdJXXtZq6uyE+5sseX7M_6Kq8wFG+37qd5TNSusKj=0gd8zA@mail.gmail.com>
Subject: Re: [RFC PATCH 09/11] drivers: acpi: implement acpi_dma_configure
From: Timur Tabi <timur@codeaurora.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: iommu@lists.linux-foundation.org,
	Marc Zyngier <marc.zyngier@arm.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Will Deacon <will.deacon@arm.com>,
	Sinan Kaya <okaya@codeaurora.org>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>,
	Jon Masters <jcm@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, vikrams@codeaurora.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 14, 2016 at 12:25 PM, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
> +void acpi_dma_configure(struct device *dev, enum dev_dma_attr attr)
> +{
> +       struct iommu_ops *iommu;
> +
> +       iommu = iort_iommu_configure(dev);
> +
> +       /*
> +        * Assume dma valid range starts at 0 and covers the whole
> +        * coherent_dma_mask.
> +        */
> +       arch_setup_dma_ops(dev, 0, dev->coherent_dma_mask + 1, iommu,
> +                          attr == DEV_DMA_COHERENT);
> +}

I have a network driver that is impacted by this code, so thank you
for posting this. (See
https://www.mail-archive.com/netdev@vger.kernel.org/msg106249.html).

One one SOC, the driver needs to set the mask to 32 bits.  On another
SOC, it needs to set it to 64 bits.  On device tree, the driver will
use dma-ranges.

In your patches, where is coherent_dma_mask initialized?  I found this
code in add_smmu_platform_device(), but I think this is setting the
mask for the IOMMU driver, not the individual devices.  Either way, I
don't understand where the correct value is going to be overridden.

+       /*
+        * Set default dma mask value for the table walker,
+        * to be overridden on probing with correct value.
+        */
+       *pdev->dev.dma_mask = DMA_BIT_MASK(32);
+       pdev->dev.coherent_dma_mask = *pdev->dev.dma_mask;

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
