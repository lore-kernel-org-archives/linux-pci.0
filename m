Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:52925 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924AbcEWKxB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 23 May 2016 06:53:01 -0400
Date: Mon, 23 May 2016 03:52:59 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
Message-ID: <20160523105259.GA26331@infradead.org>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463521199-16604-2-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Doesn't look fine (because the API is a mess), but the best we can do
for now:

Reviewed-by: Christoph Hellwig <hch@lst.de>
