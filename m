Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48298 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750888AbcDLGvO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Apr 2016 02:51:14 -0400
Date: Tue, 12 Apr 2016 09:51:08 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Zheng, Qi" <qi.zheng@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	"Zha, Qipeng" <qipeng.zha@intel.com>,
	Dave Airlie <airlied@gmail.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] PCI: Move PCIe ports to D3 during suspend
Message-ID: <20160412065108.GG1714@lahna.fi.intel.com>
References: <1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com>
 <1460111790-92836-3-git-send-email-mika.westerberg@linux.intel.com>
 <0DD381DBF8F68D419C32ACFCEB28EB2521D2B374@SHSMSX101.ccr.corp.intel.com>
 <20160411085605.GB1727@lahna.fi.intel.com>
 <CAJZ5v0he594EgJqoT4MMvhsKBSRLk7d4jFBVAfR+hGHs4oRfsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0he594EgJqoT4MMvhsKBSRLk7d4jFBVAfR+hGHs4oRfsA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Apr 11, 2016 at 03:38:07PM +0200, Rafael J. Wysocki wrote:
> Fair enough, but we may need to do something about that in the future
> if things turn out to not work properly.

Yeah, I think we can then add an exception table (blacklist) that
includes those devices which do not work properly. Hopefully it is not
needed at all :)
