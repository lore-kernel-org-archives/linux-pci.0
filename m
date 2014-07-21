Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34181 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbaGUA1u (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 20:27:50 -0400
Received: by mail-oi0-f44.google.com with SMTP id x69so2996144oia.17
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 17:27:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOesGMi0HgL14zMqALvqT_cGMr13mGSN0O493eLmydt8Dscqug@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
	<20140720192649.GA30124@quad.lixom.net>
	<CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
	<CAOesGMi0HgL14zMqALvqT_cGMr13mGSN0O493eLmydt8Dscqug@mail.gmail.com>
Date: Mon, 21 Jul 2014 05:57:49 +0530
Message-ID: <CAKohpon8mGbZ+jEPLmpKeUrxXBfXaXJAAemi8j-jhiHVJbwxRw@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Olof Johansson <olof@lixom.net>
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

On 21 July 2014 05:51, Olof Johansson <olof@lixom.net> wrote:
> Oh, sorry, I got distracted by my kid waking up so the email was a bit short. :)

I can understand, mine is 14 months :)

> The easiest way of doing it is to switch to 12 by default. In your .gitconfig:
>
> [core]
>         abbrev = 12

Oh, that will be extremely useful. Thanks.
