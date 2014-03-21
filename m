Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:37269 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753675AbaCUPHI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 11:07:08 -0400
In-Reply-To: <532C5B70.5060509@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <1395397968-6242-7-git-send-email-phil.edworthy@renesas.com> <532C5B70.5060509@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF1B1A84A2.0FE335EF-ON80257CA2.0052C1C4-80257CA2.005304D4@eu.necel.com>
Date: Fri, 21 Mar 2014 15:06:48 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On: 21/03/2014 14:32, Sergei wrote:
> Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> Hello.
> 
> On 03/21/2014 01:32 PM, Phil Edworthy wrote:
> 
> > This patch adds the device tree nodes for R8A7790
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >   arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
> >   1 file changed, 19 insertions(+)
> 
>     Why are you not enabling PCIe for Lager, only on Koelsch?
The Lager board doesn't have PCIe hardware. Note that it's possible to 
modify the Lager board and convert the SATA signals to PCIe, and we've 
done that to check that it works on R-Car H2.

> WBR, Sergei
> 

Thanks
Phil
