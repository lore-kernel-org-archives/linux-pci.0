Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:26040 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215Ab3HOTUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Aug 2013 15:20:31 -0400
From: "Luck, Tony" <tony.luck@intel.com>
To: Mauro Carvalho Chehab <m.chehab@samsung.com>,
	Borislav Petkov <bp@alien8.de>
CC: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>,
	"rjw@sisk.pl" <rjw@sisk.pl>,
	"lance.ortiz@hp.com" <lance.ortiz@hp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Date: Thu, 15 Aug 2013 19:20:29 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F31CBD184@ORSMSX106.amr.corp.intel.com>
References: <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812125343.GE18018@pd.tnic> <520A16BD.30201@linux.vnet.ibm.com>
 <20130813124258.GC4077@pd.tnic> <520A6D98.9060204@linux.vnet.ibm.com>
 <20130813175809.GE4077@pd.tnic> <520B6282.6030906@linux.vnet.ibm.com>
 <20130814212211.544ee6a4@concha.lan> <20130815093831.GA27616@pd.tnic>
 <20130815102607.7168a930@samsung.com> <20130815134454.GF27616@pd.tnic>
 <20130815111407.4080a744@samsung.com>
In-Reply-To: <20130815111407.4080a744@samsung.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> AFAIKT, APEI doesn't provide the silkscreen label. Some code (or some
> datasheet) is needed to translate between what APEI provides into the
> silkscreen label.

In theory it could. The ACPI generic error structure used to report includes
a 20-byte free format field which a BIOS could use to describe the location
of the error.  Haven't seen anyone do this yet - and our internal BIOS people
looked at me like I was crazy to suggest such a thing.  But I still entertain
hopes that some OEM will do the right thing and raise the bar of usefulness.

-Tony
