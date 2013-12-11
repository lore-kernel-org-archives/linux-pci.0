Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:48848 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751000Ab3LKWs5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 17:48:57 -0500
Received: from epcpsbgr5.samsung.com
 (u145.gpu120.samsung.co.kr [203.254.230.145])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXN00ILEZDK2930@mailout4.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 07:48:56 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Mohit KUMAR DCG' <Mohit.KUMAR@st.com>,
	'Arnd Bergmann' <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org,
	'Jagan Teki' <jagannadh.teki@gmail.com>,
	linux-pci@vger.kernel.org, 'spear-devel' <spear-devel@list.st.com>,
	'Pratyush ANAND' <pratyush.anand@st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <CAD6G_RTrETj9p+YNPjRMEFsO7Ggf3LfnuaPOSwO2brUcusNUJw@mail.gmail.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F6311@EAPEX1MAIL1.st.com>
 <201312112231.36039.arnd@arndb.de>
In-reply-to: <201312112231.36039.arnd@arndb.de>
Subject: Re: [PATCH 06/12] pcie: designware: Move register definition to the
 header file
Date: Thu, 12 Dec 2013 07:48:56 +0900
Message-id: <001001cef6c3$2c5a3cd0$850eb670$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, December 12, 2013 6:32 AM, Arnd Bergmann wrote:
> On Wednesday 11 December 2013, Mohit KUMAR DCG wrote:
> > >
> > > Seems like none were using these headers except pcie-designware.c - if ie
> > > the case better to place it same place as before.
> >
> > - We have include these and used few like ' PCIE_LINK_WIDTH_SPEED_CONTROL '  for SPEAr13xx platform,
> > so move these to the separate header  file.
> 
> I think it's better not to touch any of the registers from a platform-specific
> driver. Better make a high-level function in the common code that the
> spear driver can call to change this register.

I also agree with Arnd's opinion.

Best regards,
Jingoo Han

