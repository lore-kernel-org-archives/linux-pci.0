Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DC1C5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:31:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1974C20851
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:31:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1974C20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbeLKSbw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:31:52 -0500
Received: from mga02.intel.com ([134.134.136.20]:6774 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeLKSbw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 13:31:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 10:31:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="301301276"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga006.fm.intel.com with ESMTP; 11 Dec 2018 10:31:51 -0800
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 10:31:51 -0800
Received: from hasmsx111.ger.corp.intel.com (10.184.198.39) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 10:31:50 -0800
Received: from hasmsx112.ger.corp.intel.com ([169.254.11.88]) by
 HASMSX111.ger.corp.intel.com ([169.254.5.58]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 20:31:48 +0200
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "bjorn@helgaas.com" <bjorn@helgaas.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Mertarg10@gmail.com" <Mertarg10@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fran RR <fjrr87@outlook.com>
Subject: RE: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Thread-Topic: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Thread-Index: AQHUh2ApCc7lmNGfg0mZ5cTxRsuvBaVrCVdwgA10uACAAKnQcIAAWQuAgABN2ZD///8HAIAAIouA
Date:   Tue, 11 Dec 2018 18:31:47 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB30133756B5D@HASMSX112.ger.corp.intel.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
 <20181128211959.GB178809@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
 <20181210222452.GC85090@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
 <20181211135121.GB99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756A29@HASMSX112.ger.corp.intel.com>
 <20181211182630.GF99796@google.com>
In-Reply-To: <20181211182630.GF99796@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2ZlMDg5NzYtNDQzMS00OGI2LTkwYmEtYTdhYTViOTVmMGQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiTkk0ZjN4T2hQZzlYaEhOc1JXN2NRb2d2S2RWbTBIOE16Q1hhWnRBU1cyMW5GYXYzY0dcL2dUZHEwMWRUYmFkK1QifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.251.82.25]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 
> On Tue, Dec 11, 2018 at 04:32:25PM +0000, Grumbach, Emmanuel wrote:
> > > On Tue, Dec 11, 2018 at 06:35:20AM +0000, Grumbach, Emmanuel wrote:
> > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=201647
> > >
> > > > FWIW: I saw another problem like this with a 9650 device.
> > >
> > > Do you have a pointer to any info about this 9650 issue?  Maybe that
> > > would have a clue.
> >
> > I added him here so that you can ask whatever you like :) The story is
> > the same. I am attaching a picture I got from the reporter.
> > I can confirm that this device ID / subdevice ID is supported by the linux
> driver.
> 
> Was there a resolution, i.e., if somebody figured out how to make the
> 9650 wifi work, maybe a similar solution would work for the 3165?

Unfortunately not, I am stuck there at the exact same point.
No Wifi device shows up in lspci...

