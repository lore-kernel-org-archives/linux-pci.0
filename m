Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:45660 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3GHFNV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 8 Jul 2013 01:13:21 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Pratyush Anand' <pratyush.anand@st.com>,
	'Mohit KUMAR' <Mohit.KUMAR@st.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	'Kukjin Kim' <kgene.kim@samsung.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Sean Cross' <xobs@kosagi.com>,
	'SRIKANTH TUMKUR SHIVANAND' <ts.srikanth@samsung.com>,
	linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>
References: <000201ce7959$bf0fb150$3d2f13f0$@samsung.com>
 <51D6A370.7060604@st.com> <002801ce7b98$e1520f60$a3f62e20$@samsung.com>
In-reply-to: <002801ce7b98$e1520f60$a3f62e20$@samsung.com>
Subject: Re: [PATCH] pci: exynos: split into two parts such as Synopsys part
 and Exynos part
Date: Mon, 08 Jul 2013 14:13:12 +0900
Message-id: <002901ce7b99$d7e42930$87ac7b90$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Monday, July 08, 2013 2:06 PM, Jingoo Han wrote:
> On Friday, July 05, 2013 7:44 PM, Pratyush Anand wrote:
> > On 7/5/2013 1:59 PM, Jingoo Han wrote:
> > > Exynos PCIe IP consists of Synopsys specific part and Exynos
> > > specific part. Only core block is a Synopsys designware part;
> > > other parts are Exynos specific.
> > > Also, the Synopsys designware part can be shared with other
> > > platforms; thus, it can be split two parts such as Synopsys
> > > designware part and Exynos specific part.
> > >
> >
> > A quick and nice job :)
> > Just few minor comments.
> 
> Thank you.
> Without your comment, it could be done. :)

Oops, it is a typo.
Without your comment, it could 'NOT' be done. :)

Thank you for your comment.
It is very helpful.

Best regards,
Jingoo Han


