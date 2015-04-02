Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45485 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750747AbbDBKJF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 2 Apr 2015 06:09:05 -0400
Date: Thu, 2 Apr 2015 12:09:01 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jean Delvare <jdelvare@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Dave Jones <davej@redhat.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 00/86] pci: export pci_ids.h and related cleanups
Message-ID: <20150402120711-mutt-send-email-mst@redhat.com>
References: <1427635734-24786-1-git-send-email-mst@redhat.com>
 <20150402094424.0de6c990@endymion.delvare>
 <20150402094608-mutt-send-email-mst@redhat.com>
 <20150402082306.GA24610@infradead.org>
 <1427965456.4063.1272.camel@chaos.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1427965456.4063.1272.camel@chaos.site>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 02, 2015 at 11:04:16AM +0200, Jean Delvare wrote:
> Le Thursday 02 April 2015 à 01:23 -0700, Christoph Hellwig a écrit :
> > The class ids are a hardware defintion, not a kernel API.  Just use the
> > definitions from libpci, or copy over the kernel header if you prefer
> > it over the libpci definutions.
> 
> I agree with Christoph, such defines would better come from
> pciutils-devel, not the kernel.

This just leads to code duplication.  Projects that don't link with
pciutils don't want to depend on it.

-- 
MST
