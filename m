Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44062 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933028Ab2EWTNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 23 May 2012 15:13:05 -0400
Date: Wed, 23 May 2012 22:13:07 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jason Baron <jbaron@redhat.com>, bhelgaas@google.com,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] pci hotplug: rescan bridge after device hotplug
Message-ID: <20120523191307.GE32207@redhat.com>
References: <201205222011.q4MKBcMo024624@int-mx02.intmail.prod.int.phx2.redhat.com>
 <CAE9FiQVkOsCpxa2WzhYguX6CxM=HF+i7h9dM2XHiaCQXSmFU6g@mail.gmail.com>
 <20120523024313.GA2888@redhat.com>
 <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE9FiQV4hgUGqAz3jhRrjJyEGrV-=K=LwRhr7zePncKirajoSw@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 22, 2012 at 08:31:30PM -0700, Yinghai Lu wrote:
> but pciehp we could do that, because it will only have one device
> under that pcie root port or downstream port.
> 
> so you can make qemu to support pcie and pciehp.

This does not solve the problem I think because
there are still multiple devices behind an upstream port.

Also, swiching to pcie creates a host of other complexities
so we want to support pci bridges too.

-- 
MST
