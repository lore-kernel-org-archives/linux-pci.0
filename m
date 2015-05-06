Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36594 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750845AbbEFGrM (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 6 May 2015 02:47:12 -0400
Message-ID: <5549B87B.709@st.com>
Date: Wed, 6 May 2015 08:45:15 +0200
From: Maxime Coquelin <maxime.coquelin@st.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>,
	Gabriel FERNANDEZ <gabriel.fernandez@st.com>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Srinivas Kandagatla <srinivas.kandagatla@gmail.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	Russell King <linux@arm.linux.org.uk>,
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
	Tanmay Inamdar <tinamdar@apm.com>, <m-karicheri2@ti.com>,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Liviu Dudau <liviu.dudau@arm.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
	<linux-pci@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>
Subject: Re: [PATCH v3 5/5] MAINTAINERS: Add pci-st.c to ARCH/STI architecture
References: <1428657168-12495-1-git-send-email-gabriel.fernandez@linaro.org> <1428657168-12495-6-git-send-email-gabriel.fernandez@linaro.org> <20150505214225.GC24643@google.com>
In-Reply-To: <20150505214225.GC24643@google.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On 05/05/2015 11:42 PM, Bjorn Helgaas wrote:
> On Fri, Apr 10, 2015 at 11:12:48AM +0200, Gabriel FERNANDEZ wrote:
>> This patch adds the pci-st.c pci driver found on STMicroelectronics
>> SoC's into the STI arch section of the maintainers file.
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> I'd like an ack from the current maintainers:
>
>    ARM/STI ARCHITECTURE
>    M:      Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
>    M:      Maxime Coquelin <maxime.coquelin@st.com>
>    M:      Patrice Chotard <patrice.chotard@st.com>
>
> that they're OK with taking on this additional file.
Yes, you can add my:
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks,
Maxime


