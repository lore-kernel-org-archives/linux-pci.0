Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45528 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab3IWC1K (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 22 Sep 2013 22:27:10 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MTK00AS245263B0@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Mon, 23 Sep 2013 11:27:08 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Jason Cooper' <jason@lakedaemon.net>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <001a01ceb366$5e9481b0$1bbd8510$%han@samsung.com>
 <001c01ceb366$9bad8740$d30895c0$%han@samsung.com>
 <20130917194220.47406b49@skate>
In-reply-to: <20130917194220.47406b49@skate>
Subject: Re: [PATCH V2 3/3] PCI: mvebu: add missing __iomem annotation
Date: Mon, 23 Sep 2013 11:27:08 +0900
Message-id: <004101ceb804$669f29d0$33dd7d70$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, September 18, 2013 2:42 AM, Thomas Petazzoni wrote:
> On Tue, 17 Sep 2013 14:27:31 +0900, Jingoo Han wrote:
> > Added missing __iomem annotation in order to fix the following
> > sparse warning:
> 
> I believe your commit title and log is now wrong: this commit is not
> adding an iomem annotation anywhere.
> 

Yes, you're right.
I will fix the commit title and log, and send v3 patch, soon.
Thank you for your comment. :-)

Best regards,
Jingoo Han


