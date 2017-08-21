Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Mon, 21 Aug 2017 13:00:30 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V10 2/3] PCI: handle CRS returned by device after FLR
Message-ID: <20170821180030.GB28977@bhelgaas-glaptop.roam.corp.google.com>
References: <1502470596-4112-1-git-send-email-okaya@codeaurora.org>
 <1502470596-4112-2-git-send-email-okaya@codeaurora.org>
 <20170818210134.GO28977@bhelgaas-glaptop.roam.corp.google.com>
 <4da26c10-3426-e752-4a59-25bb59cde8cd@codeaurora.org>
MIME-Version: 1.0
In-Reply-To: <4da26c10-3426-e752-4a59-25bb59cde8cd@codeaurora.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
 linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 21, 2017 at 09:44:09AM -0400, Sinan Kaya wrote:
> Hi Bjorn,
> 
> On 8/18/2017 5:01 PM, Bjorn Helgaas wrote:
> > On Fri, Aug 11, 2017 at 12:56:35PM -0400, Sinan Kaya wrote:
> >> Sporadic reset issues have been observed with Intel 750 NVMe drive while
> >> assigning the physical function to the guest machine. The sequence of
> >> events observed is as follows:
> >>
> >> - perform a Function Level Reset (FLR)
> >> - sleep up to 1000ms total
> >> - read ~0 from PCI_COMMAND
> >> - warn that the device didn't return from FLR
> >> - touch the device before it's ready
> >> - drop register read and writes performing register settings restore
> >> - incomplete reset operation and partial register restoration
> >> - second time device probe fails in the guest machine as HW is left in
> >> limbo.
> > 
> > Pardon me while I think out loud for a while.  It's taking me a while
> > to untangle my confusion about how CRS works.
> > 
> 
> no problem,
> 
> > Prior to this patch, you saw the "Failed to return from FLR" warning.
> > That means we did this:
> > 
> >      0ms  assert FLR
> >    100ms  read PCI_COMMAND, get ~0 (i == 0)
> >    200ms  read PCI_COMMAND, get ~0 (i == 1)
> >    ...
> >   1000ms  read PCI_COMMAND, get ~0 (i == 9)
> > 
> > If we did not get completions for those config reads, the root port
> > would complete the read as a failed transaction and probably
> > synthesize ~0 data.  
> 
> That's correct. This root port returns ~0 when destination is unreachable.
> 
> > But if that were the case, this patch would make
> > no difference: it reads PCI_VENDOR_ID instead of PCI_COMMAND the first
> > time around, that would also be a failed transaction, and we wouldn't
> > interpret it as a CRS status, so the sequence would be exactly the
> > above except the first read would be of PCI_VENDOR_ID, not
> > PCI_COMMAND.
> > 
> > Since this patch *does* make a difference, CRS Software Visibility
> > must be supported and enabled, and we must have gotten completions
> > with CRS status for the PCI_COMMAND reads.  
> 
> That's right, CRS visibility is supported and enabled. Root port returns
> 0xFFFF0001 when vendor ID is read as per the spec.
> 
> > Per the completion
> > handling rules in sec 2.3.2, the root complex should transparently
> > retry the read (since we're not reading PCI_VENDOR_ID, CRS Software
> > Visibility doesn't apply, so this is invisible to software).  But the
> > root complex *is* allowed to limit the number of retries and if the
> > limit is reached, complete the request as a failed transaction.
> 
> This version of the root port doesn't support retry mechanism. This is a
> TO-DO for the hardware team. This root port returns ~0 for all accesses
> other than vendor id. This means we waited 1 seconds and the device
> was not accessible. Command register was not reachable at the end of
> 1 seconds.

OK.  Since the spec says the root complex must re-issue the request,
but also says it may limit the number of retries (without saying what
that limit should be), I don't think we can assume any.  I think zero
is a valid number of retries, so I'd say this HW conforms
to the spec as-is.

> > That must be what happened before this patch.  If that's the case, we
> > should see an error logged from the failed transaction.  We should be
> > able to verify this if we collected "lspci -vv" output for the system
> > before and after the FLR.
> 
> See above.

It would still be interesting to see the lspci output.  Likely <MAbort
in the upstream bridge will be set even before the FLR because of
aborts during enumeration.  The PCI core should probably clear that
after enumeration.  I expect that if you manually clear it with
setpci, do the lspci, do the FLR, do another lspci, you will probably
see <MAbort being set by this pci_flr_wait() loop.  We might want to
consider clearing it here as well.

> > If CRS SV is not present (or not enabled), the PCI_VENDOR_ID read will
> > still get a CRS completion, but the root port will retry it instead of
> > returning the 0x0001 ID.  When we hit the retry limit, the root port
> > will synthesize ~0 data to complete the read.
> 
> This is what is missing from the HW. I'm trying to get this corrected
> to be complete.

>From what you've described I don't see a HW issue here.  It might be
nice for other reasons for the HW to reissue config accesses that
receive a CRS completion, but the spec seems to allow the current
behavior.

> > That means we won't call pci_bus_wait_crs() at all, and we'll fall
> > back to the original PCI_COMMAND reads.  That path will only wait
> > 1000ms, just like the original code before this patch.  So I *think*
> > that if you disable CRS SV on this system (or if you put the device in
> > a system that doesn't support CRS SV), you'll probably see the same
> > "failed to return from FLR" warning.
> > 
> > You could easily test this by using setpci to turn off
> > PCI_EXP_RTCTL_CRSSVE in the root port leading to the NVMe device
> > before the FLR.
> > 
> > I think the implication is that we need to generalize
> > pci_bus_wait_crs() to be more of a "wait for device ready" interface
> > that can use CRS SV (if supported and enabled) or something like the
> > PCI_COMMAND loop (if no CRS SV).  It should use the same timeout
> > either way, since CRS SV is a property of the root port, not of the
> > device we're waiting for.
> 
> I saw your comment about timeout. I was trying not to change the behavior
> for systems that do not support CRS visibility. we can certainly increase
> the timeout if you think it is better.

I think it's important that we use the same timeout.  If we leave them
different, on systems that support CRS SV, we'll wait up to 60 sec and
the FLR will work fine, but on systems that don't, we'll only wait 1 sec
and the FLR will fail.

Bjorn

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
