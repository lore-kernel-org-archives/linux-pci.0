Return-Path: <wim@djo.tudelft.nl>
Return-Path: <wim@djo.tudelft.nl>
Date: Wed, 22 Jun 2016 00:13:47 +0200
From: Wim Osterholt <wim@djo.tudelft.nl>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
  "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
  linux-acpi@vger.kernel.org, perex@perex.cz, linux-pci@vger.kernel.org,
  Takashi Iwai <tiwai@suse.com>, Wim Osterholt <wim@djo.tudelft.nl>
Subject: Re: kernel-4.7 bug in Intel sound and/or ACPI
Message-ID: <20160621221347.GA28603@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <20160620003530.GA19571@djo.tudelft.nl>
 <2999417.fp4mqtxYS2@vostro.rjw.lan>
 <20160620212507.GA24086@localhost>
 <57686D67.8010201@codeaurora.org>
 <20160621124715.GB3528@djo.tudelft.nl>
 <576943BA.1000001@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <576943BA.1000001@codeaurora.org>
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 09:40:10AM -0400, Sinan Kaya wrote:
> 
> Thanks, It was a guess with no proof.
> 
> Let's undo the change above and start adding some print statements to collect
> data from your system.
> 
> Can you add this to the end of acpi_irq_get_penalty function and then send
> the output?
> 
> 	pr_info("%s:%d irq = %d penalty = %d\n", __func__, __LINE__, irq,
> 		penalty);
>  

This produced some 60 lines extra. Too much to include here.
The entire dmesg file is here:
http://webserver.djo.tudelft.nl/dmesg474+printpenalty


Regards, Wim.


----- wim@djo.tudelft.nl -----
