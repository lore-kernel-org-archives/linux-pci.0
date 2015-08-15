Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp2.tech.numericable.fr ([82.216.111.38]:51040 "EHLO
	smtp2.tech.numericable.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751406AbbHOXrb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sat, 15 Aug 2015 19:47:31 -0400
Subject: Re: [PATCH] PCI: Disable async suspend/resume for Jmicron chip
To: Bjorn Helgaas <bhelgaas@google.com>,
	Zhang Rui <rui.zhang@intel.com>
References: <1438047747.1856.12.camel@rzhang1-mobl4>
 <20150728175848.GI5322@mtj.duckdns.org>
 <1438133951.1856.23.camel@rzhang1-mobl4> <20150814201752.GG26431@google.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pci <linux-pci@vger.kernel.org>,
	chuansheng.liu@intel.com, Alan Stern <stern@rowland.harvard.edu>,
	Aaron Lu <aaron.lu@intel.com>, MyMailClone@t-online.de,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
From: Barto <mister.freeman@laposte.net>
Message-ID: <55CFCDD5.6040302@laposte.net>
Date: Sun, 16 Aug 2015 01:40:05 +0200
MIME-Version: 1.0
In-Reply-To: <20150814201752.GG26431@google.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Le 14/08/2015 22:17, Bjorn Helgaas a écrit :
> For 1), I think it is probably overkill to penalize all JMicron
> devices.  There's no reason to think NICs and SD/MMC/etc controllers
> have the same issue.  Or if there *is* reason to think that, you
> should give evidence for it.

if you don't want to penalize all JMicron models then a workaround would
be to create a new feature : the ability for the user to disable async
for a specific device,

for example a kernel parameter ( no-async-for-jmicron ), or a more
configurable mechanism, like a configuration file where the user can add
the name of the device, a kind of blacklist in order to disable async
only for a list of devices,

it's only a workaround, the real solution would to be find the real root
cause ( a bug in async method ? a design flaw in JMicron hardware ? a
bios/acpi bug ? )

