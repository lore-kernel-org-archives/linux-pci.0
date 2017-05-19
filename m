Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:35401 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753073AbdESIX3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 May 2017 04:23:29 -0400
Date: Fri, 19 May 2017 10:23:27 +0200
From: Christoph Hellwig <hch@lst.de>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/MSI: Ignore affinity if pre/post vector count is
        more than min_vecs
Message-ID: <20170519082327.GD1411@lst.de>
References: <20170518174747.657-1-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170518174747.657-1-himanshu.madhani@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
