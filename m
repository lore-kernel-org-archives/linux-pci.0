Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from e28smtp02.in.ibm.com ([122.248.162.2]:60647 "EHLO
	e28smtp02.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbaFQFpJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 17 Jun 2014 01:45:09 -0400
Received: from /spool/local
	by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pci@vger.kernel.org> from <yan@linux.vnet.ibm.com>;
	Tue, 17 Jun 2014 11:15:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by d28dlp01.in.ibm.com (Postfix) with ESMTP id D2784E0045
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 11:16:07 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s5H5jFMc44040430
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 11:15:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s5H5j1IS031753
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2014 11:15:01 +0530
Date: Tue, 17 Jun 2014 13:44:57 +0800
From: Guo Chao <yan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: don't UNSET resource even reassign fails
Message-ID: <20140617054457.GA30758@yanx>
References: <1402918182-13082-1-git-send-email-yan@linux.vnet.ibm.com>
 <CAErSpo5KepA52w0G2aa2y0-5W32FAkxoVQ+Kdo+hHsR2270Oxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
In-Reply-To: <CAErSpo5KepA52w0G2aa2y0-5W32FAkxoVQ+Kdo+hHsR2270Oxw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 16, 2014 at 02:44:34PM -0600, Bjorn Helgaas wrote:
> On Mon, Jun 16, 2014 at 5:29 AM, Guo Chao <yan@linux.vnet.ibm.com> wrote:
> > Commit bd064f0a sets IORESOURCE_UNSET flag if resource can not be
> > assgined. Part of these changes breaks resource assignment.
> >
> > If resource is too big, PCI core assgins basic part first and
> > extends (reassigns) it to include optional part (notably SR-IOV resources).
> > In this case, failure is permitted and IORESOURCE_UNSET should be not set.
> > Otherwise, these resources are never updated to hardware even they are
> > already propery assigned and we will see errors like this:
> >
> >         pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
> >         pci 0003:00:00.0: Error enabling bridge (-22), continuing
> 
> Please attach a complete dmesg log so I can look at this in more
> detail.  Thanks!
> 

It again appeared in the new machine and cards so it may not proper to
send complete dmesg in public list. Attachment is an excerpt related to
resource assignment.

Host bridge only exposes 2G 32-bit MMIO and we have a large SR-IOV BAR in
domain 0003.

> pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0x204000000)
> pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
> pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)

Too big to at the first round.

> pci 0003:00:00.0: BAR 15: assigned [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
> pci 0003:00:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580effffff]

Assign basic part. Success.

> 0003:00:00.0: BAR 15: can't assign mem pref (size 0xc000000)

Reassign it to include optional part. Fail.

(IORESOURCE_UNSET remains set even the resource is actually valid.)

The same process happened to 0003:01:00.0. Then you can see the error
messages in the end of the log.

Thanks,
Guo Chao

> > Signed-off-by: Guo Chao <yan@linux.vnet.ibm.com>
> > ---
> >  drivers/pci/setup-res.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> > index caed1ce..1e1076a 100644
> > --- a/drivers/pci/setup-res.c
> > +++ b/drivers/pci/setup-res.c
> > @@ -334,12 +334,14 @@ int pci_reassign_resource(struct pci_dev *dev, int resno, resource_size_t addsiz
> >         new_size = resource_size(res) + addsize;
> >         ret = _pci_assign_resource(dev, resno, new_size, min_align);
> >         if (!ret) {
> > -               res->flags &= ~IORESOURCE_UNSET;
> >                 res->flags &= ~IORESOURCE_STARTALIGN;
> >                 dev_info(&dev->dev, "BAR %d: reassigned %pR\n", resno, res);
> >                 if (resno < PCI_BRIDGE_RESOURCES)
> >                         pci_update_resource(dev, resno);
> >         }
> > +
> > +       res->flags &= ~IORESOURCE_UNSET;
> > +
> >         return ret;
> >  }
> >
> > --
> > 1.8.3.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=pci-log

