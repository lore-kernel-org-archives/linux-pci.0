Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36024 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756446AbbJVPJ6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 22 Oct 2015 11:09:58 -0400
MIME-Version: 1.0
In-Reply-To: <20151020210303.3671.52391.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20151020210303.3671.52391.stgit@bhelgaas-glaptop2.roam.corp.google.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Thu, 22 Oct 2015 10:09:36 -0500
Message-ID: <CAL_Jsq+Ea_sKsMgWtXSkLeOUibsDTR0EW7AVsyGvZdHXSdZ6GQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation/devicetree: Update PCI Device Tree bindings
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 20, 2015 at 4:03 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> Update broken links to PCI bus and interrupt mapping bindings.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied, thanks.

Rob

> ---
>  Documentation/devicetree/bindings/pci/pci.txt |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index f8fbe9a..08dcfad 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -1,12 +1,12 @@
>  PCI bus bridges have standardized Device Tree bindings:
>
>  PCI Bus Binding to: IEEE Std 1275-1994
> -http://www.openfirmware.org/ofwg/bindings/pci/pci2_1.pdf
> +http://www.firmware.org/1275/bindings/pci/pci2_1.pdf
>
>  And for the interrupt mapping part:
>
>  Open Firmware Recommended Practice: Interrupt Mapping
> -http://www.openfirmware.org/1275/practice/imap/imap0_9d.pdf
> +http://www.firmware.org/1275/practice/imap/imap0_9d.pdf
>
>  Additionally to the properties specified in the above standards a host bridge
>  driver implementation may support the following properties:
>
