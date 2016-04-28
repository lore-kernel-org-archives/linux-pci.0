Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:43992 "EHLO
	mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbcD1OdJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 28 Apr 2016 10:33:09 -0400
Date: Thu, 28 Apr 2016 16:35:47 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Keith Busch <keith.busch@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCHv2] pcie: Add driver for Downstream Port Containment
Message-ID: <20160428143547.GC18211@wunner.de>
References: <1461779958-29368-1-git-send-email-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461779958-29368-1-git-send-email-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Wed, Apr 27, 2016 at 11:59:18AM -0600, Keith Busch wrote:
> v1 -> v2:
> 
>   Fixed the descriptor id to account for more than 4 service drivers.
> 
>   Fixed the v1's broken/incomplete link state inactive detection.

Unfortunately this is still missing the change to dev_set_name(), see
https://github.com/l1k/linux/commit/a27efb60b9e70ae3d57fefd5c8fc5261d9b492c9#diff-1410221b2233ad36abbc4db14d2cfcb3L342

It's probably worth explaining this change in the commit message.
I've written a paragraph in the above-linked commit, feel free to
copy that if you want to (perhaps with some kind of attribution
or whatever).

Best regards,

Lukas
