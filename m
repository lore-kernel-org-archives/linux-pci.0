Return-Path: <SRS0=Lbw5=PZ=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA132C43387
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF1F20652
	for <linux-pci@archiver.kernel.org>; Thu, 17 Jan 2019 15:32:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfAQPcA (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Thu, 17 Jan 2019 10:32:00 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35386 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfAQPcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Jan 2019 10:32:00 -0500
Received: by mail-qk1-f193.google.com with SMTP id w204so6235591qka.2;
        Thu, 17 Jan 2019 07:31:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++ojdsTMu2M7nZVwN/DSdBH+Qcbj93Bv+yt+EefrjeA=;
        b=O8uk7wE05ABrT661DK3btX+LriRSwSO+DlO/KYEtJe5RH7xuyHAzMghQB+FW9UV2j2
         sorJtS3p2rj34WmzXEJevyr8AFReLIBjpyOGQXUZQUZ7CbWzxcikfS1a7Kh2YCb482YG
         iDQcMdZj8ofxBCWB4XdySbHTsM7oEquYUsJZnZAwAMAseZQ6z0LrSsQvCJyaanRLUDRR
         v18MlgOUx2PaS/ebEA9ls6GA6PsSQ8XTfuzCTwjwsTIO22Ve9/NQDrJf4mpWIh7Lt1uU
         af80kKqs9ky6HdYr+Wer+lfsobBPpGCGvwAPUHoVmHu4xI0YbT+XRRSW8qghCUKn5ouw
         siNg==
X-Gm-Message-State: AJcUukdt5bZrsprqup5Wit8OX0o18qM16FlKdxj+j/SDSLRBvZ03qCHc
        DY2KMu07ODAm4Ozu5sV8cHORvXgqLkC3sumMZoU=
X-Google-Smtp-Source: ALg8bN7mFVDGLV5eWahAkkhCZU7n5WYqEGDovVGROdreA1TOnFzdoLJ9E1Vx+Qh9Uz4+nSVk8xg6NOS0PLzWrX3jhYU=
X-Received: by 2002:ae9:e102:: with SMTP id g2mr10697232qkm.343.1547739118933;
 Thu, 17 Jan 2019 07:31:58 -0800 (PST)
MIME-Version: 1.0
References: <20190116163253.23780-1-vincent.whitchurch@axis.com>
 <CAK8P3a2ifu9X+SXgoDPSFMYwnKr=Yex8_tD4qRimcOQAhuEa8Q@mail.gmail.com>
 <20190117105441.eqediwlekofp2srg@axis.com> <CAK8P3a2HtSJCLVdLcs=f0b5wv-k-6E_Z4Pt3Yp_kazUZh-Ek9A@mail.gmail.com>
 <20190117151529.GA3471@infradead.org> <20190117151920.GA20359@infradead.org>
In-Reply-To: <20190117151920.GA20359@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 17 Jan 2019 16:31:42 +0100
Message-ID: <CAK8P3a1r9ACPPuj90krYOB0yGVX3Usf86SYGxtnHpYCJ6_65hw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Virtio-over-PCIe on non-MIC
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 17, 2019 at 4:19 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Jan 17, 2019 at 07:15:29AM -0800, Christoph Hellwig wrote:
> > On Thu, Jan 17, 2019 at 01:39:27PM +0100, Arnd Bergmann wrote:
> > > Can you describe how you expect a VOP device over NTB or
> > > PCIe-endpoint would get created, configured and used?
> > > Is there always one master side that is responsible for creating
> > > virtio devices on it, with the slave side automatically attaching to
> > > them, or can either side create virtio devices? Is there any limit on
> > > the number of virtio devices or queues within a VOP device?
> >
> > For VOP device over NTB your configure your device using configfs
> > on one side, and for the other side it will just show up like any
> > other PCIe device, because it is.
>
> Sorry, I mean over the PCI-EP infratructure of course.  NTB actually
> is rather hairy and complicated.

My understanding was that with virtio, we would be able to have multiple
virtio devices on a single PCI-EP port, so you need a multi-step
configuration: You first set up the PCI-EP to instantiate a VOP device,
which is then seen on both ends of the connection. The question
is how to create a particular virtio device instance (or a set of those)
inside of it.

      Arnd
