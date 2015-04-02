Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbbDBJEU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 05:04:20 -0400
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
From: Jean Delvare <jdelvare@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <20150402082306.GA24610@infradead.org>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
	 <20150402094424.0de6c990@endymion.delvare>
	 <20150402094608-mutt-send-email-mst@redhat.com>
	 <20150402082306.GA24610@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Apr 2015 11:04:16 +0200
Message-ID: <1427965456.4063.1272.camel@chaos.site>
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Le Thursday 02 April 2015 à 01:23 -0700, Christoph Hellwig a écrit :
> The class ids are a hardware defintion, not a kernel API.  Just use the
> definitions from libpci, or copy over the kernel header if you prefer
> it over the libpci definutions.

I agree with Christoph, such defines would better come from
pciutils-devel, not the kernel.

-- 
Jean Delvare
SUSE L3 Support

