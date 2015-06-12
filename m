Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 12 Jun 2015 09:14:05 -0700
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Jake Oshins <jakeo@microsoft.com>
Cc: Paul Bolle <pebolle@tiscali.nl>, "olaf@aepfle.de" <olaf@aepfle.de>,
	Mike Ebersol <Michael.Ebersol@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"apw@canonical.com" <apw@canonical.com>,
	"devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Subject: Re: [PATCH 6/6] drivers:pci:hv: New paravirtual PCI front-end for
 Hyper-V VMs
Message-ID: <20150612161405.GA15911@kroah.com>
References: <1434039747-44535-1-git-send-email-jakeo@microsoft.com>
 <1434039747-44535-7-git-send-email-jakeo@microsoft.com>
 <1434098643.2271.141.camel@x220>
 <DM2PR0301MB12323CC0C1132A7F71C79DD3ABBB0@DM2PR0301MB1232.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DM2PR0301MB12323CC0C1132A7F71C79DD3ABBB0@DM2PR0301MB1232.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jun 12, 2015 at 03:11:14PM +0000, Jake Oshins wrote:
> This driver is intended to support both full PCI Express device pass through and also be the basis for SR-IOV networking on top of Hyper-V.  These functions would allow somebody trying to make their NIC driver work on top of Hyper-V to exchange messages with their back-end Windows driver.
> 
> My question is this.  How does somebody delivering a platform usually work with the Linux community to deliver enablement code like this?  I'm trying to work in the open, and go upstream early (or at least I think that understand what these things mean.)  If the community doesn't want functions that have no callers (and I understand that, too) then how should I provide them to the NIC vendors?

You add the functions in a patch series along with the NIC driver that
uses it.  We don't add functions with no callers, sorry.

hope this helps,

greg k-h
