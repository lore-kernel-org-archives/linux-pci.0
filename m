Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Aug 2013 11:43:02 +0200
From: Borislav Petkov <bp@alien8.de>
To: Mauro Carvalho Chehab <m.chehab@samsung.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	tony.luck@intel.com, bhelgaas@google.com, rostedt@goodmis.org,
	rjw@sisk.pl, lance.ortiz@hp.com, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mce: acpi/apei: trace: Enable ghes memory error
 trace event
Message-ID: <20130815094302.GB27616@pd.tnic>
References: <1375986471-27113-4-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <20130808163822.67e0828a@samsung.com>
 <20130810180322.GC4155@pd.tnic>
 <20130812083355.47c1bae8@samsung.com>
 <5208D80D.5030206@linux.vnet.ibm.com>
 <20130812125343.GE18018@pd.tnic>
 <520A16BD.30201@linux.vnet.ibm.com>
 <20130813124258.GC4077@pd.tnic>
 <520A6D98.9060204@linux.vnet.ibm.com>
 <20130814210035.57096048@concha.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20130814210035.57096048@concha.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Aug 14, 2013 at 09:00:35PM -0300, Mauro Carvalho Chehab wrote:
> I agree: per-type of error events is better than a big generic one.

There are many types of hardware errors and having a single TP for each
is not a good design. Especially if the error formats are comparable
to a high degree. We probably would end up with a nice sensible
classification of having only a handful of TPs covering *all* hardware
events.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
