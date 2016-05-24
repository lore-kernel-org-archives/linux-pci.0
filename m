Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:32926 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbcEXKvp (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2016 06:51:45 -0400
Date: Tue, 24 May 2016 12:55:06 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Amir Levy <amir.jer.levy@intel.com>
Cc: andreas.noever@gmail.com, gregkh@linuxfoundation.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	michael.jamet@intel.com, dan.alloun@intel.com,
	mika.westerberg@intel.com, kai.svahn@intel.com,
	andriy.shevchenko@intel.com, tomas.winkler@intel.com
Subject: Re: [PATCH 0/6] thunderbolt: Introducing Thunderbolt(TM) networking
Message-ID: <20160524105506.GB5396@wunner.de>
References: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1463993336-2750-1-git-send-email-amir.jer.levy@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Amir,

On Mon, May 23, 2016 at 11:48:50AM +0300, Amir Levy wrote:
> Thunderbolt(TM) networking, introduced in these patches, provides the
> capability of connecting hosts together by emulating an Ethernet adapter.

Thank you for this contribution. I think it may take some time to review
everything, for now just some general observations:

- Since this is networking-related, it would be good if you could cc
  netdev@vger.kernel.org and possibly other relevant lists in future
  submissions of this series so that all stakeholders get the chance
  to comment.

- You're including multiple networking related header files but you're not
  adding any dependencies to Kconfig. I think you'll either have to add
  dependencies to Kconfig or compile portions of your code conditionally
  (using ifdefs in the code or conditions in the Makefile). Intel's
  kbuild test robot can help you find missing dependencies.

- Your github kernel directory only contains the raw patches. If you could
  clone torvalds/linux and apply the patches, it would allow people to
  browse the patches more comfortably with green/red highlighting.
  Also, I think kbuild test robot will automatically test forks of
  torvalds/linux.

- Your patches contain spelling fixes, it would be good to have those in
  a separate commit marked "No functional change intended" in the commit
  message. Also, since the driver was originally developed for Cactus
  Ridge but is now used for other controllers, you've changed comments
  which made it appear that the driver is Cactus Ridge only. These should
  go into a separate commit as well. Same for macro renames like
  DSL3510_REGS_H_ => NHI_REGS_H_.

- Up until now this driver was Mac-only. IIUC the functionality you're
  adding will also be used on non-Macs. That's an important change that
  should probably be made more explicit in the commit messages. Did you
  test your patches on a Mac to see that nothing regresses? Andreas
  Noever took on the Herculean task of writing this driver although no
  public documentation was available from Intel, he's the maintainer and
  needs to ack everything that goes into the driver. So in a sense it's
  like you're being a guest in someone else's house even though it's your
  own proprietary technology. E.g. adding an Intel-specific version
  number to the driver seems a bit odd at first glance.

Thanks,

Lukas
