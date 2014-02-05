Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:64002 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750994AbaBETmN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 5 Feb 2014 14:42:13 -0500
Received: by mail-lb0-f172.google.com with SMTP id c11so710242lbj.31
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2014 11:42:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140205192733.GG25695@obsidianresearch.com>
References: <1391532784-1953-1-git-send-email-will.deacon@arm.com>
 <1391532784-1953-3-git-send-email-will.deacon@arm.com> <3460536.Sh23gjDa6X@wuerfel>
 <20140205190947.GA22297@mudshark.cambridge.arm.com> <20140205192733.GG25695@obsidianresearch.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 5 Feb 2014 19:41:47 +0000
Message-ID: <CAFEAcA9bhWK+pSy8wVLtNPyHtBCnudLi7pMhNny=ZfgNLty87Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: ARM: add support for virtual PCI host controller
To: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Cc: Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Liviu Dudau <Liviu.Dudau@arm.com>,
	"mohit.kumar@st.com" <mohit.kumar@st.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 5 February 2014 19:27, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> I can't think of a reason to support alternate MMIO layouts if
> kvmtool is the only user and can be changed.

I expect we'll get a QEMU implementation too at some point,
but we should be able to just make that match whatever you
decide is the correct layout and behaviour.

The only constraint QEMU has which kvmtool doesn't is that
we care about not randomly shuffling things around between
QEMU versions, so whatever we pick we're more or less
stuck with. So a layout which leaves scope for "supports
PCI now, may do PCI-e later, MSI after that" would be good.
(My PCI knowledge is very piecemeal, I hope that makes sense...)

thanks
-- PMM
