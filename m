Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:15548
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1758593AbaDBL7E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Apr 2014 07:59:04 -0400
From: "Hong-Xing.Zhu@freescale.com" <Hong-Xing.Zhu@freescale.com>
To: Marek Vasut <marex@denx.de>, Kishon Vijay Abraham I <kishon@ti.com>
CC: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>
Subject: RE: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Date: Wed, 2 Apr 2014 11:58:42 +0000
Message-ID: <65debfc7f79a4a27a58bd7c64382881f@BLUPR03MB136.namprd03.prod.outlook.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com>
 <533BA157.6030004@ti.com> <201404021234.48134.marex@denx.de>
In-Reply-To: <201404021234.48134.marex@denx.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Marek:

> -----Original Message-----
> From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-owner@vger.kernel.org]
> On Behalf Of Marek Vasut
> Sent: Wednesday, April 02, 2014 6:35 PM
> To: Kishon Vijay Abraham I
> Cc: Mohit KUMAR DCG; Jingoo Han; 'Bjorn Helgaas'; linux-pci@vger.kernel.org;
> Pratyush ANAND; Zhu Richard-R65037
> Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
> 
> On Wednesday, April 02, 2014 at 07:34:15 AM, Kishon Vijay Abraham I wrote:
> > On Wednesday 02 April 2014 11:03 AM, Mohit KUMAR DCG wrote:
> > > Hello Jingoo,
> > >
> > >> -----Original Message-----
> > >> From: Jingoo Han [mailto:jg1.han@samsung.com]
> > >> Sent: Wednesday, April 02, 2014 10:53 AM
> > >> To: Mohit KUMAR DCG
> > >> Cc: 'Bjorn Helgaas'; linux-pci@vger.kernel.org; Pratyush ANAND;
> > >> 'Marek Vasut'; 'Richard Zhu'; 'Kishon Vijay Abraham I'
> > >> Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR
> > >> setting
> > >>
> > >> On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
> > >>> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
> > >>>> According to the spec, the synopsys core does not implement the
> > >>>> optional BARs such as BAR0/1. This is based on the assumption
> > >>>> that the RC host probably has registers on some other internal
> > >>>> bus and has knowledge and setup access to these registers already.
> > >>>> So, remove unnecessary RC BAR setting.
> > >>>
> > >>> - Normally BARs in RC are not used but somehow available in the
> > >>> design. One possible BAR use can be if RC has some memory
> > >>> connected to
> > >>
> > >> the BAR that needs to be accessed through link.
> > >>
> > >>> Otherwise we can ignore BARs setup here.
> > >>
> > >> Hi Mohit KUMAR DCG,
> > >>
> > >> Thank you for your feedback.
> > >>
> > >> I want to know whether or not other SoCs such as ST, Freescale, TI
> > >> support BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary RC
> > >> BAR setting code should  be removed.
> > >
> > > - We are not currently using RC's BAR0/1 in any application but no
> > > such restriction from HW as ST SoCs support BARs in HW design.
> >
> > Neither do we in DRA7xx.
> 
> I suspect that means we should keep the code to make sure the registers are
> configured correctly, no?
> 
> Richard, can you comment on MX6 please ?

 [Richard] Sorry to reply late. I'm engaged in another stuff in the past days.
i.MX6 pcie doesn't use RC's BAR0/1 in applications either.
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in the
> body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> 
Best Regards
Richard Zhu

