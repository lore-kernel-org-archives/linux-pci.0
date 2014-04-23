Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e06smtp11.uk.ibm.com ([195.75.94.107]:36235 "EHLO
	e06smtp11.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997AbaDWJAh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Apr 2014 05:00:37 -0400
Received: from /spool/local
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <sebott@linux.vnet.ibm.com>;
	Wed, 23 Apr 2014 10:00:35 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
	by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id CFA2C17D8062
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2014 10:01:31 +0100 (BST)
Received: from d06av05.portsmouth.uk.ibm.com (d06av05.portsmouth.uk.ibm.com [9.149.37.229])
	by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s3N90Wbg56688766
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2014 09:00:32 GMT
Received: from d06av05.portsmouth.uk.ibm.com (localhost [127.0.0.1])
	by d06av05.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s3N90V5g031882
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2014 03:00:32 -0600
Date: Wed, 23 Apr 2014 11:00:29 +0200 (CEST)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
To: Michal Simek <monstr@monstr.eu>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [Resend] pcibios_add_platform_entries usage
In-Reply-To: <5357623F.7080805@monstr.eu>
Message-ID: <alpine.LFD.2.11.1404231059370.1615@denkbrett>
References: <alpine.LFD.2.11.1403281931410.1516@denkbrett> <alpine.LFD.2.11.1404141101500.1529@denkbrett> <20140414173541.GA4417@google.com> <alpine.LFD.2.11.1404141958120.1561@denkbrett> <alpine.LFD.2.11.1404171938190.1588@denkbrett> <1397768575.32730.70.camel@pasglop>
 <alpine.LFD.2.11.1404181154450.1609@denkbrett> <1397856690.32730.110.camel@pasglop> <alpine.LFD.2.11.1404221024550.1607@denkbrett> <5357623F.7080805@monstr.eu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463805518-376787632-1398243631=:1615"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463805518-376787632-1398243631=:1615
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Wed, 23 Apr 2014, Michal Simek wrote:

> On 04/22/2014 10:26 AM, Sebastian Ott wrote:
> > On Sat, 19 Apr 2014, Benjamin Herrenschmidt wrote:
> >> On Fri, 2014-04-18 at 12:10 +0200, Sebastian Ott wrote:
> >>> On Fri, 18 Apr 2014, Benjamin Herrenschmidt wrote:
> >>>> On Thu, 2014-04-17 at 19:46 +0200, Sebastian Ott wrote:
> >>>>
> >>>>> pci: move open fabric devspec attribute to pci common code
> >>>>>
> >>>>> Move the devspec OF attribute to pci common code's set of device
> >>>>> attributes since it's not architecture dependent.
> >>>>> As a side effect microblaze and powerpc no longer need to use
> >>>>> pcibios_add_platform_entries.
> >>>>>
> >>>>> Link: https://lkml.kernel.org/r/alpine.LFD.2.11.1404141101500.1529@denkbrett
> >>>>> Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
> >>>>
> >>>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> >>>>
> >>>> (Pending you've compile tested it on powerpc, I'm on vacation and
> >>>> haven't done it :)
> >>>
> >>> I did:
> >>> make ARCH=powerpc CROSS_COMPILE=powerpc64-4.3.2- g5_defconfig
> >>> make ARCH=powerpc CROSS_COMPILE=powerpc64-4.3.2-
> >>>
> >>> and failed with:
> >>>   CC      arch/powerpc/lib/xor_vmx.o
> >>> In file included from include/linux/list.h:4,
> >>>                  from include/linux/preempt.h:10,
> >>>                  from arch/powerpc/lib/xor_vmx.c:22:
> >>> include/linux/types.h:29: error: both ‘unsigned’ and ‘_Bool’ in declaration specifiers
> >>> cc1: warnings being treated as errors
> >>> include/linux/types.h:29: error: useless type name in empty declaration
> >>
> >> Not sure what's up here, did you try with a more recent compiler ? 4.3
> >> is pretty ancient by kernel standards.
> >>
> >> You can find cross compilers there:
> >>
> >> https://www.kernel.org/pub/tools/crosstool/
> >>
> >> They aren't the newest either but they should work.
> > 
> > Yes. That did the trick.
> 
> Hope that you did the same for microblaze or just push the repo/branch with these
> patches to zero-day testing system and you got the results.

Yes, I compile-tested microblaze too.

Regards,
Sebastian
> 
> Thanks,
> Michal
> 
> 
> -- 
> Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
> w: www.monstr.eu p: +42-0-721842854
> Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
> Maintainer of Linux kernel - Xilinx Zynq ARM architecture
> Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform
> 
> 
> 
---1463805518-376787632-1398243631=:1615--

