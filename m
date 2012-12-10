Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:54912 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774Ab2LJO0k (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2012 09:26:40 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so1487864qad.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Dec 2012 06:26:40 -0800 (PST)
Message-ID: <50C5F11D.9060006@gmail.com>
Date: Mon, 10 Dec 2012 08:26:37 -0600
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: monstr@monstr.eu
CC: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: pci and pcie device-tree binding - range No cells
References: <50C5D387.90908@monstr.eu>
In-Reply-To: <50C5D387.90908@monstr.eu>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 12/10/2012 06:20 AM, Michal Simek wrote:
> Hi Grant and others,
> 
> I have a question regarding number of cells in ranges property
> for pci and pcie nodes.
> 
> Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts,
> sequoia.dts, etc)
> but also 6 cells format too (mpc832x_mds.dts)
> 
> Here is shown 6 cells ranges format and describe
> http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge
> 
> And also in documentation in the linux
> Documentation/devicetree/bindings/pci/83xx-512x-pci.txt
> 
> Both format uses:
> #size-cells = <2>;
> #address-cells = <3>;
> 
> What is valid format?

Both. 7 cells are valid when the host (parent) bus is 64-bit and 6 cells
are valid when the host bus is 32-bit. The ranges property is <<child
address> <parent address> <size>>. The parent address #address-cells is
taken from the parent node.

Rob
