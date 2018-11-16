Return-Path: <SRS0=UeAH=N3=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7636AC43441
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 464D62087C
	for <linux-pci@archiver.kernel.org>; Fri, 16 Nov 2018 12:37:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 464D62087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeKPWtK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 16 Nov 2018 17:49:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26169 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389685AbeKPWtK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Nov 2018 17:49:10 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-110-sHBmeO1DNEmY3fg_B1RTqw-1; Fri, 16 Nov 2018 12:36:54 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri,
 16 Nov 2018 12:37:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 16 Nov 2018 12:37:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexandru Gagniuc' <mr.nuke.me@gmail.com>,
        "helgaas@google.com" <helgaas@google.com>
CC:     "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "Shyam_Iyer@Dell.com" <Shyam_Iyer@Dell.com>,
        "lukas@wunner.de" <lukas@wunner.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Topic: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Thread-Index: AQHUfTk7lFmreXBXOEO6S+wDoXDgXaVSVjAw
Date:   Fri, 16 Nov 2018 12:37:00 +0000
Message-ID: <ab363e80d45e4c3d91770c1b1010d1ce@AcuMS.aculab.com>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
In-Reply-To: <20181115231605.24352-1-mr.nuke.me@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: sHBmeO1DNEmY3fg_B1RTqw-1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alexandru Gagniuc
> Sent: 15 November 2018 23:16
...
> I've asked around a few people at Dell and they unanimously agree that
> _OSC is the correct way to determine ownership of AER.

This is all very well, but we have systems (they might be Dell ones)
where failure of a PCIe link (even when all the drivers are removed)
causes an NMI - and crashes the kernel.

There are other systems which have AER registers available for
some of the PCIe devices, but the BIOS ignores them and _OSC
doesn't let the kernel take control.
In this case the AER registers can contain useful information
after a read returns ~0u.
It would be useful to be able to get this information without
having to grovel through all the PCIe config space.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

