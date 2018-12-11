Return-Path: <SRS0=NFOj=OU=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3263C5CFFE
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98B62086D
	for <linux-pci@archiver.kernel.org>; Tue, 11 Dec 2018 18:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98B62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeLKSv3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 11 Dec 2018 13:51:29 -0500
Received: from mga12.intel.com ([192.55.52.136]:21059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726252AbeLKSv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Dec 2018 13:51:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Dec 2018 10:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,343,1539673200"; 
   d="scan'208";a="117948271"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by orsmga001.jf.intel.com with ESMTP; 11 Dec 2018 10:51:18 -0800
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Tue, 11 Dec 2018 10:51:17 -0800
Received: from hasmsx112.ger.corp.intel.com ([169.254.11.88]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.192]) with mapi id 14.03.0415.000;
 Tue, 11 Dec 2018 20:51:15 +0200
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
Thread-Index: AQHUh2ApCc7lmNGfg0mZ5cTxRsuvBaVrCVdwgA10uACAAKnQcIAAWQuAgABN2ZD///8HAIAAIouA///gsoCAACJtkA==
Date:   Tue, 11 Dec 2018 18:51:14 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB30133756BE7@HASMSX112.ger.corp.intel.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
 <20181128211959.GB178809@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
 <20181210222452.GC85090@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133754C00@HASMSX112.ger.corp.intel.com>
 <20181211135121.GB99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756A29@HASMSX112.ger.corp.intel.com>
 <20181211182630.GF99796@google.com>
 <0BA3FCBA62E2DC44AF3030971E174FB30133756B5D@HASMSX112.ger.corp.intel.com>
 <20181211183805.GG99796@google.com>
In-Reply-To: <20181211183805.GG99796@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTgwMDFjOGItNzRhNi00OGRiLWJmOGQtNmJhMmZmYjkyYTgxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiclRmdWxWem1PcUZvQ0tybHBCUUQ4WDJVY3dBenZhMGpCd1wvcFBsNWkxNWl2QUlCNmljTjlwNUgrYTBMODRiMlMifQ==
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
> On Tue, Dec 11, 2018 at 06:31:47PM +0000, Grumbach, Emmanuel wrote:
> > > On Tue, Dec 11, 2018 at 04:32:25PM +0000, Grumbach, Emmanuel wrote:
> > > > > On Tue, Dec 11, 2018 at 06:35:20AM +0000, Grumbach, Emmanuel
> wrote:
> > > > > > > > > > https://bugzilla.kernel.org/show_bug.cgi?id=201647
> > > > >
> > > > > > FWIW: I saw another problem like this with a 9650 device.
> > > > >
> > > > > Do you have a pointer to any info about this 9650 issue?  Maybe
> > > > > that would have a clue.
> > > >
> > > > I added him here so that you can ask whatever you like :) The
> > > > story is the same. I am attaching a picture I got from the reporter.
> > > > I can confirm that this device ID / subdevice ID is supported by
> > > > the linux
> > > driver.
> > >
> > > Was there a resolution, i.e., if somebody figured out how to make
> > > the
> > > 9650 wifi work, maybe a similar solution would work for the 3165?
> >
> > Unfortunately not, I am stuck there at the exact same point.
> > No Wifi device shows up in lspci...
> 
> Is there a public spec?  My patience for reverse engineering things that are
> documented somewhere that I'm not allowed to see is pretty limited.
> Presumably *you* should be able to see the spec, since this is an Intel device
> and you have an @intel.com address?

Ok, I start to understand. So no, no public spec. I am an Intel employee,
I used to maintain the WiFi driver (iwlwifi). I don't know much about PCI though.
I am definitely not asking you to reverse engineer our device :)
I can try to ask internally what could be going on.
The reason I haven't done so so far and reached out to you is because I am not
aware about switches that we need to toggle to make the device magically
show up. So I thought it'd be related to the PCI core, which take me to the next point...

> 
> From what we can tell so far, I don't *think* this is a PCI issue.  If the device
> doesn't respond to a PCI config access, the PCI core can't really be expected
> to do anything about it.

Ok, thanks. So I understand from you that you didn't see any weird log from the
PCI core saying: "I can see this device, but I can't enumerate it because XYZ".
I tried to look for such a thing but couldn't.

From this point, I guess I can't do much either. I'll try to get info internally.
