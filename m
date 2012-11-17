Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 17 Nov 2012 13:27:43 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: iommu@lists.linux-foundation.org, prometheanfire@gentoo.org,
	cardoe@gentoo.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, mthode@mthode.org,
	ddutile@redhat.com, bhelgaas@google.com, dwmw2@infradead.org
Subject: Re: [PATCH] intel-iommu: Fix lookup in add device
Message-ID: <20121117122743.GB11220@8bytes.org>
References: <20121113172144.6783.37724.stgit@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121113172144.6783.37724.stgit@bling.home>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 13, 2012 at 10:22:03AM -0700, Alex Williamson wrote:
> We can't assume this device exists, fall back to the bridge itself.
> 
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> Tested-by: Matthew Thode <prometheanfire@gentoo.org>
> Cc: stable@vger.kernel.org

Applied to iommu/fixes, thanks.

