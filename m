Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:10992
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755363AbaJ2IJw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 29 Oct 2014 04:09:52 -0400
Date: Wed, 29 Oct 2014 16:08:09 +0800
From: Huang Rui <ray.huang@amd.com>
To: Felipe Balbi <balbi@ti.com>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	USB list <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 13/19] usb: dwc3: add tx demphasis quirk
Message-ID: <20141029080809.GB10840@hr-slim.amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
 <1414497280-3126-14-git-send-email-ray.huang@amd.com>
 <CAErSpo6ouE7AZi8ysTFnTNtKc8R9w-71AhXe6b-_0g_yeR-=Ag@mail.gmail.com>
 <20141028184303.GD25735@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141028184303.GD25735@saruman>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 28, 2014 at 01:43:03PM -0500, Felipe Balbi wrote:
> On Tue, Oct 28, 2014 at 10:27:27AM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 28, 2014 at 5:54 AM, Huang Rui <ray.huang@amd.com> wrote:
> > > This patch adds Tx demphasis quirk, and the Tx demphasis value is
> > 
> > "demphasis" (above and in subject) should be "de-emphasis" as used in
> > the code and comments below.
> 
> +1
> 

OK, will update
