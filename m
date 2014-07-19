Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:57025 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbaGSOj2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 19 Jul 2014 10:39:28 -0400
Received: by mail-oa0-f52.google.com with SMTP id o6so5067729oag.39
        for <linux-pci@vger.kernel.org>; Sat, 19 Jul 2014 07:39:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140719053359.GF20064@quad.lixom.net>
References: <CAKohpo=T3taZx8e39tenCRBNxCUr=7H2xG7Ng=e+YQXuuY9u8Q@mail.gmail.com>
	<20140719045804.GC20064@quad.lixom.net>
	<20140719053359.GF20064@quad.lixom.net>
Date: Sat, 19 Jul 2014 20:09:28 +0530
Message-ID: <CAKohpok0-RQ2L4LZoEuZ4UvN_1FkffUukDk4aMUF56ybjMSBwQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: SPEAr13xx PCIe updates for v3.17
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Olof Johansson <olof@lixom.net>
Cc: "arm@kernel.org" <arm@kernel.org>,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Pratyush ANAND <pratyush.anand@st.com>,
	"'Bjorn Helgaas' (bhelgaas@google.com)" <bhelgaas@google.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Mark Nicholson <mark@nicholnet.com>,
	Mohit KUMAR DCG <Mohit.KUMAR@st.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Arnd Bergmann <arnd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 19 July 2014 11:03, Olof Johansson <olof@lixom.net> wrote:
> Also, there's a conflict with one of the fixes that were sent earlier.
> It'd been nice to keep this based on the -rc that had that fix to avoid the
> conflict. Please check the contents in our for-next.

I wasn't aware of any such issues, otherwise I would have rebased
it over latest rc.

I kept it on rc3 as I thought people might want to look at diffs
between v8, 9 and 10 and v8 was rebased over rc3. So never changed
it.
