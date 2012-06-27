Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 27 Jun 2012 15:37:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	kvm <kvm@vger.kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	iommu <iommu@lists.linux-foundation.org>,
	qemu-devel <qemu-devel@nongnu.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alexey Kardashevskiy <aik@ozlabs.ru>,
	David Gibson <david@gibson.dropbear.id.au>,
	chrisw <chrisw@sous-sol.org>,
	"Roedel, Joerg" <Joerg.Roedel@amd.com>, linux-next@vger.kernel.org
Subject: Re: Request VFIO inclusion in linux-next
Message-ID: <20120627123733.GA5449@mwanda>
References: <1340686552.1207.128.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340686552.1207.128.camel@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jun 25, 2012 at 10:55:52PM -0600, Alex Williamson wrote:
> Hi,
> 
> VFIO has been kicking around for well over a year now and has been
> posted numerous times for review.  The pre-requirements are finally
> available in linux-next (or will be in the 20120626 build) so I'd like
> to request a new branch be included in linux-next with a goal of being
> accepted into v3.6.
> 

Could you run Sparse over the driver?
http://lwn.net/Articles/205624/

It reports a bunch of endian problems.  Some are definitely bugs
like:
	*prev |= cpu_to_le32((u32)epos << 20);

regards,
dan carpenter

