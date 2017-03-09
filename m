Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 9 Mar 2017 08:37:42 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170309143742.GA3685@bhelgaas-glaptop.roam.corp.google.com>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
 <20170203025901.GA15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170203060053.GA240323@otc-nc-03>
 <20170203165104.GC15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170307002417.GA21358@bhelgaas-glaptop.roam.corp.google.com>
 <20170308122726.6phvemtqgyowoa7l@araj-mobl1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170308122726.6phvemtqgyowoa7l@araj-mobl1>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Mar 08, 2017 at 04:27:26AM -0800, Raj, Ashok wrote:
> On Mon, Mar 06, 2017 at 06:24:17PM -0600, Bjorn Helgaas wrote:
> > On Fri, Feb 03, 2017 at 10:51:04AM -0600, Bjorn Helgaas wrote:
> > 
> > Hi Ashok,
> > 
> > Just a ping to make sure we're not deadlocked.  I'm waiting for you,
> > so I hope you're not also waiting for me :)  I'm not trying to rush you;
> > I just don't want to drop this by mistake.
> > 
> Hi Bjorn
> 
> no we aren't deadlocked :-). I didn't get around changing it to ordered
> queue yet, mostly worried about having to retest all the different 
> combinations with ATTN, POWER_CTL, SLD.
> 
> I'm depending on other folks to test SLD. They are tied up with other
> issues ATM.
> 
> I have had another OEM test with several disks and multiple ATTN's 
> pressed/cancel and current code seems to be working well so far, except the 
> SLD case.
> 
> The change in the patch was only ensuring that we don't start another 
> POWER_ON or POWER_OFF before the earlier operation was complete.
> 
> Would it be alright to fix SLD with this version while we can probe a clean
> approach that can give us sufficient time to test a clean approach that works
> with all the different combinations and OEM systems?

This version avoids some SLD issues, but we can't guarantee that it is
a complete solution.

I don't really like to put in an incomplete solution because it
reduces the urgency for doing a proper fix, and it also complicates
debugging if we trip over an SLD issue we haven't seen yet during
testing.

Bjorn
