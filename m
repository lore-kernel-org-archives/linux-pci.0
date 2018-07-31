Return-Path: <SRS0=tr2T=KP=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=tr2T=KP=linux.intel.com=mika.westerberg@kernel.org>
Date: Tue, 31 Jul 2018 10:59:28 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Sinan Kaya <okaya@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: pciehp: Avoid implicit fallthroughs in switch
 statements
Message-ID: <20180731075928.GZ2534@lahna.fi.intel.com>
References: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <92c3c456edb461494d5c44e1ff6bab2711228ff1.1532754355.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jul 28, 2018 at 07:22:00AM +0200, Lukas Wunner wrote:
> Per Mika's request, add an explicit break to the last case of switch
> statements everywhere in pciehp to be more defensive towards future
> amendments.
> 
> Per Gustavo's request, mark all non-empty implicit fallthroughs with a
> comment to silence warnings triggered by -Wimplicit-fallthrough=2.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
