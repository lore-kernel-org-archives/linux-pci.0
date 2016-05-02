Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:3203 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752805AbcEBKQo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 2 May 2016 06:16:44 -0400
Date: Mon, 2 May 2016 13:16:38 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mathias Nyman <mathias.nyman@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5 0/4] PCI: Add support for suspending (including
 runtime) of PCIe ports
Message-ID: <20160502101638.GN32610@lahna.fi.intel.com>
References: <1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com>
 <57234999.2040202@intel.com>
 <86024359.9LxrAC1gtb@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <86024359.9LxrAC1gtb@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 29, 2016 at 02:10:59PM +0200, Rafael J. Wysocki wrote:
> > For the non-functional one-line only xhci change in patch 2/4:
> > Acked-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> > 
> > Out of curiosity, does enabling bridge d3 in any way impact #PME
> > wakeup signaling initiated by devices behind that bridge?
> 
> If the device reports (via the config space) that it is capable of signaling
> PME from D3_{cold}, the wakeup signaling won't be affected (as long as the
> hardware design follows the spec).
> 
> The Mika's patches take that into account AFAICS.

Yes, that's right.
