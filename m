Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:52442 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbbIMRrj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sun, 13 Sep 2015 13:47:39 -0400
MIME-Version: 1.0
Message-ID: <trinity-0d083bb7-77f6-4541-8f7e-b54ee6eb459d-1442166454144@3capp-webde-bs41>
From: "Roland Weber" <r-o-l@web.de>
To: linux-usb@vger.kernel.org
Cc: "Mathias Nyman" <mathias.nyman@intel.com>,
	"Bjorn Helgaas" <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PROBLEM: lsusb -v freezes kernel on Acer ES1-111M
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Sep 2015 19:47:34 +0200
In-Reply-To: <trinity-7f2ca9f3-c478-4d8d-9bb9-7656c1fc6333-1442159105440@3capp-webde-bs07>
References: <Pine.LNX.4.44L0.1509121341080.13622-100000@netrider.rowland.org>,
 <trinity-7f2ca9f3-c478-4d8d-9bb9-7656c1fc6333-1442159105440@3capp-webde-bs07>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi all,

I wrote:
> I cannot yet tell whether the difference between freeze and non-freeze
> is due to code changes, or because I used a different kernel config.
> (It brings down compilation times from 3h to 2h.)
> 
> So next I'll compile 3.17.8 with my config.

Actually, it made more sense to try other precompiled kernels.
I can freeze the precompiled 3.17.0 with unbind/bind/unbind,
but not the one I compiled myself. I'm currently compiling
3.17.0 with the exact config of the precompiled kernel, to
rule out differences in the build environment as the cause.

Assuming that this kernel does freeze, I will start to 'bisect' the
differences in the kernel configurations, based on the assumption
that it might give us a clue about where the problem comes from.
I expect this to take several days... please stop me if you've got
a better lead.

cheers,
  Roland
