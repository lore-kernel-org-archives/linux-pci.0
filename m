Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f43.google.com ([209.85.218.43]:43940 "EHLO
	mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbaGUATP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 20 Jul 2014 20:19:15 -0400
Received: by mail-oi0-f43.google.com with SMTP id u20so3013494oif.30
        for <linux-pci@vger.kernel.org>; Sun, 20 Jul 2014 17:19:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140720192649.GA30124@quad.lixom.net>
References: <76576b662613369d0c71db30ceed4ed5ae1343d2.1405857442.git.viresh.kumar@linaro.org>
	<20140720192649.GA30124@quad.lixom.net>
Date: Mon, 21 Jul 2014 05:42:36 +0530
Message-ID: <CAKohpokOJLKOwB_rKz0W-1T0nYX7-2_8nm3wQr6khR55x4gqrA@mail.gmail.com>
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

On 21 July 2014 00:56, Olof Johansson <olof@lixom.net> wrote:
> Please use 12 significant digits, since 7 might not be sufficient later
> on in time. I've fixed it up here.

I surely didn't knew this and haven't seen other maintainers do this
as well.. And thought, whatever "git log --online" gives would be
enough.

Will take care of this in future.
