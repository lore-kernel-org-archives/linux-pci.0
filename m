Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:49297 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab2LJMU2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 10 Dec 2012 07:20:28 -0500
Received: by mail-lb0-f174.google.com with SMTP id gi11so1920235lbb.19
        for <linux-pci@vger.kernel.org>; Mon, 10 Dec 2012 04:20:27 -0800 (PST)
Message-ID: <50C5D387.90908@monstr.eu>
Date: Mon, 10 Dec 2012 13:20:23 +0100
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
MIME-Version: 1.0
To: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	linux-pci@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: pci and pcie device-tree binding - range No cells
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Grant and others,

I have a question regarding number of cells in ranges property
for pci and pcie nodes.

Linux pci/pcie powerpc DTSes contain 7 cells (xpedite5370.dts, sequoia.dts, etc)
but also 6 cells format too (mpc832x_mds.dts)

Here is shown 6 cells ranges format and describe
http://devicetree.org/Device_Tree_Usage#PCI_Host_Bridge

And also in documentation in the linux
Documentation/devicetree/bindings/pci/83xx-512x-pci.txt

Both format uses:
#size-cells = <2>;
#address-cells = <3>;

What is valid format?

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel 2.6 Microblaze Linux - http://www.monstr.eu/fdt/
Microblaze U-BOOT custodian
