Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:60141 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab2FLPis (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 11:38:48 -0400
Message-ID: <4FD76284.5000506@wwwdotorg.org>
Date: Tue, 12 Jun 2012 09:38:44 -0600
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
Subject: Re: [PATCH v2 09/10] ARM: tegra: harmony: Initialize PCIe from DT
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-10-git-send-email-thierry.reding@avionic-design.de> <4FD6661A.1060407@wwwdotorg.org> <20120612054811.GB4040@avionic-0098.adnet.avionic-design.de>
In-Reply-To: <20120612054811.GB4040@avionic-0098.adnet.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 11:48 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 06/11/2012 09:05 AM, Thierry Reding wrote:
>>> With the device tree support in place, probe the PCIe
>>> controller from the device tree and remove the corresponding
>>> workaround in the board file.
>> 
>>> diff --git a/arch/arm/boot/dts/tegra-harmony.dts
>>> b/arch/arm/boot/dts/tegra-harmony.dts
>> 
>>> +	pci_vdd_reg: fixedregulator@0 {
>> 
>> I think that'd usually just be "regulator@0".
>> 
>> If you need the "@0" part to differentiate between multiple
>> regulators, the node needs a reg property too:
>> 
>> reg = <0 0>;
>> 
>> although then I wonder about putting the regulator under the root
>> node, since the address wouldn't really make sense...
> 
> Perhaps we should add a new "regulators" node under the root node
> to collect this kind of regulators that don't fit anywhere else.
> Looking at the code, something like this should work:
> 
> / { ...
> 
> regulators { compatible = "simple-bus"; #address-cells = <1>; 
> #size-cells = <0>;
> 
> pci_vdd_reg: regulator@0 { reg = <0>; }; }; };

That seems like a good idea, and there's certainly precedent for doing
exactly that in other ARM .dts files already.

To maintain .dts alphabetical sorting of non-addressed nodes, this new
node should slot in just before the sound node, near the end of the file.
