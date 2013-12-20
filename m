Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:33533 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700Ab3LTQJl (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 20 Dec 2013 11:09:41 -0500
Received: by mail-ie0-f170.google.com with SMTP id qd12so3373979ieb.29
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2013 08:09:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <003201cefd2d$0c7cbc60$25763520$%han@samsung.com>
References: <20131212182903.409515738@gmail.com> <005b01cef9f9$52022bd0$f6068370$%han@samsung.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189F95F6A22@EAPEX1MAIL1.st.com> <003201cefd2d$0c7cbc60$25763520$%han@samsung.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 20 Dec 2013 09:09:20 -0700
Message-ID: <CAErSpo5Kjq4=nTP1DaCjiPSPqAKYyFUBNB6r9tfLm6aF_U-qNA@mail.gmail.com>
Subject: Re: [PATCH] pci: designware: fix missing msi irqs
To: Jingoo Han <jg1.han@samsung.com>
Cc: Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	Harro Haan <hrhaan@gmail.com>, Marek Vasut <marex@denx.de>,
	Richard Zhu <hong-xing.zhu@freescale.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Tim Harvey <tharvey@gateworks.com>,
	Juergen Beisert <jbe@pengutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Siva Reddy Kallam <siva.kallam@samsung.com>,
	Srikanth T Shivanand <ts.srikanth@samsung.com>,
	Sean Cross <xobs@kosagi.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-arm <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 19, 2013 at 7:41 PM, Jingoo Han <jg1.han@samsung.com> wrote:
> On Monday, December 16, 2013 3:49 PM, Mohit KUMAR DCG wrote:
>> On Monday, December 16, 2013 6:24 AM, Jingoo Han wrote:
>> > On Friday, December 13, 2013 3:29 AM, Harro Haan wrote:
>> > >
>> > > The interrupts were cleared after the irq handler was called.
>> > > This means that new interrupts that occur after the handler handled
>> > > the previous irq but before the interrupt is cleared will be missed.
>> > >
>> > > Signed-off-by: Harro Haan <hrhaan@gmail.com>
>> > > Cc: Mohit Kumar <mohit.kumar@st.com>
>> > > Cc: Jingoo Han <jg1.han@samsung.com>
>> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
>> > > Cc: Marek Vasut <marex@denx.de>
>> > > Cc: Richard Zhu <hong-xing.zhu@freescale.com>
>> > > Cc: Shawn Guo <shawn.guo@linaro.org>
>> > > Cc: Pratyush Anand <pratyush.anand@st.com>
>> > > Cc: Tim Harvey <tharvey@gateworks.com>
>> > > Cc: Juergen Beisert <jbe@pengutronix.de>
>> > > Cc: Arnd Bergmann <arnd@arndb.de>
>> > > Cc: Siva Reddy Kallam <siva.kallam@samsung.com>
>> > > Cc: Srikanth T Shivanand <ts.srikanth@samsung.com>
>> > > Cc: Sean Cross <xobs@kosagi.com>
>> > > Cc: linux-pci@vger.kernel.org
>> > > Cc: linux-arm-kernel@lists.infradead.org
>> >
>> > Acked-by: Jingoo Han <jg1.han@samsung.com>
>> >
>> > I was not able to reproduce the problem, however it looks good. Also, there
>> > is no side effect on Exynos platform.
>> >
>> > Mohit,
>> > If you have some comments, please let us know.
>>
>> - Quickly tested on SPEAr1310, working fine without any side effect. So is,
>> Acked-by: Mohit Kumar <mohit.kumar@st.com>
>
> Hi Bjorn Helgaas,
>
> Would you apply this patch to your 'pci/host-designware' branch
> with the following Tested-by and Acked-by?
>
> Tested-by: Marek Vasut <marex@denx.de>
> Tested-by:  Matthias Mann <m.mann@arkona-technologies.de>
> Acked-by: Jingoo Han <jg1.han@samsung.com>
> Acked-by: Mohit Kumar <mohit.kumar@st.com>

Applied to pci/host-designware for v3.14, thanks for the reminder!

Bjorn
