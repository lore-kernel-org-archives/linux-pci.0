Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45602 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeEAK4B (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 May 2018 06:56:01 -0400
Date: Tue, 1 May 2018 11:55:56 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Simon Horman <horms@verge.net.au>
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Dien Pham <dien.pham.ry@rvc.renesas.com>,
        Hien Dang <hien.dang.eb@renesas.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH V5] PCI: rcar: Use runtime PM to control controller clock
Message-ID: <20180501105556.GB19391@e107981-ln.cambridge.arm.com>
References: <3973dcdf-c6d7-5622-0c19-ea6f77899261@gmail.com>
 <20180409114159.azxeehjkeuinwrwe@verge.net.au>
 <CAMuHMdUF0oG+fdWv2CissD9tviHiVCg3ofW3oR3vY+=Km41tAg@mail.gmail.com>
 <20180409122636.6rmtzhqqlpqxyear@verge.net.au>
 <caaa0a56-7487-a4de-2b43-82f5fa5b5552@gmail.com>
 <CAMuHMdWTTaJF8+GJdLmM_4J+gMaHPzT2rpO=B2kWYb_2bNbQNg@mail.gmail.com>
 <a5a0d78d-627b-6277-ee75-44e204cbd390@gmail.com>
 <CAMuHMdX9d29JYVDsghd3Koyg8Aeuv0D2Fx5Lnn0bBZSb9RntDw@mail.gmail.com>
 <cdc1b25a-e87d-144b-50c1-4abe31bcf5d0@gmail.com>
 <20180413124819.tw5436lolpn5eqhw@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180413124819.tw5436lolpn5eqhw@verge.net.au>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 13, 2018 at 02:48:19PM +0200, Simon Horman wrote:
> On Tue, Apr 10, 2018 at 06:17:04PM +0200, Marek Vasut wrote:
> > On 04/10/2018 05:28 PM, Geert Uytterhoeven wrote:
> 
> ...
> 
> > >>> rcar_pcie_get_resources() is called while the device is
> > >>> runtime-enabled/resumed,
> > >>> pci_free_resource_list() is called while the device is runtime-disabled.
> > 
> > rcar_pcie_get_resources() is NOT a pair function for
> > pci_free_resource_list() . rcar_pcie_parse_request_of_pci_ranges() is a
> > pair function for pci_free_resource_list().
> > 
> > rcar_pcie_parse_request_of_pci_ranges() calls
> > of_pci_get_host_bridge_resources() internally, so every single function
> > called after successful call of rcar_pcie_parse_request_of_pci_ranges()
> > must call pci_free_resource_list().
> > 
> > Both of_pci_get_host_bridge_resources() and pci_free_resource_list() are
> > called with runtime PM disabled.
> > 
> > The naming of the functions is confusing though.
> 
> Hi,
> 
> thanks everyone for their efforts in preparing/reviewing this patch.
> 
> It seems there are some differences of opinion on how best to handle the
> error paths but unlike earlier versions this one seems correct to me. If
> that turns out to be false we can address it. But I don't think its likely
> things will be enhanced by continuing this review.
> 
> Lorenzo, please consider taking this patch in its current form.
> 
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

Applied to pci/rcar for v4.18, thanks.

Lorenzo
