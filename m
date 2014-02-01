Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2lp0241.outbound.protection.outlook.com ([207.46.163.241]:35316
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S933102AbaBAO2S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Sat, 1 Feb 2014 09:28:18 -0500
Message-ID: <52ED010E.80500@myricom.com>
Date: Sat, 1 Feb 2014 23:13:34 +0900
From: Hyong-Youb Kim <hyong-youb.kim@myricom.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
	Alexander Gordeev <agordeev@redhat.com>,
	<linux-kernel@vger.kernel.org>
CC: Hyong-Youb Kim <hykim@myri.com>, <netdev@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 20/34] myri10ge: Use pci_enable_msix_range()
References: <cover.1391172839.git.agordeev@redhat.com> <1253b3c920637ab6bb987defb88d1698ac1e4851.1391172839.git.agordeev@redhat.com> <52EBF885.30309@cogentembedded.com>
In-Reply-To: <52EBF885.30309@cogentembedded.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


On 2/1/2014 4:24 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 01/31/2014 06:08 PM, Alexander Gordeev wrote:
>
[...]
>> +        if (status < 0)
>> +            goto disable_msix;
>
>     Hm, if enabling MSI failed, we don't need to disable it, right? So,
> perhaps the label should be renamed?
>

The code following disable_msix does not call pci_disable_msix().  It 
frees the allocated vector buffer and loads the firmware that uses a 
single interrupt vector.  So, it is "disable" in the sense that the 
driver is not going to use MSI-X vectors.  I agree that naming could be 
better.

disable_msix:
         if (mgp->msix_vectors != NULL) {
                 kfree(mgp->msix_vectors);
                 mgp->msix_vectors = NULL;
         }

abort_with_fw:
         mgp->num_slices = 1;
         set_fw_name(mgp, old_fw, old_allocated);
         myri10ge_load_firmware(mgp, 0);
