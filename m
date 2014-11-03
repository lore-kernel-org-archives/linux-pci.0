Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:59756 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaKCKuC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 3 Nov 2014 05:50:02 -0500
Date: Mon, 3 Nov 2014 10:49:50 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Mohit Kumar <mohit.kumar@st.com>
Subject: Re: [RFC PATCH 2/2] arm: pcibios: move to generic PCI domains
Message-ID: <20141103104950.GA30519@e102568-lin.cambridge.arm.com>
References: <1414669490-1217-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1414669490-1217-3-git-send-email-lorenzo.pieralisi@arm.com>
 <5456FB07.40002@huawei.com>
MIME-Version: 1.0
In-Reply-To: <5456FB07.40002@huawei.com>
Content-Type: text/plain; charset=WINDOWS-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 03, 2014 at 03:48:23AM +0000, Yijing Wang wrote:
> On 2014/10/30 19:44, Lorenzo Pieralisi wrote:

[...]

> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index 7fc4278..f19f627 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -44,9 +44,6 @@ struct hw_pci {
> >   * Per-controller structure
> >   */
> 
> domain in hw_pci also should be clean up, right ?
> 
> 
> struct hw_pci {
> #ifdef CONFIG_PCI_DOMAINS
> 	int		domain;
> #endif
> 	struct pci_ops	*ops;
> 	int		nr_controllers;
> 	void		**private_data;

Yes, thanks for spotting that.

Lorenzo

