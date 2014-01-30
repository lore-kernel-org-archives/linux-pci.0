Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:60911 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338AbaA3OKS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jan 2014 09:10:18 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [RFC PATCH V3 2/4] arm64: dts: APM X-Gene PCIe device tree nodes
Date: Thu, 30 Jan 2014 15:09:25 +0100
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Grant Likely <grant.likely@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Rob Landley <rob@landley.net>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	patches@apm.com, jcm@redhat.com
References: <1390599168-13150-1-git-send-email-tinamdar@apm.com> <1390599168-13150-3-git-send-email-tinamdar@apm.com>
In-Reply-To: <1390599168-13150-3-git-send-email-tinamdar@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201401301509.26080.arnd@arndb.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday 24 January 2014, Tanmay Inamdar wrote:
> +               pcie3: pcie@1f500000 {
> +                       reg-names = "csr", "cfg";
> +                       ranges = <0x01000000 0x0 0x00000000 0xa0 0x00000000 0x0 0x00010000  /* mem */
> +                                 0x02000000 0x0 0x10000000 0xa0 0x10000000 0x0 0x80000000>; /* io  */

The two comments are wrong for this instance.

	Arnd
