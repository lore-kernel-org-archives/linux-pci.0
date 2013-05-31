Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40335 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195Ab3EaHig (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 03:38:36 -0400
Date: Fri, 31 May 2013 16:38:32 +0900
From: Tejun Heo <tj@kernel.org>
To: "Huang, Shane" <Shane.Huang@amd.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH 3/3] i2c-piix4: add AMD CZ SMBus device ID
Message-ID: <20130531073832.GB16809@mtj.dyndns.org>
References: <1369999333-2073-1-git-send-email-shane.huang@amd.com>
 <20130531080336.04481330@endymion.delvare>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8CC5@SCYBEXDAG04.amd.com>
 <20130531092846.51f2e202@endymion.delvare>
 <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8D06@SCYBEXDAG04.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <43EB3AB3EEFE8D43B525F4D2EAF507E1085B8D06@SCYBEXDAG04.amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 07:33:51AM +0000, Huang, Shane wrote:
> > Can you show the exact message? checkpatch doesn't complain here, and I
> > can't think of any reason why it would care about that.
> 
> $ ./scripts/checkpatch.pl 0003-i2c-piix4-add-AMD-CZ-SMBus-device-ID.patch
> WARNING: Avoid CamelCase: <Hudson>
> #52: FILE: drivers/i2c/busses/i2c-piix4.c:25:
> +       AMD Hudson-2, CZ
> 
> total: 0 errors, 1 warnings, 39 lines checked

Even if checkpatch complains, there's no point in following it
religiously.  If addressing the complaint doesn't make the code
better, there's no point in doing so.

Thanks.

-- 
tejun
