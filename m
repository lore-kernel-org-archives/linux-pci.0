Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vc0-f179.google.com ([209.85.220.179]:43374 "EHLO
	mail-vc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaGUCP1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 22:15:27 -0400
Received: by mail-vc0-f179.google.com with SMTP id hq11so9451528vcb.24
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 19:15:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
 <20140720192649.GA30124@quad.lixom.net> <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
From: Rob Herring <robherring2@gmail.com>
Date: Sun, 20 Jul 2014 21:15:06 -0500
Message-ID: <CAL_Jsq+dSoYp83wnXXHnfQ__GkQvoNcijmktvwqvcpazsQGioQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: spear: Fix Section mismatch compilation warning
 for probe()
To: Viresh Kumar <viresh.kumar@linaro.org>
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

On Sun, Jul 20, 2014 at 7:12 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 21 July 2014 00:56, Olof Johansson <olof@lixom.net> wrote:
>> Please use 12 significant digits, since 7 might not be sufficient later
>> on in time. I've fixed it up here.
>
> I surely didn't knew this and haven't seen other maintainers do this
> as well.. And thought, whatever "git log --online" gives would be
> enough.

The Fixes tag is new and the format is documented in SubmittingPatches
IIRC. I believe it is also supposed to be quotes rather than
parentheses around the commit message if we want to be really picky.

Rob
