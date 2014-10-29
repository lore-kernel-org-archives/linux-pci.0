Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 29 Oct 2014 15:44:16 +0800
From: Huang Rui <ray.huang@amd.com>
To: Bjorn Helgaas <bhelgaas@google.com>
CC: Felipe Balbi <balbi@ti.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	"Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
	Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Jason Chang <jason.chang@amd.com>,
	"Vincent Wan" <vincent.wan@amd.com>, Tony Li <tony.li@amd.com>,
	USB list <linux-usb@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 05/19] usb: dwc3: add lpm erratum support
Message-ID: <20141029074416.GA10840@hr-slim.amd.com>
References: <1414497280-3126-1-git-send-email-ray.huang@amd.com>
 <1414497280-3126-6-git-send-email-ray.huang@amd.com>
 <CAErSpo7JeiJSD+-XAMZH+D8r9Knkq80KPUroYYbqak6EQ6f4RA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAErSpo7JeiJSD+-XAMZH+D8r9Knkq80KPUroYYbqak6EQ6f4RA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Oct 28, 2014 at 10:30:50AM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 28, 2014 at 5:54 AM, Huang Rui <ray.huang@amd.com> wrote:
> > When parameter DWC_USB3_LPM_ERRATA_ENABLE is enabled in Andvanced
> 
> "Advanced"
> 
> > Configuration of coreConsultant, it supports of xHCI BESL Errata Dated
> 
> I can't parse "is supports of" and I don't know enough to suggest an
> alternate wording.
> 
> > 10/19/2011 is enabled in host mode. In device mode it adds the capability
> > to send NYET response threshold based on the BESL value received in the LPM
> > token, and the threhold is configurable for each soc platform.
> 
> "threshold"
> 

Thanks to reminder.

It should be:
When parameter DWC_USB3_LPM_ERRATA_ENABLE is enabled in Advanced
Configuration of coreConsultant, support of xHCI BESL Errata Dated
10/19/2011 is enabled in host mode. In device mode it adds the
capability to send NYET response threshold based on the BESL value
received in the LPM token, and the threshold is configurable for each
SoC platform.

Thanks,
Rui
