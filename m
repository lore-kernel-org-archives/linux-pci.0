Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46911 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752678AbcBEJpr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 5 Feb 2016 04:45:47 -0500
Date: Fri, 5 Feb 2016 09:47:40 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Jayachandran Chandrashekaran Nair
	<jayachandran.chandrashekaran@broadcom.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Jayachandran C <jchandra@broadcom.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Tomasz Nowicki <tn@semihalf.com>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v7 5/5] PCI: ACPI: Add a generic ACPI based host
 controller
Message-ID: <20160205094740.GA31547@red-moon>
References: <1454058340-7904-1-git-send-email-jchandra@broadcom.com>
 <1454058340-7904-6-git-send-email-jchandra@broadcom.com>
 <20160205001907.GJ7031@localhost>
 <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKc_7PXYtFt1MQE-UGO0O5vvQ+xFKa2b5=F8wXB=EN-JUJVzZw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Feb 05, 2016 at 02:05:37PM +0530, Jayachandran Chandrashekaran Nair wrote:

[...]

> pci_host_acpi.c is a generic implementation of these using a sysdata
> pointing to acpi_pci_root_info, and using a pointer to the pci_mmcfg_region
> to access ECAM area, Maybe I can rename this file to
> pci_acpi_host_generic.c to reflect this better.

Maybe you should stop sending this series and work with Tomasz to
get this done, you are confusing everyone and I am really really
annoyed about this.

Do you realize there is no point in having two patch series doing
the same thing and wasting everyone's review time ?

Do you realize he started this work long before you and went through
several rounds of review already (I told you before but in case you
forgot) ?

Tomasz posted a version yesterday, integrating comments following months
of review and testing and I think it is ready to get upstream:

https://lkml.org/lkml/2016/2/4/646

Did you even consider reviewing his code or helping him instead of
churning out more patches doing the *SAME* thing ?

Do you want all of us to go through your code and re-fix what has
already been fixed in Tomasz's series with the end result of missing
yet another merge window ?

This is really annoying, stop it please, really.

Thank you,
Lorenzo
