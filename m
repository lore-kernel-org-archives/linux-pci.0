Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:46054 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbaGUE2F (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jul 2014 00:28:05 -0400
Received: by mail-oa0-f49.google.com with SMTP id eb12so6521938oac.22
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 21:28:03 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
	<20140720192649.GA30124@quad.lixom.net>
	<CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
	<CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
Date: Mon, 21 Jul 2014 09:58:03 +0530
Message-ID: <CAKohponUGvs818F-Ch4kFrRPv+vwXkuZotiVjQD9To0LuyNcZg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rob Herring <robherring2@gmail.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Olof Johansson <olof@lixom.net>,
	Pratyush Anand <pratyush.anand@st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	spear-devel <spear-devel@list.st.com>,
	"arm@kernel.org" <arm@kernel.org>,
	Mohit KUMAR <mohit.kumar@st.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 21 July 2014 07:45, Rob Herring <robherring2@gmail.com> wrote:
> The Fixes tag is new and the format is documented in SubmittingPatches

Yeah, just saw that for the first time :)

> IIRC. I believe it is also supposed to be quotes rather than
> parentheses around the commit message if we want to be really picky.

Actually both: ("$subject")

I never saw the doc and picked how it was done by Rafael for cpufreq stuff.
Though he was correctly adding 12 digits of the sha key, but the quotes
were missing :)

I will take care of this now.

--
viresh
