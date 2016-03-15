Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:58125 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932842AbcCOI1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 15 Mar 2016 04:27:32 -0400
Message-ID: <56E7C771.6060700@intel.com>
Date: Tue, 15 Mar 2016 16:27:29 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH] PCI: PTM preliminary implementation
References: <1457681184-20439-1-git-send-email-jonathan.yong@intel.com> <1457681184-20439-2-git-send-email-jonathan.yong@intel.com> <20160311155332.GA31716@localhost> <56E66BF3.4080500@intel.com> <20160314154215.GB13471@localhost>
In-Reply-To: <20160314154215.GB13471@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/14/2016 23:42, Bjorn Helgaas wrote:
>
> The nomenclature is confusing, but I think you're reading this
> backwards.  An Upstream Port is on the downstream end of a Link.  The
> "Upstream" definition in the PCIe spec "Terms and Acronyms" section
> says:
>
>    The Port on a Switch that is closest topologically to the Root Complex
>    is the Upstream Port. The Port on a component that contains only
>    Endpoint or Bridge Functions is an Upstream Port.
>
> I think the spec is saying that PTM must be enabled in a bridge before
> it is enabled in any device downstream from the bridge.
>

Thanks for the explanation, looks like back to the drawing board. Do you 
recommend using pci_walk_bus on all potential PTM masters?


