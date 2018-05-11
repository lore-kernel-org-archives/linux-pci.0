Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Return-Path: <SRS0=VBTT=H6=linux.intel.com=keith.busch@kernel.org>
Date: Fri, 11 May 2018 14:02:57 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Aron Griffis <aron@arongriffis.com>, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org
Subject: Re: PCIe unsupported request with Intel 760p
Message-ID: <20180511200256.GA7772@localhost.localdomain>
References: <CAKDfzeD5_AV=YtWqTPr=40vvW4oMFAs4gJs_r42PJWcb815zyQ@mail.gmail.com>
 <20180507123035.GA20097@gmail.com>
 <20180507134354.GF18116@bombadil.infradead.org>
 <20180507151246.GB20686@localhost.localdomain>
 <20180511193923.GJ190385@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180511193923.GJ190385@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 11, 2018 at 02:39:23PM -0500, Bjorn Helgaas wrote:
> Any update on this?  I'm pretty concerned about this issue because it
> *looks* like we're not doing anything that should cause this problem,
> and I don't know what we *could* do to avoid it.

The only update I have at the moment is that the sighting has been
opened and assigned to the development team. I'm afraid I do not have an
ETA on when we will get a response, much less a fix.
 
> The theory is that the Intel 760p NVMe is sending LTR messages even
> though it's configured to *not* send them.  It happens that Aron's
> system has a root port that doesn't support LTR, and it complains when
> it sees the messages.
> 
> Anybody who has the Intel 760p NVMe should be able to reproduce this.
> If the root port leading to the NVMe doesn't support LTR (its DevCap2
> would say "LTR-"), the same problem should occur.
> 
> If your root port *does* support LTR, you might be able to force this
> to happen by booting with "pcie_aspm=off" and then running this
> command where "bb:dd.f" is the bus/domain/function of the root port:
> 
>   # setpci -sbb:dd.f CAP_EXP+0x28.W=0:0x400
> 
> But I tried this on a root port leading to a different (non-NVMe)
> device with LTR enabled, and I didn't see any AER complaints about
> unexpected LTR messages, so maybe there's something I'm missing.

Hm, do you know if you were able to get the end device to transmit
an LTR while the root port had the capability disabled? Just a quick
glance through the spec suggests it should transmit one if you toggle
the capability off/on.

If the capability is disabled in the root/downstream port, and it
recieves an LTR, it should be treated as an Unsupported Request error.
That should trigger an AER if it's not masked and enabled to report it.

If everything is set up to make the error happen, but you're not seeing
one, it sounds like maybe the message is just getting discarded.
