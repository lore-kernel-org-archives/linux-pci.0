Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1334310754.17013.YahooMailNeo@web161804.mail.bf1.yahoo.com> <201204150011.53556.rjw@sisk.pl> <1334486385.82898.YahooMailNeo@web161803.mail.bf1.yahoo.com> <201204152030.23148.rjw@sisk.pl>
Message-ID: <1334553341.70819.YahooMailNeo@web161806.mail.bf1.yahoo.com>
Date: Sun, 15 Apr 2012 22:15:41 -0700 (PDT)
From: Mikko Vinni <mmvinni@yahoo.com>
Reply-To: Mikko Vinni <mmvinni@yahoo.com>
Subject: Re: [linux-pm] "i8042: Can't reactivate AUX port" after s2ram on 3.4-rc2
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Allen Kay <allen.m.kay@intel.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
In-Reply-To: <201204152030.23148.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Rafael J. Wysocki

>
> Do you still have the kernel where all PCI devices worked correctly after system
> resume?

If you are talking about https://bugzilla.kernel.org/show_bug.cgi?id=35452,
I am not aware of such a kernel. That bug has existed for as long as I have
cared to test.

Testing the patch v4 soon.


Mikko

