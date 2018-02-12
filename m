Return-Path: <SRS0=jAyG=FG=gmail.com=alexander.duyck@kernel.org>
Return-Path: <SRS0=jAyG=FG=gmail.com=alexander.duyck@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180212174341.GC75542@bhelgaas-glaptop.roam.corp.google.com>
References: <1516710549-26660-1-git-send-email-arjun@chelsio.com> <20180212174341.GC75542@bhelgaas-glaptop.roam.corp.google.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 12 Feb 2018 09:56:58 -0800
Message-ID: <CAKgT0Ucr7SZURefYtCSziNhPF_cc66tT7GzSp0u43-2tJ=Lt_A@mail.gmail.com>
Subject: Re: [REGRESSION, bisect] pci: cxgb4 probe fails after commit
 104daa71b3961434 ("PCI: Determine actual VPD size on first access")
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Arjun Vynipadath <arjun@chelsio.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	Netdev <netdev@vger.kernel.org>, Casey Leedom <leedom@chelsio.com>,
	Santosh Raspatur <santosh@chelsio.com>, Ganesh Goudar <ganeshgr@chelsio.com>, nirranjan@chelsio.com,
	kumaras@chelsio.com, swise@opengridcomputing.com,
	Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 12, 2018 at 9:43 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Tue, Jan 23, 2018 at 05:59:09PM +0530, Arjun Vynipadath wrote:
>> Sending on behalf of "Casey Leedom <leedom@chelsio.com>"
>>
>> Way back on April 11, 2016 we reported a regression in Linux kernel 4.6-rc2
>> brought on by kernel.org commit 104daa71b396. This commit calculates the
>> size of a PCI Device's VPD area by parsing the VPD Structure at offset 0x000,
>> and restricts accesses to the VPD to that computed size.
>>
>> Our devices have a second VPD structure which is located starting at offset
>> 0x400 which is the "real" VPD[1].  The 104daa71b396 commit (plus a follow on
>> commit 408641e93aa5) caused efforts to read past the end of that computed
>> length of the VPD to return silently without error leaving stack junk in the
>> VPD read buffers.
>>
>> We introduced kernel.org commit cb92148b to allow a driver to tell the
>> kernel how large the VPD area really is, introducing a new API
>> pci_set_vpd_size() for this purpose.
>>
>> Now we've discovered a new subtlety to the problem.
>>
>> We have a KVM Hypervisor running a 4.9.70 kernel.  So it has all of the
>> above commits.  When we attach our Physical Function 4 to a Virtual Machine
>> and attempt to run cxgb4 in that VM, we see the problem again.  The issue is
>> that all of the VM Guest OS's efforts to access the PCIe VPD Capability are
>> trapped into the KVM 4.9.70 kernel and executed there, with the results
>> routed back to the VM Guest OS.  The cxgb4 driver in the VM Guest OS uses
>> the new pci_set_vpd_size() to notify the OS of the true size of the VPD, but
>> that information of course is never sent to the KVM 4.9.70 Hypervisor.
>> (And, truth be told, if the Guest OS were older than 4.6, it wouldn't even
>> know that it needed to do this.)  The result is that again we get silent VPD
>> read failures with random stack garbage in the VPD read buffers. (sigh)
>
> Let me pull out one tiny piece of this problem: If the VPD read
> returns failure, the caller should not look at the read buffer.  But
> we should *never* copy random stack garbage into the read buffer, no
> matter what the VPD read returns.
>
> I guess it's the 4.9.70 kernel that's putting garbage into the VPD
> read buffer?  Is this something that needs to be fixed in the current
> upstream kernel?

My guess would be that it is not random stack garbage that is being
put in the read. If the read buffer was not initialized it will
contain random data. I suspect that is what we are likely seeing is
the use of uninitialized memory for the read buffer.

There should already be a fix for this that was added in commit
1c7de2b4ff88 "PCI: Enable access to non-standard VPD for Chelsio
devices (cxgb3)". If you are missing device IDs you need to add them
to the existing quirk in order to make certain all your devices are
covered. Just adding the quirk to your driver won't fix the issue.
Adding a workaround to KVM that allows for you to circumvent this
would just make for a huge security hole since as I recall one of the
reasons why we were putting the limits on this in the first place was
because access to uninitialized VPD memory on some devices was causing
some pretty serious issues.

- Alex
