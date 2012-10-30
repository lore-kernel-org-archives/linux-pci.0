Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65284 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753027Ab2J3Frk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 30 Oct 2012 01:47:40 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so7726705iea.19
        for <linux-pci@vger.kernel.org>; Mon, 29 Oct 2012 22:47:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <508F4863.2010605@st.com>
References: <cover.1351492562.git.pratyush.anand@st.com>
	<91c2505d23f161ce535b220dea497e2c3abfd7f6.1351492562.git.pratyush.anand@st.com>
	<CAOh2x=ndvJF6qFgXOOQOJfAjFh93vosBrYN4FbvnDK0SW0CcXA@mail.gmail.com>
	<508F4863.2010605@st.com>
Date: Tue, 30 Oct 2012 11:17:39 +0530
Message-ID: <CAKohpo=JoZHCeOFTjoF+V0sSz7uJK2onUQqiJ=JhumSUUOVZOg@mail.gmail.com>
Subject: Re: [PATCH 10/15] SPEAr13xx: DTS: Add auxiliary data for PCIe host
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pratyush Anand <pratyush.anand@st.com>
Cc: "arnd@arndb.de" <arnd@arndb.de>,
	Shiraz HASHIM <shiraz.hashim@st.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"olof@lixom.net" <olof@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 30 October 2012 08:54, Pratyush Anand <pratyush.anand@st.com> wrote:
>> What do you mean by auxiliary data in subject?
>
> It used to be plat data earlier, which is being passed from DT now.

Yes. But how did you conclude that it should be called auxiliary data?

I would change subject of this patch to:
ARM: SPEAr13xx: Pass configuration information of PCIe via DT

But i believe you wouldn't need any of above messages and the new message
will also add basic DT support for PCIe.

--
viresh
