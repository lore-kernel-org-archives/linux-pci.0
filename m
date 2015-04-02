Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:38948 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752688AbbDBIXI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 2 Apr 2015 04:23:08 -0400
Date: Thu, 2 Apr 2015 01:23:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jean Delvare <jdelvare@suse.de>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150402082306.GA24610@infradead.org>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <20150402094424.0de6c990@endymion.delvare>
 <20150402094608-mutt-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150402094608-mutt-send-email-mst@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

The class ids are a hardware defintion, not a kernel API.  Just use the
definitions from libpci, or copy over the kernel header if you prefer
it over the libpci definutions.
