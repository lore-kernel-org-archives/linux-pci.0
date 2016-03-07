Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ni.piap.pl ([195.187.100.4]:35109 "EHLO ni.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752300AbcCGNyb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 7 Mar 2016 08:54:31 -0500
From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Fix NULL ptr dereference in pci_bus_assign_domain_nr() on ARM
References: <m337sapw89.fsf@t19.piap.pl> <20160303173522.GA9189@localhost>
	<m38u1yojmq.fsf@t19.piap.pl> <20160304162737.GA1296@localhost>
Date: Mon, 07 Mar 2016 14:54:27 +0100
In-Reply-To: <20160304162737.GA1296@localhost> (Bjorn Helgaas's message of
	"Fri, 4 Mar 2016 10:27:37 -0600")
Message-ID: <m3h9gimm0c.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn Helgaas <helgaas@kernel.org> writes:

>> At least CNS3xxx doesn't boot. I haven't verified a couple of others,
>> but they may be broken as well.
>
> Good, thanks.  Also (I should have asked this before), please include a
> "Fixes:" line so we know exactly when this broke and what stable kernels
> need the fix.

The problem started here:

Fixes: 8c7d14746abc ("ARM/PCI: Move to generic PCI domains")

It means the patch should be applicable starting with v4.0, and ...
indeed v4.0 with the patch boots correctly, while v4.0 without the patch
does not.

Thanks.
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
