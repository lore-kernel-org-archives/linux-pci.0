Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35080 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752026AbbCQHtS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Mar 2015 03:49:18 -0400
Received: by igcau2 with SMTP id au2so26792195igc.0
        for <linux-pci@vger.kernel.org>; Tue, 17 Mar 2015 00:49:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <550718B4.5090406@linaro.org>
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org>
	<1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
	<550718B4.5090406@linaro.org>
Date: Tue, 17 Mar 2015 08:49:17 +0100
Message-ID: <CAG374jCD05qXiMfCZOPFvaxYLgU75CR3Kiryxxxz1CzmgVOsjg@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI: designware: Add disable IO support
From: Gabriel Fernandez <gabriel.fernandez@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Maxime Coquelin <maxime.coquelin@st.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Fabrice Gasnier <fabrice.gasnier@st.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Joe Perches <joe@perches.com>, Tejun Heo <tj@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Minghuan Lian <Minghuan.Lian@freescale.com>,
	Tanmay Inamdar <tinamdar@apm.com>,
	Muralidharan Karicheri <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@stlinux.com" <kernel@stlinux.com>,
	linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Srinivas,

Yes, you are right.

Nevertheless i'll try the Kumar and Arnd 's request to not use DT to do that.

BR

Gabriel

On 16 March 2015 at 18:53, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 16/03/15 14:20, Gabriel FERNANDEZ wrote:
>>
>>   - bus-range: PCI bus numbers covered (it is recommended for new
>> devicetrees to
>>     specify this property, to keep backwards compatibility a range of
>> 0x00-0xff
>>     is assumed if not present)
>> +- disable_io_support: set this property for PCIe host controller without
>> IO
>> +  port access
>
> Shouldn't dt properties use hyphens rather than under scores ?
