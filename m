Return-Path: <SRS0=+/yS=LN=intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=+/yS=LN=intel.com=keith.busch@kernel.org>
Date: Wed, 29 Aug 2018 18:46:47 -0600
From: Keith Busch <keith.busch@intel.com>
To: Sinan Kaya <okaya@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	"poza@codeaurora.org" <poza@codeaurora.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Thomas Tai <thomas.tai@oracle.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-pci-owner@vger.kernel.org" <linux-pci-owner@vger.kernel.org>,
	Sam Bobroff <sam.bobroff@au1.ibm.com>
Subject: Re: [PATCH 1/1] PCI/AER: prevent pcie_do_fatal_recovery from using
 device after it is removed
Message-ID: <20180830004646.GA5946@localhost.localdomain>
References: <a149d9657ca83b41c724b0ddd319c6fb@codeaurora.org>
 <512e0e11c3ba462c1d033f8b0e768fa27489731c.camel@kernel.crashing.org>
 <ad23b16cf7ff1f3b51961fda59533892@codeaurora.org>
 <2742bdba5ae8ccc420234b6e6b0224919367ed4c.camel@kernel.crashing.org>
 <20180821143751.GA18477@localhost.localdomain>
 <277b7056aa7af8e98d5cd912838e582783943aa9.camel@kernel.crashing.org>
 <20180821220456.GC18612@localhost.localdomain>
 <5d69daf9918878b95b6df3265fc4c3d5b52f9baa.camel@kernel.crashing.org>
 <20180830000100.GA5841@localhost.localdomain>
 <3e39e860-95a6-ae17-cc89-ac9550ffca40@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3e39e860-95a6-ae17-cc89-ac9550ffca40@kernel.org>
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 29, 2018 at 05:10:53PM -0700, Sinan Kaya wrote:
> Why does hotplug operations cause a fatal error? DPC driver is only monitoring
> fatal errors today.

Oh, not considering DPC capabilities; just AER. A hotplug capable
switch only suppresses Suprise Link Down, but its possible other link
or transaction errors occur along with the event.
