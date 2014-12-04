Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:41558 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbaLDWYh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 17:24:37 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so15514909igi.6
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 14:24:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20141204163741.GD3168@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
	<CAE9FiQXqqg-KYi3aEVvCm=hfjN3mx_7J8uQ61hVJFVLNe+U=Zg@mail.gmail.com>
	<20141204163741.GD3168@google.com>
Date: Thu, 4 Dec 2014 14:24:36 -0800
Message-ID: <CAE9FiQXe-jedCr-DUat3Ujay1Q=jUX9B_qLJRfhia-QVB_RW4w@mail.gmail.com>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alexey Voronkov <zermond@gmail.com>,
	David Airlie <airlied@linux.ie>,
	Saifi Khan <saifi.khan@datasynergy.org>,
	Alex Deucher <alexdeucher@gmail.com>,
	=?UTF-8?Q?Marek_Kord=C3=ADk?= <kordikmarek@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 4, 2014 at 8:37 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> pci=realloc should workaround the problem, as it would take control of
>> the bridge mmio BAR, and allocate more range for mmio pref under it.
>
> I don't think pci=realloc is the answer because
>
>   1) It's a poor user experience.  We should be able to handle this
>      automatically, without asking the user to do anything.

we can detect that when bridge support 64bit mmio pref, and reject
child device pref that only
support mmio pref non-b64bit.

>
>   2) It puts the radeon framebuffer in the non-prefetchable window, and we
>      should be able to keep it in the prefetchable window.

clear bridge 64bit flags if all children does not support that?

even that slot supports hotplug.

Yinghai
