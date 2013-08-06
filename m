Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ch1ehsobe002.messaging.microsoft.com ([216.32.181.182]:37710
	"EHLO ch1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753996Ab3HFU7T (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 6 Aug 2013 16:59:19 -0400
Message-ID: <520163A1.6040901@amd.com>
Date: Tue, 6 Aug 2013 15:59:13 -0500
From: Aravind Gopalakrishnan <aravind.gopalakrishnan@amd.com>
MIME-Version: 1.0
To: Borislav Petkov <bp@alien8.de>
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>,
	<dougthompson@xmission.com>, <bhelgaas@google.com>,
	<jbeulich@suse.com>, <linux-kernel@vger.kernel.org>,
	<linux-edac@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/3 V2] EDAC, AMD64_EDAC: Add PCI Device ID Functions
 3 and 4 for newer F15h models.
References: <1375483384-2302-1-git-send-email-Aravind.Gopalakrishnan@amd.com> <1375483384-2302-2-git-send-email-Aravind.Gopalakrishnan@amd.com> <20130806201742.GF14891@pd.tnic>
In-Reply-To: <20130806201742.GF14891@pd.tnic>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 8/6/2013 3:17 PM, Borislav Petkov wrote:
> On Fri, Aug 02, 2013 at 05:43:02PM -0500, Aravind Gopalakrishnan wrote:
>> Adding PCI_DEVICE_ID_AMD_15H_NB_M30H_F3 and PCI_DEVICE_ID_AMD_15H_NB_M30H_F4
>> for F15h model 30h. This is required for the file amd_nb.c
> ... and amd64_edac.c
>
> Also, remember to read the comment at the beginning of
> include/linux/pci_ids.h!
>
> I fixed up the commit message when applying.
>
Okay, Thanks!

