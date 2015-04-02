Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37482 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbbDBLPd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 07:15:33 -0400
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
From: Jean Delvare <jdelvare@suse.de>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20150402120711-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	 <20150402094424.0de6c990@endymion.delvare>
	 <20150402094608-mutt-send-email-mst@redhat.com>
	 <20150402082306.GA24610@infradead.org>
	 <1427965456.4063.1272.camel@chaos.site>
	 <20150402120711-mutt-send-email-mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Apr 2015 13:15:30 +0200
Message-ID: <1427973330.4063.1410.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Le Thursday 02 April 2015 à 12:09 +0200, Michael S. Tsirkin a écrit :
> On Thu, Apr 02, 2015 at 11:04:16AM +0200, Jean Delvare wrote:
> > Le Thursday 02 April 2015 à 01:23 -0700, Christoph Hellwig a écrit :
> > > The class ids are a hardware defintion, not a kernel API.  Just use the
> > > definitions from libpci, or copy over the kernel header if you prefer
> > > it over the libpci definutions.
> > 
> > I agree with Christoph, such defines would better come from
> > pciutils-devel, not the kernel.
> 
> This just leads to code duplication.  Projects that don't link with
> pciutils don't want to depend on it.

Well, they don't have to depend on anything then, they can keep defining
their own named IDs.

Please realize that 1* code duplication is impossible to avoid
completely and 2* this hardly qualifies as code duplication in the first
place (giving symbolic names to constants is not actual programming.)

-- 
Jean Delvare
SUSE L3 Support

