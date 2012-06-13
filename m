Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:54335 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754144Ab2FMQUJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2012 12:20:09 -0400
Message-ID: <4FD8BDB4.5070000@wwwdotorg.org>
Date: Wed, 13 Jun 2012 10:20:04 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@avionic-design.de>
CC: linux-tegra@vger.kernel.org,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-pci@vger.kernel.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	devicetree-discuss@lists.ozlabs.org,
	Russell King <linux@arm.linux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Colin Cross <ccross@android.com>,
	Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v2 07/10] ARM: tegra: pcie: Add device tree support
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-8-git-send-email-thierry.reding@avionic-design.de> <4FD66410.7090001@wwwdotorg.org> <20120612062124.GE4040@avionic-0098.adnet.avionic-design.de> <4FD763C5.3090500@wwwdotorg.org> <20120612172041.GA28010@avionic-0098.adnet.avionic-design.de> <4FD7A36B.9090409@wwwdotorg.org> <20120613063422.GC31001@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120613063422.GC31001@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/13/2012 12:34 AM, Thierry Reding wrote:
> * Stephen Warren wrote:
...
>> I think you also need a property to specify the exact port
>> layout; the Tegra20 controller supports:
>> 
>> 1 x4 port 2 x2 ports (you can choose to use only 1 of these I
>> assume)
>> 
>> So just because only 1 of the ports is enabled, doesn't imply
>> it's x4; it could still be x2.
>> 
>> Tegra30 has more options.
> 
> Both the upstream and downstream drivers currently hard-code this
> to dual and 411 (I assume that means 1x4, 2x1?) configurations for
> Tegra20 and Tegra30 respectively. Unfortunately the register
> AFI_PCIE_CONFIG isn't documented on Tegra20 at all and for Tegra30
> lists only the valid configurations (see 28.4.1.5 PCIe CONFIG) but
> not the corresponding encodings.
> 
> Maybe a good name for the new property would be "num-lanes". I also
> wonder if this property would be better off in the parent node,
> which would make it easier to check for valid configurations.
> Otherwise the code would have to collect the settings of all the
> ports and check if the combination is valid. Then again, having
> num-lanes in the parent with one cell for each controller isn't
> very nice if each controller can be individually disabled.

Indeed, since the register that controls this is in the main register
set rather than the per-port register set, it does seem like a good
idea to put the property in the main node, not the per-port node.
