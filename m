Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:34519 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755951AbbCPRyB (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2015 13:54:01 -0400
Received: by wibg7 with SMTP id g7so34232512wib.1
        for <linux-pci@vger.kernel.org>; Mon, 16 Mar 2015 10:54:00 -0700 (PDT)
Message-ID: <550718B4.5090406@linaro.org>
Date: Mon, 16 Mar 2015 17:53:56 +0000
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
To: Gabriel FERNANDEZ <gabriel.fernandez@st.com>,
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
	Tanmay Inamdar <tinamdar@apm.com>, m-karicheri2@ti.com,
	Sachin Kamat <sachin.kamat@samsung.com>,
	Andrew Lunn <andrew@lunn.ch>, Liviu Dudau <liviu.dudau@arm.com>
CC: devicetree@vger.kernel.org, kernel@stlinux.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gabriel Fernandez <gabriel.fernandez@linaro.org>,
	Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 4/5] PCI: designware: Add disable IO support
References: <1426515635-9466-1-git-send-email-gabriel.fernandez@linaro.org> <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
In-Reply-To: <1426515635-9466-5-git-send-email-gabriel.fernandez@linaro.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/03/15 14:20, Gabriel FERNANDEZ wrote:
>   - bus-range: PCI bus numbers covered (it is recommended for new devicetrees to
>     specify this property, to keep backwards compatibility a range of 0x00-0xff
>     is assumed if not present)
> +- disable_io_support: set this property for PCIe host controller without IO
> +  port access
Shouldn't dt properties use hyphens rather than under scores ?
