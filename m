Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:44113 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753656AbaBTENc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 19 Feb 2014 23:13:32 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Thu, 20 Feb 2014 12:13:17 +0800
Subject: RE: [PATCH 1/1] Designware:RC BARs setup related fix
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD40D6FE@EAPEX1MAIL1.st.com>
References: <1392811475-17744-1-git-send-email-mohit.kumar@st.com>
 <20140219215359.GA19233@google.com>
In-Reply-To: <20140219215359.GA19233@google.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

> -----Original Message-----
> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
> Sent: Thursday, February 20, 2014 3:24 AM
> To: Mohit KUMAR DCG
> Cc: jg1.han@samsung.com; Pratyush ANAND; Arnd Bergmann; spear-devel;
> linux-pci@vger.kernel.org
> Subject: Re: [PATCH 1/1] Designware:RC BARs setup related fix
> 
> On Wed, Feb 19, 2014 at 05:34:35PM +0530, Mohit Kumar wrote:
> > The Synopsys  PCIe core provides one pair of 32-bit BARs (BAR 0 and BAR
> 1).
> > The BARs can  be configured as follows:
> >
> > - One 64-bit BAR: BARs 0 and 1 are combined to form a single 64-bit BAR.
> > - Two 32-bit BARs: BARs 0 and 1 are two independent 32-bit BARs
> >
> > This patch corrects 64-bit, non-prefetchable memory BAR configuration
> > implemented in dw driver.
> >
> > Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: spear-devel@list.st.com
> > Cc: linux-pci@vger.kernel.org
> 
> Applied to pci/host-designware for v3.15, thanks!

- thanks

> 
> I update the summary to the following; let me know if it's not accurate:
> 
>   PCI: designware: Fix RC BAR to be single 64-bit non-prefetchable memory
> BAR

- yes, it looks better

Thanks,
Mohit
