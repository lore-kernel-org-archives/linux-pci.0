Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:47412 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734AbaHTTWk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Aug 2014 15:22:40 -0400
Date: Wed, 20 Aug 2014 12:22:39 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexander Gordeev <agordeev@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org,
	Naresh Kumar Inna <naresh@chelsio.com>,
	Arvind Bhushan <arvindb@chelsio.com>,
	Jayamohan Kallickal <jayamohan.kallickal@emulex.com>,
	linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
	"James E.J. Bottomley" <JBottomley@parallels.com>,
	Tomas Henzl <thenzl@redhat.com>
Subject: Re: [PATCH v3 00/13] scsi: Use pci_enable_msix_range() instead of
 pci_enable_msix()
Message-ID: <20140820192239.GA25281@infradead.org>
References: <cover.1408335523.git.agordeev@redhat.com>
 <20140819170047.GA7237@infradead.org>
 <20140820191416.GA1886@agordeev.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140820191416.GA1886@agordeev.usersys.redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 20, 2014 at 08:14:17PM +0100, Alexander Gordeev wrote:
> > I've applied patches 1 to 7 to the drivers-for-3.18 branch.
> 
> Thanks, Christoph!
> 
> Not sure how to handle the rest, though. Chelsio driver has no
> maintainers and none of be2iscsi, pmcraid and csiostor has been
> reviewed for several months.

I've added Tomas to the Cc list who has been very helpful with reviewing
drivers lately.  Tomas, can you take a quick look at these patches?
