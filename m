Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:35014 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751492Ab2FLFeA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jun 2012 01:34:00 -0400
Message-ID: <4FD6D4C6.2080201@wwwdotorg.org>
Date: Mon, 11 Jun 2012 23:33:58 -0600
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
Subject: Re: [PATCH v2 06/10] ARM: tegra: pcie: Add MSI support
References: <1339427118-32263-1-git-send-email-thierry.reding@avionic-design.de> <1339427118-32263-7-git-send-email-thierry.reding@avionic-design.de> <4FD660F9.7030807@wwwdotorg.org> <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120612050713.GB3669@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/11/2012 11:07 PM, Thierry Reding wrote:
> * Stephen Warren wrote:
>> On 06/11/2012 09:05 AM, Thierry Reding wrote:
>>> This commit adds support for message signaled interrupts to the
>>> Tegra PCIe controller. Based on code by Krishna Kishore
>>> <kthota@nvidia.com>.
...
>> Why allocate pcie->msi separately; why not include the fields
>> directly into struct tegra_pcie_info *pcie?
...
> Second, and more importantly, this will keep the size of struct 
> tegra_pcie_info smaller if PCI_MSI is not selected because there is
> just one unused pointer instead of five unused fields.

Well, you can always ifdef out the structure fields too, right?
