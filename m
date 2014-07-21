Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:36598 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaGUAVa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 20:21:30 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so9550746vcb.10
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 17:21:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
	<20140720192649.GA30124@quad.lixom.net>
	<CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
Date: Sun, 20 Jul 2014 17:21:29 -0700
Message-ID: <CAOesGMi0HgL14zMqALvqT_cGMr13mGSN0O493eLmydt8Dscqug@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
From: Olof Johansson <olof@lixom.net>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@linaro.org>, "arm@kernel.org" <arm@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	spear-devel <spear-devel@list.st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	Pratyush Anand <pratyush.anand@st.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 20, 2014 at 5:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21 July 2014 00:56, Olof Johansson <olof@lixom.net> wrote:
>> Please use 12 significant digits, since 7 might not be sufficient later
>> on in time. I've fixed it up here.
>
> I surely didn't knew this and haven't seen other maintainers do this
> as well.. And thought, whatever "git log --online" gives would be
> enough.
>
> Will take care of this in future.

Oh, sorry, I got distracted by my kid waking up so the email was a bit short. :)

The easiest way of doing it is to switch to 12 by default. In your .gitconfig:

[core]
        abbrev = 12


-Olof
