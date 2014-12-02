Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:38687 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932800AbaLBV0W (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 2 Dec 2014 16:26:22 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so12047124iec.25
        for <linux-pci@vger.kernel.org>; Tue, 02 Dec 2014 13:26:21 -0800 (PST)
Date: Tue, 2 Dec 2014 14:26:16 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: "Zytaruk, Kelly" <Kelly.Zytaruk@amd.com>
Cc: Yu Zhao <yuzhao@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: Architectural question regarding IOV support in Linux 3.13.4
Message-ID: <20141202212616.GA20069@google.com>
References: <B756807489D6244883AC0B799A6EEC15EAB2E8@storexdag02.amd.com>
 <CAErSpo4OkgGrrZ9anAJ2vSZJDYikv4WC6hjt4T2-mMXpGA=w6A@mail.gmail.com>
 <1393020186.9111.91.camel@ul30vt.home>
 <CAOUHufai=eoR+tgVB5Zdp6veCQgY=pHDSAESZ5cLOjPTw-R8CQ@mail.gmail.com>
 <B756807489D6244883AC0B799A6EEC15EB26C6@storexdag02.amd.com>
 <CAErSpo7tyzujCqvsQcns1wX+j5jM1=Xo9TiCC+5-h67uXqbGSg@mail.gmail.com>
 <B756807489D6244883AC0B799A6EEC1514C68E79@storexdag03.amd.com>
 <CAErSpo5Y9MpkiC8iRSR4_Hx6mtp0YXRZizYfPBZj0nJ6p7hdKA@mail.gmail.com>
 <B756807489D6244883AC0B799A6EEC1514C6A32D@storexdag03.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <B756807489D6244883AC0B799A6EEC1514C6A32D@storexdag03.amd.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Dec 02, 2014 at 09:11:26PM +0000, Zytaruk, Kelly wrote:
> > -----Original Message-----
> > From: linux-pci-owner@vger.kernel.org [mailto:linux-pci-
> > owner@vger.kernel.org] On Behalf Of Bjorn Helgaas
> > Sent: Tuesday, December 02, 2014 4:02 PM
> > To: Zytaruk, Kelly
> > Cc: Yu Zhao; linux-pci@vger.kernel.org; Alex Williamson
> > Subject: Re: Architectural question regarding IOV support in Linux 3.13.4
> > 
> > On Tue, Dec 2, 2014 at 9:42 AM, Zytaruk, Kelly <Kelly.Zytaruk@amd.com>
> > wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Bjorn Helgaas [mailto:bhelgaas@google.com]
...

> > >> Can you try out Yu's patch and see what happens?  If you do turn on
> > >> SR-IOV on this device, it would be interesting to see the complete dmesg log
> > and "lspci -vv"
> > >> output to see what we do with it.
> > >
> > > Bjorn,
> > > I am resurrecting this thread as I have been looking through the 3.18 source
> > code and don't see any support for PCI_EXP_TYPE_LEG_END for SRIOV.  For
> > devices that must remain defined as Legacy endpoints we still need to be able to
> > enable SRIOV.
> > 
> > Looking back, I see that Yu Zhao did attach a patch earlier in the thread.  Are you
> > asking me to apply that one?  I don't remember why I dropped it from my queue;
> > maybe it was because I was waiting for you to test it.
> > 
> > Did you test it?  What were the results (complete dmesg log and lspci -vv
> > output)?  There was also some follow-on discussion that I would need to
> > evaluate before applying it.
> > 
> > Bjorn
> 
> I lost the original patch but it was simple enough that I coded it myself (one line change) locally.  I have been testing with it for several months now and have no issues with it.  In fact my testing requires it to be present in order to succeed, it will fail if it is not present.

Huh, I don't see it in the archives, either.  Ah, I see, it was a
multi-part message, which is rejected by the mailing lists.  But since I'm
a nice guy, I'll include it again below.

See https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/SubmittingPatches
for the usual procedure.

Please test the patch below (or post your patch if you prefer), collect
the info I requested above (dmesg and lspci info), and attach it to a
bugzilla so we can archive the details that motivate this change.

Bjorn



>From e81dfb3e73982ae9d74e3a8c6110a5104e36c3c0 Mon Sep 17 00:00:00 2001
From: Yu Zhao <yuzhao@google.com>
Date: Fri, 21 Feb 2014 14:46:50 -0800
Subject: [PATCH] pci: fix legacy endpoint being excluded from using SR-IOV

Neither PCIe 3.0 nor SR-IOV 1.1 spec excludes device of legacy
endpoint type from having SR-IOV capability. The legacy endpoint
together with root complex integrated and regular endpoints should
be supported by sriov_init().

Signed-off-by: Yu Zhao <yu.zhao@google.com>
---
 drivers/pci/iov.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 9dce7c5..5f98707 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -418,6 +418,7 @@ static int sriov_init(struct pci_dev *dev, int pos)
 	struct pci_dev *pdev;
 
 	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END &&
+	    pci_pcie_type(dev) != PCI_EXP_TYPE_LEG_END &&
 	    pci_pcie_type(dev) != PCI_EXP_TYPE_ENDPOINT)
 		return -ENODEV;
 
-- 
1.9.0.rc1.175.g0b1dcb5

