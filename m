Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe005.messaging.microsoft.com ([216.32.181.185]:17839
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753651AbaB0Qcb (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Feb 2014 11:32:31 -0500
Message-ID: <530F6898.1040807@amd.com>
Date: Thu, 27 Feb 2014 10:32:24 -0600
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<x86@kernel.org>, <dougthompson@xmission.com>,
	<bhelgaas@google.com>, <JBeulich@suse.com>,
	<dan.carpenter@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<Arindam.Nath@amd.com>
Subject: Re: [PATCH] amd64_edac: Add support for newer F16h models
References: <1392913726-16961-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <20140221142749.GC11531@pd.tnic> <5307BF6F.8040303@amd.com> <20140224140931.GA16457@pd.tnic> <530F6643.5090009@amd.com> <20140227163108.GH18191@pd.tnic>
In-Reply-To: <20140227163108.GH18191@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2/27/2014 10:31 AM, Borislav Petkov wrote:
> On Thu, Feb 27, 2014 at 10:22:27AM -0600, Aravind Gopalakrishnan wrote:
>> Ok, here's more info: we will need to add support in k10temp for this
>> model; and support is not required in fam15h_power as register bits
>> used by the driver code are unavailable for OS. But F{3,4} usage is
>> split: k10temp uses F3 device ID and fam15h_power uses F4 device ID.
>>
>> Not sure if you want to split these definitions between amd_nb.h and
>> pci_ids.h or just let it be.
> Yeah, let's let it be. Thanks for getting the info - I'll ack the
> original submission.
>

Thanks,
-Aravind.

