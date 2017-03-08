Return-Path: <SRS0=IPgH=2R=intel.com=ashok.raj@kernel.org>
Return-Path: <SRS0=IPgH=2R=intel.com=ashok.raj@kernel.org>
Date: Wed, 8 Mar 2017 04:27:26 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-kernel@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
	ashok.raj@intel.com
Subject: Re: [PATCH] pciehp: Fix race condition handling surprise link-down
Message-ID: <20170308122726.6phvemtqgyowoa7l@araj-mobl1>
References: <1481317564-18045-1-git-send-email-ashok.raj@intel.com>
 <20170203025901.GA15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170203060053.GA240323@otc-nc-03>
 <20170203165104.GC15080@bhelgaas-glaptop.roam.corp.google.com>
 <20170307002417.GA21358@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170307002417.GA21358@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Mar 06, 2017 at 06:24:17PM -0600, Bjorn Helgaas wrote:
> On Fri, Feb 03, 2017 at 10:51:04AM -0600, Bjorn Helgaas wrote:
> 
> Hi Ashok,
> 
> Just a ping to make sure we're not deadlocked.  I'm waiting for you,
> so I hope you're not also waiting for me :)  I'm not trying to rush you;
> I just don't want to drop this by mistake.
> 
Hi Bjorn

no we aren't deadlocked :-). I didn't get around changing it to ordered
queue yet, mostly worried about having to retest all the different 
combinations with ATTN, POWER_CTL, SLD.

I'm depending on other folks to test SLD. They are tied up with other
issues ATM.

I have had another OEM test with several disks and multiple ATTN's 
pressed/cancel and current code seems to be working well so far, except the 
SLD case.

The change in the patch was only ensuring that we don't start another 
POWER_ON or POWER_OFF before the earlier operation was complete.

Would it be alright to fix SLD with this version while we can probe a clean
approach that can give us sufficient time to test a clean approach that works
with all the different combinations and OEM systems?

Cheers
Ashok
