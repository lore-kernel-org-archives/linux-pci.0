Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:39463 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaLDReQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 4 Dec 2014 12:34:16 -0500
Received: by mail-pd0-f181.google.com with SMTP id v10so12608241pde.26
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2014 09:34:16 -0800 (PST)
Date: Thu, 4 Dec 2014 10:34:11 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	zermond@gmail.com, David Airlie <airlied@linux.ie>,
	saifi.khan@datasynergy.org, Alex Deucher <alexdeucher@gmail.com>,
	kordikmarek@gmail.com, Guo Chao <yan@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Regression: bug 85491: radeon 0000:01:00.0: Fatal error during
 GPU init
Message-ID: <20141204173411.GA5949@google.com>
References: <CAErSpo6UvY10MNidAOFf4Fptv+wL-NsX6JMaU8OvSP6ywWEebQ@mail.gmail.com>
 <CAErSpo63uZeo1feoPjjXpdH43nsbcWh63kpBmxCnckPd0t9yrg@mail.gmail.com>
 <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQWV-rKdvSeV-ivME-64QtzCX2Te5DfOVtzr0an=6eOCMA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Dec 03, 2014 at 05:44:26PM -0800, Yinghai Lu wrote:
> On Wed, Dec 3, 2014 at 4:51 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> > I think another way to fix the bug 74151 problem would have been to
> > put the ROMs in the non-prefetchable window and the 64-bit BARs in the
> > 64-bit prefetchable window.
> 
> I thought we did that way already.

Can you point me to the code that does this?  I don't see anything in
pbus_size_mem() that treats ROMs differently.

I'm considering reverting 5b28541552ef (assuming that would fix this radeon
regression) because I think the radeon problem is worse than the 74151
problem and I think we can solve 74151 in a different way.

Guo, Ben, this would affect you!  It's too late to revert 5b28541552ef for
v3.18, but we really need to work on this for v3.19.

FOr 85491 (the radeon problem), we might be able to work around it by
fixing the bridge window, but I'm not sure we could even get that done
before v3.18.  I'll work on that today.

Bjorn
