Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Jan 2016 10:50:57 +0900
From: Simon Horman <horms@verge.net.au>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 1/4] PCI: rcar: remove unused pci_sys_data structure
 in pcie-rcar
Message-ID: <20160108015056.GB9600@verge.net.au>
References: <1451998831-27705-1-git-send-email-phil.edworthy@renesas.com>
 <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1451998831-27705-2-git-send-email-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Phil,

On Tue, Jan 05, 2016 at 01:00:28PM +0000, Phil Edworthy wrote:
> Commit b3a72384fe29 ("ARM/PCI: Replace pci_sys_data->align_resource
> with global function pointer") removed the struct pci_sys_data
> dependency from the ARM pcibios functions, so remove it from this
> driver.

I am a little confused by this as I still see two instances of
the following in bios32.c as of the commit above.

	struct pci_sys_data *sys = dev->sysdata;
