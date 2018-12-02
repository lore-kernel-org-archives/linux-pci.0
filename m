Return-Path: <SRS0=dd4N=OL=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD6CC04EB8
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 06:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CF4206B7
	for <linux-pci@archiver.kernel.org>; Sun,  2 Dec 2018 06:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77CF4206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbeLBG5n convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:57:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:1952 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725379AbeLBG5n (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 Dec 2018 01:57:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Dec 2018 22:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,305,1539673200"; 
   d="scan'208";a="122193112"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by fmsmga004.fm.intel.com with ESMTP; 01 Dec 2018 22:57:39 -0800
Received: from fmsmsx157.amr.corp.intel.com (10.18.116.73) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 1 Dec 2018 22:57:39 -0800
Received: from hasmsx106.ger.corp.intel.com (10.184.198.20) by
 FMSMSX157.amr.corp.intel.com (10.18.116.73) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sat, 1 Dec 2018 22:57:38 -0800
Received: from hasmsx112.ger.corp.intel.com ([169.254.11.97]) by
 HASMSX106.ger.corp.intel.com ([169.254.10.88]) with mapi id 14.03.0415.000;
 Sun, 2 Dec 2018 08:57:36 +0200
From:   "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "bjorn@helgaas.com" <bjorn@helgaas.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Mertarg10@gmail.com" <Mertarg10@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Thread-Topic: Fwd: [Bug 201647] New: Intel Wireless card 3165 does not get
 detected but bluetooth works
Thread-Index: AQHUh2ApCc7lmNGfg0mZ5cTxRsuvBaVrCVdw
Date:   Sun, 2 Dec 2018 06:57:35 +0000
Message-ID: <0BA3FCBA62E2DC44AF3030971E174FB3013373E4A3@HASMSX112.ger.corp.intel.com>
References: <bug-201647-193951@https.bugzilla.kernel.org/>
 <CABhMZUXc4FS-f52ZDsErEhbkm_jjEz+kn75YO5Tuvp42Qm+1xw@mail.gmail.com>
 <20181128211959.GB178809@google.com>
In-Reply-To: <20181128211959.GB178809@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjIwY2I2ZDUtNTFiMy00NjQyLTkxZDQtNzg2MWU5YTIxYTQwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieTJzNDNLcUpBTFlGdm1OOU8rdGNqVk96UHRudkZRbzhmdDQ0ZVpYZHVoc3NJTkFIWlVSVHRxUW80TlVEeTJhRyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.12.85.151]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> 
> [+cc Emmanuel, LKML]
> 
> On Fri, Nov 09, 2018 at 03:43:06PM -0600, Bjorn Helgaas wrote:
> > ---------- Forwarded message ---------
> > From: <bugzilla-daemon@bugzilla.kernel.org>
> > Date: Fri, Nov 9, 2018 at 4:10 AM
> > Subject: [Bug 201647] New: Intel Wireless card 3165 does not get
> > detected but bluetooth works
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=201647
> >
> >             Bug ID: 201647
> >            Summary: Intel Wireless card 3165 does not get detected but
> >                     bluetooth works
> >            Product: Drivers
> >            Version: 2.5
> >     Kernel Version: 4.19.1
> >           Hardware: Intel
> >                 OS: Linux
> >               Tree: Mainline
> >             Status: NEW
> >           Severity: high
> >           Priority: P1
> >          Component: PCI
> >           Assignee: drivers_pci@kernel-bugs.osdl.org
> >           Reporter: Mertarg10@gmail.com
> >         Regression: No
> >
> > This bug affects most of the devices with a Celeron N4000 and an Intel
> > wifi 3165 Ac adapter.
> >
> > When using Linux wifi is not working however, Bluetooth is working
> > fine.  Also, Bluetooth part of this chip is connected via btusb and
> > the wifi part of this chip is connected via PCIe.
> 
> Can you attach a screenshot of the Windows 10 device manager info for the
> wifi adapter to the bugzilla?  If you can get a raw hex dump of its config
> space, that would be awesome.
> 
> Also attach a copy of your kernel .config file (typically in /boot/).
> 
> My only guess is that maybe the system keeps wifi completely powered
> down and uses hotplug to add it when needed.  [1] mentions wifi being on
> pcibus 1 under Windows.  Your lspci does show bridge 00:13.0 leading to bus
> 01, but Linux doesn't find any devices on bus 01.
> 
> Hotplug could be done via either acpiphp (ACPI mediated hotplug) or pciehp
> (native PCIe hotplug).  Your dmesg shows you do have acpiphp.
> 
> I can't tell about pciehp (your .config will show that), but I think pciehp will
> only claim bridges where SltCap contains HotPlug+, and yours shows HotPlug-
> , so I don't think pciehp will do anything on your system.
> 
> Even if the system does use hotplug, I don't know what mechanism the OS
> would use to wake up the device, since we don't know it even exists.  I guess
> there could be some magic switch accessible via USB.
> But if that were the case, I'm sure Emmanuel would know about it.
> 

Hm... Don't be so sure... :)
I don't think we have anything as fancy as this.
I guess you can try to dig into the BIOS settings?
I have heard of such a switch that would make the device disappear.

