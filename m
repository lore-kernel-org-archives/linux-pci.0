Return-Path: <SRS0=nVf2=ZP=bombadil.srs.infradead.org=BATV+126c71efb4a07ec1f0fd+4911+infradead.org+hch@kernel.org>
Return-Path: <SRS0=nVf2=ZP=bombadil.srs.infradead.org=BATV+126c71efb4a07ec1f0fd+4911+infradead.org+hch@kernel.org>
Date: Thu, 2 Feb 2017 08:30:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	lists@ssl-mail.com, "Jayachandran C." <jnair@caviumnetworks.com>,
	"H.J. Lu" <hjl.tools@gmail.com>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [GIT PULL] PCI fixes for v4.10
Message-ID: <20170202163024.GA30074@infradead.org>
References: <20170202161812.GB21267@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170202161812.GB21267@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Feb 02, 2017 at 10:18:12AM -0600, Bjorn Helgaas wrote:
> PCI fixes:
> 
>   - configure ASPM on the link from a PCI-to-PCIe bridge (avoids a NULL
>     pointer dereference on topologies including these bridges)

Any reason you didn't include the affinity use outside the allocate
range fix sent on Tuesday?
