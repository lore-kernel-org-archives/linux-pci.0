Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:12008 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753797Ab3FKExZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 00:53:25 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Thierry Reding' <thierry.reding@gmail.com>
CC: "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
	"swarren@wwwdotorg.org" <swarren@wwwdotorg.org>,
	"thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"olof@lixom.net" <olof@lixom.net>, Hiroshi Doyu <hdoyu@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"mturquette@linaro.org" <mturquette@linaro.org>,
	Peter De Schrijver <pdeschrijver@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Tue, 11 Jun 2013 10:22:59 +0530
Subject: RE: [PATCH V3 3/4] ARM: dts: tegra: Correct PCIe entry
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BEEF@BGMAIL01.nvidia.com>
References: <1370372252-4332-1-git-send-email-jagarwal@nvidia.com>
 <1370372252-4332-3-git-send-email-jagarwal@nvidia.com>
 <20130610195511.GC25859@mithrandir>
In-Reply-To: <20130610195511.GC25859@mithrandir>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


> On Wed, Jun 05, 2013 at 12:27:31AM +0530, Jay Agarwal wrote:
> [...]
> > @@ -29,7 +29,7 @@
> >  		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000
> /* port 0 configuration space */
> >  			  0x82000000 0 0x00001000 0x00001000 0 0x00001000
> /* port 1 configuration space */
> >  			  0x82000000 0 0x00004000 0x00004000 0 0x00001000
> /* port 2 configuration space */
> > -			  0x81000000 0 0          0x02000000 0 0x00010000   /*
> downstream I/O */
> > +			  0x81000000 0 0          0x02000000 0 0x00100000   /*
> downstream I/O */
> >  			  0x82000000 0 0x20000000 0x20000000 0 0x10000000
> /* non-prefetchable memory */
> >  			  0xc2000000 0 0x30000000 0x30000000 0 0x10000000>;
> /*
> > prefetchable memory */
> 
> That increases the I/O region size from 64 KiB to 1 MiB. Why is that
> necessary? I/O operations can only address 64 KiB, so I don't think adding
> more makes any sense.
> 
Okay, you can keep it 64KiB then, I did it to match with downstream. 
Please let me know if you want me to upload new patch for this or you will take care while integrating.
