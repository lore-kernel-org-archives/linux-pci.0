Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:6006 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751731AbcD1PDu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 28 Apr 2016 11:03:50 -0400
Date: Thu, 28 Apr 2016 18:03:12 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Qi Zheng <qi.zheng@intel.com>, Dave Airlie <airlied@gmail.com>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] PCI: Move PCIe ports to D3 during suspend
Message-ID: <20160428150312.GE32610@lahna.fi.intel.com>
References: <1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com>
 <1461578004-129094-3-git-send-email-mika.westerberg@linux.intel.com>
 <CAJZ5v0itrp_=KUo9kFHh8rSN5RYfPk0+iEgeAWZR5rrnFq-jDA@mail.gmail.com>
 <20160428142519.GB18211@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160428142519.GB18211@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Apr 28, 2016 at 04:25:19PM +0200, Lukas Wunner wrote:
> He had a helper for this in a prior version and removed it on my
> suggestion. Sorry Mika, guess I caused you additional work there. :-/

No worries :-)
