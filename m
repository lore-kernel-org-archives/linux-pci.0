Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1450427719-29619-3-git-send-email-hare@suse.de>
References: <1450427719-29619-1-git-send-email-hare@suse.de>
	<1450427719-29619-3-git-send-email-hare@suse.de>
Date: Fri, 18 Dec 2015 05:49:48 -0800
Message-ID: <CAKgT0Uceg2CmiXu926nfAWg25pSb24UhbmNBw2noNKRNHwDMow@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Update VPD size with correct length
From: Alexander Duyck <alexander.duyck@gmail.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Michal Kubecek <mkubecek@suse.com>,
	"Shane M. Seymour" <shane.seymour@hpe.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Dec 18, 2015 at 12:35 AM, Hannes Reinecke <hare@suse.de> wrote:
> PCI-2.2 VPD entries have a maximum size of 32k, but might actually
> be smaller than that. To figure out the actual size one has to read
> the VPD area until the 'end marker' is reached.
> Trying to read VPD data beyond that marker results in 'interesting'
> effects, from simple read errors to crashing the card. And to make
> matters worse not every PCI card implements this properly, leaving
> us with no 'end' marker or even completely invalid data.
> This path modifies the size of the VPD attribute to the available
> size, or set it to '0' if no valid data could be read.

This isn't what I had in mind.  There is no need to add an f0 version
of the size function.  The size for all functions other than function
0 when the F0 flag is set is 0.  We aren't going to be reading their
VPD, we only read the VPD region of function 0.

If you just  moved the call to pci_vpd_size into the conditional
statement in the init function you could then set the length to 0 in
the branch taken for if the F0 flag is set.  You might have to reorder
the init function a bit but there is no need to add additional
function pointers.

- Alex
