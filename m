Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:48241 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402Ab3LLBM5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 11 Dec 2013 20:12:57 -0500
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MXO005LN61D8P10@mailout2.samsung.com> for
 linux-pci@vger.kernel.org; Thu, 12 Dec 2013 10:12:49 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Jagan Teki' <jagannadh.teki@gmail.com>
Cc: 'Mohit Kumar' <mohit.kumar@st.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	'Pratyush Anand' <pratyush.anand@st.com>,
	'spear-devel' <spear-devel@list.st.com>,
	'Jingoo Han' <jg1.han@samsung.com>
References: <cover.1386752447.git.mohit.kumar@st.com>
 <11157a3462fcad1067bddd27dcd580bbeb2c289e.1386752447.git.mohit.kumar@st.com>
 <CAD6G_RTiswApVUz_A3V8A++tQcWaWi2rRtVCuCAFE1eWY6d0CQ@mail.gmail.com>
In-reply-to: <CAD6G_RTiswApVUz_A3V8A++tQcWaWi2rRtVCuCAFE1eWY6d0CQ@mail.gmail.com>
Subject: Re: [PATCH 07/12] pcie: designware: add dw_pcie prefix before
 cfg_read/write
Date: Thu, 12 Dec 2013 10:12:49 +0900
Message-id: <002301cef6d7$462451f0$d26cf5d0$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, December 11, 2013 8:40 PM, Jagan Teki wrote:
> On Wed, Dec 11, 2013 at 3:08 PM, Mohit Kumar <mohit.kumar@st.com> wrote:
> > From: Pratyush Anand <pratyush.anand@st.com>
> >
> > cfg_read/write function are designware pcie specific. Add dw_pcie prefix
> > to avoid collision in global name space.
> >
> > Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
> > Cc: Mohit Kumar <mohit.kumar@st.com>
> > Cc: Jingoo Han <jg1.han@samsung.com>
> > Cc: spear-devel@list.st.com
> > Cc: linux-pci@vger.kernel.org
> > ---
> >  drivers/pci/host/pci-exynos.c      |    5 +++--
> >  drivers/pci/host/pcie-designware.c |   23 ++++++++++++++---------
> >  drivers/pci/host/pcie-designware.h |    4 ++--

[....]

> Acked-by: Jagannadha Sutradharudu Teki <jagannadh.teki@gmail.com>

Please use ' Reviewed-by', instead of 'Acked-by'.
It will apply to other patches, too.

According to the ./Documentation/SubmittingPatches,

Acked-by: is often used by the maintainer of the affected code when that
maintainer neither contributed to nor forwarded the patch.

Reviewed-by:, instead, indicates that the patch has been reviewed and found
acceptable according to the Reviewer's Statement:

Best regards,
Jingoo Han

