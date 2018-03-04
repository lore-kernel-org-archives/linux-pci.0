Return-Path: <SRS0=VrDU=F2=gmail.com=htejun@kernel.org>
Return-Path: <SRS0=VrDU=F2=gmail.com=htejun@kernel.org>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sun, 4 Mar 2018 12:36:40 -0800
From: Tejun Heo <tj@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ahci/pci-quirks: Add PCI-id for the Highpoint
 Rocketraid 644L card
Message-ID: <20180304203640.GF231488@devbig577.frc2.facebook.com>
References: <20180302103633.10592-1-hdegoede@redhat.com>
 <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180302192907.GB202062@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 02, 2018 at 01:29:07PM -0600, Bjorn Helgaas wrote:
> On Fri, Mar 02, 2018 at 11:36:31AM +0100, Hans de Goede wrote:
> > Hi All,
> > 
> > Here are 2 patches adding support for Highpoint Rocketraid 644L cards,
> > they can be merged independently from each-other into their resp. subsys,
> > but since they belong together I'm sending them out as a series.
> 
> Seems like it'd be nice to keep these together, so Tejun, feel free to
> take both patches with my
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> on the pci/quirks.c patch.  If you'd prefer me to take them, just let
> me know.

Applied both to libata/for-4.16-fixes with ack added.

Thanks.

-- 
tejun
