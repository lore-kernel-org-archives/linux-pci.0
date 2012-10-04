Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15739 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965609Ab2JDP0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 4 Oct 2012 11:26:46 -0400
Message-ID: <1349364399.2759.42.camel@ul30vt.home>
Subject: Re: vfio: missing patch in linux 3.6
From: Alex Williamson <alex.williamson@redhat.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
Cc: kvm@vger.kernel.org, "Roedel, Joerg" <Joerg.Roedel@amd.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Date: Thu, 04 Oct 2012 09:26:39 -0600
In-Reply-To: <506DA799.5090603@01019freenet.de>
References: <506DA799.5090603@01019freenet.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2012-10-04 at 17:13 +0200, Andreas Hartmann wrote:
> Hello Alex,
> 
> I just tested vfio as part of linux 3.6 and detected, that it doesn't
> work because of the following missing patch:
> 
> http://news.gmane.org/find-root.php?group=gmane.linux.kernel.pci&article=16422
> 
> Could you please get it applied for the next stable release?

Hi Andreas,

This patch needs to go through Bjorn's PCI tree, but as noted in the
comments I have some outstanding questions that need to be answered,
probably by Joerg.  Thanks,

Alex

