Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44518 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575AbaIQQmP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 17 Sep 2014 12:42:15 -0400
Message-ID: <1410972133.1199.58.camel@ul30vt.home>
Subject: Re: [PATCH 0/2] PCI: Remove dead code after DMA alias work
From: Alex Williamson <alex.williamson@redhat.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com, linux-kernel@vger.kernel.org
Date: Wed, 17 Sep 2014 10:42:13 -0600
In-Reply-To: <20140917163412.21412.51729.stgit@gimli.home>
References: <20140917163412.21412.51729.stgit@gimli.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, 2014-09-17 at 10:35 -0600, Alex Williamson wrote:
> Now that IOMMU drivers have completed the DMA alias transition,
> remove the left behind dead code.  Thanks,

Grr, resending a v2, my DNS hiccuped just after sending the cover.
Thanks,

Alex

