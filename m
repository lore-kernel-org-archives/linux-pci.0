Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:52339 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750844AbaGNFhi (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jul 2014 01:37:38 -0400
Received: by mail-oa0-f46.google.com with SMTP id m1so3694089oag.5
        for <linux-pci@vger.kernel.org>; Sun, 13 Jul 2014 22:37:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
	<d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
	<53BE926A.2070005@ti.com>
	<CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
Date: Mon, 14 Jul 2014 11:07:37 +0530
Message-ID: <CAKohpomKjOZspU0CKuDW5kckoUqo3X-LxF5v5GGkuVMHuhi8mg@mail.gmail.com>
Subject: Re: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Arnd Bergmann <arnd@linaro.org>, "olof@lixom.net" <olof@lixom.net>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Nicholson <mark@nicholnet.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10 July 2014 19:00, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>  drivers/phy/phy-spear1310-miphy.c                  | 274 +++++++++++++++++++
>>>  drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++++++++
>>
>> Please send separate patche for each driver.
>
> These were both around SPEAr and were on the same lines.
> So sending these in a single patch shouldn't be a big issue I believe.

For completeness I have still kept them together as they have a single
bindings file now. And breaking it out *may* affect readability later.
