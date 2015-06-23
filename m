Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:42099 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752275AbbFWWqt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 23 Jun 2015 18:46:49 -0400
Message-ID: <1435099588.3996.14.camel@kernel.crashing.org>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	Will Deacon <Will.Deacon@arm.com>
Date: Wed, 24 Jun 2015 08:46:28 +1000
In-Reply-To: <20150602145510.GE23650@red-moon>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
	 <20150527210447.GY32152@google.com> <20150602145510.GE23650@red-moon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2015-06-02 at 15:55 +0100, Lorenzo Pieralisi wrote:
> While at it, do you think it is reasonable to also claim the bridge
> windows (resources) in the respective pci_read_bridge_* calls ?

No, don't claim in read. There's a clear distinction between gathering
resources and claiming them, and we need to keep that.

Some fixups might happen in between the two for example.

Cheers,
Ben.


