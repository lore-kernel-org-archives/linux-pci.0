Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [RFD][PATCH 2/7] PM / QoS: Introduce request and constraint data types for PM QoS flags
Date: Sat, 29 Sep 2012 23:36:22 +0200
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Huang Ying <ying.huang@intel.com>,
	Sarah Sharp <sarah.a.sharp@linux.intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Jean Pihet <j-pihet@ti.com>,
	linux-pci@vger.kernel.org,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	mark gross <markgross@thegnar.org>
References: <201209282351.10663.rjw@sisk.pl> <201209282352.49615.rjw@sisk.pl> <50668F01.7030406@intel.com>
In-Reply-To: <50668F01.7030406@intel.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201209292336.22960.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Saturday, September 29, 2012, Lan Tianyu wrote:
> On 2012/9/29 5:52, Rafael J. Wysocki wrote:
> > Index: linux/kernel/power/qos.c
> > ===================================================================
> > --- linux.orig/kernel/power/qos.c
> > +++ linux/kernel/power/qos.c
> > @@ -213,6 +213,69 @@ int pm_qos_update_target(struct pm_qos_c
> >   }
> >
> >   /**
> > + * pm_qos_flags_remove_req - Remove device PM QoS flags request.
> > + * @f: Device PM QoS flags set to remove the request from.
> -------^
> A typo     	
> > + * @req: Request to remove from the set.
> > + */

Yes, thanks!

Rafael
