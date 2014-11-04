Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:52822 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaKDMA4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Nov 2014 07:00:56 -0500
Date: Tue, 4 Nov 2014 12:00:52 +0000
From: Liviu Dudau <Liviu.Dudau@arm.com>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: add missing DT binding for linux,pci-domain property
Message-ID: <20141104120052.GE11102@e106497-lin.cambridge.arm.com>
References: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <1415101660-26450-1-git-send-email-l.stach@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Nov 04, 2014 at 11:47:40AM +0000, Lucas Stach wrote:
> This property was added by 41e5c0f81d3e
> (of/pci: Add pci_get_new_domain_nr() and of_get_pci_domain_nr())
> without the required binding documentation. As this property
> will be supported by a number of host bridge drivers going forward,
> add it to the common PCI binding doc.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
> This is a non-critical fix, but may still qualify for 3.18-rc as
> the property was added in this release cycle.

Hi Lucas,

Thanks for taking care of this, sorry it slipped through the cracks
of last minute changes in this area.

> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 41aeed38926d..b754f786ed5e 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -7,3 +7,13 @@ And for the interrupt mapping part:
>  
>  Open Firmware Recommended Practice: Interrupt Mapping
>  http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
> +
> +Additionally to the properties specified in the above standards a host bridge
> +driver implementation may support the following properties:
> +
> +- linux,pci-domain:
> +   If present this property assigns a fixed PCI domain number to a host bridge,
> +   otherwise an unstable (across boots) unique number will be assigned.
> +   It is recommended to either not set this property at all or set it for all
> +   host bridges in the system, otherwise potentially conflicting domain numbers
> +   may be assigned to root buses behind different host bridges.
> -- 
> 2.1.1
> 

While the description is potentially correct, what it fails to explain is that the
choice of using the property or generating an unstable (across boots) unique
number is actually the choice of the host bridge driver at the moment. I know that
my earlier implementations were defaulting to the automatic numbering, but that has
been dropped from the final series as Rob Herring was objecting to it.

There is still scope to adopt a wide policy here, but for now it should say something
to the tune:

   If present this property assigns a fixed PCI domain number to a host bridge,
   otherwise an unstable (across boots) unique number will be assigned.
   If you decide to use the property to assign a fixed PCI domain number to a host
   bridge you have to ensure that all the host bridge drivers present in the system
   follow the same policy. Otherwise, potentially conflicting domain numbers
   may be assigned to root busses behind different host bridges.

Best regards,
Liviu
-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯

