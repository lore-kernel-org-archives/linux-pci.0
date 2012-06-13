Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:43494 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2FMRDs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jun 2012 13:03:48 -0400
Message-ID: <4FD8C7F0.5050305@wwwdotorg.org>
Date: Wed, 13 Jun 2012 11:03:44 -0600
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
...
> One other thing: in addition to the device tree binding, this will
> all have to be represented in the platform data as well to support
> the legacy board definitions currently in the tree. But instead of
> adding all of these changes to the patch that converts the code to
> a driver, I'm thinking it might be better to split these additions
> off into one or more separate patches. Do you have any objections?

So long as git bisect isn't broken for build- or run-time, that's just
fine.
