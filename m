Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34932 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263AbbDBOeu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 10:34:50 -0400
Message-ID: <1427985259.5567.371.camel@redhat.com>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
From: Alex Williamson <alex.williamson@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Thu, 02 Apr 2015 08:34:19 -0600
In-Reply-To: <20150402140519-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	 <20150402094424.0de6c990@endymion.delvare>
	 <20150402094608-mutt-send-email-mst@redhat.com>
	 <20150402082306.GA24610@infradead.org>
	 <20150402140519-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2015-04-02 at 14:09 +0200, Michael S. Tsirkin wrote:
> On Thu, Apr 02, 2015 at 01:23:06AM -0700, Christoph Hellwig wrote:
> > The class ids are a hardware defintion, not a kernel API.
> 
> It's part of the API, it's used to decode values in this sysfs file:
> /sys/bus/pci/devices/<address>/class
> VFIO also made this part of it's kernel API.

vfio-pci does expose PCI config space, but it also exposes memory mapped
and io port mapped regions of the device.  Do we consider the memory
mapped config space of every device that can be exposed through vfio to
be part of the kernel API?  I don't think so.  PCI config space is
obviously more standardized and vfio-pci plays a greater role in
intercepting and interacting with standardized portions, but we don't
really care where userspace gets their definitions for config space
offsets.

