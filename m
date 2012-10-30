Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog120.obsmtp.com ([207.126.144.149]:55615 "EHLO
	eu1sys200aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753769Ab2J3DZk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 29 Oct 2012 23:25:40 -0400
Message-ID: <508F48A6.8070108@st.com>
Date: Tue, 30 Oct 2012 08:55:26 +0530
From: Pratyush Anand <pratyush.anand@st.com>
MIME-Version: 1.0
To: viresh kumar <viresh.kumar@linaro.org>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Subject: Re: [PATCH 13/15] SPEAr13xx: update kconfig for PCIe selection
References: <cover.1351492562.git.pratyush.anand@st.com> <d13ec089ce3a327746ddf20674a0c1f5d22acb88.1351492562.git.pratyush.anand@st.com> <CAOh2x==OzbwA+4ArPG+yJuZHaQ-v_2VS8YNuFYH36ZqrkZLn3A@mail.gmail.com>
In-Reply-To: <CAOh2x==OzbwA+4ArPG+yJuZHaQ-v_2VS8YNuFYH36ZqrkZLn3A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/29/2012 7:03 PM, viresh kumar wrote:
>> >  endmenu
>> >+
>> >+config SPEAR13XX_PCI
>> >+       bool "PCI Express support"
> cant this be module
>

No.

