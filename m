Return-Path: <SRS0=j1yu=SW=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69509C282DD
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 09:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 275482183F
	for <linux-pci@archiver.kernel.org>; Sat, 20 Apr 2019 09:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gigaio-com.20150623.gappssmtp.com header.i=@gigaio-com.20150623.gappssmtp.com header.b="joO2SXFN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfDTJGq (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sat, 20 Apr 2019 05:06:46 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:32815 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725910AbfDTJGq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 20 Apr 2019 05:06:46 -0400
Received: by mail-wr1-f43.google.com with SMTP id k1so8377253wrw.0
        for <linux-pci@vger.kernel.org>; Sat, 20 Apr 2019 02:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gigaio-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=RvkJoIEFyTNOPsEph20SqfPS/EcvVN5zRXbAfpDssBs=;
        b=joO2SXFNwZsQwtQK3dRjeP2Bu3XOlVOpwVBb9faks19z6yPr4ri86084eTLA8HDve9
         e4XakZw9g0XPuBt4MdznhiD0IKhqcmEinvOoySRvPfhiKeL/aoNt3GNwLFFAcCg+k43W
         +l+Wz1H0+Lw5jNglWTm6PSpd86lRSNmzWqs+ajzb6Jm36aJWUKM1phYxqEt5RX+oYuu6
         JT0TrwN9sWBqyCMTMvoOlt6K9ZVmABhFl/VeW2g9IDLwW5kzCctfAFKb/Wn/oGFNI7sv
         RYNcrSvcTd+fAb3PcA97PBPo/F0XBwdo5DRnwZOKmf1lrd2FCIoDiPf4xyhGnvYf/Po2
         t6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=RvkJoIEFyTNOPsEph20SqfPS/EcvVN5zRXbAfpDssBs=;
        b=Xba1xz3z6N958tYzSRo7e85zPhr6+VxPckozRFqLBlH3fKIsnyZ8N82l6twI0ryJr6
         H+rJOUS4KWfBzup6nxkULnP+nypkAbbdbcwns22K44EBVKZg+vdarMa0HpWVoklEa4yj
         Fd9o3YnDG3wccixt7p/TfkFGi0w86LS1EJdqzkTssHyZow4B6cUXm2AfPUJ1t76dX6dS
         GPwfe0TM3V3RPbgAbd2sj+dyxjp72MsuyuIO3Pk9FwBbrphBgKGVRpG5MGEooeqsAEeq
         dooHQPFv4vJizimVxg2tx/XlgDNcxCf6TvMZL8R3iVp/qlqMkc6lIieHY5IW+GUDvBNZ
         pwJw==
X-Gm-Message-State: APjAAAX9DDzZYwasGSCFL9TVeCjZNE2qkOgQWeY97EwpjQlcPEijnRno
        vaiAdhUhiDoZdi7jJUKfVU5whp2GUQ2b3Api4+g+fQ==
X-Google-Smtp-Source: APXvYqxNyZwRkNSEzgEQ9TNnMwtsXrgWREd9DHB888z9k+Y5FgKEnw8qS1jD6QddrLUhmCwq3+dK+kFODTry7QcuPF0=
X-Received: by 2002:a5d:5346:: with SMTP id t6mr6472821wrv.59.1555751204243;
 Sat, 20 Apr 2019 02:06:44 -0700 (PDT)
MIME-Version: 1.0
From:   Eric Pilmore <epilmore@gigaio.com>
Date:   Sat, 20 Apr 2019 02:06:33 -0700
Message-ID: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
Subject: AMD IO_PAGE_FAULT w/NTB on Write ops?
To:     linux-ntb <linux-ntb@googlegroups.com>, linux-pci@vger.kernel.org
Cc:     S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Folks,

Before I ask my questions, here is a little background on the
environment I have:
- 2 hosts: 1 Xeon based (Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz),
                1 AMD based (AMD EPYC 7401 24-Core Processor)
- Each host is interconnected via an external PCI-e (switchtec) switch.
- The two hosts are exporting memory to each other via NTB.
- IOMMU is enabled in both hosts. The Xeon platform requires some BIOS
settings and a kernel parameter (intel_iommu=on), however as far as I
have been able to determine, the AMD only requires the IOMMU BIOS
setting to be enabled and no special kernel boot parameters. Does that
sound right for AMD?
- Region of memory exported to each host is acquired/mapped via
dma_alloc_coherent() using the "device" of the respective external
PCI-e switch.
- The dma_addr returned from the dma_alloc_coherent is relayed to the
peer host who then adds that value (i.e. IOVA offset) to it's local
PCI BAR representing the switch, and then ioremap()'s that resulting
address to get a CPU virtual address to which it can now perform
ioread/iowrite operations.

What we have found is that the Xeon based host can successfully ioread
to this mapped shared buffer, but whenever it attempts an iowrite to
this region, it results in an IO_PAGE_FAULT on the AMD based host:

AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
address=0x00000000fde1c18c flags=0x0070]

Going in the opposite direction there are no issues, i.e. the AMD
based host can successfully ioread/iowrite to the mapped in buffer
exported by the Xeon host.  Or if both hosts are Xeon's, then
everything works fine also.

I have looked high and low, and have not been able to interpret what
the "flags=0x0070" represent. I assume they are indicating some write
permission error, but was wondering if anybody here might know?

More importantly, does anybody know why the AMD IOMMU might seemingly
default to not allow Write operations to the exported memory? Is there
some additional BIOS or kernel boot parameter setting that needs to be
set?

lspci on the AMD hosts of the external PCI-e switch:
   23:00.0 PCI bridge: PMC-Sierra Inc. Device 8536
   23:00.1 Bridge: PMC-Sierra Inc. Device 8536

The 23:00.1 BDF is the NTB bridge. The BDF (23:01.2) in the error
message represents the "NTB translated" BDF of the request that came
from the peer, i.e. the 01.2 is the proxy-id. Is there a chance that
this proxy-id is causing some confusion for the AMD IOMMU?

Would greatly appreciate any assistance!

Thanks!

-- 
Eric Pilmore
epilmore@gigaio.com
http://gigaio.com
Phone: (858) 775 2514

This e-mail message is intended only for the individual(s) to whom it
is addressed and
may contain information that is privileged, confidential, proprietary,
or otherwise exempt
from disclosure under applicable law. If you believe you have received
this message in
error, please advise the sender by return e-mail and delete it from
your mailbox.
Thank you.
