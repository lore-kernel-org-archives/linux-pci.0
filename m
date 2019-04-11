Return-Path: <SRS0=+gKf=SN=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D0FC10F13
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F17C2184B
	for <linux-pci@archiver.kernel.org>; Thu, 11 Apr 2019 20:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbfDKUmy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 11 Apr 2019 16:42:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:26407 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbfDKUmy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 11 Apr 2019 16:42:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Apr 2019 13:42:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,338,1549958400"; 
   d="scan'208";a="142002025"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga007.fm.intel.com with ESMTP; 11 Apr 2019 13:37:54 -0700
Received: from orsmsx108.amr.corp.intel.com ([169.254.2.238]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.217]) with mapi id 14.03.0415.000;
 Thu, 11 Apr 2019 13:37:53 -0700
From:   "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     "Dalessandro, Dennis" <dennis.dalessandro@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "Arumugam, Kamenee" <kamenee.arumugam@intel.com>
Subject: RE: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Thread-Topic: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error
 non-fatal
Thread-Index: AQHU75nXBeeESwYKgU6W3nz6YBGO26Y2PakAgAExpwD//44bwIAASLuwgAB5CQD//6r2oA==
Date:   Thu, 11 Apr 2019 20:37:53 +0000
Message-ID: <A503C24F5B2FB844864C0DD400A8F742121C859F@ORSMSX108.amr.corp.intel.com>
References: <20190410123253.26818.37261.stgit@scvm10.sc.intel.com>
 <20190410123455.26818.49424.stgit@scvm10.sc.intel.com>
 <20190410192948.GG256045@google.com>
 <14063C7AD467DE4B82DEDB5C278E8663BE6A1B14@FMSMSX108.amr.corp.intel.com>
 <A503C24F5B2FB844864C0DD400A8F742121C8525@ORSMSX108.amr.corp.intel.com>
 <20190411182938.GB14495@ziepe.ca>
In-Reply-To: <20190411182938.GB14495@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTE4NDk4ZmEtYTE0MS00Yjk2LWI2YjktZTg4YThlNDliY2FhIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUXRxWk1CQmdBMTNNYTVzNmprZTBjaUxaNEFrZjdUSG5FMjJNU0NONjZ5cUpSc2t5dzF3M3FIXC85RHlxam95QkMifQ==
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
From: Jason Gunthorpe [mailto:jgg@ziepe.ca] 
Sent: Thursday, April 11, 2019 2:30 PM
To: Arumugam, Kamenee <kamenee.arumugam@intel.com>
Cc: Dalessandro, Dennis <dennis.dalessandro@intel.com>; bhelgaas@google.com; linux-rdma@vger.kernel.org; linux-pci@vger.kernel.org; Ruhl, Michael J <michael.j.ruhl@intel.com>; dledford@redhat.com
Subject: Re: [PATCH for-next 2/2] IB/hfi1: Make Unsupported Request error non-fatal

On Thu, Apr 11, 2019 at 06:22:45PM +0000, Arumugam, Kamenee wrote:

> This is a device bug then. 

> A RDMA device must accept and respond to all TLPs that the CPU could create for the user accessible BAR pages.

> A user process must not be able to crash the CPU or make the device malfunction by accessing the exposed BAR page. This includes a broad range of topics, like mis-aligned acceses, SSE instructions, atomics, >etc.

> Is blocking AER even enough here? If the device isn't generating a reasonable reply I have a bad feeling worse will happen.

After blocking unsupported request error, we don't see any other issue including no system hang. 


