Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Tue, 13 Sep 2016 09:24:41 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: nwatters@codeaurora.org, iommu@lists.linux-foundation.org,
        Tomasz Nowicki <tn@semihalf.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Jon Masters <jcm@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Prem Mallappa <prem.mallappa@broadcom.com>,
        Dennis Chen <dennis.chen@arm.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 07/14] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
Message-ID: <20160913082441.GA28804@red-moon>
References: <20160909142343.13314-1-lorenzo.pieralisi@arm.com>
 <20160909142343.13314-8-lorenzo.pieralisi@arm.com>
 <7a63cf312b6e9714cdce1d0aca88cf4d@codeaurora.org>
 <fb4acfd5-b7fd-636f-53f3-13dc6fb8b713@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fb4acfd5-b7fd-636f-53f3-13dc6fb8b713@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Sep 13, 2016 at 04:15:31PM +0800, Hanjun Guo wrote:

[...]

> >>+static acpi_status __init iort_match_iommu_callback(struct
> >>acpi_iort_node *node,
> >>+                            void *context)
> >>+{
> >>+    int ret;
> >>+    struct fwnode_handle *fwnode;
> >>+
> >>+    fwnode = iort_get_fwnode(node);
> >>+
> >>+    if (!fwnode)
> >>+        return AE_NOT_FOUND;
> >>+
> >>+    ret = iort_add_smmu_platform_device(fwnode, node);
> >>+    if (ret) {
> >>+        pr_err("Error in platform device creation\n");
> >>+        return AE_ERROR;
> >>+    }
> >>+
> >>+    return AE_OK;
> >>+}
> >>+
> >>+static void __init iort_smmu_init(void)
> >>+{
> >>+    iort_scan_node(ACPI_IORT_NODE_SMMU, iort_match_iommu_callback,
> >>NULL);
> >>+    iort_scan_node(ACPI_IORT_NODE_SMMU_V3, iort_match_iommu_callback,
> >>NULL);
> >
> >Since iort_scan_node() returns after the first successful match it finds,
> >only the first SMMU_V3 in my IORT is being enumerated. I think you need
> >to go back to the "iterator" like approach you had been using or make
> >iort_match_iommu_callback() always return a non-AE_OK value so the scan
> >continues and has a chance to visit all of the SMMU_V3 nodes.
> 
> Please use the updated version of IORT patch (aka Tomasz's v11)
> then things will work fine.

Nate is right, I was too keen on using iort_scan_node(), it does
not really work here (unless as he said I return a value !AE_OK in
the callback, which is horrible), I reverted back to the iterator
approach and I can push out a fixed up branch if useful before next
posting.

Thanks,
Lorenzo
