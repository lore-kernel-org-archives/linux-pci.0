Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 27 Oct 2015 09:22:58 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Vijay Mishra <vijaym@nvidia.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: arm64: PCI: HAVE_PCI_MMAP not defined
Message-ID: <20151027092258.GC21548@red-moon>
References: <fdc3df19fc8940f48cc9744855b796b1@BGMAIL104.nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fdc3df19fc8940f48cc9744855b796b1@BGMAIL104.nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 27, 2015 at 09:11:29AM +0000, Vijay Mishra wrote:
> Hi All,
> 
> I see "HAVE_PCI_MMAP" is defined in arm32 but missing in arm64 support.
> Is it intentional or missed out because no-body asked for it.

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/358906.html

Lorenzo
