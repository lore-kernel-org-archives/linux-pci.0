Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:54070 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753638AbdCBBmj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Mar 2017 20:42:39 -0500
Date: Thu, 2 Mar 2017 00:49:04 +0100
From: Christoph Hellwig <hch@lst.de>
To: Himanshu Madhani <himanshu.madhani@cavium.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] PCI/MSI: Only disable affinity settings if pre and
        post vector count is equal to max_vecs and not min_vecs
Message-ID: <20170301234904.GA22814@lst.de>
References: <20170301233158.1035-1-himanshu.madhani@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170301233158.1035-1-himanshu.madhani@cavium.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
