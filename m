Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:47406 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751327Ab2GBDlS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 1 Jul 2012 23:41:18 -0400
Received: by pbbrp8 with SMTP id rp8so6971375pbb.19
        for <linux-pci@vger.kernel.org>; Sun, 01 Jul 2012 20:41:17 -0700 (PDT)
Message-ID: <4FF11855.2060605@ozlabs.ru>
Date: Mon, 02 Jul 2012 13:41:09 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Alex Williamson <alex.williamson@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	David Gibson <david@gibson.dropbear.id.au>,
	chrisw <chrisw@sous-sol.org>,
	"Roedel, Joerg" <Joerg.Roedel@amd.com>, linux-next@vger.kernel.org
Subject: Re: Request VFIO inclusion in linux-next
References: <1340686552.1207.128.camel@bling.home> <20120627123733.GA5449@mwanda>
In-Reply-To: <20120627123733.GA5449@mwanda>
Content-Type: text/plain; charset=KOI8-R
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 27/06/12 22:37, Dan Carpenter wrote:
> On Mon, Jun 25, 2012 at 10:55:52PM -0600, Alex Williamson wrote:
>> Hi,
>>
>> VFIO has been kicking around for well over a year now and has been
>> posted numerous times for review.  The pre-requirements are finally
>> available in linux-next (or will be in the 20120626 build) so I'd like
>> to request a new branch be included in linux-next with a goal of being
>> accepted into v3.6.
>>
> 
> Could you run Sparse over the driver?
> http://lwn.net/Articles/205624/
> 
> It reports a bunch of endian problems.  Some are definitely bugs
> like:
> 	*prev |= cpu_to_le32((u32)epos << 20);


What is wrong here?



-- 
Alexey
