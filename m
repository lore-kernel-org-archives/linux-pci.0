Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34713 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751469AbbDBMJe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 08:09:34 -0400
Date: Thu, 2 Apr 2015 14:09:30 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150402140519-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <20150402094424.0de6c990@endymion.delvare>
 <20150402094608-mutt-send-email-mst@redhat.com>
 <20150402082306.GA24610@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402082306.GA24610@infradead.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 02, 2015 at 01:23:06AM -0700, Christoph Hellwig wrote:
> The class ids are a hardware defintion, not a kernel API.

It's part of the API, it's used to decode values in this sysfs file:
/sys/bus/pci/devices/<address>/class
VFIO also made this part of it's kernel API.

> Just use the
> definitions from libpci, or copy over the kernel header if you prefer
> it over the libpci definutions.
