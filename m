Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout2.hostsharing.net ([83.223.90.233]:40958 "EHLO
	mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753602AbcEBLAP (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2016 07:00:15 -0400
Date: Mon, 2 May 2016 13:03:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI: Add support for suspending (including
 runtime) of PCIe ports
Message-ID: <20160502110300.GA19207@wunner.de>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi,

On Fri, Apr 29, 2016 at 11:51:55AM +0300, Mika Westerberg wrote:
> Current Linux PCI core does not do any kind of power management to PCIe
> ports. This means that we waste energy and consume laptop battery even if
> the port has nothing connected to. These patches aim to change that to the
> right direction.

I've rebased my Thunderbolt runtime pm patches on Mika's v5.
Works for me, so this series is

Tested-by: Lukas Wunner <lukas@wunner.de>

Thanks,

Lukas
