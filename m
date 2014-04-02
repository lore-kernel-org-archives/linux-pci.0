Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:39771 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758006AbaDBKew (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 2 Apr 2014 06:34:52 -0400
From: Marek Vasut <marex@denx.de>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
Date: Wed, 2 Apr 2014 12:34:47 +0200
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	"'Bjorn Helgaas'" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"'Richard Zhu'" <r65037@freescale.com>
References: <000801cf4d95$64322ef0$2c968cd0$%han@samsung.com> <2CC2A0A4A178534D93D5159BF3BCB66189FEC4809B@EAPEX1MAIL1.st.com> <533BA157.6030004@ti.com>
In-Reply-To: <533BA157.6030004@ti.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201404021234.48134.marex@denx.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, April 02, 2014 at 07:34:15 AM, Kishon Vijay Abraham I wrote:
> On Wednesday 02 April 2014 11:03 AM, Mohit KUMAR DCG wrote:
> > Hello Jingoo,
> > 
> >> -----Original Message-----
> >> From: Jingoo Han [mailto:jg1.han@samsung.com]
> >> Sent: Wednesday, April 02, 2014 10:53 AM
> >> To: Mohit KUMAR DCG
> >> Cc: 'Bjorn Helgaas'; linux-pci@vger.kernel.org; Pratyush ANAND; 'Marek
> >> Vasut'; 'Richard Zhu'; 'Kishon Vijay Abraham I'
> >> Subject: Re: [PATCH] PCI: designware: Remove unnecessary RC BAR setting
> >> 
> >> On Wednesday, April 02, 2014 1:57 PM, Mohit KUMAR DCG wrote:
> >>> On Tuesday, April 01, 2014 4:00 PM, Jingoo Han wrote:
> >>>> According to the spec, the synopsys core does not implement the
> >>>> optional BARs such as BAR0/1. This is based on the assumption that
> >>>> the RC host probably has registers on some other internal bus and
> >>>> has knowledge and setup access to these registers already.
> >>>> So, remove unnecessary RC BAR setting.
> >>> 
> >>> - Normally BARs in RC are not used but somehow available in the
> >>> design. One possible BAR use can be if RC has some memory connected to
> >> 
> >> the BAR that needs to be accessed through link.
> >> 
> >>> Otherwise we can ignore BARs setup here.
> >> 
> >> Hi Mohit KUMAR DCG,
> >> 
> >> Thank you for your feedback.
> >> 
> >> I want to know whether or not other SoCs such as ST, Freescale, TI
> >> support BAR0/BAR1. If no SoC supports BAR0/BAR1, the unnecessary RC BAR
> >> setting code should  be removed.
> > 
> > - We are not currently using RC's BAR0/1 in any application but no such
> > restriction from HW as ST SoCs support BARs in HW design.
> 
> Neither do we in DRA7xx.

I suspect that means we should keep the code to make sure the registers are 
configured correctly, no?

Richard, can you comment on MX6 please ?

Best regards,
Marek Vasut
