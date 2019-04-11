Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8B6C10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 18:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73F072146F
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 18:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfDKSWr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:22:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:49862 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726577AbfDKSWr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 14:22:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 11:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="315129035"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2019 11:22:46 -0700
Received: from orsmsx122.amr.corp.intel.com (10.22.225.227) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 11 Apr 2019 11:22:46 -0700
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.238]) by
 ORSMSX122.amr.corp.intel.com ([169.254.11.68]) with mapi id 14.03.0415.000;
 Thu, 11 Apr 2019 11:22:46 -0700
From:   "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
To:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
Subject: RE: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Thread-Topic: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Thread-Index: AQHU75nXBeeESwYKgU6W3nz6YBGO26Y2PakAgAExpwD//44bwIAASLuw
Date:   Thu, 11 Apr 2019 18:22:45 +0000
Message-ID: <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMGNlMDFmZGMtZGRlYi00YmQ2LTgxMzMtNDhjZDQxZjBjMDdkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiRzYrTjFhQ1NhOVFNemJoSEh4ek10ZjdPamhvQjVEVHhycjE1MjFWanVXTExvS3FqR3JOTWVaczlmc2FaZ0xiayJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


-----Original Message-----
From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
Sent: Wednesday, April 10, 2019 3:30 PM
To: Dalessandro, Dennis <dennis.dalessandro@intel.com>
Cc: jgg@ziepe.ca; linux-rdma@vger.kernel.org; linux-pci@vger.kernel.org; Ruhl, Michael J <michael.j.ruhl@intel.com>; dledford@redhat.com; Arumugam, Kamenee <kamenee.arumugam@intel.com>
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error non-fatal

Hi Bjorn,

> I know there are a few drivers that fiddle with AER bits, but that makes me a little bit nervous because error handling is more than just a > driver issue.  It involves the PCI core and the platform firmware as well.

> Anyway, let's figure out more about this particular case.  Unsupported 
> Request is a PCIe protocol-level issue.  You're masking it in the HFI adapter, which I guess means you want to prevent it from reporting UR.
> So the HFI is receiving a TLP that it doesn't support?

Yes, HFI is receiving a TLP with unsupported request error.

> What exactly is causing the UR?  Is it something the driver could potentially avoid, e.g., an AtomicOp that HFI doesn't support?  I have a > vague notion that InfiniBand allows some sort of direct user-space access to hardware; is there something there that can cause a UR?

HFI PCIe BAR are mapped to user space to implement kernel bypass for MPI/PSM jobs. In this case, user-level application is making spurious read accesses (invalid width access) to this memory mapping causing the device to report an unsupported request error through AER. The spurious read accesses may be due to errant application behavior (e.g. reading beyond the end of an array).

> The system hang sounds like a separate problem that should also be fixed.  Even if HFI signals a UR error, I would not expect a system > > hang.
 
We haven't root cause the system hang but it doesn't appear to be related to our driver.


>> Set Unsupported Request Error bit in Uncorrectable Error Mask register 
>> to disable error reporting to the PCIe root complex.
>> 
>> Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> Signed-off-by: Kamenee Arumugam <kamenee.arumugam@intel.com>
>> Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
>> ---
>>  drivers/infiniband/hw/hfi1/pcie.c |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>> 
>> diff --git a/drivers/infiniband/hw/hfi1/pcie.c
>> b/drivers/infiniband/hw/hfi1/pcie.c
>> index c96d193..a033e28 100644
>> --- a/drivers/infiniband/hw/hfi1/pcie.c
>> +++ b/drivers/infiniband/hw/hfi1/pcie.c
>> @@ -114,6 +114,7 @@ int hfi1_pcie_init(struct hfi1_devdata *dd)
>>  	}
>>  
>>  	pci_set_master(pdev);
>> +	pcie_aer_set_dword(pdev, PCI_ERR_UNCOR_MASK, PCI_ERR_UNC_UNSUP);
>>  	(void)pci_enable_pcie_error_reporting(pdev);
>>  	return 0;
>>  
>> 
