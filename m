Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49195 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab3KOGNz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 15 Nov 2013 01:13:55 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MWA00HBZJZ0ZS90@mailout3.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 15 Nov 2013 15:13:48 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Kishon Vijay Abraham I' <kishon@ti.com>
Cc: 'Marek Vasut' <marex@denx.de>,
	'Pratyush Anand' <pratyush.anand@gmail.com>,
	'Pratyush Anand' <pratyush.anand@st.com>,
	linux-pci@vger.kernel.org, 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Ajay KHANDELWAL' <ajay.khandelwal@st.com>,
	'Tim Harvey' <tharvey@gateworks.com>,
	'Arnd Bergmann' <arnd@arndb.de>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <52652BF1.4040507@ti.com>
 <CAHM4w1=YkiYv_N0qxQpbfqz3VHQrZ46j96x0tCvL6q-oOLXtKA@mail.gmail.com>
 <527A0112.60908@ti.com> <201311150140.22501.marex@denx.de>
 <5285B0E7.5000802@ti.com>
In-reply-to: <5285B0E7.5000802@ti.com>
Subject: Re: [QUERY] Number of address translation regions in designware
Date: Fri, 15 Nov 2013 15:13:42 +0900
Message-id: <000901cee1c9$d8ec6450$8ac52cf0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, November 15, 2013 2:28 PM, Kishon Vijay Abraham I wrote:
> On Friday 15 November 2013 06:10 AM, Marek Vasut wrote:
> > Hi Kishon,
> >
> > just curious, what's the current status of the DWC PCIe driver? How's the iATU
> > issue going? Can you please update us a little?
> 
> I was able to get it working in DRA7. Few of the dependent stuffs are not in
> mainline yet (some clock related patches, rest framework changes, PHY changes).
> Will post a RFC soon for pcie only part.

OK, I see.
If you send the RFC patch, I will review ant test your patch
as soon as possible. Thank you for your effort. :-)

Best regards,
Jingoo Han

