Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:65360 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751904Ab2GIUS0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 9 Jul 2012 16:18:26 -0400
Date: Mon, 9 Jul 2012 13:18:18 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matthew Wilcox <matthew.r.wilcox@intel.com>,
	Robert Hancock <hancockrwd@gmail.com>
Subject: Re: [PATCH 1/2] PCI: leave MEM and IO decoding disabled during
 64-bit BAR sizing, too
Message-ID: <20120709131818.72799bcb@chromoly>
In-Reply-To: <20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
References: <20120709181745.18165.93914.stgit@bhelgaas.mtv.corp.google.com>
	<20120709182018.18165.98339.stgit@bhelgaas.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, 09 Jul 2012 12:20:18 -0600
Bjorn Helgaas <bhelgaas@google.com> wrote:

> After 253d2e5498, we disable MEM and IO decoding for most devices
> while we size 32-bit BARs.  However, we restore the original COMMAND
> register before we size the upper 32 bits of 64-bit BARs, so we can
> still cause a conflict.
> 
> This patch waits to restore the original COMMAND register until we're
> completely finished sizing the BAR.
agreed.

Thanks,

Jacob
