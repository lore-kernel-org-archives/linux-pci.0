Return-Path: <wim@djo.tudelft.nl>
Return-Path: <wim@djo.tudelft.nl>
Date: Thu, 30 Jun 2016 04:30:41 +0200
From: Wim Osterholt <wim@djo.tudelft.nl>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
  "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
  linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
  Takashi Iwai <tiwai@suse.com>, linux-pci-owner@vger.kernel.org,
  Alex Williamson <alex.williamson@redhat.com>,
  Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Message-ID: <20160630023041.GA5407@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <576C042B.20507@codeaurora.org>
 <20160623232533.GA14984@djo.tudelft.nl>
 <f85fb7c7-53aa-3a1e-0635-bb245d08e804@codeaurora.org>
 <20160625013920.GA26737@djo.tudelft.nl>
 <3bf1261bc7a931cb5e1e93ea0d66b265@codeaurora.org>
 <20160627062724.GA6713@djo.tudelft.nl>
 <9ad14db03ecb39a098d588b25c7b54a0@codeaurora.org>
 <20160627130417.GA8184@djo.tudelft.nl>
 <a8b7406eb12fc43246af4d78fc7e2278@codeaurora.org>
 <8602f0b7-e052-913f-d633-294dff6cd3b2@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <8602f0b7-e052-913f-d633-294dff6cd3b2@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 29, 2016 at 04:34:14AM -0400, Sinan Kaya wrote:
> > 
> 
> I posted this [PATCH V2 0/4] ACPI,PCI,IRQ: correct ISA penalty calculation
> 
> Can you test this and give me a tested-by?


Kernel-4.7-rc5 plus this patch works like a charm on my Inspiron 4100.
Dmesg output is quite similar to the one from kernel-4.6 .

Tested-by: Wim Osterholt. <wim@djo.tudelft.nl>
