Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:46592 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab3A3Usy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jan 2013 15:48:54 -0500
Received: by mail-ve0-f174.google.com with SMTP id c13so1464227vea.33
        for <linux-pci@vger.kernel.org>; Wed, 30 Jan 2013 12:48:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130130124721.0ad0294e@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201301292254.01069.arnd@arndb.de> <20130130042103.GB5734@obsidianresearch.com>
 <201301300955.49473.arnd@arndb.de> <20130130124721.0ad0294e@skate>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 30 Jan 2013 13:48:33 -0700
Message-ID: <CAErSpo4GKimzwTBB8aN4aj7ms=8pfkoV1=j8mstPDCxc-+gPxQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 30, 2013 at 4:47 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> So what I'm going to do now is rework my patch series by removing the
> emulated host bridge (which is normally mandatory by PCIe standard, but
> Linux doesn't need it, so we don't care), ...

This is a tangent since you're removing the emulated host bridge
anyway, but it's been mentioned a couple of times, and I'd like to
understand this.  Jason mentioned earlier in the [07/27] emulated host
bridge thread that the PCIe spec requires a host bridge at 00:00.0.
I've never seen that mentioned in the spec; can somebody point me to
the actual requirement that host bridges appear in config space?

My understanding has been that host bridges, whether PCI or PCIe, are
required to *exist*, but that the way you enumerate them and configure
them is outside the scope of the PCI/PCIe specs.  I know that many
chips, especially for x86, *do* make the host bridge appear in config
space, but I've never seen a requirement for that.

Bjorn
