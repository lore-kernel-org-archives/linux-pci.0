Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:21038 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab3EaH24 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 03:28:56 -0400
Date: Fri, 31 May 2013 09:28:46 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Tejun Heo <tj@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-i2c@vger.kernel.org
Subject: Re: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130531092846.51f2e202@endymion.delvare>
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
	<20130531080336.04481330@endymion.delvare>
	<43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 31 May 2013 06:42:54 +0000, Huang, Shane wrote:
> Hi Jean,
> 
> > Please don't change the case. This makes your patch larger and
> > increases the risk of conflict with other patches, for no good reason.
> > 
> > Other than that, the patch looks OK.
> 
> I didn't want to change it but checkpatch.pl warns due to
> "Hudson-2" in i2c-piix4.c

Can you show the exact message? checkpatch doesn't complain here, and I
can't think of any reason why it would care about that.

-- 
Jean Delvare
