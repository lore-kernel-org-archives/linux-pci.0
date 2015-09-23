Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1443047264-4003-1-git-send-email-sean.stalley@intel.com>
References: <1443047264-4003-1-git-send-email-sean.stalley@intel.com>
Date: Wed, 23 Sep 2015 16:26:56 -0700
Message-ID: <CAE9FiQXYzcEnagnAZ_agXXSVssAfVD8tBjKh9ox_ajqKG0v27g@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] PCI: Add support for PCI Enhanced Allocation "BARs"
From: Yinghai Lu <yinghai@kernel.org>
To: "Sean O. Stalley" <sean.stalley@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatxjain@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	"gong.chen@linux.intel.com" <gong.chen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-api@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Sep 23, 2015 at 3:27 PM, Sean O. Stalley <sean.stalley@intel.com> wrote:
> PCI Enhanced Allocation is a new method of allocating MMIO & IO
> resources for PCI devices & bridges. It can be used instead
> of the traditional PCI method of using BARs.
>
> EA entries are hardware-initialized to a fixed address.
> Unlike BARs, regions described by EA are cannot be moved.
> Because of this, only devices which are permanently connected to
> the PCI bus can use EA. A removable PCI card must not use EA.

As it is fixed, can you put IORESOURCE_PCI_FIXED in the res->flags?

Thanks

Yinghai
