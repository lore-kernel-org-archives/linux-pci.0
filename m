Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f178.google.com ([209.85.216.178]:33385 "EHLO
	mail-qc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbbEJLmq (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 10 May 2015 07:42:46 -0400
Received: by qcvo8 with SMTP id o8so33208044qcv.0
        for <linux-pci@vger.kernel.org>; Sun, 10 May 2015 04:42:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150510130619-mutt-send-email-mst@redhat.com>
References: <20150410223533.20848.95316.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150426084739-mutt-send-email-mst@kernel.org> <20150506210327.GG24643@google.com>
 <20150510130619-mutt-send-email-mst@redhat.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Sun, 10 May 2015 06:42:25 -0500
Message-ID: <CAErSpo5dUnSpE6gRVMU4Fe6ogaSB+wu+B1WW4h6Bn4yLph2+3A@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] PCI: Fix unhandled interrupt on shutdown
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Michael S. Tsirkin" <mst@kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Fam Zheng <famz@redhat.com>, Yinghai Lu <yinghai@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 10, 2015 at 6:09 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

> I think it's easier to just have all the info in the commit log, so I'll
> do that for the next version.  I'm not too worried about adding these
> patches to stable, so I think adding bugzilla for this isn't a must,
> right?

Right.  If it all fits in the changelog, so much the better.  I just
use bugzilla as a place to archive things too big to reasonably put in
the changelog.

Bjorn
