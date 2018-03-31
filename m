Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Return-Path: <SRS0=s/JU=GV=linux.intel.com=mika.westerberg@kernel.org>
Date: Sat, 31 Mar 2018 13:12:31 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Mario Limonciello <Mario.Limonciello@dell.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <yehezkel.bernat@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linux PCI <linux-pci@vger.kernel.org>,
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] PCI: Make sure all bridges reserve at least one
 bus number
Message-ID: <20180331101231.GW2703@lahna.fi.intel.com>
References: <20180328114346.GZ2703@lahna.fi.intel.com>
 <20180328180906.GI7759@bhelgaas-glaptop.roam.corp.google.com>
 <20180329115911.GN2703@lahna.fi.intel.com>
 <20180331082903.GA21051@wunner.de>
 <20180331085852.GQ2703@lahna.fi.intel.com>
 <20180331091245.GA10720@wunner.de>
 <20180331092017.GS2703@lahna.fi.intel.com>
 <CAJZ5v0iFP3VuJoMD2PXp73WoszB3rDFpro6Sgy5PnrVp0Zz0zQ@mail.gmail.com>
 <20180331095615.GT2703@lahna.fi.intel.com>
 <CAJZ5v0hUHZQDYnzhORReCZkTyszQBvSARLnDrc-8N4nfFHt2wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAJZ5v0hUHZQDYnzhORReCZkTyszQBvSARLnDrc-8N4nfFHt2wA@mail.gmail.com>
List-ID: <linux-pci.vger.kernel.org>

On Sat, Mar 31, 2018 at 12:05:50PM +0200, Rafael J. Wysocki wrote:
> I also think that it would be good to put the above example somewhere
> like a git commit changelog or even a comment in the code, so people
> in the future don't have to wonder what this is all about.

Sure, I'll add this information to the changelogs of the next revision
of the patch series.
