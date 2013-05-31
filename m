Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:10003 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753567Ab3EaHq4 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 03:46:56 -0400
Date: Fri, 31 May 2013 09:46:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130531094643.5b256d2d@endymion.delvare>
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8D06@SCYBEXDAG04.amd.com>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
	<20130531080336.04481330@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
	<20130531092846.51f2e202@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1085B8D06@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 31 May 2013 07:33:51 +0000, Huang, Shane wrote:
> > Can you show the exact message? checkpatch doesn't complain here, and I
> > can't think of any reason why it would care about that.
> 
> $ ./scripts/checkpatch.pl 0003-i2c-piix4-add-AMD-CZ-SMBus-device-ID.patch
> WARNING: Avoid CamelCase: <Hudson>
> #52: FILE: drivers/i2c/busses/i2c-piix4.c:25:
> +       AMD Hudson-2, CZ
> 
> total: 0 errors, 1 warnings, 39 lines checked

checkpatch is twice wrong here, firstly because there is no CamelCase
and secondly because this is a comment and not code (ideally middle
comment lines would start with "*" to avoid this false positive, but
that style wasn't yet in use when the i2c-piix4 driver was written.)

So, just ignore it.

-- 
Jean Delvare
