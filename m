Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:46658 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbaBTT0o (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Feb 2014 14:26:44 -0500
Received: by mail-ie0-f181.google.com with SMTP id rl12so1577555iec.40
        for <linux-pci@vger.kernel.org>; Thu, 20 Feb 2014 11:26:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2CC2A0A4A178534D93D5159BF3BCB66189FD40D78C@EAPEX1MAIL1.st.com>
References: <1392811475-17744-1-git-send-email-mohit.kumar@st.com>
 <20140219215359.GA19233@google.com> <2CC2A0A4A178534D93D5159BF3BCB66189FD40D6FE@EAPEX1MAIL1.st.com>
 <2CC2A0A4A178534D93D5159BF3BCB66189FD40D78C@EAPEX1MAIL1.st.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 20 Feb 2014 12:26:23 -0700
Message-ID: <CAErSpo7HqBAwakxEOSJaL9eYGdGKZzsWue8K7ux3SKf1+gzZLA@mail.gmail.com>
Subject: Re: [PATCH 1/1] Designware:RC BARs setup related fix
To: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
Cc: "jg1.han@samsung.com" <jg1.han@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	Arnd Bergmann <arnd@arndb.de>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Feb 19, 2014 at 11:45 PM, Mohit KUMAR DCG <Mohit.KUMAR@st.com> wrote:
> +cc stable@vger.kerne.org

I assume you meant that you want this patch to go to the stable
kernels?  I added the appropriate tag to the patch:

  Cc: stable@vger.kernel.org  # v3.12+

This won't apply cleanly to v3.11 because there were unrelated changes
to these lines.  If you want it in v3.11, please send the appropriate
patch to stable@vger.kernel.org.

Bjorn

>> -----Original Message-----
>> From: Mohit KUMAR [mailto:mohit.kumar@st.com]
>> Sent: Thursday, February 20, 2014 9:43 AM
>> To: Bjorn Helgaas
>> Cc: jg1.han@samsung.com; Pratyush ANAND; Arnd Bergmann; spear-devel;
>> linux-pci@vger.kernel.org
>> Subject: RE: [PATCH 1/1] Designware:RC BARs setup related fix
>>
>> Hello Bjorn,
>>
>> > -----Original Message-----
>> > From: Bjorn Helgaas [mailto:bhelgaas@google.com]
>> > Sent: Thursday, February 20, 2014 3:24 AM
>> > To: Mohit KUMAR DCG
>> > Cc: jg1.han@samsung.com; Pratyush ANAND; Arnd Bergmann; spear-
>> devel;
>> > linux-pci@vger.kernel.org
>> > Subject: Re: [PATCH 1/1] Designware:RC BARs setup related fix
>> >
>> > On Wed, Feb 19, 2014 at 05:34:35PM +0530, Mohit Kumar wrote:
>> > > The Synopsys  PCIe core provides one pair of 32-bit BARs (BAR 0 and
>> > > BAR
>> > 1).
>> > > The BARs can  be configured as follows:
>> > >
>> > > - One 64-bit BAR: BARs 0 and 1 are combined to form a single 64-bit BAR.
>> > > - Two 32-bit BARs: BARs 0 and 1 are two independent 32-bit BARs
>> > >
>> > > This patch corrects 64-bit, non-prefetchable memory BAR
>> > > configuration implemented in dw driver.
>> > >
>> > > Signed-off-by: Mohit Kumar <mohit.kumar@st.com>
>> > > Cc: Pratyush Anand <pratyush.anand@st.com>
>> > > Cc: Jingoo Han <jg1.han@samsung.com>
>> > > Cc: Arnd Bergmann <arnd@arndb.de>
>> > > Cc: spear-devel@list.st.com
>> > > Cc: linux-pci@vger.kernel.org
>> >
>> > Applied to pci/host-designware for v3.15, thanks!
>>
>> - thanks
>>
>> >
>> > I update the summary to the following; let me know if it's not accurate:
>> >
>> >   PCI: designware: Fix RC BAR to be single 64-bit non-prefetchable
>> > memory BAR
>>
>> - yes, it looks better
>>
>> Thanks,
>> Mohit
