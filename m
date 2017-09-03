Return-Path: <SRS0=u63I=AE=gmail.com=yhlu.kernel@kernel.org>
Return-Path: <SRS0=u63I=AE=gmail.com=yhlu.kernel@kernel.org>
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <20170829195322.GB2304@bhelgaas-glaptop.roam.corp.google.com>
References: <1503855651-17409-1-git-send-email-okaya@codeaurora.org> <20170829195322.GB2304@bhelgaas-glaptop.roam.corp.google.com>
From: Yinghai Lu <yinghai@kernel.org>
Date: Sun, 3 Sep 2017 15:13:51 -0700
Message-ID: <CAE9FiQWyuW_ukTiYR+Kb1ZoqK7cZSeUE7f8TYRh4B6cF=XywUA@mail.gmail.com>
Subject: Re: [PATCH V13 1/4] PCI: Don't ignore valid response before CRS timeout
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Sinan Kaya <okaya@codeaurora.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, timur@codeaurora.org,
	Alex Williamson <alex.williamson@redhat.com>, linux-arm-msm@vger.kernel.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Tue, Aug 29, 2017 at 12:53 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:

>
> Applied this series to pci/enumeration for v4.14.  You didn't include a
> cover letter, but the series includes:
>
>   [V13 1/4] PCI: Don't ignore valid response before CRS timeout
>   [V13 2/4] PCI: Factor out pci_bus_wait_crs()
>   [V13 3/4] PCI: Handle CRS ('device not ready') returned by device af
>   [V13 4/4] PCI: Warn periodically while waiting for device to become
>
> I made some changes:
>
>   - Renamed pci_bus_crs_visibility_pending() to pci_bus_crs_vendor_id()
>     because the CRS completion is not "pending".  It is not waiting
>     somewhere for us to do something about it.  The CRS completion has
>     already occurred and is over.  All we have now is a magic Vendor ID
>     value that tells us that it happened.
>
>   - Split addition of pci_bus_crs_vendor_id() to a separate patch, move
>     it to probe.c, and make it static.

the calling of pci_bus_crs_vendor_id() in pci_bus_read_dev_vendor_id()
could be removed. pci_bus_wait_crs() have that calling inside.

-Yinghai
