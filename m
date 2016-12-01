Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750708AbcLAQgE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Dec 2016 11:36:04 -0500
Date: Thu, 1 Dec 2016 10:35:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        Tomasz Nowicki <tn@semihalf.com>, Duc Dang <dhdang@apm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Christopher Covington <cov@codeaurora.org>,
        Dongdong Liu <liudongdong3@huawei.com>
Subject: Re: [PATCH v10 01/12] ACPI: Add acpi_resource_consumer() to find
 device that claims a resource
Message-ID: <20161201163557.GF19681@bhelgaas-glaptop.roam.corp.google.com>
References: <20161201075131.12247.2211.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161201082932.12247.7479.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0hB61=17Fbf=2-K=zaRmMZkY3NVxMPHNwfF9Nr6=ey+-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hB61=17Fbf=2-K=zaRmMZkY3NVxMPHNwfF9Nr6=ey+-g@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 01, 2016 at 02:17:20PM +0100, Rafael J. Wysocki wrote:
> On Thu, Dec 1, 2016 at 9:29 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Add acpi_resource_consumer().  This takes a struct resource and searches
> > the ACPI namespace for a device whose current resource settings (_CRS)
> > includes the resource.  It returns the device if it exists, or NULL if no
> > device uses the resource.
> >
> > If more than one device uses the resource (this may happen in the case of
> > bridges), acpi_resource_consumer() returns the first one found by
> > acpi_get_devices() in its modified depth-first walk of the namespace.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> (this patch should have been CCed to linux-acpi too, however).

Thanks for taking a look!  I didn't CC linux-acpi because this was mostly
to get build testing and I didn't want linux-acpi to get spammed by
buildbot errors.  I'll add linux-acpi on future postings.

Bjorn