[    1.441010] pci 0001:00:00.0: BAR 14: assigned [mem 0x3d01800000000-0x3d01801ffffff]
[    1.441084] pci 0001:00:00.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.441166] pci 0001:00:00.0: BAR 13: can't assign io (size 0x3000)
[    1.441228] pci 0001:00:00.0: BAR 13: can't assign io (size 0x3000)
[    1.441299] pci 0001:01:00.0: BAR 14: assigned [mem 0x3d01800000000-0x3d018017fffff]
[    1.441371] pci 0001:01:00.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.441455] pci 0001:01:00.0: BAR 0: assigned [mem 0x3d01801800000-0x3d0180183ffff]
[    1.441530] pci 0001:01:00.0: BAR 13: can't assign io (size 0x3000)
[    1.441591] pci 0001:01:00.0: BAR 13: can't assign io (size 0x3000)
[    1.441681] pci 0001:02:01.0: BAR 14: assigned [mem 0x3d01800000000-0x3d018007fffff]
[    1.441754] pci 0001:02:01.0: BAR 15: assigned [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.441837] pci 0001:02:08.0: BAR 14: assigned [mem 0x3d01800800000-0x3d01800ffffff]
[    1.441909] pci 0001:02:08.0: BAR 15: assigned [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.441992] pci 0001:02:09.0: BAR 14: assigned [mem 0x3d01801000000-0x3d018017fffff]
[    1.442064] pci 0001:02:09.0: BAR 15: assigned [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.442146] pci 0001:02:01.0: BAR 13: can't assign io (size 0x1000)
[    1.442206] pci 0001:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.442267] pci 0001:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.442329] pci 0001:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.442389] pci 0001:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.442449] pci 0001:02:01.0: BAR 13: can't assign io (size 0x1000)
[    1.442509] pci 0001:02:01.0: PCI bridge to [bus 03-07]
[    1.442566] pci 0001:02:01.0:   bridge window [mem 0x3d01800000000-0x3d018007fffff]
[    1.442642] pci 0001:02:01.0:   bridge window [mem 0x3d01802000000-0x3d018027fffff 64bit pref]
[    1.442820] pci 0001:08:00.0: BAR 6: assigned [mem 0x3d01800800000-0x3d0180081ffff pref]
[    1.442893] pci 0001:08:00.0: BAR 0: assigned [mem 0x3d01800820000-0x3d0180082ffff 64bit]
[    1.442980] pci 0001:08:00.0: BAR 2: assigned [mem 0x3d01800830000-0x3d0180083ffff 64bit]
[    1.443094] pci 0001:08:00.0: BAR 7: assigned [mem 0x3d01800840000-0x3d01800a3ffff 64bit]
[    1.443207] pci 0001:08:00.0: BAR 9: assigned [mem 0x3d01800a40000-0x3d01800c3ffff 64bit]
[    1.443294] pci 0001:02:08.0: PCI bridge to [bus 08]
[    1.443348] pci 0001:02:08.0:   bridge window [mem 0x3d01800800000-0x3d01800ffffff]
[    1.443425] pci 0001:02:08.0:   bridge window [mem 0x3d01802800000-0x3d01802ffffff 64bit pref]
[    1.443602] pci 0001:09:00.0: BAR 6: assigned [mem 0x3d01801000000-0x3d0180101ffff pref]
[    1.443676] pci 0001:09:00.0: BAR 0: assigned [mem 0x3d01801020000-0x3d0180102ffff 64bit]
[    1.443763] pci 0001:09:00.0: BAR 2: assigned [mem 0x3d01801030000-0x3d0180103ffff 64bit]
[    1.443877] pci 0001:09:00.0: BAR 7: assigned [mem 0x3d01801040000-0x3d0180123ffff 64bit]
[    1.443991] pci 0001:09:00.0: BAR 9: assigned [mem 0x3d01801240000-0x3d0180143ffff 64bit]
[    1.444078] pci 0001:02:09.0: PCI bridge to [bus 09]
[    1.444132] pci 0001:02:09.0:   bridge window [mem 0x3d01801000000-0x3d018017fffff]
[    1.444207] pci 0001:02:09.0:   bridge window [mem 0x3d01803000000-0x3d018037fffff 64bit pref]
[    1.444297] pci 0001:01:00.0: PCI bridge to [bus 02-09]
[    1.444351] pci 0001:01:00.0:   bridge window [mem 0x3d01800000000-0x3d018017fffff]
[    1.444427] pci 0001:01:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.444517] pci 0001:00:00.0: PCI bridge to [bus 01-09]
[    1.444570] pci 0001:00:00.0:   bridge window [mem 0x3d01800000000-0x3d01801ffffff]
[    1.444646] pci 0001:00:00.0:   bridge window [mem 0x3d01802000000-0x3d018037fffff 64bit pref]
[    1.444782] pci 0002:00:00.0: BAR 14: assigned [mem 0x3d04800000000-0x3d048007fffff]
[    1.444855] pci 0002:00:00.0: BAR 15: assigned [mem 0x3d04800800000-0x3d04800ffffff 64bit pref]
[    1.447092] pci 0002:01:00.0: BAR 6: assigned [mem 0x3d04800000000-0x3d0480007ffff pref]
[    1.447164] pci 0002:01:00.1: BAR 6: assigned [mem 0x3d04800080000-0x3d048000fffff pref]
[    1.447676] pci 0002:01:00.0: BAR 7: assigned [mem 0x3d04800800000-0x3d0480093ffff 64bit pref]
[    1.448476] pci 0002:01:00.1: BAR 7: assigned [mem 0x3d04800940000-0x3d04800a7ffff 64bit pref]
[    1.448846] pci 0002:01:00.0: BAR 0: assigned [mem 0x3d04800a80000-0x3d04800a87fff 64bit pref]
[    1.449197] pci 0002:01:00.1: BAR 0: assigned [mem 0x3d04800a88000-0x3d04800a8ffff 64bit pref]
[    1.449541] pci 0002:01:00.0: BAR 4: assigned [mem 0x3d04800a90000-0x3d04800a90fff 64bit pref]
[    1.449893] pci 0002:00:00.0: PCI bridge to [bus 01]
[    1.449947] pci 0002:00:00.0:   bridge window [mem 0x3d04800000000-0x3d048007fffff]
[    1.450022] pci 0002:00:00.0:   bridge window [mem 0x3d04800800000-0x3d04800ffffff 64bit pref]
[    1.450290] pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0x204000000)
[    1.450363] pci 0003:00:00.0: BAR 14: assigned [mem 0x3d05800000000-0x3d05802ffffff]
[    1.450434] pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
[    1.450496] pci 0003:00:00.0: BAR 15: assigned [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
[    1.450579] pci 0003:00:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580effffff]
[    1.450652] pci 0003:00:00.0: BAR 15: can't assign mem pref (size 0xc000000)
[    1.450726] pci 0003:00:00.0: BAR 13: can't assign io (size 0x4000)
[    1.450795] pci 0003:01:00.0: BAR 15: can't assign mem pref (size 0x204000000)
[    1.450867] pci 0003:01:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.450939] pci 0003:01:00.0: BAR 0: assigned [mem 0x3d0580e800000-0x3d0580e83ffff]
[    1.451015] pci 0003:01:00.0: BAR 13: can't assign io (size 0x4000)
[    1.451076] pci 0003:01:00.0: BAR 15: assigned [mem 0x3d05800000000-0x3d0580bffffff 64bit pref]
[    1.451159] pci 0003:01:00.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.451231] pci 0003:01:00.0: BAR 0: assigned [mem 0x3d0580e800000-0x3d0580e83ffff]
[    1.451308] pci 0003:01:00.0: BAR 15: can't assign mem pref (size 0xc000000)
[    1.451383] pci 0003:01:00.0: BAR 13: can't assign io (size 0x4000)
[    1.451467] pci 0003:02:09.0: BAR 15: can't assign mem pref (size 0x200000000)
[    1.451538] pci 0003:02:01.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.451610] pci 0003:02:08.0: BAR 14: assigned [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.451684] pci 0003:02:08.0: BAR 15: assigned [mem 0x3d05800000000-0x3d058007fffff 64bit pref]
[    1.451767] pci 0003:02:09.0: BAR 14: assigned [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.451839] pci 0003:02:10.0: BAR 14: assigned [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.451911] pci 0003:02:10.0: BAR 15: assigned [mem 0x3d05800800000-0x3d05800ffffff 64bit pref]
[    1.451994] pci 0003:02:11.0: BAR 14: assigned [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.452066] pci 0003:02:11.0: BAR 15: assigned [mem 0x3d05801000000-0x3d058017fffff 64bit pref]
[    1.452148] pci 0003:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.452209] pci 0003:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.452268] pci 0003:02:10.0: BAR 13: can't assign io (size 0x1000)
[    1.452329] pci 0003:02:11.0: BAR 13: can't assign io (size 0x1000)
[    1.452392] pci 0003:02:09.0: BAR 15: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.452475] pci 0003:02:01.0: BAR 14: assigned [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.452548] pci 0003:02:08.0: BAR 14: assigned [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.452622] pci 0003:02:09.0: BAR 14: assigned [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.452694] pci 0003:02:10.0: BAR 14: assigned [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.452766] pci 0003:02:10.0: BAR 15: assigned [mem 0x3d05808000000-0x3d058087fffff 64bit pref]
[    1.452849] pci 0003:02:11.0: BAR 14: assigned [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.452920] pci 0003:02:11.0: BAR 15: assigned [mem 0x3d05808800000-0x3d05808ffffff 64bit pref]
[    1.453004] pci 0003:02:11.0: BAR 13: can't assign io (size 0x1000)
[    1.453063] pci 0003:02:10.0: BAR 13: can't assign io (size 0x1000)
[    1.453125] pci 0003:02:09.0: BAR 15: can't assign mem pref (size 0x8000000)
[    1.453200] pci 0003:02:09.0: BAR 13: can't assign io (size 0x1000)
[    1.453260] pci 0003:02:08.0: BAR 15: assigned [mem 0x3d05809000000-0x3d058097fffff 64bit pref]
[    1.453343] pci 0003:02:08.0: BAR 13: can't assign io (size 0x1000)
[    1.453405] pci 0003:03:00.0: BAR 0: assigned [mem 0x3d0580c000000-0x3d0580c00ffff 64bit]
[    1.453494] pci 0003:03:00.0: BAR 2: assigned [mem 0x3d0580c010000-0x3d0580c011fff 64bit]
[    1.453582] pci 0003:02:01.0: PCI bridge to [bus 03]
[    1.453640] pci 0003:02:01.0:   bridge window [mem 0x3d0580c000000-0x3d0580c7fffff]
[    1.453814] pci 0003:04:00.0: BAR 6: assigned [mem 0x3d0580c800000-0x3d0580c81ffff pref]
[    1.453887] pci 0003:04:00.0: BAR 0: assigned [mem 0x3d0580c820000-0x3d0580c82ffff 64bit]
[    1.453975] pci 0003:04:00.0: BAR 2: assigned [mem 0x3d0580c830000-0x3d0580c83ffff 64bit]
[    1.454090] pci 0003:04:00.0: BAR 7: assigned [mem 0x3d0580c840000-0x3d0580ca3ffff 64bit]
[    1.454205] pci 0003:04:00.0: BAR 9: assigned [mem 0x3d0580ca40000-0x3d0580cc3ffff 64bit]
[    1.454292] pci 0003:02:08.0: PCI bridge to [bus 04]
[    1.454347] pci 0003:02:08.0:   bridge window [mem 0x3d0580c800000-0x3d0580cffffff]
[    1.454423] pci 0003:02:08.0:   bridge window [mem 0x3d05809000000-0x3d058097fffff 64bit pref]
[    1.454671] pci 0003:05:00.0: BAR 2: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.455004] pci 0003:05:00.0: BAR 9: can't assign mem pref (size 0x1f8000000)
[    1.455077] pci 0003:05:00.0: BAR 0: assigned [mem 0x3d0580d000000-0x3d0580d0fffff 64bit]
[    1.455246] pci 0003:05:00.0: BAR 6: assigned [mem 0x3d0580d100000-0x3d0580d1fffff pref]
[    1.455319] pci 0003:05:00.0: BAR 2: assigned [mem 0x3d05800000000-0x3d05807ffffff 64bit pref]
[    1.455499] pci 0003:05:00.0: BAR 0: assigned [mem 0x3d0580d000000-0x3d0580d0fffff 64bit]
[    1.455666] pci 0003:05:00.0: BAR 6: assigned [mem 0x3d0580d100000-0x3d0580d1fffff pref]
[    1.455894] pci 0003:05:00.0: BAR 9: can't assign mem pref (size 0x1f8000000)
[    1.455965] pci 0003:02:09.0: PCI bridge to [bus 05]
[    1.456019] pci 0003:02:09.0:   bridge window [mem 0x3d0580d000000-0x3d0580d7fffff]
[    1.456095] pci 0003:02:09.0:   bridge window [mem size 0x08000000 64bit pref]
[    1.456177] pci 0003:06:00.0: BAR 6: assigned [mem 0x3d0580d800000-0x3d0580d87ffff pref]
[    1.456250] pci 0003:06:00.1: BAR 6: assigned [mem 0x3d0580d880000-0x3d0580d8fffff pref]
[    1.456322] pci 0003:06:00.2: BAR 6: assigned [mem 0x3d0580d900000-0x3d0580d97ffff pref]
[    1.456394] pci 0003:06:00.3: BAR 6: assigned [mem 0x3d0580d980000-0x3d0580d9fffff pref]
[    1.456466] pci 0003:06:00.0: BAR 0: assigned [mem 0x3d05808000000-0x3d0580800ffff 64bit pref]
[    1.456565] pci 0003:06:00.0: BAR 2: assigned [mem 0x3d05808010000-0x3d0580801ffff 64bit pref]
[    1.456665] pci 0003:06:00.0: BAR 4: assigned [mem 0x3d05808020000-0x3d0580802ffff 64bit pref]
[    1.456765] pci 0003:06:00.1: BAR 0: assigned [mem 0x3d05808030000-0x3d0580803ffff 64bit pref]
[    1.456865] pci 0003:06:00.1: BAR 2: assigned [mem 0x3d05808040000-0x3d0580804ffff 64bit pref]
[    1.456965] pci 0003:06:00.1: BAR 4: assigned [mem 0x3d05808050000-0x3d0580805ffff 64bit pref]
[    1.457065] pci 0003:06:00.2: BAR 0: assigned [mem 0x3d05808060000-0x3d0580806ffff 64bit pref]
[    1.457166] pci 0003:06:00.2: BAR 2: assigned [mem 0x3d05808070000-0x3d0580807ffff 64bit pref]
[    1.457265] pci 0003:06:00.2: BAR 4: assigned [mem 0x3d05808080000-0x3d0580808ffff 64bit pref]
[    1.457366] pci 0003:06:00.3: BAR 0: assigned [mem 0x3d05808090000-0x3d0580809ffff 64bit pref]
[    1.457465] pci 0003:06:00.3: BAR 2: assigned [mem 0x3d058080a0000-0x3d058080affff 64bit pref]
[    1.457566] pci 0003:06:00.3: BAR 4: assigned [mem 0x3d058080b0000-0x3d058080bffff 64bit pref]
[    1.457665] pci 0003:02:10.0: PCI bridge to [bus 06]
[    1.457719] pci 0003:02:10.0:   bridge window [mem 0x3d0580d800000-0x3d0580dffffff]
[    1.457795] pci 0003:02:10.0:   bridge window [mem 0x3d05808000000-0x3d058087fffff 64bit pref]
[    1.457889] pci 0003:07:00.0: BAR 6: assigned [mem 0x3d0580e000000-0x3d0580e07ffff pref]
[    1.457961] pci 0003:07:00.1: BAR 6: assigned [mem 0x3d0580e080000-0x3d0580e0fffff pref]
[    1.458033] pci 0003:07:00.2: BAR 6: assigned [mem 0x3d0580e100000-0x3d0580e17ffff pref]
[    1.458105] pci 0003:07:00.3: BAR 6: assigned [mem 0x3d0580e180000-0x3d0580e1fffff pref]
[    1.458182] pci 0003:07:00.0: BAR 0: assigned [mem 0x3d05808800000-0x3d0580880ffff 64bit pref]
[    1.458282] pci 0003:07:00.0: BAR 2: assigned [mem 0x3d05808810000-0x3d0580881ffff 64bit pref]
[    1.458382] pci 0003:07:00.0: BAR 4: assigned [mem 0x3d05808820000-0x3d0580882ffff 64bit pref]
[    1.458482] pci 0003:07:00.1: BAR 0: assigned [mem 0x3d05808830000-0x3d0580883ffff 64bit pref]
[    1.458581] pci 0003:07:00.1: BAR 2: assigned [mem 0x3d05808840000-0x3d0580884ffff 64bit pref]
[    1.458682] pci 0003:07:00.1: BAR 4: assigned [mem 0x3d05808850000-0x3d0580885ffff 64bit pref]
[    1.458781] pci 0003:07:00.2: BAR 0: assigned [mem 0x3d05808860000-0x3d0580886ffff 64bit pref]
[    1.458882] pci 0003:07:00.2: BAR 2: assigned [mem 0x3d05808870000-0x3d0580887ffff 64bit pref]
[    1.458982] pci 0003:07:00.2: BAR 4: assigned [mem 0x3d05808880000-0x3d0580888ffff 64bit pref]
[    1.459081] pci 0003:07:00.3: BAR 0: assigned [mem 0x3d05808890000-0x3d0580889ffff 64bit pref]
[    1.459182] pci 0003:07:00.3: BAR 2: assigned [mem 0x3d058088a0000-0x3d058088affff 64bit pref]
[    1.459281] pci 0003:07:00.3: BAR 4: assigned [mem 0x3d058088b0000-0x3d058088bffff 64bit pref]
[    1.459381] pci 0003:02:11.0: PCI bridge to [bus 07]
[    1.459436] pci 0003:02:11.0:   bridge window [mem 0x3d0580e000000-0x3d0580e7fffff]
[    1.459511] pci 0003:02:11.0:   bridge window [mem 0x3d05808800000-0x3d05808ffffff 64bit pref]
[    1.459602] pci 0003:01:00.0: PCI bridge to [bus 02-07]
[    1.459656] pci 0003:01:00.0:   bridge window [mem 0x3d0580c000000-0x3d0580e7fffff]
[    1.459731] pci 0003:01:00.0:   bridge window [mem size 0x0c000000 64bit pref]
[    1.459810] pci 0003:00:00.0: PCI bridge to [bus 01-07]
[    1.459864] pci 0003:00:00.0:   bridge window [mem 0x3d0580c000000-0x3d0580effffff]
[    1.459939] pci 0003:00:00.0:   bridge window [mem size 0x0c000000 64bit pref]
[    1.460079] pci 0004:00:00.0: BAR 14: assigned [mem 0x3d20800000000-0x3d208007fffff]
[    1.460151] pci 0004:00:00.0: BAR 15: assigned [mem 0x3d20800800000-0x3d208047fffff 64bit pref]
[    1.460526] pci 0004:01:00.0: BAR 0: assigned [mem 0x3d20800800000-0x3d20800ffffff 64bit pref]
[    1.460624] pci 0004:01:00.0: BAR 2: assigned [mem 0x3d20801000000-0x3d208017fffff 64bit pref]
[    1.460724] pci 0004:01:00.1: BAR 0: assigned [mem 0x3d20801800000-0x3d20801ffffff 64bit pref]
[    1.460823] pci 0004:01:00.1: BAR 2: assigned [mem 0x3d20802000000-0x3d208027fffff 64bit pref]
[    1.460922] pci 0004:01:00.0: BAR 6: assigned [mem 0x3d20800000000-0x3d2080007ffff pref]
[    1.460995] pci 0004:01:00.1: BAR 6: assigned [mem 0x3d20800080000-0x3d208000fffff pref]
[    1.461094] pci 0004:01:00.0: BAR 11: assigned [mem 0x3d20802800000-0x3d20802ffffff 64bit pref]
[    1.461221] pci 0004:01:00.1: BAR 11: assigned [mem 0x3d20803000000-0x3d208037fffff 64bit pref]
[    1.461320] pci 0004:01:00.0: BAR 4: assigned [mem 0x3d20803800000-0x3d2080380ffff 64bit pref]
[    1.461447] pci 0004:01:00.0: BAR 7: assigned [mem 0x3d20803810000-0x3d20803c0ffff 64bit pref]
[    1.461546] pci 0004:01:00.1: BAR 4: assigned [mem 0x3d20803c10000-0x3d20803c1ffff 64bit pref]
[    1.461676] pci 0004:01:00.1: BAR 7: assigned [mem 0x3d20803c20000-0x3d2080401ffff 64bit pref]
[    1.461777] pci 0004:00:00.0: PCI bridge to [bus 01]
[    1.461831] pci 0004:00:00.0:   bridge window [mem 0x3d20800000000-0x3d208007fffff]
[    1.461906] pci 0004:00:00.0:   bridge window [mem 0x3d20800800000-0x3d208047fffff 64bit pref]
[    1.462029] pci 0005:00:00.0: BAR 14: assigned [mem 0x3d21800000000-0x3d218007fffff]
[    1.462102] pci 0005:00:00.0: BAR 15: assigned [mem 0x3d21800800000-0x3d218067fffff 64bit pref]
[    1.462752] pci 0005:01:00.0: BAR 0: assigned [mem 0x3d21800800000-0x3d21800ffffff 64bit pref]
[    1.462852] pci 0005:01:00.0: BAR 2: assigned [mem 0x3d21801000000-0x3d218017fffff 64bit pref]
[    1.462951] pci 0005:01:00.1: BAR 0: assigned [mem 0x3d21801800000-0x3d21801ffffff 64bit pref]
[    1.463051] pci 0005:01:00.1: BAR 2: assigned [mem 0x3d21802000000-0x3d218027fffff 64bit pref]
[    1.463150] pci 0005:01:00.2: BAR 0: assigned [mem 0x3d21802800000-0x3d21802ffffff 64bit pref]
[    1.463249] pci 0005:01:00.2: BAR 2: assigned [mem 0x3d21803000000-0x3d218037fffff 64bit pref]
[    1.463348] pci 0005:01:00.3: BAR 0: assigned [mem 0x3d21803800000-0x3d21803ffffff 64bit pref]
[    1.463448] pci 0005:01:00.3: BAR 2: assigned [mem 0x3d21804000000-0x3d218047fffff 64bit pref]
[    1.463547] pci 0005:01:00.0: BAR 6: assigned [mem 0x3d21800000000-0x3d2180003ffff pref]
[    1.463619] pci 0005:01:00.1: BAR 6: assigned [mem 0x3d21800040000-0x3d2180007ffff pref]
[    1.463692] pci 0005:01:00.2: BAR 6: assigned [mem 0x3d21800080000-0x3d218000bffff pref]
[    1.463764] pci 0005:01:00.3: BAR 6: assigned [mem 0x3d218000c0000-0x3d218000fffff pref]
[    1.463864] pci 0005:01:00.0: BAR 11: assigned [mem 0x3d21804800000-0x3d21804ffffff 64bit pref]
[    1.463990] pci 0005:01:00.1: BAR 11: assigned [mem 0x3d21805000000-0x3d218057fffff 64bit pref]
[    1.464090] pci 0005:01:00.0: BAR 4: assigned [mem 0x3d21805800000-0x3d2180580ffff 64bit pref]
[    1.464216] pci 0005:01:00.0: BAR 7: assigned [mem 0x3d21805810000-0x3d21805c0ffff 64bit pref]
[    1.464316] pci 0005:01:00.1: BAR 4: assigned [mem 0x3d21805c10000-0x3d21805c1ffff 64bit pref]
[    1.464442] pci 0005:01:00.1: BAR 7: assigned [mem 0x3d21805c20000-0x3d2180601ffff 64bit pref]
[    1.464541] pci 0005:01:00.2: BAR 4: assigned [mem 0x3d21806020000-0x3d2180602ffff 64bit pref]
[    1.464641] pci 0005:01:00.3: BAR 4: assigned [mem 0x3d21806030000-0x3d2180603ffff 64bit pref]
[    1.464740] pci 0005:00:00.0: PCI bridge to [bus 01]
[    1.464795] pci 0005:00:00.0:   bridge window [mem 0x3d21800000000-0x3d218007fffff]
[    1.464871] pci 0005:00:00.0:   bridge window [mem 0x3d21800800000-0x3d218067fffff 64bit pref]
[    1.464994] pci 0006:00:00.0: BAR 14: assigned [mem 0x3d24800000000-0x3d248007fffff]
[    1.465067] pci 0006:00:00.0: BAR 15: assigned [mem 0x3d24800800000-0x3d248017fffff 64bit pref]
[    1.518333] pci 0006:01:00.0: BAR 6: assigned [mem 0x3d24800000000-0x3d2480007ffff pref]
[    1.518405] pci 0006:01:00.1: BAR 6: assigned [mem 0x3d24800080000-0x3d248000fffff pref]
[    1.518477] pci 0006:01:00.2: BAR 6: assigned [mem 0x3d24800100000-0x3d2480017ffff pref]
[    1.518549] pci 0006:01:00.3: BAR 6: assigned [mem 0x3d24800180000-0x3d248001fffff pref]
[    1.518621] pci 0006:01:00.4: BAR 6: assigned [mem 0x3d24800200000-0x3d2480027ffff pref]
[    1.518693] pci 0006:01:00.5: BAR 6: assigned [mem 0x3d24800280000-0x3d248002fffff pref]
[    1.520062] pci 0006:01:00.0: BAR 7: assigned [mem 0x3d24800800000-0x3d24800cfffff 64bit pref]
[    1.522296] pci 0006:01:00.1: BAR 7: assigned [mem 0x3d24800d00000-0x3d248011fffff 64bit pref]
[    1.524544] pci 0006:01:00.2: BAR 7: assigned [mem 0x3d24801200000-0x3d2480133ffff 64bit pref]
[    1.526839] pci 0006:01:00.3: BAR 7: assigned [mem 0x3d24801340000-0x3d2480147ffff 64bit pref]
[    1.529073] pci 0006:01:00.4: BAR 7: assigned [mem 0x3d24801480000-0x3d248015bffff 64bit pref]
[    1.531441] pci 0006:01:00.5: BAR 7: assigned [mem 0x3d248015c0000-0x3d248016fffff 64bit pref]
[    1.532459] pci 0006:01:00.0: BAR 0: assigned [mem 0x3d24801700000-0x3d24801707fff 64bit pref]
[    1.533473] pci 0006:01:00.1: BAR 0: assigned [mem 0x3d24801708000-0x3d2480170ffff 64bit pref]
[    1.534396] pci 0006:01:00.2: BAR 0: assigned [mem 0x3d24801710000-0x3d24801717fff 64bit pref]
[    1.535318] pci 0006:01:00.3: BAR 0: assigned [mem 0x3d24801718000-0x3d2480171ffff 64bit pref]
[    1.536316] pci 0006:01:00.4: BAR 0: assigned [mem 0x3d24801720000-0x3d24801727fff 64bit pref]
[    1.537321] pci 0006:01:00.5: BAR 0: assigned [mem 0x3d24801728000-0x3d2480172ffff 64bit pref]
[    1.538318] pci 0006:01:00.0: BAR 4: assigned [mem 0x3d24801730000-0x3d24801730fff 64bit pref]
[    1.539327] pci 0006:00:00.0: PCI bridge to [bus 01]
[    1.539424] pci 0006:00:00.0:   bridge window [mem 0x3d24800000000-0x3d248007fffff]
[    1.539564] pci 0006:00:00.0:   bridge window [mem 0x3d24800800000-0x3d248017fffff 64bit pref]
[    1.539692] pci 0007:00:00.0: BAR 15: assigned [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.539776] pci 0007:00:00.0: BAR 14: assigned [mem 0x3d25801000000-0x3d258017fffff]
[    1.539849] pci 0007:01:00.0: BAR 2: assigned [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.539950] pci 0007:01:00.0: BAR 0: assigned [mem 0x3d25801000000-0x3d2580103ffff 64bit]
[    1.540039] pci 0007:01:00.0: BAR 6: assigned [mem 0x3d25801040000-0x3d2580105ffff pref]
[    1.540112] pci 0007:00:00.0: PCI bridge to [bus 01]
[    1.540166] pci 0007:00:00.0:   bridge window [mem 0x3d25801000000-0x3d258017fffff]
[    1.540242] pci 0007:00:00.0:   bridge window [mem 0x3d25800000000-0x3d25800ffffff 64bit pref]
[    1.540344] pci 0000:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.540656] pci 0000:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.540966] pci 0001:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.541276] pci 0001:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.541585] pci 0001:02     : [PE# 003] Secondary bus 2 associated with PE#3
[    1.541962] pci 0001:03     : [PE# 004] Secondary bus 3 associated with PE#4
[    1.542338] pci 0001:08     : [PE# 005] Secondary bus 8 associated with PE#5
[    1.542715] pci 0001:09     : [PE# 006] Secondary bus 9 associated with PE#6
[    1.543091] pci 0002:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.543469] pci 0002:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.543845] pci 0003:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.544220] pci 0003:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.544595] pci 0003:02     : [PE# 003] Secondary bus 2 associated with PE#3
[    1.544972] pci 0003:03     : [PE# 004] Secondary bus 3 associated with PE#4
[    1.545347] pci 0003:04     : [PE# 005] Secondary bus 4 associated with PE#5
[    1.545722] pci 0003:05     : [PE# 006] Secondary bus 5 associated with PE#6
[    1.546098] pci 0003:06     : [PE# 007] Secondary bus 6 associated with PE#7
[    1.546409] pci 0003:07     : [PE# 008] Secondary bus 7 associated with PE#8
[    1.546719] pci 0004:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.547029] pci 0004:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.547339] pci 0005:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.547649] pci 0005:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.547959] pci 0006:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.548270] pci 0006:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.548580] pci 0007:00     : [PE# 001] Secondary bus 0 associated with PE#1
[    1.548890] pci 0007:01     : [PE# 002] Secondary bus 1 associated with PE#2
[    1.550172] PCI: Domain 0000 has 8 available 32-bit DMA segments
[    1.550232] PCI: 0 PE# for a total weight of 0
[    1.550279] PCI: Domain 0001 has 8 available 32-bit DMA segments
[    1.550339] PCI: 2 PE# for a total weight of 30
[    1.550387] pci 0001:08     : [PE# 005] Assign DMA32 space
[    1.550435] pci 0001:08     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
[    1.627692] IOMMU table initialized, virtual merging enabled
[    1.627784] pci 0001:08     : [PE# 005] Enabling 64-bit DMA bypass
[    1.627860] pci 0001:09     : [PE# 006] Assign DMA32 space
[    1.627920] pci 0001:09     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
[    1.704475] pci 0001:09     : [PE# 006] Enabling 64-bit DMA bypass
[    1.704618] PCI: Domain 0002 has 8 available 32-bit DMA segments
[    1.704732] PCI: 1 PE# for a total weight of 20
[    1.704825] pci 0002:01     : [PE# 002] Assign DMA32 space
[    1.704981] pci 0002:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    1.780308] pci 0002:01     : [PE# 002] Enabling 64-bit DMA bypass
[    1.780370] PCI: Domain 0003 has 8 available 32-bit DMA segments
[    1.780429] PCI: 5 PE# for a total weight of 115
[    1.780477] pci 0003:06     : [PE# 007] Assign DMA32 space
[    1.780525] pci 0003:06     : [PE# 007] Setting up 32-bit TCE table at 0..80000000
[    1.855688] pci 0003:06     : [PE# 007] Enabling 64-bit DMA bypass
[    1.855784] pci 0003:07     : [PE# 008] Assign DMA32 space
[    1.855843] pci 0003:07     : [PE# 008] Setting up 32-bit TCE table at 0..80000000
[    1.931042] pci 0003:07     : [PE# 008] Enabling 64-bit DMA bypass
[    1.931105] pci 0003:04     : [PE# 005] Assign DMA32 space
[    1.931153] pci 0003:04     : [PE# 005] Setting up 32-bit TCE table at 0..80000000
[    2.006335] pci 0003:04     : [PE# 005] Enabling 64-bit DMA bypass
[    2.006414] pci 0003:03     : [PE# 004] Assign DMA32 space
[    2.006473] pci 0003:03     : [PE# 004] Setting up 32-bit TCE table at 0..80000000
[    2.081697] pci 0003:03     : [PE# 004] Enabling 64-bit DMA bypass
[    2.081790] pci 0003:05     : [PE# 006] Assign DMA32 space
[    2.081850] pci 0003:05     : [PE# 006] Setting up 32-bit TCE table at 0..80000000
[    2.157032] pci 0003:05     : [PE# 006] Enabling 64-bit DMA bypass
[    2.157094] PCI: Domain 0004 has 8 available 32-bit DMA segments
[    2.157153] PCI: 1 PE# for a total weight of 20
[    2.157201] pci 0004:01     : [PE# 002] Assign DMA32 space
[    2.157249] pci 0004:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.232703] pci 0004:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.232765] PCI: Domain 0005 has 8 available 32-bit DMA segments
[    2.232824] PCI: 1 PE# for a total weight of 40
[    2.232872] pci 0005:01     : [PE# 002] Assign DMA32 space
[    2.232920] pci 0005:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.308780] pci 0005:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.308842] PCI: Domain 0006 has 8 available 32-bit DMA segments
[    2.308901] PCI: 1 PE# for a total weight of 60
[    2.308949] pci 0006:01     : [PE# 002] Assign DMA32 space
[    2.308996] pci 0006:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.389827] pci 0006:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.389889] PCI: Domain 0007 has 8 available 32-bit DMA segments
[    2.389948] PCI: 1 PE# for a total weight of 15
[    2.389996] pci 0007:01     : [PE# 002] Assign DMA32 space
[    2.390045] pci 0007:01     : [PE# 002] Setting up 32-bit TCE table at 0..80000000
[    2.470868] pci 0007:01     : [PE# 002] Enabling 64-bit DMA bypass
[    2.474776] EEH: PCI Enhanced I/O Error Handling Enabled
[    2.476266] powernv-rng: Registering arch random hook.
[    2.512487] random: nonblocking pool is initialized
[    2.515358] vgaarb: loaded
[    2.516579] SCSI subsystem initialized
[    2.517364] usbcore: registered new interface driver usbfs
[    2.517428] usbcore: registered new interface driver hub
[    2.517546] usbcore: registered new device driver usb
[    2.518602] NetLabel: Initializing
[    2.518639] NetLabel:  domain hash size = 128
[    2.518687] NetLabel:  protocols = UNLABELED CIPSOv4
[    2.518755] NetLabel:  unlabeled traffic allowed by default
[    2.520291] Switched to clocksource timebase
[    2.531898] NET: Registered protocol family 2
[    2.532942] TCP established hash table entries: 524288 (order: 6, 4194304 bytes)
[    2.534878] TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
[    2.535498] TCP: Hash tables configured (established 524288 bind 65536)
[    2.535662] TCP: reno registered
[    2.535742] UDP hash table entries: 65536 (order: 5, 2097152 bytes)
[    2.536971] UDP-Lite hash table entries: 65536 (order: 5, 2097152 bytes)
[    2.539527] NET: Registered protocol family 1
[    2.539680] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.539764] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.539830] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.539913] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.540016] pci 0003:01:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.540099] pci 0003:01:00.0: Error enabling bridge (-22), continuing
[    2.540164] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.540246] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.540310] pci 0003:00:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.540393] pci 0003:00:00.0: Error enabling bridge (-22), continuing
[    2.540455] pci 0003:01:00.0: can't enable device: BAR 15 [mem size 0x0c000000 64bit pref] not assigned
[    2.540537] pci 0003:01:00.0: Error enabling bridge (-22), continuing


--X1bOJ3K7DJ5YkBrT--

