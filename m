Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:58038 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751420AbaCUQbc (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 12:31:32 -0400
In-Reply-To: <532C6BF7.1050404@cogentembedded.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com> <532C5ADE.4030708@cogentembedded.com> <OF4D80B18E.5A1F55AB-ON80257CA2.0051AADA-80257CA2.0051D412@eu.necel.com> <6044873.2S2Xlhp0hC@wuerfel> <532C6BF7.1050404@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@verge.net.au>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OFCC2858D2.BB49EE27-ON80257CA2.005AA51E-80257CA2.005AC3A0@eu.necel.com>
Date: Fri, 21 Mar 2014 16:31:24 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes for R8A7790
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On: 21/03/2014 15:42, Sergei wrote:
> Subject: Re: [PATCH v4 6/9] ARM: shmobile: Add PCIe device tree nodes 
for R8A7790
> 
> Hello.
> 
> On 03/21/2014 05:57 PM, Arnd Bergmann wrote:
> 
> >>>> +      reg = <0 0xfe000000 0 0x80000>;
> >>>> +      #address-cells = >;
> >>>> +      #size-cells = <2>;
> >>>> +      device_type = "pci";
> 
> >>>      This legacy property is only meaningful for the true OF 
firmware and thus
> >>> have been phased out (it's only actively used for the memory nodes).
> 
> >> Ok, thanks for pointing this out.
> 
> > I think the code still relies on it for PCI though.
> 
>     OK, I have found where it does that but the recommended value seems 
to be 
> "pciex" for PCI-Express case.

Ok, but why then do all the other PCIe hosts use "pci"?

Thanks
Phil
