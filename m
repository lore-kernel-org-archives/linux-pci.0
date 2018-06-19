Return-Path: <SRS0=y81w=JF=h08.hostsharing.net=foo00@kernel.org>
Return-Path: <SRS0=y81w=JF=h08.hostsharing.net=foo00@kernel.org>
Date: Tue, 19 Jun 2018 16:29:16 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Delete skeleton driver
Message-ID: <20180619142916.GA14203@wunner.de>
References: <a451571d5b24bee5d426c02636fc89c23e28f09e.1529412379.git.lukas@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <a451571d5b24bee5d426c02636fc89c23e28f09e.1529412379.git.lukas@wunner.de>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 19, 2018 at 02:52:50PM +0200, Lukas Wunner wrote:
>  drivers/pci/hotplug/pcihp_skeleton.c | 348 -----------------------------------
>  1 file changed, 348 deletions(-)
>  delete mode 100644 drivers/pci/hotplug/pcihp_skeleton.c

Apologies, I hand-edited the patch before sending it out and emacs
mangled it in such a way that it can no longer be applied with git am.
I've just sent out a rectified version (identical but sans the glitch)
and will mark this one superseded in patchwork.
