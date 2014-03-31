Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47415 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377AbaCaPHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 31 Mar 2014 11:07:35 -0400
Message-ID: <533984A9.7030003@redhat.com>
Date: Mon, 31 Mar 2014 11:07:21 -0400
From: Prarit Bhargava <prarit@redhat.com>
MIME-Version: 1.0
To: Jean Delvare <jdelvare@suse.de>
CC: Neil Horman <nhorman@tuxdriver.com>,
	Joerg Roedel <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Subject: Re: Interrupt remapping quirk tainting the kernel
References: <1396253868.23070.94.camel@chaos.site>  <20140331105619.GA8050@hmsreliant.think-freely.org> <1396275485.23070.261.camel@chaos.site>
In-Reply-To: <1396275485.23070.261.camel@chaos.site>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/31/2014 10:18 AM, Jean Delvare wrote:
> Hi Neil,
> 
> Le Monday 31 March 2014 à 06:56 -0400, Neil Horman a écrit :
>> On Mon, Mar 31, 2014 at 10:17:48AM +0200, Jean Delvare wrote:
>>> Hi Neil and all,
>>>
>>> I have (once again) a question about this commit:
>>>
>>> From: Neil Horman <nhorman@tuxdriver.com>
>>> Date: Tue, 16 Apr 2013 20:38:32 +0000
>>> Subject: iommu/vt-d: add quirk for broken interrupt remapping on 55XX chipsets
>>> Git-commit: 03bbcb2e7e292838bb0244f5a7816d194c911d62
>>>
>>> When interrupt remapping is disabled by this quirk, the kernel gets
>>> tainted. What is the rationale for doing that?
>>>
>>> The user can boot with intremap=off. That will also disable interrupt
>>> remapping, as the quirk does, but not taint the kernel. If this is
>>> considered OK then I fail to see why the quirk should behave differently
>>> and taint the kernel.
>>>
>>> Thanks,
>> The quirk is intented to flag to the user the fact that BIOS has not followed
>> the recommended procedure that was laied out in the intel published errata
>> sheet.  Arguably you could say that we should still taint the kernel in the
>> event that intremap=off is still specified, but it seems pragmatic not to do so,
>> as the use of that option suggsts the administrator has asserted a workaround to
>> the problem that is identical to the fix (in the event that the BIOS vendor has
>> not released an update).
> 
> That doesn't really answer my question. While I understand that the
> preferred fix is that the BIOS disables the feature, how bad are we if
> it does not and the kernel has to do it?
> 
> We normally taint the kernel when the situation is such that debugging
> the kernel would be a waste of time. For example, because a binary
> driver was loaded, or a module was forcibly unloaded, etc. How does that
> apply here? 

There seems to be some misconception with various Enterprise Linux Support Teams
(plural emphasized ... I can only hope my support is paying attention) that
tainting only has one meaning.  In your definition we should only taint when
"debugging the kernel would be a waste of time".  I completely disagree with
that.  Many (if not most) of the time I as a engineer get only a stack trace
from a kernel (see pretty much every bug sent to LKML) that gives me useful
information on exactly what the kernel state was at the time of the stack trace.

In that stack trace there is an entry (for example)

CPU: 23 PID: 0 Comm: swapper/23 Not tainted 3.13.rc5+goredsox #1

which will/will not show TAINT entries.  These entries can be easily deciphered
from kernel/panic.c:

 *  'P' - Proprietary module has been loaded.
 *  'F' - Module has been forcibly loaded.
 *  'S' - SMP with CPUs not designed for SMP.
 *  'R' - User forced a module unload.
 *  'M' - System experienced a machine check exception.
 *  'B' - System has hit bad_page.
 *  'U' - Userspace-defined naughtiness.
 *  'D' - Kernel has oopsed before
 *  'A' - ACPI table overridden.
 *  'W' - Taint on warning.
 *  'C' - modules from drivers/staging are loaded.
 *  'I' - Working around severe firmware bug.
 *  'O' - Out-of-tree module has been loaded.

All of those are important to me as an engineer (and I'd like to add a few more
for support but that's really a RHEL thing).  Many of those, such as the "W" for
Taint on warning, are useful to me to let me know what the system state was when
the panic/oops/warning occurred.  They tell me if some critical situation has
occurred that led to the stack trace.

Taint does not and should not be taken as "we can't debug this." If you, or your
support organization has interpreted taint in that manner you should do all that
you can to inform them of the error of their ways.

tl;dr Tainting is supposed to aid in debugging, not prevent debugging.

If the quirk kicks in, aren't we just as safe as if the BIOS
> had disabled the feature? If not, then I would like to understand why,
> and document it properly.

In this case, yes, you are just as unsafe as if the BIOS had disabled the
feature.  The quirk completely disables the subsystem IIRC.  nhorman, of course,
can confirm.

P.
